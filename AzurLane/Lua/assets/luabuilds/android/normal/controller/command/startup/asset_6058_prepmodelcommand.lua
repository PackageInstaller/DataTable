class = var_0_10000

local var_0_0 = "PrepModelCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.facade
	local var_1_1 = var_2.registerProxy

	ContextProxy = var_1_10004

	var_1_1(var_1_0, var_1_10004.New({}))

	local var_1_2 = arg_1_0.facade
	local var_1_3 = var_2.registerProxy

	ServerProxy = var_4

	var_1_3(var_1_2, var_4.New({}))

	local var_1_4 = arg_1_0.facade
	local var_1_5 = var_2.registerProxy

	UserProxy = var_4

	var_1_5(var_1_4, var_4.New())

	local var_1_6 = arg_1_0.facade
	local var_1_7 = var_2.registerProxy

	GatewayNoticeProxy = var_4

	var_1_7(var_1_6, var_4.New())

	local var_1_8 = arg_1_0.facade
	local var_1_9 = var_2.registerProxy

	SettingsProxy = var_4

	var_1_9(var_1_8, var_4.New())

	return
end

return var_0_1
