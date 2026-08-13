class = var_0_10000

local var_0_0 = "RemoveLayersCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().context

	assert = var_1_10004
	isa = var_1_10005

	local var_1_1 = var_1_0

	Context = var_1_10007

	var_1_10004(var_1_10005(var_1_1, var_1_10007), "should be an instance of Context")

	pg = var_1_10004

	local var_1_2 = var_1_10004.SceneMgr.GetInstance()

	var_4.removeLayer(var_1_2, arg_1_0.facade, var_1_0, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10002

		var_2_1(var_2_0, var_2_10002.REMOVE_LAYER_DONE, var_1_0)

		existCall = var_2_1

		var_2_1(var_0.callback)

		return
	end)

	return
end

return var_0_1
