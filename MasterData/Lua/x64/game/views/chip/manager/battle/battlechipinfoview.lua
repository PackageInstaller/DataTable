local BattleChipInfoView = class("BattleChipInfoView", (import("game.views.chip.info.ChipInfoView")))

function BattleChipInfoView:OnEnter()
	self.chipManagerDataTemplate_ = self.params_.chipDataTemplate
	self.sectionProxy_ = self.chipManagerDataTemplate_.sectionProxy_

	self.super.OnEnter(self)
end

function BattleChipInfoView:AddListeners()
	self:AddBtnListener(self.useBtn_, nil, function()
		self.chipManagerDataTemplate_:SetUseChipId(self.defaultSelectID_)
		manager.notify:Invoke(ENABLED_CHIP, self.defaultSelectID)
		self.sectionProxy_:InsertMimirChip(self.defaultSelectID_)
	end)
	self:AddBtnListener(self.unlockBtn_, nil, function()
		ChipAction.UnlockChip(self.defaultSelectID_)
	end)
	self:AddBtnListener(self.unloadBtn_, nil, function()
		self.chipManagerDataTemplate_:SetNoUseChipId(self.defaultSelectID_, self.params_.selectChipIndex)
		manager.notify:CallUpdateFunc(UNUSE_BATTLECHIP, self.defaultSelectID_)
		self.sectionProxy_:RemoveMimirChip(self.defaultSelectID_)
	end)
end

function BattleChipInfoView:OnEnabledChip()
	self.currentChipList_ = self:GetChipData()

	self:RefreshUI()
	self.chipUIList_:Refresh()
end

function BattleChipInfoView:GetChipData()
	return (self.sectionProxy_:GetMimirChipList())
end

function BattleChipInfoView:SortChip()
	return ChipTools.SortChip((self:GetChipTypeCntList() or {})[-1], self.params_.chipManagerID)
end

return BattleChipInfoView
