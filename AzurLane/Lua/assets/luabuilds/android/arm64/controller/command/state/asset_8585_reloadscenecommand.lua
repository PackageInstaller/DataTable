class = var_0_10000

local var_0_0 = "ReloadSceneCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	ContextProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.popContext(var_1_1)

	var_4.extendData(var_1_2, var_1_0)

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.sendNotification

	GAME = var_8

	var_1_4(var_1_3, var_8.LOAD_SCENE, {
		context = var_4,
		prevContext = var_4
	})

	return
end

return var_0_1
