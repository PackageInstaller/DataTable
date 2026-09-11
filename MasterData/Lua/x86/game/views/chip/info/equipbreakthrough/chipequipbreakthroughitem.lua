local ChipEquipBreakThroughItem = class("ChipEquipBreakThroughItem", import("..ChipItem"))

function ChipEquipBreakThroughItem:GetUnlockChipIDList()
	return EquipBreakThroughMaterialData:GetChipList()
end

function ChipEquipBreakThroughItem:GetManagerData(arg_2_1)
	return EquipBreakThroughMaterialData:GetChipList()
end

function ChipEquipBreakThroughItem:BindRedPoint()
	return
end

function ChipEquipBreakThroughItem:UnbindRedPoint()
	return
end

return ChipEquipBreakThroughItem
