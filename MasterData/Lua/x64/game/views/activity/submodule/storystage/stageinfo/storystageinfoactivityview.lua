SectionInfoBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local SotryStageInfoActivityView = class("SotryStageInfoActivityView", SectionInfoBaseView)

function SotryStageInfoActivityView:InitUI()
	SotryStageInfoActivityView.super.InitUI(self)
	SetActive(self.tipsPanel_, true)

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")

	self.controller_:SetSelectedState("activity")

	if self.readyTxt_ then
		self.readyTxt_.text = GetTips("BATTLE_READY_1")
	end
end

function SotryStageInfoActivityView:OnClickBtn()
	if BattleConst.BATTLE_TAG.STORY == BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).tag then
		BattleController.GetInstance():LaunchStoryBattle(self.stageType_, self.stageID_, ActivityStoryChapterCfg[self.params_.chapterID].activity_id)
	else
		self:Go("/sectionSelectHero", {
			section = self.stageID_,
			sectionType = self.stageType_,
			activityID = ActivityStoryChapterCfg[self.params_.chapterID].activity_id
		})
	end
end

function SotryStageInfoActivityView:RefreshData()
	SotryStageInfoActivityView.super.RefreshData(self)

	local var_3_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	self.lock_ = PlayerData:GetPlayerInfo().userLevel < var_3_0.level
	self.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_3_0.level)
	self.drop_lib_id = var_3_0.drop_lib_id_list[1]
	self.isFirstClear_ = StoryStageActivityData:GetStageData(self.params_.chapterID)[self.stageID_].clear_times <= 0
	self.cost = var_3_0.cost or 0
end

function SotryStageInfoActivityView:RefreshStageInfo()
	local var_4_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	if self.oldCfgID_ ~= var_4_0.id then
		self.sectionName_.text = GetI18NText(var_4_0.name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_4_0.background_1))
		self.textStory_.text = GetI18NText(var_4_0.tips)
		self.oldCfgID_ = var_4_0.id
	end
end

return SotryStageInfoActivityView
