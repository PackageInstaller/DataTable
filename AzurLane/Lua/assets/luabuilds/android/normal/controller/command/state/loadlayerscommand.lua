class = var_0_10000

local var_0_0 = "LoadLayersCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	LOAD_TYPE_LAYER = var_1_0
	var_1_1.type = var_1_0

	local var_1_2 = var_1_1.context

	var_3.extendData(var_1_2, {
		isLayer = true
	})

	SCENE = var_3

	var_3.CheckPreloadData(var_1_1, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10002

		var_2_1(var_2_0, var_2_10002.LOAD_CONTEXT, var_1_1)

		return
	end)

	return
end

return var_0_1
