local var_0_0 = class("GatewayNoticeMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:updateNotices()

	return
end

function var_0_0.updateNotices(arg_2_0)
	arg_2_0.viewComponent:updateNotices(getProxy(GatewayNoticeProxy):getGatewayNotices(false))

	return
end

return var_0_0
