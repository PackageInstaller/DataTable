class = var_0_10000

local var_0_0 = "resumeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.player
	local var_1_1 = arg_1_0.viewComponent

	var_2.setPlayerVO(var_1_1, var_1_0)

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	return {}
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return var_0_1
