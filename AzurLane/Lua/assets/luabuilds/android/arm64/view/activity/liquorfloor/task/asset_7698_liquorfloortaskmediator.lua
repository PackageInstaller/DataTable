class = var_0_10000

local var_0_0 = "LiquorFloorTaskMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_TASK_GO = "LiquorFloorTaskMediator::ON_TASK_GO"
var_0_1.ON_TASK_SUBMIT = "LiquorFloorTaskMediator::ON_TASK_SUBMIT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SUBMIT_TASK, arg_3_1.id)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[var_1_10002.SUBMIT_TASK_DONE] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.viewComponent
		local var_5_1 = var_2.emit

		BaseUI = var_2_10005

		var_5_1(var_5_0, var_2_10005.ON_ACHIEVE, arg_5_1:getBody().awards)

		local var_5_2 = arg_5_0.viewComponent

		var_2.RefreshUI(var_5_2)

		return
	end
	GAME = var_2
	var_4_0[var_2.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.viewComponent
		local var_6_1 = var_2.emit

		BaseUI = var_2_10005

		var_6_1(var_6_0, var_2_10005.ON_ACHIEVE, arg_6_1:getBody().awards)

		local var_6_2 = arg_6_0.viewComponent

		var_2.RefreshUI(var_6_2)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

function var_0_1.remove(arg_7_0)
	return
end

return var_0_1
