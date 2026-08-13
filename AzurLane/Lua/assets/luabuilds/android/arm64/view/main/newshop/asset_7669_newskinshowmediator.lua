class = var_0_10000

local var_0_0 = "NewSkinShowMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	PlayerProxy = var_1_10002
	var_2_0[1] = var_1_10002.UPDATED

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getName(var_3_0)
	local var_3_2 = arg_3_1:getBody()

	PlayerProxy = var_3_0

	if var_3_1 == var_3_0.UPDATED then
		local var_3_3 = arg_3_0.viewComponent

		var_4.SetResource(var_3_3)
	end

	return
end

return var_0_1
