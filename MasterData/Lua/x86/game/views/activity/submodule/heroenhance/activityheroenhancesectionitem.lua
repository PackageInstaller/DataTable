local ActivityHeroEnhanceSectionItem = class("ActivityHeroEnhanceSectionItem", (import("game.views.sectionSelect.SectionBaseItem")))

function ActivityHeroEnhanceSectionItem:IsOpenSectionInfo()
	return self:IsOpenRoute("activityHeroEnhanceSectionInfo")
end

function ActivityHeroEnhanceSectionItem:OnCtor(arg_2_1, arg_2_2)
	self.gameObject_ = Object.Instantiate(arg_2_1, arg_2_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityHeroEnhanceSectionItem:Init()
	self:InitUI()
	self:AddListeners()
end

function ActivityHeroEnhanceSectionItem:InitUI()
	ActivityHeroEnhanceSectionItem.super.InitUI(self)
end

function ActivityHeroEnhanceSectionItem:RefreshStar()
	local var_5_1 = ActivityHeroEnhanceData:IsStageClear(self.activityId_, self.stageID_)

	for iter_5_0 = 1, 3 do
		self.threeStarBarList_[iter_5_0]:SetData(var_5_1)
	end
end

function ActivityHeroEnhanceSectionItem:GetTag()
	return (BattleHeroEnhanceCfg[self.stageID_] or nil) and (BattleHeroEnhanceCfg[self.stageID_].tag or 0)
end

function ActivityHeroEnhanceSectionItem:GetPosition()
	return (BattleHeroEnhanceCfg[self.stageID_] or nil) and (BattleHeroEnhanceCfg[self.stageID_].position or {
		0,
		0
	})
end

function ActivityHeroEnhanceSectionItem:RefreshData()
	self.enoughLevel_ = true
	self.isLock_ = not self:IsUnlockPreStage()
end

function ActivityHeroEnhanceSectionItem:IsUnlockPreStage()
	return ActivityHeroEnhanceTools.IsCfgStageUnlock(ActivityHeroEnhanceCfg[self.cfgId_], self.stageID_)
end

function ActivityHeroEnhanceSectionItem:SetData(arg_10_1, arg_10_2)
	self.cfgId_ = arg_10_1
	self.activityId_ = ActivityHeroEnhanceCfg[arg_10_1].activity_id
	self.stageID_ = arg_10_2
	self.stageType_ = BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE

	self:RefreshData()
	self:RefreshUI()
end

function ActivityHeroEnhanceSectionItem:SetClickHandler(arg_11_1)
	self.onClickCallback_ = arg_11_1
end

function ActivityHeroEnhanceSectionItem:OnClick()
	if self.onClickCallback_ then
		self.onClickCallback_(self.stageID_, self.isLock_)
	end
end

function ActivityHeroEnhanceSectionItem:RefreshText()
	self.text_.text = GetI18NText(BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).name)
end

return ActivityHeroEnhanceSectionItem
