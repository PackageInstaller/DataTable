local var_0_0 = class("IslandStaticUnitBuilder", import(".IslandGenericBuilder"))

function var_0_0.GetModule(arg_1_0, arg_1_1, arg_1_2)
	return IslandStaticUnit.New(arg_1_1, arg_1_2)
end

function var_0_0.SetTag(arg_2_0, arg_2_1)
	arg_2_1.tag = IslandConst.TAG_NPC

	return
end

function var_0_0.AddComponents(arg_3_0, arg_3_1, arg_3_2)
	return
end

return var_0_0
