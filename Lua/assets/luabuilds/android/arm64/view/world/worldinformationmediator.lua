local var_0_0 = class("WorldInformationMediator", import("..base.ContextMediator"))

var_0_0.OnTriggerTask = "WorldInformationMediator.OnTriggerTask"
var_0_0.OnSubmitTask = "WorldInformationMediator.OnSubmitTask"
var_0_0.OnTaskGoto = "WorldInformationMediator.OnTaskGoto"
var_0_0.OnOpenDailyTaskPanel = "WorldInformationMediator.OnOpenDailyTaskPanel"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OnTaskGoto, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(WorldMediator.OnTriggerTaskGo, {
			taskId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnTriggerTask, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.WORLD_TRIGGER_TASK, {
			taskId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnSubmitTask, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.WORLD_SUMBMIT_TASK, {
			taskId = arg_4_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnOpenDailyTaskPanel, function(arg_5_0)
		nowWorld():GetTaskProxy():checkDailyTask(function()
			arg_1_0:addSubLayers(Context.New({
				mediator = WorldDailyTaskMediator,
				viewComponent = WorldDailyTaskLayer
			}))

			return
		end)

		return
	end)
	arg_1_0.viewComponent:setWorldTaskProxy(nowWorld():GetTaskProxy())

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		WorldCollectionMediator.ON_MAP
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getBody()

	if arg_8_1:getName() == WorldCollectionMediator.ON_MAP then
		arg_8_0.viewComponent:closeView()
	end

	return
end

return var_0_0
