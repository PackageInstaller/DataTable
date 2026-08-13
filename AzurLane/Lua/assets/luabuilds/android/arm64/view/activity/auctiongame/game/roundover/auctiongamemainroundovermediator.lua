class = var_0_10000

local var_0_0 = "BidGameMainRoundOverMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.initNotificationHandleDic(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[var_1_10002.AUCTION_GAME_NEW_ROUND] = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0.viewComponent

		var_2.closeView(var_3_0)

		return
	end
	arg_2_0.handleDic = var_2_0

	return
end

function var_0_1.remove(arg_4_0)
	return
end

return var_0_1
