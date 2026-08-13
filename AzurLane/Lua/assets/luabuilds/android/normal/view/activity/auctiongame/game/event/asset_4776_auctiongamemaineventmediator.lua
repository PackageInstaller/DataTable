class = var_0_10000

local var_0_0 = "AuctionGameMainEventMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.EVENT_SELECTED_ID = "AuctionGameMainEventMediator::EVENT_SELECTED_ID"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EVENT_SELECTED_ID, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.AUCTION_GAME_EVENT_SELECTED_ID, arg_2_1)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[var_1_10002.AUCTION_GAME_EVENT_SELECTED_ID_DONE] = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0.viewComponent

		var_2.closeView(var_4_0)

		return
	end
	GAME = var_2
	var_3_0[var_2.AUCTION_GAME_ROUND_OVER] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.viewComponent

		var_2.closeView(var_5_0)

		return
	end
	GAME = var_2
	var_3_0[var_2.AUCTION_GAME_BID_PHASE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.viewComponent

		var_2.closeView(var_6_0)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

function var_0_1.remove(arg_7_0)
	return
end

return var_0_1
