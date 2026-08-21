local var_0_0 = class("EducateSelEndingMediator", import(".base.EducateContextMediator"))

var_0_0.ON_SELECT_ENDING = "EducateSelEndingMediator:ON_SELECT_ENDING"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SELECT_ENDING, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.EDUCATE_TRIGGER_END, {
			ids = arg_2_2,
			selId = arg_2_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.EDUCATE_TRIGGER_END_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.EDUCATE_TRIGGER_END_DONE then
		arg_4_0.viewComponent:closeView()
	end

	return
end

return var_0_0
