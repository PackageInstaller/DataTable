local var_0_0 = class("BidGameMainRoundOverMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.initNotificationHandleDic(arg_2_0)
	arg_2_0.handleDic = {
		[GAME.AUCTION_GAME_NEW_ROUND] = function(arg_3_0, arg_3_1)
			arg_3_0.viewComponent:closeView()

			return
		end
	}

	return
end

function var_0_0.remove(arg_4_0)
	return
end

return var_0_0
