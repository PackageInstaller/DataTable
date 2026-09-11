local ChipManagerEquipBreakThroughView = class("ChipManagerEquipBreakThroughView", import("..ChipManagerView"))

function ChipManagerEquipBreakThroughView:GetChipManagerList()
	return {
		EquipBreakThroughMaterialData:GetChipManagerID()
	}
end

function ChipManagerEquipBreakThroughView:GetUnlockChipManagerList()
	return {
		EquipBreakThroughMaterialData:GetChipManagerID()
	}
end

function ChipManagerEquipBreakThroughView:GetManagerUnlockView()
	return ChipManagerUnlockEquipBreakThroughView
end

function ChipManagerEquipBreakThroughView:GetChipManagerItem()
	return ChipManagerEquipBreakThroughItem
end

return ChipManagerEquipBreakThroughView
