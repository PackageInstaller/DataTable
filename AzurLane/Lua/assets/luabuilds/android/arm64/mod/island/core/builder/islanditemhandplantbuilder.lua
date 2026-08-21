local var_0_0 = class("IslandItemHandPlantBuilder", import(".IslandGenericBuilder"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_0.GetModule(arg_2_0, arg_2_1, arg_2_2)
	return IslandHandPlantUnit.New(arg_2_1, arg_2_2)
end

function var_0_0.SetTag(arg_3_0, arg_3_1)
	arg_3_1.tag = IslandConst.TAG_NPC

	return
end

function var_0_0.AddComponents(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:AddComponent(typeof(HighlightController))

	return
end

return var_0_0
