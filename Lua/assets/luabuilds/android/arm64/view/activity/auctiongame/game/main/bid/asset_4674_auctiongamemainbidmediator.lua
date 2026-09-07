local AuctionGameMainBidMediator = class("AuctionGameMainBidMediator", import("view.base.ContextMediator"))

AuctionGameMainBidMediator.BID = "AuctionGameMainBidMediator::BID"

function AuctionGameMainBidMediator:register()
	self:bind(AuctionGameMainBidMediator.BID, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.AUCTION_GAME_BID, arg_2_1)

		return
	end)

	return
end

function AuctionGameMainBidMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.AUCTION_GAME_ROUND_OVER] = function(arg_4_0, arg_4_1)
			local var_4_0 = getProxy(AuctionGameProxy)

			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionBid(var_4_0:GetAuctionID(), var_4_0:GetRound(), pg.gameset.auction_bid_time.key_value, 0, 1))
			arg_4_0.viewComponent:closeView()

			return
		end,
		[GAME.AUCTION_GAME_BID_DONE] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:closeView()

			return
		end
	}

	return
end

function AuctionGameMainBidMediator:remove()
	return
end

return AuctionGameMainBidMediator
