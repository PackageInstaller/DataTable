local Chapter19SectionInfoView = class("Chapter19SectionInfoView", import("..SectionInfoBaseView"))

function Chapter19SectionInfoView:Init()
	Chapter19SectionInfoView.super.Init(self)
	self.hideStageNumController_:SetSelectedState("true")
	self.hideStageDescController_:SetSelectedState("false")
	self.hideDropPanelController_:SetSelectedState("true")
	self.showTipsController_:SetSelectedState("true")
end

function Chapter19SectionInfoView:Dispose()
	Chapter19SectionInfoView.super.Dispose(self)
end

function Chapter19SectionInfoView:OnTop()
	self:UpdateBar()
end

function Chapter19SectionInfoView:RefreshData()
	Chapter19SectionInfoView.super.RefreshData(self)

	local var_4_0 = BattleChapterStageCfg[self.stageID_]

	self.dropLibID_ = BattleChapterStageCfg[self.stageID_].drop_lib_id

	local var_4_1 = BattleStageData:GetStageData()[self.stageID_]

	self.isFirstClear_ = var_4_1 and var_4_1.clear_times <= 0 or true
	self.cost_ = self.isFirstClear_ and (var_4_0.cost or 0) or 0

	self:RefreshLock()
end

function Chapter19SectionInfoView:RefreshLock()
	local var_5_0 = BattleChapterStageCfg[self.stageID_]
	local var_5_1 = getChapterAndSectionID(self.stageID_)

	BattleFieldData:SetCacheStage(var_5_1, self.stageID_)

	if ActivityData:GetActivityIsOpen(ChapterCfg[var_5_1].activity_id) then
		self.lock_ = false
	else
		self.lock_ = PlayerData:GetPlayerInfo().userLevel < var_5_0.level
		self.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_5_0.level)

		if self.lock_ then
			return
		end
	end

	local var_5_2 = BattleStageData:GetStageData()

	for iter_5_0, iter_5_1 in pairs(var_5_0.pre_unlock_id_list or {}) do
		if var_5_2[iter_5_1] == nil or var_5_2[iter_5_1] and var_5_2[iter_5_1].clear_times <= 0 then
			self.lock_ = true

			local var_5_3 = getChapterDifficulty(iter_5_1)
			local var_5_4, var_5_5 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(iter_5_1).toggle, iter_5_1)

			self.lockTips_ = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), var_5_3, GetI18NText(var_5_4), GetI18NText(var_5_5))

			return
		end
	end

	self.lock_ = false
end

function Chapter19SectionInfoView:RefreshStageInfo()
	Chapter19SectionInfoView.super.RefreshStageInfo(self)

	self.storyText_.text = GetI18NText(BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).tips)
end

function Chapter19SectionInfoView:OnClickBtn()
	ChapterTools.DoReadyBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.stageID_)
end

return Chapter19SectionInfoView
