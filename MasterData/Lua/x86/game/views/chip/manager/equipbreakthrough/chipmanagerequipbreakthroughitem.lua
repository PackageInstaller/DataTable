local ChipManagerEquipBreakThroughItem = class("ChipManagerEquipBreakThroughItem", import("..ChipManagerItem"))

function ChipManagerEquipBreakThroughItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		return
	end)
end

function ChipManagerEquipBreakThroughItem:GetUnlockChipManagerList()
	return {}
end

function ChipManagerEquipBreakThroughItem:GetEnabledChipManagerID()
	return EquipBreakThroughMaterialData:GetChipManagerID()
end

function ChipManagerEquipBreakThroughItem:BindRedPoint()
	return
end

function ChipManagerEquipBreakThroughItem:UnbindRedPoint()
	return
end

function ChipManagerEquipBreakThroughItem:RefreshUI(arg_7_1)
	ChipManagerEquipBreakThroughItem.super.RefreshUI(self, arg_7_1)
	SetActive(self.lockGo_)
end

return ChipManagerEquipBreakThroughItem
