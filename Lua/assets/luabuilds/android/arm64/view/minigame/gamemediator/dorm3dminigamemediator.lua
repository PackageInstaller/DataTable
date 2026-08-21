local var_0_0 = class("Dorm3dMiniGameMediator", import("view.base.ContextMediator"))

var_0_0.GAME_OPERATION = "Dorm3dMiniGameMediator:GAME_OPERATION"
var_0_0.OPERATION = "Dorm3dMiniGameMediator:OPERATION"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GAME_OPERATION, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(var_0_0.OPERATION, arg_2_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_0
