class = var_0_10000

local var_0_0 = "GameRoomCoinMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.CHANGE_VISIBLE = "GameRoomCoinMediator:CHANGE_VISIBLE"
var_0_1.CHANGE_COIN_NUM = "GameRoomCoinMediator:CHANGE COIN COUNT"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GameRoomCoinMediator = var_1_10003

	var_1_1(var_1_0, var_1_10003.CHANGE_COIN_NUM, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.GAME_COIN_COUNT_CHANGE, arg_2_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GameRoomCoinMediator = var_1_10002
	var_3_0[1] = var_1_10002.CHANGE_VISIBLE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GameRoomCoinMediator = var_4_1

	if var_4_0 == var_4_1.CHANGE_VISIBLE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.changeVisible(var_4_3, var_4_2)
	end

	return
end

return var_0_1
