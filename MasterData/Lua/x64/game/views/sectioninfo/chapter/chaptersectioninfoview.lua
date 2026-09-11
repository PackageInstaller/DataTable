local ChapterSectionInfoView = class("ChapterSectionInfoView", import("..SectionInfoBaseView"))

function ChapterSectionInfoView:Init()
	ChapterSectionInfoView.super.Init(self)

	self.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(self.threeStarGo_)

	self.hideStageNumController_:SetSelectedState("false")
	self.hideThreeStarController_:SetSelectedState("false")
	self.hideDropPanelController_:SetSelectedState("false")
end

function ChapterSectionInfoView:Dispose()
	self.sectionInfoThreeStarBar_:Dispose()

	self.sectionInfoThreeStarBar_ = nil

	ChapterSectionInfoView.super.Dispose(self)
end

function ChapterSectionInfoView:OnTop()
	self:UpdateBar()
end

function ChapterSectionInfoView:RefreshData()
	ChapterSectionInfoView.super.RefreshData(self)

	local var_4_0 = BattleChapterStageCfg[self.stageID_]

	self.dropLibID_ = BattleChapterStageCfg[self.stageID_].drop_lib_id

	local var_4_1 = BattleStageData:GetStageData()[self.stageID_]

	self.isFirstClear_ = var_4_1 and var_4_1.clear_times <= 0 or true
	self.cost_ = self.isFirstClear_ and (var_4_0.cost or 0) or 0

	self:RefreshLock()
	self:RefreshThreeStarData()
end

function ChapterSectionInfoView:RefreshLock()
	local var_5_0 = BattleChapterStageCfg[self.stageID_]
	local var_5_1 = getChapterAndSectionID(self.stageID_)

	BattleFieldData:SetCacheStage(var_5_1, self.stageID_)

	local var_5_2 = ChapterTools.GetChapterActivity(var_5_1)
	local var_5_3, var_5_4 = ActivityTools.GetActivityIsSuspended(var_5_2)

	if var_5_3 then
		self.lock_, self.lockTips_ = true, GetTips(var_5_4)
	elseif ActivityData:GetActivityIsOpen(var_5_2) then
		self.lock_ = false
	else
		self.lock_ = PlayerData:GetPlayerInfo().userLevel < var_5_0.level
		self.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_5_0.level)
	end

	if self.lock_ then
		return
	end

	local var_5_5 = BattleStageData:GetStageData()

	if not var_5_5[self.stageID_] then
		for iter_5_0, iter_5_1 in pairs(var_5_0.pre_unlock_id_list or {}) do
			if var_5_5[iter_5_1] == nil or var_5_5[iter_5_1] and var_5_5[iter_5_1].clear_times <= 0 then
				self.lock_ = true

				local var_5_7 = getChapterDifficulty(iter_5_1)
				local var_5_8, var_5_9 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(iter_5_1).toggle, iter_5_1)

				self.lockTips_ = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), var_5_7, GetI18NText(var_5_8), GetI18NText(var_5_9))

				return
			end
		end
	end

	self.lock_ = false
end

function ChapterSectionInfoView:RefreshThreeStarData()
	self.threeStarDataList_ = {}

	local var_6_0 = BattleChapterStageCfg[self.stageID_]
	local var_6_1 = BattleStageData:GetStageData()[self.stageID_]

	for iter_6_0 = 1, 3 do
		self.threeStarDataList_[iter_6_0] = {
			var_6_1 and var_6_1.stars[iter_6_0] == 1 or false,
			var_6_0.three_star_need[iter_6_0]
		}
	end
end

function ChapterSectionInfoView:RefreshUI()
	ChapterSectionInfoView.super.RefreshUI(self)
	self.sectionInfoThreeStarBar_:SetData(self.threeStarDataList_)
end

function ChapterSectionInfoView:OnClickBtn()
	local var_8_0 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT

	if BattleStageTools.SkipSectionSelectHero(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.stageID_) then
		BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.stageID_)))

		return
	end

	if StageTools.NeedShowContinueBattleWindow(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.stageID_) then
		JumpTools.OpenPopUp("continueBattleCostPop", {
			stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT,
			stageID = self.stageID_,
			callback = function()
				ChapterTools.DoReadyBattle(var_8_0, self.stageID_)
			end
		})
	else
		ChapterTools.DoReadyBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.stageID_)
	end
end

return ChapterSectionInfoView
