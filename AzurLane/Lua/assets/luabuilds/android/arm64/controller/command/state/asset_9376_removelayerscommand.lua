class = var_0_10000

local var_0_0 = "RemoveLayersCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).context

	assert = var_1_0
	isa = var_1_10006

	local var_1_2 = var_1_1

	Context = var_1_10009

	var_1_0(var_1_10006(var_1_2, var_1_10009), "should be an instance of Context")

	pg = var_1_0

	local var_1_3 = var_1_0.SceneMgr.GetInstance()

	var_4.removeLayer(var_1_3, arg_1_0.facade, var_1_1, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		var_2_1(var_2_0, var_2_10003.REMOVE_LAYER_DONE, var_1_1)

		existCall = var_2_1

		var_2_1(var_0.callback)

		return
	end)

	return
end

return var_0_1
