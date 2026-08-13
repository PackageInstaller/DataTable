class = var_0_10000

local var_0_0 = "CultivatingPlantMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GO_SCENE = "CultivatingPlantMediator::GO_SCENE"
var_0_1.ON_TASK_SUBMIT = "CultivatingPlantMediator::ON_TASK_SUBMIT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_2_1(var_2_0, var_2_2, var_2_10006.NEW_EDUCATE_SELECT)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SUBMIT_TASK_V2, arg_3_1.id)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[var_1_10002.SUBMIT_ACTIVITY_TASK_V2_DONE] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.viewComponent

		var_2.RefreshSubmitTaskDone(var_5_0)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

function var_0_1.remove(arg_6_0)
	return
end

return var_0_1
