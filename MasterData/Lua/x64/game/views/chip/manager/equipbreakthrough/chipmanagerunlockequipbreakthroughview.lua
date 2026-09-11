local ChipManagerUnlockEquipBreakThroughView = class("ChipManagerUnlockEquipBreakThroughView", import("..ChipManagerUnlockView"))

function ChipManagerUnlockEquipBreakThroughView:Ctor(arg_1_1)
	ChipManagerUnlockEquipBreakThroughView.super.Ctor(self, arg_1_1)
	SetActive(self.goScheme_, false)
end

function ChipManagerUnlockEquipBreakThroughView:AddListeners()
	self:AddBtnListener(self.useBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
	self:AddBtnListener(self.unloadBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)

	for iter_2_0 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		self:AddBtnListener(self[string.format("chipBtn%s_", iter_2_0)], nil, function()
			self:Go("/chipEquipBreakThroughInfo", {
				chipManagerID = self.chipManagerID_,
				selectChipIndex = iter_2_0
			})
		end)
	end
end

function ChipManagerUnlockEquipBreakThroughView:RefreshBtn()
	SetActive(self.unloadBtnGo_, false)
	SetActive(self.useBtnGo_, false)
end

function ChipManagerUnlockEquipBreakThroughView:GetChipData()
	return EquipBreakThroughMaterialData:GetChipList()
end

function ChipManagerUnlockEquipBreakThroughView:GetEnabledManagerID()
	return EquipBreakThroughMaterialData:GetChipManagerID()
end

function ChipManagerUnlockEquipBreakThroughView:BindRedPoint()
	return
end

function ChipManagerUnlockEquipBreakThroughView:UnbindRedPoint()
	return
end

return ChipManagerUnlockEquipBreakThroughView
