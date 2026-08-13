class = var_0_10000

local var_0_0 = "Dorm3dMiniGameMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GAME_OPERATION = "Dorm3dMiniGameMediator:GAME_OPERATION"
var_0_1.OPERATION = "Dorm3dMiniGameMediator:OPERATION"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GAME_OPERATION, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0

		var_3.sendNotification(var_2_0, var_0_1.OPERATION, arg_2_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_1
