class = var_0_10000

local var_0_0 = "IslandVirtualInteractBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandItemInteractBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandVirtualInteractUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.Load(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {}
	local var_2_1

	table = var_1_10005

	var_1_10005.insert(var_2_0, function(arg_3_0)
		GameObject = var_2_10001
		var_2_1 = var_2_10001.New("VirtualInteractUnit" .. arg_2_1.id)

		arg_3_0()

		return
	end)

	table = var_5

	var_5.insert(var_2_0, function(arg_4_0)
		local var_4_0 = arg_2_0
		local var_4_1 = var_1.SetupBT
		local var_4_2 = var_2_1
		local var_4_3 = arg_2_1

		var_4_1(var_4_0, var_4_2, var_4.GetBehaviourTree(var_4_3), arg_4_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_2_0, function()
		arg_2_2(var_2_1)

		return
	end)

	return
end

return var_0_1
