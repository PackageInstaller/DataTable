class = var_0_10000

local var_0_0 = "LoadSceneCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	LOAD_TYPE_SCENE = var_1_0
	var_1_1.type = var_1_0

	local var_1_3

	if not var_1_1.prevContext then
		getProxy = var_1_3
		ContextProxy = var_1_10004

		local var_1_2 = var_1_3(var_1_10004)

		var_1_3 = var_1_3.getCurrentContext(var_1_2)
	end

	var_1_1.prevContext = var_1_3
	SCENE = var_1_3

	var_1_3.CheckPreloadData(var_1_1, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10002

		var_2_1(var_2_0, var_2_10002.LOAD_CONTEXT, var_1_1)

		return
	end)

	return
end

return var_0_1
