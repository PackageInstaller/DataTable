local var_0_0 = class("NewEducateSetCallediator", import("view.newEducate.base.NewEducateContextMediator"))

var_0_0.ON_SET_CALL = "NewEducateSetCallediator:ON_SET_CALL"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SET_CALL, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_SET_CALL, {
			id = arg_1_0.contextData.char.id,
			name = arg_2_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.NEW_EDUCATE_SET_CALL_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.NEW_EDUCATE_SET_CALL_DONE then
		arg_4_0.viewComponent:closeView()
	end

	return
end

return var_0_0
