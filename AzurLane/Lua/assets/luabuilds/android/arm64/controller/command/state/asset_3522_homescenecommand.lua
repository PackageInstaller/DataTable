class = var_0_10000

local var_0_0 = "HomeSceneCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)
	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.getType(var_1_2)

	getProxy = var_1_0
	ContextProxy = var_1_10006

	local var_1_4 = var_1_0(var_1_10006)
	local var_1_5 = var_4.getCurrentContext(var_1_4)

	Context = var_1_2

	local var_1_6 = var_1_2.New()

	var_5.extendData(var_1_6, var_1_3)

	SCENE = var_6

	var_6.SetSceneInfo(var_5, var_1_1)

	var_5.cleanStack = true

	local var_1_7 = arg_1_0
	local var_1_8 = arg_1_0.sendNotification

	GAME = var_9

	var_1_8(var_1_7, var_9.LOAD_SCENE, {
		prevContext = var_1_5,
		context = var_5
	})

	return
end

return var_0_1
