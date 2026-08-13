class = var_0_10000

local var_0_0 = "LinerBackHillMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillMediatorTemplate"))

var_0_1.GO_MINIGAME = "GO_MINIGAME"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()
	arg_1_0:bind(var_0_1.GO_MINIGAME, function(arg_2_0, arg_2_1, ...)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.GO_MINI_GAME, arg_2_1, ...)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[var_1_10002.ACTIVITY_LINER_OP_DONE] = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0.viewComponent

		var_2.UpdateView(var_4_0)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

return var_0_1
