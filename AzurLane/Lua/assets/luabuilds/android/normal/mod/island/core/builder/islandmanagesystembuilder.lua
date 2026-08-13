class = var_0_10000

local var_0_0 = "IslandManageSystemBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandGenericBuilder"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	IslandConst = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_10006.UNIT_LIST_MANAGE_SYSTEM)

	arg_1_0.cls = arg_1_2

	return
end

function var_0_1.LoadAsset(arg_2_0, arg_2_1, arg_2_2)
	GameObject = var_1_10003

	local var_2_0 = var_1_10003.New()

	arg_2_2(var_2_0)

	return
end

function var_0_1.GetModule(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0.cls.New(arg_3_1, arg_3_2)
end

return var_0_1
