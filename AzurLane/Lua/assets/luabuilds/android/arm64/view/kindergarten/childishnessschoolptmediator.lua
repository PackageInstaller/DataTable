local var_0_0 = class("ChildishnessSchoolPtMediator", import("view.base.ContextMediator"))

var_0_0.EVENT_PT_OPERATION = "event pt op"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EVENT_PT_OPERATION, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.ACT_NEW_PT, arg_2_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.ACT_NEW_PT_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.ACT_NEW_PT_DONE then
		arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_0.awards, var_4_0.callback)
		arg_4_0.viewComponent:Show()
	end

	return
end

return var_0_0
