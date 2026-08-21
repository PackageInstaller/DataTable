local var_0_0 = class("PrepModelCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	arg_1_0.facade:registerProxy(ContextProxy.New({}))
	arg_1_0.facade:registerProxy(ServerProxy.New({}))
	arg_1_0.facade:registerProxy(UserProxy.New())
	arg_1_0.facade:registerProxy(GatewayNoticeProxy.New())
	arg_1_0.facade:registerProxy(SettingsProxy.New())

	return
end

return var_0_0
