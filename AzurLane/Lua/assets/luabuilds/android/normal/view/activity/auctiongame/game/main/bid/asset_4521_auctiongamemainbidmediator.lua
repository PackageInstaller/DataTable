class = var_0_10000

local var_0_0 = "AuctionGameMainBidMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.BID = "AuctionGameMainBidMediator::BID"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.BID, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.AUCTION_GAME_BID, arg_2_1)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[var_1_10002.AUCTION_GAME_ROUND_OVER] = function(arg_4_0, arg_4_1)
		getProxy = var_2_10002
		AuctionGameProxy = var_2_10003

		local var_4_0 = var_2_10002(var_2_10003)

		pg = var_2_10003

		local var_4_1 = var_2_10003.gameset.auction_bid_time.key_value

		pg = var_2_10004

		local var_4_2 = var_2_10004.GameTrackerMgr.GetInstance()
		local var_4_3 = var_4.Record

		GameTrackerBuilder = var_2_10006

		var_4_3(var_4_2, var_2_10006.BuildAuctionBid(var_4_0:GetAuctionID(), var_4_0:GetRound(), var_4_1, 0, 1))

		local var_4_4 = arg_4_0.viewComponent

		var_4.closeView(var_4_4)

		return
	end
	GAME = var_2
	var_3_0[var_2.AUCTION_GAME_BID_DONE] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.viewComponent

		var_2.closeView(var_5_0)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

function var_0_1.remove(arg_6_0)
	return
end

return var_0_1
