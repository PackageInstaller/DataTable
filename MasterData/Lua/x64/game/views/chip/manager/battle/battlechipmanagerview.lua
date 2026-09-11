local BattleChipManagerView = class("BattleChipManagerView", (import("game.views.chip.manager.ChipManagerView")))

function BattleChipManagerView:SetViewParam()
	self.chipManagerDataTemplate_:SetTeamInfo(self.params_.stageType, self.params_.stageID, self.params_.sectionProxy and self.params_.sectionProxy or SectionSelectHeroTools.GetProxyClass(self.params_.stageType).New({
		section = self.params_.stageID,
		sectionType = self.params_.stageType
	}, self.params_.reserveParams or ReserveTools.GetReserveParams(self.params_.stageType, self.params_.stageID)))
end

function BattleChipManagerView:OnUpdate()
	self.defaultSelectID_ = self.params_.chipManagerID or self.chipManagerList_[1]

	self:RefreshUI()
end

function BattleChipManagerView:RefreshUI()
	BattleChipManagerView.super.RefreshUI(self)
	self:RefreshList()
end

function BattleChipManagerView:RefreshList()
	self.chipManagerUIList_:Refresh()
end

function BattleChipManagerView:GetChipManagerItem()
	return BattleChipManagerItem
end

function BattleChipManagerView:GetChipManagerList()
	return ChipTools.SortChipManager((self.chipManagerDataTemplate_.sectionProxy_:GetMimirID()))
end

function BattleChipManagerView:GetChipDataTemplate()
	local var_7_0 = ChipManagerDataTemplate.New({
		id = self.defaultSelectID_,
		unlockChipManagerIDList_ = self:GetUnlockChipManagerList(),
		unlockChipIDList_ = self:GetUnlockChipList()
	})

	var_7_0:SetChipInfoViewPath("/battleChipInfo")

	return var_7_0
end

function BattleChipManagerView:OnSchemeBtn()
	JumpTools.OpenPageByJump("battleChipScheme", {
		chipManagerID = self.chipManagerID_,
		template = self.chipManagerDataTemplate_
	})
end

function BattleChipManagerView:EnableChipManagerIDFunc(arg_9_1)
	self.chipManagerDataTemplate_.sectionProxy_:SetMimirID(arg_9_1)
	self:RefreshUI()
	self.chipManagerUIList_:Refresh()
end

return BattleChipManagerView
