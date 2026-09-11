local ChipInfoEquipBreakThroughView = class("ChipInfoEquipBreakThroughView", ChipInfoView)

function ChipInfoEquipBreakThroughView:Init()
	ChipInfoEquipBreakThroughView.super.Init(self)
	SetActive(self.goResetBtn_, false)
	SetActive(self.goFilterPanel_, false)
	SetActive(self.transformBtnPanel_.gameObject, false)
end

function ChipInfoEquipBreakThroughView:AddListeners()
	self:AddBtnListener(self.useBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
	self:AddBtnListener(self.unlockBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
	self:AddBtnListener(self.unloadBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
end

function ChipInfoEquipBreakThroughView:OnClickItem(arg_7_1)
	self:Go("/chipEquipBreakThroughInfo", {
		chipManagerID = self.params_.chipManagerID,
		selectChipID = arg_7_1,
		selectChipIndex = self.params_.selectChipIndex
	})
end

function ChipInfoEquipBreakThroughView:GetChipItem()
	return ChipEquipBreakThroughItem
end

function ChipInfoEquipBreakThroughView:GetChipTypeCntList()
	return ChipTools.GetChipTypeCntList(EquipBreakThroughMaterialData:GetChipList())
end

function ChipInfoEquipBreakThroughView:GetChipData()
	return EquipBreakThroughMaterialData:GetChipList()
end

function ChipInfoEquipBreakThroughView:SortChip()
	return ChipTools.SortChip(EquipBreakThroughMaterialData:GetChipList(), self.params_.chipManagerID)
end

function ChipInfoEquipBreakThroughView:GetUnlockChipIDList()
	return EquipBreakThroughMaterialData:GetChipList()
end

function ChipInfoEquipBreakThroughView:RefreshBtnState()
	if table.keyof(self:GetUnlockChipIDList(), self.defaultSelectID_) then
		SetActive(self.lockPanel_, false)

		if table.keyof(self:GetChipData(), self.defaultSelectID_) == nil then
			self.controller_:SetSelectedState("enable")
		else
			self.controller_:SetSelectedState("unload")
		end

		if isMutex then
			self.controller_:SetSelectedState("unuse")
		end
	else
		SetActive(self.lockPanel_, true)
		self.controller_:SetSelectedState("unlock")
	end
end

return ChipInfoEquipBreakThroughView
