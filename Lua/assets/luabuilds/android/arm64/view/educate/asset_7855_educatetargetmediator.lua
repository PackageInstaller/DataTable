local EducateTargetMediator = class("EducateTargetMediator", import(".base.EducateContextMediator"))

EducateTargetMediator.ON_TASK_SUBMIT = "EducateTargetMediator:ON_TASK_SUBMIT"
EducateTargetMediator.ON_GET_TARGET_AWARD = "EducateTargetMediator:ON_GET_TARGET_AWARD"

function EducateTargetMediator:register()
	self:bind(EducateTargetMediator.ON_TASK_SUBMIT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_SUBMIT_TASK, {
			id = arg_2_1.id,
			system = arg_2_1:GetSystemType()
		})

		return
	end)
	self:bind(EducateTargetMediator.ON_GET_TARGET_AWARD, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.EDUCATE_GET_TARGET_AWARD)

		return
	end)

	return
end

function EducateTargetMediator:listNotificationInterests()
	return {
		GAME.EDUCATE_SUBMIT_TASK_DONE,
		GAME.EDUCATE_GET_TARGET_AWARD_DONE
	}
end

function EducateTargetMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()

	if var_5_0 == GAME.EDUCATE_SUBMIT_TASK_DONE or var_5_0 == GAME.EDUCATE_GET_TARGET_AWARD_DONE then
		self.viewComponent:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
			items = arg_5_1:getBody().awards
		})
		self.viewComponent:updateView()
	end

	return
end

return EducateTargetMediator
