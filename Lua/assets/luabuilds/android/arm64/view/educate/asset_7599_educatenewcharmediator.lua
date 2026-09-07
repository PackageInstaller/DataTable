local EducateNewCharMediator = class("EducateNewCharMediator", import(".base.EducateContextMediator"))

EducateNewCharMediator.ON_SET_CALL = "EducateNewCharMediator:ON_SET_CALL"

function EducateNewCharMediator:register()
	self:bind(EducateNewCharMediator.ON_SET_CALL, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_SET_CALL, {
			name = arg_2_1
		})

		return
	end)

	return
end

function EducateNewCharMediator:listNotificationInterests()
	return {
		GAME.EDUCATE_SET_CALL_DONE
	}
end

function EducateNewCharMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.EDUCATE_SET_CALL_DONE then
		self.viewComponent:closeView()
	end

	return
end

return EducateNewCharMediator
