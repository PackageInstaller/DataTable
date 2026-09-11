local ActivityReforgeBattleInfoView = class("ActivityReforgeBattleInfoView", ReduxView)

function ActivityReforgeBattleInfoView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeBattleInfoUI"
end

function ActivityReforgeBattleInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityReforgeBattleInfoView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeBattleInfoView:InitUI()
	self:BindCfgUI()

	self.controller_ = self.controllerEx_:GetController("status")
	self.heroHeadItemList_ = {}

	for iter_4_0 = 1, 3 do
		self.heroHeadItemList_[iter_4_0] = ActivityReforgeHeroHeadItem.New(self["heroHeadGo" .. iter_4_0 .. "_"])
	end
end

function ActivityReforgeBattleInfoView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.chapterActivityID_ = self.params_.chapterActivityID
	self.levelID_ = self.params_.levelID
	self.waveID_ = self.params_.waveID
	self.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(self.waveID_)

	for iter_5_0 = 1, 3 do
		self.heroHeadItemList_[iter_5_0]:SetData(ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID].team_info[self.curWaveTeamData_.level][iter_5_0])

		local var_5_0 = ActivityReforgeData:GetFinishWaveHeroInfo(self.waveID_, HeroStandardSystemCfg[ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID].team_info[self.curWaveTeamData_.level][iter_5_0]].hero_id)

		if (var_5_0.leftHp <= 0 and 0 or var_5_0.leftHp / var_5_0.maxHp) <= 0.01 then
			SetActive(self["dieGo" .. iter_5_0 .. "_"], true)

			self["hpImage" .. iter_5_0 .. "_"].fillAmount = 0
		else
			SetActive(self["dieGo" .. iter_5_0 .. "_"], false)

			self["hpImage" .. iter_5_0 .. "_"].fillAmount = var_5_1
		end
	end

	self.waveNameText_.text = ActivityReforgeWaveCfg[self.waveID_].wave_name

	local var_5_3 = ActivityReforgeData:GetWaveFinishData(self.waveID_)
	local var_5_4 = manager.time:DescCTime(var_5_3.useSeconds, "%M%S")
	local var_5_5 = var_5_4 % 100
	local var_5_6 = math.floor(var_5_4 / 100) % 100

	if var_5_4 % 100 < 10 then
		var_5_5 = "0" .. var_5_5
	end

	if var_5_6 < 10 then
		var_5_6 = "0" .. var_5_6
	end

	self.timeText_.text = var_5_6 .. ":" .. var_5_5
	self.pointText_.text = var_5_3.losePoint
	self.useGoldText_.text = var_5_3.useGold

	local var_5_7 = 0
	local var_5_8 = 0
	local var_5_9 = ActivityReforgeData:GetGoldMaxNum(self.activityID_)
	local var_5_10 = 0

	for iter_5_1, iter_5_2 in pairs(ActivityReforgeLevelCfg[self.levelID_].wave_list) do
		var_5_7 = var_5_7 + ActivityReforgeWaveCfg[iter_5_2].point

		if iter_5_2 ~= self.waveID_ then
			local var_5_11 = ActivityReforgeData:GetWaveFinishData(iter_5_2)

			var_5_8 = var_5_8 + var_5_11.losePoint
			var_5_10 = var_5_10 + var_5_11.useGold
		end
	end

	self.pointImage1_.fillAmount = (var_5_8 + var_5_3.losePoint) / var_5_7
	self.pointImage2_.fillAmount = var_5_8 / var_5_7
	self.useGoldImage1_.fillAmount = (var_5_10 + var_5_3.useGold) / var_5_9
	self.useGoldImage2_.fillAmount = var_5_10 / var_5_9

	if table.indexof(ActivityReforgeLevelCfg[self.levelID_].wave_list, self.waveID_) == #ActivityReforgeLevelCfg[self.levelID_].wave_list then
		self.isLast_ = true

		self.controller_:SetSelectedState("last")
	else
		self.isLast_ = false

		self.controller_:SetSelectedState("normal")
	end
end

function ActivityReforgeBattleInfoView:AddUIListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.reBattleBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_REFORGE_REBATTLE_CHECK"),
			OkCallback = function()
				local var_9_0 = ActivityReforgeData:GetCurLastWinWaveID()

				BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[var_9_0].map_id, {
					activityID = self.activityID_,
					chapterActivityID = self.chapterActivityID_,
					levelID = self.levelID_,
					waveID = var_9_0,
					skillList = ActivityReforgeData:GetPassWaveUsedSkillList(var_9_0),
					battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_9_0)
				})))
			end
		})
	end)
	self:AddBtnListener(self.continueBtn_, nil, function()
		ActivityReforgeAction.LevelFinish(self.chapterActivityID_, self.levelID_, function()
			ActivityReforgeAction.RequestAllPlayerLevelData(self.chapterActivityID_, self.levelID_, function()
				JumpTools.OpenPageByJump("/activityReforgeBattleResultView", {
					activityID = self.activityID_,
					chapterActivityID = self.chapterActivityID_,
					levelID = self.levelID_,
					IsBattleBack = self.params_.IsBattleBack,
					stageData = self.params_.stageData
				})
			end)
		end)
	end)
end

function ActivityReforgeBattleInfoView:Dispose()
	for iter_13_0 = 1, 3 do
		self.heroHeadItemList_[iter_13_0]:Dispose()

		self.heroHeadItemList_[iter_13_0] = nil
	end

	self.heroHeadItemList_ = nil

	self.super.Dispose(self)
end

return ActivityReforgeBattleInfoView
