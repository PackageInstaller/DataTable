local WorldDailyTaskMediator = class("WorldDailyTaskMediator", import("..base.ContextMediator"))

WorldDailyTaskMediator.OnTaskGoto = "WorldDailyTaskMediator.OnTaskGoto"
WorldDailyTaskMediator.OnAccepetTask = "WorldDailyTaskMediator.OnAccepetTask"
WorldDailyTaskMediator.OnSubmitTask = "WorldDailyTaskMediator.OnSubmitTask"

function WorldDailyTaskMediator:register()
	self:bind(WorldDailyTaskMediator.OnTaskGoto, function(arg_2_0, arg_2_1)
		self.viewComponent:closeView()
		self:sendNotification(WorldMediator.OnTriggerTaskGo, {
			taskId = arg_2_1
		})

		return
	end)
	self:bind(WorldDailyTaskMediator.OnAccepetTask, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.WORLD_TRIGGER_DAILY_TASK, {
			taskIds = arg_3_1
		})

		return
	end)
	self:bind(WorldDailyTaskMediator.OnSubmitTask, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.WORLD_SUMBMIT_TASK, {
			taskId = arg_4_1.id
		})

		return
	end)
	self.viewComponent:SetTaskProxy(nowWorld():GetTaskProxy())

	return
end

function WorldDailyTaskMediator:listNotificationInterests()
	return {}
end

function WorldDailyTaskMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	return
end

return WorldDailyTaskMediator
