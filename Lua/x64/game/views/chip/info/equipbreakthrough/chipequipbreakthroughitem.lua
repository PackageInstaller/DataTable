local var_0_0 = class("ChipEquipBreakThroughItem", import("..ChipItem"))

function var_0_0.GetUnlockChipIDList(arg_1_0)
	return EquipBreakThroughMaterialData:GetChipList()
end

function var_0_0.GetManagerData(arg_2_0, arg_2_1)
	return EquipBreakThroughMaterialData:GetChipList()
end

function var_0_0.BindRedPoint(arg_3_0)
	return
end

function var_0_0.UnbindRedPoint(arg_4_0)
	return
end

return var_0_0
