class = var_0_10000

local var_0_0 = "WorldDailyTaskMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OnTaskGoto = "WorldDailyTaskMediator.OnTaskGoto"
var_0_1.OnAccepetTask = "WorldDailyTaskMediator.OnAccepetTask"
var_0_1.OnSubmitTask = "WorldDailyTaskMediator.OnSubmitTask"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnTaskGoto, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.viewComponent

		var_2.closeView(var_2_0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_2.sendNotification

		WorldMediator = var_2_10004

		var_2_2(var_2_1, var_2_10004.OnTriggerTaskGo, {
			taskId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnAccepetTask, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.WORLD_TRIGGER_DAILY_TASK, {
			taskIds = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnSubmitTask, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.WORLD_SUMBMIT_TASK, {
			taskId = arg_4_1.id
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.SetTaskProxy

	nowWorld = var_3

	local var_1_2 = var_3()

	var_1_1(var_1_0, var_3.GetTaskProxy(var_1_2))

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	return {}
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	return
end

return var_0_1
