import = var_0_10000

local var_0_0 = var_0_10000("view.playRoom.PlayRoomCommonMediator")

class = var_0_10001

local var_0_1 = var_0_10001("AuctionGameEntranceMediator", var_0_0)

var_0_1.CLICK_PREORDER_BOX = "AuctionGameEntranceMediator::CLICK_PREORDER_BOX"
var_0_1.CLICK_OPEN_BOX = "AuctionGameEntranceMediator::CLICK_OPEN_BOX"
var_0_1.SHOW_WARNING_TIP = "AuctionGameEntranceMediator::SHOW_WARNING_TIP"
var_0_1.CLICK_GET_RELIEF = "AuctionGameEntranceMediator::CLICK_GET_RELIEF"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CLICK_PREORDER_BOX, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.AUCTION_GAME_PREORDER_BOX)

		return
	end)
	arg_1_0:bind(var_0_1.CLICK_OPEN_BOX, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.AUCTION_GAME_OPEN_BOX)

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_WARNING_TIP, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.AUCTION_GAME_SHOW_MATCH_WARNING_TIP)

		return
	end)
	arg_1_0:bind(var_0_1.CLICK_GET_RELIEF, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.AUCTION_GAME_GET_RELIEF)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[var_1_10002.AUCTION_GAME_PREORDER_BOX_DONE] = function(arg_7_0, arg_7_1)
		pg = var_2_10002

		local var_7_0 = var_2_10002.GameTrackerMgr.GetInstance()
		local var_7_1 = var_2.Record

		GameTrackerBuilder = var_2_10005

		local var_7_2 = var_2_10005.BuildPreorder
		local var_7_3 = 0

		AuctionGameTools = var_2_10008

		var_7_1(var_7_0, var_7_2(var_7_3, var_2_10008.GetPreorderCurrentyCnt()))

		local var_7_4 = arg_7_0.viewComponent

		var_2.OnUpdateCurrency(var_7_4)

		return
	end
	GAME = var_2
	var_6_0[var_2.AUCTION_GAME_OPEN_BOX_DONE] = function(arg_8_0, arg_8_1)
		getProxy = var_2_10002
		AuctionGameBaseProxy = var_2_10004

		local var_8_0 = var_2_10002(var_2_10004)

		var_2.SetNeedInitFlag(var_8_0, true)

		local var_8_1 = arg_8_0
		local var_8_2 = arg_8_0.sendNotification

		GAME = var_6

		local var_8_3 = var_6.GO_SCENE

		SCENE = var_2_10007

		var_8_2(var_8_1, var_8_3, var_2_10007.AUCTION_GAME_PREORDER_BOX_SETTLEMENT)

		return
	end
	GAME = var_2
	var_6_0[var_2.ADD_ITEM] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0.viewComponent

		var_2.RefreshLocationTip(var_9_0)

		local var_9_1 = arg_9_0.viewComponent

		var_2.OnUpdateCurrency(var_9_1)

		local var_9_2 = arg_9_0.viewComponent
		local var_9_3 = var_2.emit

		AuctionGamePlayerPanel = var_2_10005

		var_9_3(var_9_2, var_2_10005.REFRESH_CURRENCY)

		return
	end
	GAME = var_2
	var_6_0[var_2.SUBMIT_TASK_DONE] = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.viewComponent

		var_2.RefreshTaskTip(var_10_0)

		return
	end
	GAME = var_2
	var_6_0[var_2.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.viewComponent

		var_2.RefreshTaskTip(var_11_0)

		return
	end
	GAME = var_2
	var_6_0[var_2.AUCTION_GAME_GET_RELIEF_DONE] = function(arg_12_0, arg_12_1)
		if #arg_12_1:getBody() > 0 then
			local var_12_0 = arg_12_0.viewComponent
			local var_12_1 = var_3.emit

			BaseUI = var_2_10006

			var_12_1(var_12_0, var_2_10006.ON_ACHIEVE, var_2)
		end

		return
	end
	GAME = var_2
	var_6_0[var_2.TOTAL_TASK_UPDATED] = function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0.viewComponent

		var_2.RefreshTaskTip(var_13_0)

		return
	end
	GAME = var_2
	var_6_0[var_2.ON_RECONNECTION] = function(arg_14_0, arg_14_1)
		local var_14_0 = {}

		table = var_2_10003

		var_2_10003.insert(var_14_0, function(arg_15_0)
			getProxy = var_3_10001
			AuctionGameBaseProxy = var_3_10003

			local var_15_0 = var_3_10001(var_3_10003)

			var_1.SetNeedInitFlag(var_15_0, true)

			local var_15_1 = arg_14_0
			local var_15_2 = var_1.sendNotification

			GAME = var_4

			var_15_2(var_15_1, var_4.AUCTION_GAME_INIT, {
				callback = arg_15_0
			})

			return
		end)

		seriesAsync = var_3

		var_3(var_14_0, function()
			local var_16_0 = arg_14_0.viewComponent

			if var_0.IsQuickMatch(var_16_0) then
				local var_16_1 = arg_14_0
				local var_16_2 = var_0.sendNotification

				GAME = var_3_10003

				var_16_2(var_16_1, var_3_10003.AUCTION_GAME_MATCHING_RECONNECT, {})
			end

			return
		end)

		return
	end
	GAME = var_2
	var_6_0[var_2.AUCTION_GAME_MATCHING_RECONNECT_DONE] = function(arg_17_0, arg_17_1)
		if arg_17_1:getBody() == 3 then
			local var_17_0 = arg_17_0.viewComponent

			var_3.OnClickStopQuickMatch(var_17_0)
		end

		return
	end
	arg_6_0.handleDic = var_6_0

	return
end

function var_0_1.remove(arg_18_0)
	return
end

return var_0_1
