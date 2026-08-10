local var_0_0 = class("ChipManagerEquipBreakThroughView", import("..ChipManagerView"))

function var_0_0.GetChipManagerList(arg_1_0)
	return {
		EquipBreakThroughMaterialData:GetChipManagerID()
	}
end

function var_0_0.GetUnlockChipManagerList(arg_2_0)
	return {
		EquipBreakThroughMaterialData:GetChipManagerID()
	}
end

function var_0_0.GetManagerUnlockView(arg_3_0)
	return ChipManagerUnlockEquipBreakThroughView
end

function var_0_0.GetChipManagerItem(arg_4_0)
	return ChipManagerEquipBreakThroughItem
end

return var_0_0
