local ActivityHeroEnhanceSectionInfoView = class("ActivityHeroEnhanceSectionInfoView", (import("game.views.sectionInfo.SectionInfoBaseView")))

function ActivityHeroEnhanceSectionInfoView:Init()
	ActivityHeroEnhanceSectionInfoView.super.Init(self)

	self.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(self.threeStarGo_)

	self.hideThreeStarController_:SetSelectedState("false")
	self.hideStageDescController_:SetSelectedState("false")
	self.btnWebController_:SetSelectedState("notshow")
	self.hideFatigueController_:SetSelectedState("close")
end

function ActivityHeroEnhanceSectionInfoView:OnClickBtn()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs((ActivityHeroEnhanceTools.GetCfgTalentList(ActivityHeroEnhanceCfg[self.params_.heroEnhance_CfgID]))) do
		var_2_0[TalentTreeCfg[iter_2_1].stage] = iter_2_1
	end

	for iter_2_2 = 1, ActivityHeroEnhanceTools.GetCfgTalentMaxStage(ActivityHeroEnhanceCfg[self.params_.heroEnhance_CfgID]) do
		if not var_2_0[iter_2_2] and not ActivityHeroEnhanceTools.IsCfgTalentStageLock(ActivityHeroEnhanceCfg[self.params_.heroEnhance_CfgID], iter_2_2) then
			break
		end
	end

	self:GoBattle()
end

function ActivityHeroEnhanceSectionInfoView:GoBattle()
	local var_3_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	gameContext:Go("/sectionSelectHero", {
		section = self.stageID_,
		sectionType = self.stageType_,
		activityID = self.params_.activityID,
		heroEnhance_CfgID = self.params_.heroEnhance_CfgID
	})
end

function ActivityHeroEnhanceSectionInfoView:RefreshData()
	ActivityHeroEnhanceSectionInfoView.super.RefreshData(self)

	self.lock_ = not ActivityHeroEnhanceTools.IsCfgStageUnlock(ActivityHeroEnhanceCfg[self.params_.heroEnhance_CfgID], self.stageID_)
	self.lockTips_ = GetTips("ERROR_STAGE_NOT_CLEAR")
	self.dropLibID_ = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).drop_lib_id

	local var_4_0 = ActivityHeroEnhanceData:IsStageClear(self.params_.activityID, self.stageID_)

	self.isFirstClear_ = not var_4_0
	self.cost = 0
	self.threeStarDataList_ = {
		{
			var_4_0,
			{
				8
			}
		},
		{
			false
		},
		{
			false
		}
	}
end

function ActivityHeroEnhanceSectionInfoView:RefreshStageInfo()
	local var_5_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	self.sectionName_.text = GetI18NText(var_5_0.name)
	self.storyText_.text = GetI18NText(var_5_0.tips)
end

function ActivityHeroEnhanceSectionInfoView:RefreshUI()
	ActivityHeroEnhanceSectionInfoView.super.RefreshUI(self)
	self.sectionInfoThreeStarBar_:SetData(self.threeStarDataList_)
end

function ActivityHeroEnhanceSectionInfoView:Dispose()
	self.sectionInfoThreeStarBar_:Dispose()

	self.sectionInfoThreeStarBar_ = nil

	ActivityHeroEnhanceSectionInfoView.super.Dispose(self)
end

return ActivityHeroEnhanceSectionInfoView
