local EducateSelEndingMediator = class("EducateSelEndingMediator", import(".base.EducateContextMediator"))

EducateSelEndingMediator.ON_SELECT_ENDING = "EducateSelEndingMediator:ON_SELECT_ENDING"

function EducateSelEndingMediator:register()
	self:bind(EducateSelEndingMediator.ON_SELECT_ENDING, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.EDUCATE_TRIGGER_END, {
			ids = arg_2_2,
			selId = arg_2_1
		})

		return
	end)

	return
end

function EducateSelEndingMediator:listNotificationInterests()
	return {
		GAME.EDUCATE_TRIGGER_END_DONE
	}
end

function EducateSelEndingMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.EDUCATE_TRIGGER_END_DONE then
		self.viewComponent:closeView()
	end

	return
end

return EducateSelEndingMediator
