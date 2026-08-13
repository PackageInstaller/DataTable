class = var_0_10000

local var_0_0 = "SecretShipyardMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.GO_MINI_GAME = "go minigame"
var_0_1.SUBMIT_TASK = "submit task"
var_0_1.TASK_GO = "task go"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_MINI_GAME, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.GO_MINI_GAME, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.SUBMIT_TASK, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.SUBMIT_TASK, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.TASK_GO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.SUBMIT_TASK_DONE
	ActivityProxy = var_2
	var_5_0[2] = var_2.ACTIVITY_OPERATION_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	GAME = var_6_1

	local var_6_4

	if var_6_0 == var_6_1.SUBMIT_TASK_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_6_4 = var_6_4.emit
		BaseUI = var_1_10006

		var_6_4(var_6_3, var_1_10006.ON_ACHIEVE, var_6_2, function()
			local var_7_0 = arg_6_0.viewComponent

			var_0.updateTaskLayers(var_7_0)

			return
		end)
	else
		ActivityProxy = var_6_4

		if var_6_0 == var_6_4.ACTIVITY_OPERATION_DONE then
			local var_6_5 = arg_6_0.viewComponent

			var_4.updateTaskLayers(var_6_5)
		end
	end

	return
end

return var_0_1
