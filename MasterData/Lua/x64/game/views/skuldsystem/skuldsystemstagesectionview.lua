SectionInfoBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local SkuldSystemStageSectionView = class("SkuldSystemStageSectionView", SectionInfoBaseView)

function SkuldSystemStageSectionView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_StageBaseUI"
end

function SkuldSystemStageSectionView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		SkuldSystemAction.OpenSkuldBattle(self.levelID_, self.stageType_)
	end)
end

function SkuldSystemStageSectionView:OnEnter()
	self.levelID_ = self.params_.levelID
	self.systemCfg_ = SkuldStageCfg[self.levelID_]
	self.stageID_ = self.systemCfg_.type[2]
	self.stageType_ = self.params_.battleType

	manager.notify:RegistListener(CURRENCY_UPDATE, self.currencyUpdateHandle_)
	self.hideFatigueController_:SetSelectedState("close")
	self.hideStageDescController_:SetSelectedState("false")
	self:RefreshData()
	self:RefreshUI()
	self:RefreshTitleDesc()
end

function SkuldSystemStageSectionView:OnTop()
	self:UpdateBar()
end

function SkuldSystemStageSectionView:OnUpdate()
	if self.levelID_ == self.params_.levelID then
		return
	end

	self.levelID_ = self.params_.levelID
	self.systemCfg_ = SkuldStageCfg[self.levelID_]
	self.stageID_ = self.systemCfg_.type[2]

	self:RefreshData()
	self:RefreshUI()
end

function SkuldSystemStageSectionView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SkuldSystemStageSectionView:RefreshData()
	if SkuldSystemData:GetLevelIDIsOpen(self.levelID_) then
		self.lock_ = false
	else
		self.lock_ = true
		self.lockTips_ = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end

	self.cost_ = 0
	self.isFirstClear_ = not SkuldSystemData:GetLevelIDIsClear(self.levelID_)
	self.dropLibID_ = self.systemCfg_.reward
end

function SkuldSystemStageSectionView:HaveCostCntFlag()
	return false
end

function SkuldSystemStageSectionView:RefreshStageInfo()
	self.skuldLevelNameText_.text = self.systemCfg_.name
	self.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, self.systemCfg_.background_1)
end

function SkuldSystemStageSectionView:RefreshUI()
	SkuldSystemStageSectionView.super.RefreshUI(self)

	self.storyText_.text = formatText(self.systemCfg_.desc)
end

function SkuldSystemStageSectionView:Dispose()
	SkuldSystemStageSectionView.super.Dispose(self)
end

return SkuldSystemStageSectionView
