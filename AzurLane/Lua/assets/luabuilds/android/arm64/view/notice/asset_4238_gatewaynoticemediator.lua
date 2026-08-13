class = var_0_10000

local var_0_0 = "GatewayNoticeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	arg_1_0:updateNotices()

	return
end

function var_0_1.updateNotices(arg_2_0)
	getProxy = var_1_10001
	GatewayNoticeProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = arg_2_0.viewComponent

	var_2.updateNotices(var_2_1, var_2_0:getGatewayNotices(false))

	return
end

return var_0_1
