local HololiveMedalCollectionMediator = class("HololiveMedalCollectionMediator", import("view.base.ContextMediator"))

function HololiveMedalCollectionMediator:register()
	self:BindEvent()

	return
end

function HololiveMedalCollectionMediator:BindEvent()
	self:bind(ActivityMediator.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	self:bind(ActivityMediator.ON_TASK_GO, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function HololiveMedalCollectionMediator:listNotificationInterests()
	return {
		GAME.MEMORYBOOK_UNLOCK_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		GAME.SUBMIT_TASK_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function HololiveMedalCollectionMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.MEMORYBOOK_UNLOCK_DONE then
		self.viewComponent:UpdateView()
	elseif var_6_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:PlayStory(function()
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, var_6_1.callback)

			return
		end)
	elseif var_6_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1, function()
			self.viewComponent:UpdateView()

			return
		end)
	elseif var_6_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		self.viewComponent:UpdateView()
	end

	return
end

return HololiveMedalCollectionMediator
