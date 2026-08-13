class = var_0_10000

local var_0_0 = "IslandDelayRecycleUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSceneUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.OnAttach(arg_2_0, arg_2_1)
	var_0_1.super.OnAttach(arg_2_0, arg_2_1)

	Timer = var_2
	arg_2_0.delayRemoveTimer = var_2.New(function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.NotifiyCore

		ISLAND_EVT = var_2_10003

		local var_3_2 = var_2_10003.RMOVE_UNIT

		IslandConst = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.UNIT_LIST_DELAY, arg_2_0.data.id)

		return
	end, arg_2_0.data.delayRecycleTime, 1)

	local var_2_0 = arg_2_0.delayRemoveTimer

	var_2.Start(var_2_0)

	return
end

function var_0_1.OnDetach(arg_4_0)
	if arg_4_0.delayRemoveTimer then
		local var_4_0 = arg_4_0.delayRemoveTimer

		var_1.Stop(var_4_0)

		arg_4_0.delayRemoveTimer = nil
	end

	return
end

return var_0_1
