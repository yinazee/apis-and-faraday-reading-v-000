class SearchesController < ApplicationController

  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "BDYBQPDQH0M0AP5WOHWJCBJKNL3I4WN1IMMOSXZIET3ZB4OO"
        req.params['client_secret'] = "241FK1RIZMTOBOQYV4HOWJHIDRGTEIZ20YMLLXXARLKRBCKQ"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
      end

      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

     render 'search'
    end



end
