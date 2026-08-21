local var_0_0 = class("AuctionGameMainBidMediator", import("view.base.ContextMediator"))

var_0_0.BID = "AuctionGameMainBidMediator::BID"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.BID, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.AUCTION_GAME_BID, arg_2_1)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {
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

function var_0_0.remove(arg_6_0)
	return
end

return var_0_0
