class = var_0_10000

local var_0_0 = "PileGameSignedMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_GET_AWARD = "PileGameSignedMediator:ON_GET_AWARD"
var_0_1.MINIGAME_ID = 5

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0:bind(var_0_1.ON_GET_AWARD, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.SEND_MINI_GAME_OP
		local var_2_3 = {
			hubid = var_0_1.MINIGAME_ID
		}

		MiniGameOPCommand = var_6
		var_2_3.cmd = var_6.CMD_ULTIMATE
		var_2_3.args1 = {}

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)

	local var_1_1 = var_1_0:GetHubByHubId(var_0_1.MINIGAME_ID)
	local var_1_2 = arg_1_0.viewComponent

	var_3.SetData(var_1_2, var_1_1)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	MiniGameProxy = var_1_10002
	var_3_0[1] = var_1_10002.ON_HUB_DATA_UPDATE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	MiniGameProxy = var_4_0

	if var_4_1 == var_4_0.ON_HUB_DATA_UPDATE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.SetData(var_4_3, var_4_2)

		local var_4_4 = arg_4_0.viewComponent

		var_4.UpdateSigned(var_4_4)
	end

	return
end

return var_0_1
