local var_0_0 = class("IslandCheaterTavernTableBuilder", import(".IslandGenericBuilder"))

function var_0_0.GetModule(arg_1_0, arg_1_1, arg_1_2)
	return IslandCheaterTavernTableUnit.New(arg_1_1, arg_1_2)
end

function var_0_0.SetTag(arg_2_0, arg_2_1)
	arg_2_1.tag = IslandConst.TAG_NPC

	return
end

return var_0_0
