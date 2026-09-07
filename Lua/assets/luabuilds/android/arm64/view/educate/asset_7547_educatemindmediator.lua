local EducateMindMediator = class("EducateMindMediator", import(".base.EducateContextMediator"))

EducateMindMediator.ON_TASK_SUBMIT = "EducateMindMediator:ON_TASK_SUBMIT"

function EducateMindMediator:register()
	self:bind(EducateMindMediator.ON_TASK_SUBMIT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_SUBMIT_TASK, {
			id = arg_2_1.id,
			system = arg_2_1:GetSystemType()
		})

		return
	end)

	return
end

function EducateMindMediator:listNotificationInterests()
	return {
		GAME.EDUCATE_SUBMIT_TASK_DONE
	}
end

function EducateMindMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.EDUCATE_SUBMIT_TASK_DONE then
		self.viewComponent:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
			items = arg_4_1:getBody().awards
		})
		self.viewComponent:updateView()
	end

	return
end

return EducateMindMediator
