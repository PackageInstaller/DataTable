class = var_0_10000

local var_0_0 = "ReloadSceneCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	ContextProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.popContext(var_1_2)

	var_4.extendData(var_1_3, var_1_1)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.sendNotification

	GAME = var_7

	var_1_5(var_1_4, var_7.LOAD_SCENE, {
		context = var_4,
		prevContext = var_4
	})

	return
end

return var_0_1
