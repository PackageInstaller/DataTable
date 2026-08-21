local var_0_0 = class("IslandManageSystemBuilder", import(".IslandGenericBuilder"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, IslandConst.UNIT_LIST_MANAGE_SYSTEM)

	arg_1_0.cls = arg_1_2

	return
end

function var_0_0.LoadAsset(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2((GameObject.New()))

	return
end

function var_0_0.GetModule(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0.cls.New(arg_3_1, arg_3_2)
end

return var_0_0
