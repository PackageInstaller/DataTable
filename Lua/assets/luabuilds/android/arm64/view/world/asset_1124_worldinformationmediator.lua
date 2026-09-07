local WorldInformationMediator = class("WorldInformationMediator", import("..base.ContextMediator"))

WorldInformationMediator.OnTriggerTask = "WorldInformationMediator.OnTriggerTask"
WorldInformationMediator.OnSubmitTask = "WorldInformationMediator.OnSubmitTask"
WorldInformationMediator.OnTaskGoto = "WorldInformationMediator.OnTaskGoto"
WorldInformationMediator.OnOpenDailyTaskPanel = "WorldInformationMediator.OnOpenDailyTaskPanel"

function WorldInformationMediator:register()
	self:bind(WorldInformationMediator.OnTaskGoto, function(arg_2_0, arg_2_1)
		self:sendNotification(WorldMediator.OnTriggerTaskGo, {
			taskId = arg_2_1
		})

		return
	end)
	self:bind(WorldInformationMediator.OnTriggerTask, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.WORLD_TRIGGER_TASK, {
			taskId = arg_3_1
		})

		return
	end)
	self:bind(WorldInformationMediator.OnSubmitTask, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.WORLD_SUMBMIT_TASK, {
			taskId = arg_4_1.id
		})

		return
	end)
	self:bind(WorldInformationMediator.OnOpenDailyTaskPanel, function(arg_5_0)
		nowWorld():GetTaskProxy():checkDailyTask(function()
			self:addSubLayers(Context.New({
				mediator = WorldDailyTaskMediator,
				viewComponent = WorldDailyTaskLayer
			}))

			return
		end)

		return
	end)
	self.viewComponent:setWorldTaskProxy(nowWorld():GetTaskProxy())

	return
end

function WorldInformationMediator:listNotificationInterests()
	return {
		WorldCollectionMediator.ON_MAP
	}
end

function WorldInformationMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getBody()

	if arg_8_1:getName() == WorldCollectionMediator.ON_MAP then
		self.viewComponent:closeView()
	end

	return
end

return WorldInformationMediator
