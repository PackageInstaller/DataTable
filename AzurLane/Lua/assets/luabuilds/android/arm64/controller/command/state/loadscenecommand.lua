class = var_0_10000

local var_0_0 = "LoadSceneCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	LOAD_TYPE_SCENE = var_1_10003
	var_1_0.type = var_1_10003

	local var_1_2

	if not var_1_0.prevContext then
		getProxy = var_1_2
		ContextProxy = var_1_10005

		local var_1_1 = var_1_2(var_1_10005)

		var_1_2 = var_1_2.getCurrentContext(var_1_1)
	end

	var_1_0.prevContext = var_1_2
	SCENE = var_1_2

	var_1_2.CheckPreloadData(var_1_0, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		var_2_1(var_2_0, var_2_10003.LOAD_CONTEXT, var_1_0)

		return
	end)

	return
end

return var_0_1
