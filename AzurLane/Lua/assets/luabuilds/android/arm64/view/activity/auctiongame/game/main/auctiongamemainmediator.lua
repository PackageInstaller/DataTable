class = var_0_10000

local var_0_0 = "AuctionGameMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.FORFEIT = "AuctionGameMainMediator::FORFEIT"
var_0_1.EXIT = "AuctionGameMainMediator::EXIT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.FORFEIT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.AUCTION_GAME_FORFEIT)

		return
	end)
	arg_1_0:bind(var_0_1.EXIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0.viewComponent

		var_2.closeView(var_3_0)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[var_1_10002.AUCTION_GAME_NEW_ROUND] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.viewComponent

		var_2.RefreshRound(var_5_0)

		local var_5_1 = arg_5_0.viewComponent
		local var_5_2 = var_2.emit

		AuctionGameMainRightView = var_2_10005

		var_5_2(var_5_1, var_2_10005.POP_EVENT_LAYER)

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_EVENT_SELECTED_ID_DONE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.viewComponent
		local var_6_1 = var_2.emit

		AuctionGameMainRightView = var_2_10005

		var_6_1(var_6_0, var_2_10005.EVENT_SELECTED)

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_BID_PHASE] = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.viewComponent

		var_2.OnStartBid(var_7_0)

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_BID_DONE] = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0.viewComponent

		var_2.OnBidDone(var_8_0, arg_8_1:getBody())

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_FORFEIT_DONE] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0.viewComponent
		local var_9_1 = var_2.emit

		AuctionGameMainRightView = var_2_10005

		var_9_1(var_9_0, var_2_10005.FORFEIT_DONE, arg_9_1)

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_EVENT_EFFECT_UPDATE] = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.viewComponent
		local var_10_1 = var_2.emit

		AuctionGameStoreView = var_2_10005

		var_10_1(var_10_0, var_2_10005.UPDATE_ITEM_LIST)

		local var_10_2 = arg_10_0.viewComponent
		local var_10_3 = var_2.emit

		AuctionGameMainRightInfoView = var_5

		var_10_3(var_10_2, var_5.EVENT_INFO_UPDATE)

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_PLAYER_OPT_STATE_UPDATE] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.viewComponent
		local var_11_1 = var_2.emit

		AuctionGameMainRightView = var_2_10005

		var_11_1(var_11_0, var_2_10005.PLAYER_OPT_STATE_UPDATE)

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_ROUND_OVER] = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0.viewComponent

		var_2.OnStartRoundOver(var_12_0)

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_SETTLEMENT] = function(arg_13_0, arg_13_1)
		getProxy = var_2_10002
		AuctionGameProxy = var_2_10004

		local var_13_0 = var_2_10002(var_2_10004)

		pg = var_2_10003

		local var_13_1 = var_2_10003.GameTrackerMgr.GetInstance()
		local var_13_2 = var_3.Record

		GameTrackerBuilder = var_2_10006

		var_13_2(var_13_1, var_2_10006.BuildAuctionFinish(var_13_0:GetAuctionID(), var_13_0:GetRound(), 0))

		local var_13_3 = arg_13_0
		local var_13_4 = arg_13_0.sendNotification

		GAME = var_6

		local var_13_5 = var_6.GO_SCENE

		SCENE = var_2_10007

		var_13_4(var_13_3, var_13_5, var_2_10007.AUCTION_GAME_MAIN_SETTLEMENT)

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_KICK] = function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0.viewComponent

		var_2.OnKick(var_14_0)

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_SHOW_EMOJI] = function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0.viewComponent
		local var_15_1 = var_2.emit

		AuctionGameMainRightView = var_2_10005

		var_15_1(var_15_0, var_2_10005.SHOW_EMOJI, arg_15_1:getBody())

		return
	end
	GAME = var_2
	var_4_0[var_2.AUCTION_GAME_SWITCH_EMOJI_DONE] = function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0.viewComponent
		local var_16_1 = var_2.emit

		AuctionGameMainRightView = var_2_10005

		var_16_1(var_16_0, var_2_10005.SWITCH_EMOJI)

		return
	end
	GAME = var_2
	var_4_0[var_2.ON_RECONNECTION] = function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0.viewComponent

		var_2.OnReconnection(var_17_0)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

function var_0_1.remove(arg_18_0)
	return
end

return var_0_1
