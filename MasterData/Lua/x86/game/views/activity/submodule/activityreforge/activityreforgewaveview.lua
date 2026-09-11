local ActivityReforgeWaveView = class("ActivityReforgeWaveView", ReduxView)
local var_0_1 = {
	INFO = "info",
	TASK = "task"
}

function ActivityReforgeWaveView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeWaveUI"
end

function ActivityReforgeWaveView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityReforgeWaveView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeWaveView:InitUI()
	self:BindCfgUI()

	self.wavePanelController_ = self.controllerEx_:GetController("wavePanel")
	self.teamInfoController_ = self.controllerEx_:GetController("teamInfo")
	self.levelUpController_ = self.controllerEx_:GetController("levelUp")
	self.waveList_ = LuaList.New(handler(self, self.IndexWaveItem), self.waveListGo_, ActivityReforgeWaveItem)
	self.waveTaskList_ = LuaList.New(handler(self, self.IndexWaveTaskItem), self.waveTaskListGo_, ActivityReforgeWaveTaskItem)
	self.curWaveInfoToggle_ = var_0_1.INFO
	self.waveItemClickHandle_ = handler(self, self.OnWaveItemClick)
	self.curWaveIndex_ = 1
	self.curWaveTeamData_ = nil
	self.skillItemList_ = {}

	for iter_4_0 = 1, 4 do
		self.skillItemList_[iter_4_0] = ActivityReforgeSkillSmallItem.New(self["skillItemGo" .. iter_4_0 .. "_"])
	end

	self.heroHeadItemList_ = {}

	for iter_4_1 = 1, 3 do
		self.heroHeadItemList_[iter_4_1] = ActivityReforgeHeroHeadItem.New(self["heroHeadGo" .. iter_4_1 .. "_"])
	end
end

function ActivityReforgeWaveView:OnWaveItemClick(arg_5_1)
	if self.curWaveIndex_ == arg_5_1 then
		return
	end

	self.curWaveIndex_ = arg_5_1
	self.curWaveID_ = self.levelCfg_.wave_list[self.curWaveIndex_]
	self.curWaveCfg_ = ActivityReforgeWaveCfg[self.curWaveID_]
	self.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(self.curWaveID_)

	self:RefreshWaveList()
	self:RefreshWaveInfoPanel()
	self.wavePanelAni_:Play("WaveUI_item")
end

function ActivityReforgeWaveView:IndexWaveItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.levelCfg_.wave_list[arg_6_1], self.curWaveIndex_)
	arg_6_2:SetClickHandle(self.waveItemClickHandle_)
end

function ActivityReforgeWaveView:IndexWaveTaskItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.curWaveCfg_.task_list[arg_7_1])
end

function ActivityReforgeWaveView:AddUIListeners()
	self:AddBtnListener(self.startBtn_, nil, function()
		if ActivityReforgeData:CheckLevelCanStart() then
			local var_9_0, var_9_1 = ActivityReforgeData:GetCurUsingSkillList()

			if var_9_1 then
				ShowMessageBox({
					content = GetTips("ACTIVITY_REFORGE_SKILL_EMPTY_BATTLE"),
					OkCallback = function()
						BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[self.levelCfg_.wave_list[1]].map_id, {
							activityID = self.activityID_,
							chapterActivityID = self.chapterActivityID_,
							levelID = self.levelID_,
							waveID = self.levelCfg_.wave_list[1],
							skillList = var_9_0,
							battleParams = ActivityReforgeData:GetFrontWaveBattleParams(self.levelCfg_.wave_list[1])
						})))
					end
				})
			else
				BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[self.levelCfg_.wave_list[1]].map_id, {
					activityID = self.activityID_,
					chapterActivityID = self.chapterActivityID_,
					levelID = self.levelID_,
					waveID = self.levelCfg_.wave_list[1],
					skillList = var_9_0,
					battleParams = ActivityReforgeData:GetFrontWaveBattleParams(self.levelCfg_.wave_list[1])
				})))
			end
		else
			ShowTips("ACTIVITY_REFORGE_UNFINISH_ALL_WAVE_TEAM")
		end
	end)
	self:AddBtnListener(self.teamBtn_, nil, function()
		JumpTools.OpenPageByJump("activityReforgeTeamView", {
			chapterActivityID = self.chapterActivityID_,
			levelID = self.levelID_,
			curWaveID = self.curWaveID_
		})
	end)
	self:AddBtnListener(self.toggleBtn_, nil, function()
		if self.curWaveInfoToggle_ == var_0_1.INFO then
			self.curWaveInfoToggle_ = var_0_1.TASK
		elseif self.curWaveInfoToggle_ == var_0_1.TASK then
			self.curWaveInfoToggle_ = var_0_1.INFO
		end

		self:RefreshWaveInfoPanelStatus()
	end)
	self:AddBtnListener(self.resetTeamLevelBtn_, nil, function()
		if self.curWaveTeamData_ and self.curWaveTeamData_.level > 1 then
			ActivityReforgeAction.ResetTeamLevel(self.chapterActivityID_, self.levelID_, self.curWaveTeamData_.teamID)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_NO_LEVELUP")
		end
	end)
	self:AddBtnListener(self.teamLevelUpBtn_, nil, function()
		if self.curWaveTeamData_ and #ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID].team_info > self.curWaveTeamData_.level then
			ActivityReforgeAction.TeamLevelUp(self.chapterActivityID_, self.levelID_, self.curWaveTeamData_.teamID, function()
				self.teamInfoAni_:Play("LevelUp")
			end)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_LEVEL_MAX")
		end
	end)
	self:AddBtnListener(self.passiveSkillBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 2,
			viewType = 2,
			activityID = self.activityID_,
			chapterActivityID = self.chapterActivityID_,
			levelID = self.levelID_
		})
	end)
end

function ActivityReforgeWaveView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.chapterActivityID_ = self.params_.chapterActivityID

	if self.levelID_ == self.params_.levelID then
		-- block empty
	else
		self.levelID_ = self.params_.levelID
		self.curWaveIndex_ = 1
	end

	self.levelCfg_ = ActivityReforgeLevelCfg[self.levelID_]
	self.curWaveID_ = self.levelCfg_.wave_list[self.curWaveIndex_]
	self.curWaveCfg_ = ActivityReforgeWaveCfg[self.curWaveID_]
	self.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(self.curWaveID_)

	self:RefreshWaveList()
	self:RefreshWaveInfoPanel()
	self:RefreshWaveInfoPanelStatus()

	for iter_17_0 = 1, 4 do
		self.skillItemList_[iter_17_0]:SetData(self.activityID_, self.chapterActivityID_, self.levelID_, iter_17_0)
	end

	SetActive(self.passiveNumText_.gameObject, true)

	self.passiveNumText_.text = "+" .. #ActivityReforgeData:GetCurUsingPassiveSkillList()
end

function ActivityReforgeWaveView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_REFORGE_GAMEHELPKEY")
end

function ActivityReforgeWaveView:OnExit()
	manager.windowBar:HideBar()
end

function ActivityReforgeWaveView:RefreshWaveList()
	self.waveList_:StartScroll(#self.levelCfg_.wave_list)
end

function ActivityReforgeWaveView:RefreshWaveInfoPanel()
	self.waveName_.text = string.format(GetTips("ACTIVITY_REFORGE_CUR_WAVE"), self.curWaveIndex_)

	if self.curWaveTeamData_ then
		local var_21_0 = ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID]
		local var_21_1 = {}

		for iter_21_0, iter_21_1 in pairs(ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID].team_info[self.curWaveTeamData_.level]) do
			table.insert(var_21_1, iter_21_1)
		end

		for iter_21_2 = 1, 3 do
			self.heroHeadItemList_[iter_21_2]:SetData(var_21_0.team_info[self.curWaveTeamData_.level][iter_21_2])
			self.heroHeadItemList_[iter_21_2]:SetClickCallBack(function(arg_22_0)
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					hid = arg_22_0,
					type = HeroConst.HERO_DATA_TYPE.TRIAL,
					tempHeroList = var_21_1
				})
			end)
		end

		self.teamInfoController_:SetSelectedState("normal")

		self.levelText_.text = self.curWaveTeamData_.level

		if var_21_0.combo_skill_id > 0 then
			SetActive(self.comboSkillGo_, true)

			self.comboName_.text = GetI18NText(HeroSkillCfg[ComboSkillCfg[var_21_0.combo_skill_id].skill_id].name)
			self.comboLevelText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), ComboSkillCfg[var_21_0.combo_skill_id].maxLevel)
			self.comboIcon_.sprite = getSpriteViaConfig("ComboSkill", ComboSkillCfg[var_21_0.combo_skill_id].skill_id)
		else
			SetActive(self.comboSkillGo_, false)
		end

		self.teamLevelUpCost_.text = var_21_0.cost[self.curWaveTeamData_.level]

		if self.curWaveTeamData_.level == 1 then
			self.levelUpController_:SetSelectedState("noDown")
		elseif #var_21_0.team_info <= self.curWaveTeamData_.level then
			self.levelUpController_:SetSelectedState("noUp")
		else
			self.levelUpController_:SetSelectedState("mid")
		end
	else
		self.teamInfoController_:SetSelectedState("empty")

		self.levelText_.text = 1
	end

	self.waveTaskList_:StartScroll(#self.curWaveCfg_.task_list)

	self.waveDesText_.text = self.curWaveCfg_.description
end

function ActivityReforgeWaveView:RefreshWaveInfoPanelStatus()
	if self.curWaveInfoToggle_ == var_0_1.INFO then
		self.wavePanelController_:SetSelectedState("info")
	elseif self.curWaveInfoToggle_ == var_0_1.TASK then
		self.wavePanelController_:SetSelectedState("task")
	end
end

function ActivityReforgeWaveView:OnActivityReforgeCurLevelUpdate()
	self.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(self.curWaveID_)

	self:RefreshWaveList()
	self:RefreshWaveInfoPanel()
	self:RefreshWaveInfoPanelStatus()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE
	})
end

function ActivityReforgeWaveView:Dispose()
	if self.waveList_ then
		self.waveList_:Dispose()

		self.waveList_ = nil
	end

	if self.waveTaskList_ then
		self.waveTaskList_:Dispose()

		self.waveTaskList_ = nil
	end

	for iter_25_0 = 1, 4 do
		self.skillItemList_[iter_25_0]:Dispose()

		self.skillItemList_[iter_25_0] = nil
	end

	self.skillItemList_ = nil

	for iter_25_1 = 1, 3 do
		self.heroHeadItemList_[iter_25_1]:Dispose()

		self.heroHeadItemList_[iter_25_1] = nil
	end

	self.heroHeadItemList_ = nil

	self.super.Dispose(self)
end

return ActivityReforgeWaveView
