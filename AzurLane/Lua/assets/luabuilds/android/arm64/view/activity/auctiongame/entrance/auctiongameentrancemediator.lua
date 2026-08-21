local var_0_0 = class("AuctionGameEntranceMediator", (import("view.playRoom.PlayRoomCommonMediator")))

var_0_0.CLICK_PREORDER_BOX = "AuctionGameEntranceMediator::CLICK_PREORDER_BOX"
var_0_0.CLICK_OPEN_BOX = "AuctionGameEntranceMediator::CLICK_OPEN_BOX"
var_0_0.SHOW_WARNING_TIP = "AuctionGameEntranceMediator::SHOW_WARNING_TIP"
var_0_0.CLICK_GET_RELIEF = "AuctionGameEntranceMediator::CLICK_GET_RELIEF"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.CLICK_PREORDER_BOX, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.AUCTION_GAME_PREORDER_BOX)

		return
	end)
	arg_1_0:bind(var_0_0.CLICK_OPEN_BOX, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.AUCTION_GAME_OPEN_BOX)

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_WARNING_TIP, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.AUCTION_GAME_SHOW_MATCH_WARNING_TIP)

		return
	end)
	arg_1_0:bind(var_0_0.CLICK_GET_RELIEF, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.AUCTION_GAME_GET_RELIEF)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_6_0)
	arg_6_0.handleDic = {
		[GAME.AUCTION_GAME_PREORDER_BOX_DONE] = function(arg_7_0, arg_7_1)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPreorder(0, AuctionGameTools.GetPreorderCurrentyCnt()))
			arg_7_0.viewComponent:OnUpdateCurrency()

			return
		end,
		[GAME.AUCTION_GAME_OPEN_BOX_DONE] = function(arg_8_0, arg_8_1)
			getProxy(AuctionGameBaseProxy):SetNeedInitFlag(true)
			arg_8_0:sendNotification(GAME.GO_SCENE, SCENE.AUCTION_GAME_PREORDER_BOX_SETTLEMENT)

			return
		end,
		[GAME.ADD_ITEM] = function(arg_9_0, arg_9_1)
			arg_9_0.viewComponent:RefreshLocationTip()
			arg_9_0.viewComponent:OnUpdateCurrency()
			arg_9_0.viewComponent:emit(AuctionGamePlayerPanel.REFRESH_CURRENCY)

			return
		end,
		[GAME.SUBMIT_TASK_DONE] = function(arg_10_0, arg_10_1)
			arg_10_0.viewComponent:RefreshTaskTip()

			return
		end,
		[GAME.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_11_0, arg_11_1)
			arg_11_0.viewComponent:RefreshTaskTip()

			return
		end,
		[GAME.AUCTION_GAME_GET_RELIEF_DONE] = function(arg_12_0, arg_12_1)
			local var_12_0 = arg_12_1:getBody()

			if #var_12_0 > 0 then
				arg_12_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_12_0)
			end

			return
		end,
		[GAME.TOTAL_TASK_UPDATED] = function(arg_13_0, arg_13_1)
			arg_13_0.viewComponent:RefreshTaskTip()

			return
		end,
		[GAME.ON_RECONNECTION] = function(arg_14_0, arg_14_1)
			table.insert({}, function(arg_15_0)
				getProxy(AuctionGameBaseProxy):SetNeedInitFlag(true)
				arg_14_0:sendNotification(GAME.AUCTION_GAME_INIT, {
					callback = arg_15_0
				})

				return
			end)
			seriesAsync({}, function()
				if arg_14_0.viewComponent:IsQuickMatch() then
					arg_14_0:sendNotification(GAME.AUCTION_GAME_MATCHING_RECONNECT, {})
				end

				return
			end)

			return
		end,
		[GAME.AUCTION_GAME_MATCHING_RECONNECT_DONE] = function(arg_17_0, arg_17_1)
			if arg_17_1:getBody() == 3 then
				arg_17_0.viewComponent:OnClickStopQuickMatch()
			end

			return
		end
	}

	return
end

function var_0_0.remove(arg_18_0)
	return
end

return var_0_0
