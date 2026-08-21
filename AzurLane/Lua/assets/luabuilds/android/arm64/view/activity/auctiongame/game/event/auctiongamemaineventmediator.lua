local var_0_0 = class("AuctionGameMainEventMediator", import("view.base.ContextMediator"))

var_0_0.EVENT_SELECTED_ID = "AuctionGameMainEventMediator::EVENT_SELECTED_ID"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EVENT_SELECTED_ID, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.AUCTION_GAME_EVENT_SELECTED_ID, arg_2_1)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {
		[GAME.AUCTION_GAME_EVENT_SELECTED_ID_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:closeView()

			return
		end,
		[GAME.AUCTION_GAME_ROUND_OVER] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:closeView()

			return
		end,
		[GAME.AUCTION_GAME_BID_PHASE] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:closeView()

			return
		end
	}

	return
end

function var_0_0.remove(arg_7_0)
	return
end

return var_0_0
