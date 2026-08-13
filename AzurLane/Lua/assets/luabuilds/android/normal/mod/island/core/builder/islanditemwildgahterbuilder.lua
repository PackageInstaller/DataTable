class = var_0_10000

local var_0_0 = "IslandItemWildGahterBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandGenericBuilder"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.GetModule(arg_2_0, arg_2_1, arg_2_2)
	IslandWildGatherUnit = var_1_10003

	return var_1_10003.New(arg_2_1, arg_2_2)
end

function var_0_1.SetTag(arg_3_0, arg_3_1)
	IslandConst = var_1_10002
	arg_3_1.tag = var_1_10002.TAG_NPC

	return
end

function var_0_1.AddComponents(arg_4_0, arg_4_1, arg_4_2)
	return
end

return var_0_1
