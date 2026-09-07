local ClueTasksMediator = class("ClueTasksMediator", import("view.base.ContextMediator"))

ClueTasksMediator.ON_TASK_SUBMIT = "ClueTasksMediator.ON_TASK_SUBMIT"
ClueTasksMediator.ON_TASK_SUBMIT_ONESTEP = "ClueTasksMediator.ON_TASK_SUBMIT_ONESTEP"
ClueTasksMediator.ON_TASK_GO = "ClueTasksMediator.ON_TASK_GO"

function ClueTasksMediator:register()
	self:BindEvent()

	return
end

function ClueTasksMediator:BindEvent()
	self:bind(ClueTasksMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1,
			task_ids = arg_3_2,
			callback = arg_3_3
		})

		return
	end)
	self:bind(ClueTasksMediator.ON_TASK_GO, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function ClueTasksMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function ClueTasksMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		warning("hand SUBMIT_ACTIVITY_TASK_DONE", #var_6_0.awards)

		if #var_6_0.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_0.awards)
		end

		self.viewComponent:UpdateView()
	end

	return
end

return ClueTasksMediator
