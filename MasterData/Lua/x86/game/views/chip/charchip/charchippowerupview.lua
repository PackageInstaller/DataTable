local CharChipPowerupView = class("CharChipPowerupView", ReduxView)

function CharChipPowerupView:UIName()
	return "Widget/System/Administrators/AdministratorsChipPowerupUI"
end

function CharChipPowerupView:UIParent()
	return manager.ui.uiPop.transform
end

function CharChipPowerupView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = self.conEx_:GetController("infoShow")
end

function CharChipPowerupView:AddListeners()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()

		if self.level_ == #ChipTools.GetCharChipExtraIDList(self.baseID_) then
			-- block empty
		end
	end)
end

function CharChipPowerupView:OnEnter()
	self.baseID_ = self.params_.baseID
	self.level_ = #ChipTools.GetCharChipExtraIDListUnlock(self.baseID_)

	self:RefreshUI()
end

function CharChipPowerupView:OnExit()
	return
end

function CharChipPowerupView:RefreshUI()
	self.iconImg_.sprite = ChipTools.GetCharChipIcon(self.baseID_, true)

	if self.level_ > 0 then
		self.titleText_.text = GetTips("ADMIN_CHIP_PASS_UNLOCK")
		self.skillText_.text = ChipCfg[ChipTools.GetCharChipExtraIDList(self.baseID_)[self.level_]].desc
	else
		self.titleText_.text = GetTips("ADMIN_CHIP_ACT_UNLOCK")
		self.skillText_.text = ChipCfg[self.baseID_].desc
	end
end

function CharChipPowerupView:Dispose()
	CharChipPowerupView.super.Dispose(self)
end

return CharChipPowerupView
