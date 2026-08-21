local var_0_0 = class("WorldDailyTaskMediator", import("..base.ContextMediator"))

var_0_0.OnTaskGoto = "WorldDailyTaskMediator.OnTaskGoto"
var_0_0.OnAccepetTask = "WorldDailyTaskMediator.OnAccepetTask"
var_0_0.OnSubmitTask = "WorldDailyTaskMediator.OnSubmitTask"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OnTaskGoto, function(arg_2_0, arg_2_1)
		arg_1_0.viewComponent:closeView()
		arg_1_0:sendNotification(WorldMediator.OnTriggerTaskGo, {
			taskId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnAccepetTask, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.WORLD_TRIGGER_DAILY_TASK, {
			taskIds = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnSubmitTask, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.WORLD_SUMBMIT_TASK, {
			taskId = arg_4_1.id
		})

		return
	end)
	arg_1_0.viewComponent:SetTaskProxy(nowWorld():GetTaskProxy())

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	return
end

return var_0_0
