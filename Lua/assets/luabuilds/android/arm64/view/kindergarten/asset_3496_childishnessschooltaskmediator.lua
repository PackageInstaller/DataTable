local ChildishnessSchoolTaskMediator = class("ChildishnessSchoolTaskMediator", import("view.base.ContextMediator"))

ChildishnessSchoolTaskMediator.ON_TASK_GO = "event on task go"
ChildishnessSchoolTaskMediator.ON_TASK_SUBMIT = "event on task submit"
ChildishnessSchoolTaskMediator.ON_TASK_SUBMIT_ONESTEP = "event on task submit one step"

function ChildishnessSchoolTaskMediator:register()
	self:bind(ChildishnessSchoolTaskMediator.ON_TASK_GO, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(ChildishnessSchoolTaskMediator.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id, arg_3_2)

		return
	end)
	self:bind(ChildishnessSchoolTaskMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_1,
			task_ids = arg_4_2
		})

		return
	end)

	return
end

function ChildishnessSchoolTaskMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_AVATAR_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function ChildishnessSchoolTaskMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1)
		self.viewComponent:Show()
	elseif var_6_0 == GAME.SUBMIT_AVATAR_TASK_DONE or var_6_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards)
		self.viewComponent:Show()
	end

	return
end

return ChildishnessSchoolTaskMediator
