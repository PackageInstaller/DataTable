local SubPlotSectionInfoView = class("SubPlotSectionInfoView", import("..SectionInfoBaseView"))

function SubPlotSectionInfoView:Init()
	SubPlotSectionInfoView.super.Init(self)
	self.hideStageNumController_:SetSelectedState("true")
	self.hideStageDescController_:SetSelectedState("false")
	self.hideDropPanelController_:SetSelectedState("false")
end

function SubPlotSectionInfoView:OnTop()
	self:UpdateBar()
end

function SubPlotSectionInfoView:OnClickBtn()
	local var_3_0 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT

	if StageTools.NeedShowContinueBattleWindow(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT, self.stageID_) then
		JumpTools.OpenPopUp("continueBattleCostPop", {
			stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT,
			stageID = self.stageID_,
			callback = function()
				ChapterTools.DoReadyBattle(var_3_0, self.stageID_)
			end
		})
	else
		ChapterTools.DoReadyBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT, self.stageID_)
	end
end

function SubPlotSectionInfoView:CheckLock()
	local var_5_0 = BattleActivityStoryStageCfg[self.stageID_]
	local var_5_1 = self.params_.activityId

	if self.params_.activityId == 0 or var_5_1 == nil then
		var_5_1 = ChapterTools.GetChapterActivity(self.params_.chapterID)
	end

	local var_5_2, var_5_3 = ActivityTools.GetActivityIsSuspended(var_5_1)

	if var_5_2 then
		return true, GetTips(var_5_3)
	elseif PlayerData:GetPlayerInfo().userLevel < var_5_0.level then
		return true, GetTipsF("PLAYER_LEVEL_UNLOCK", var_5_0.level)
	end

	return false
end

function SubPlotSectionInfoView:RefreshData()
	self.lock_, self.lockTips_ = self:CheckLock()

	print(self.lock_, self.lockTips_)

	if ChapterCfg[self.params_.chapterID].activity_id ~= 0 then
		local var_6_0 = ActivityData:GetActivityData(ChapterCfg[self.params_.chapterID].activity_id)
		local var_6_1 = manager.time:GetServerTime()

		self.dropLibID_ = var_6_1 > var_6_0.startTime and var_6_1 <= var_6_0.stopTime and BattleActivityStoryStageCfg[self.stageID_].drop_lib_id_list[1] or BattleActivityStoryStageCfg[self.stageID_].drop_lib_id_list[2]
	else
		self.dropLibID_ = BattleActivityStoryStageCfg[self.stageID_].drop_lib_id_list[2]
	end

	self.isFirstClear_ = BattleStageData:GetStageData()[self.stageID_] and BattleStageData:GetStageData()[self.stageID_].clear_times <= 0 or true

	if self.isFirstClear_ then
		local var_6_2 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

		self.cost_ = type(var_6_2.extra_cost) == "table" and var_6_2.extra_cost[1] and (var_6_2.extra_cost[2] or 0) or var_6_2.cost or 0
	else
		self.cost_ = 0
	end

	BattleFieldData:SetCacheStage(getChapterAndSectionID(self.stageID_), self.stageID_)
end

function SubPlotSectionInfoView:RefreshStageInfo()
	if self.oldCfgID_ ~= BattleActivityStoryStageCfg[self.stageID_].id then
		self.sectionText_.text = ""
		self.sectionName_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleActivityStoryStageCfg[self.stageID_].background_1))
		self.oldCfgID_ = BattleActivityStoryStageCfg[self.stageID_].id
		self.storyText_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].tips)
	end
end

return SubPlotSectionInfoView
