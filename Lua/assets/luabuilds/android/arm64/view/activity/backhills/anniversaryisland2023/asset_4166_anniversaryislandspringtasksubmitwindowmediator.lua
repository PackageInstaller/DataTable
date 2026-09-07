local AnniversaryIslandSpringTaskSubmitWindowMediator = class("AnniversaryIslandSpringTaskSubmitWindowMediator", import("view.base.ContextMediator"))

function AnniversaryIslandSpringTaskSubmitWindowMediator:register()
	self:bind(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK, function(arg_2_0)
		self:sendNotification(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK, self.contextData.task)

		return
	end)
	self:bind(WorkBenchItemDetailMediator.SHOW_DETAIL, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			mediator = WorkBenchItemDetailMediator,
			viewComponent = WorkBenchItemDetailLayer,
			data = {
				material = arg_3_1
			}
		}))

		return
	end)

	return
end

function AnniversaryIslandSpringTaskSubmitWindowMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function AnniversaryIslandSpringTaskSubmitWindowMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:closeView()
	end

	return
end

function AnniversaryIslandSpringTaskSubmitWindowMediator:remove()
	return
end

return AnniversaryIslandSpringTaskSubmitWindowMediator
