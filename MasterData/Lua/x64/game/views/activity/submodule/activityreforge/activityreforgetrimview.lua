local ActivityReforgeTrimView = class("ActivityReforgeTrimView", ReduxView)
local var_0_1 = {
	INFO = "info",
	TASK = "task"
}

function ActivityReforgeTrimView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeTrimUI"
end

function ActivityReforgeTrimView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityReforgeTrimView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeTrimView:InitUI()
	self:BindCfgUI()

	self.passiveSkillList_ = {}

	for iter_4_0, iter_4_1 in pairs(ActivityReforgeSkillCfg.all) do
		if ActivityReforgeSkillCfg[iter_4_1].type == 0 then
			table.insert(self.passiveSkillList_, iter_4_1)
		end
	end

	self.wavePanelController_ = self.controllerEx_:GetController("wavePanel")
	self.waveTaskList_ = LuaList.New(handler(self, self.IndexWaveTaskItem), self.waveTaskListGo_, ActivityReforgeWaveTaskItem)
	self.curWaveInfoToggle_ = var_0_1.INFO
	self.curWaveTeamData_ = nil
	self.bigSkillItemList_ = {}

	for iter_4_2 = 1, 4 do
		self.bigSkillItemList_[iter_4_2] = ActivityReforgeTrimSkillBigItem.New(self["bigSkillItemGo" .. iter_4_2 .. "_"])
	end

	self.smallSkillItemList_ = {}

	for iter_4_3 = 1, 4 do
		self.smallSkillItemList_[iter_4_3] = ActivityReforgeTrimSkillSmallItem.New(self["smallSkillItemGo" .. iter_4_3 .. "_"])
	end

	self.heroHeadItemList_ = {}

	for iter_4_4 = 1, 3 do
		self.heroHeadItemList_[iter_4_4] = ActivityReforgeHeroHeadItem.New(self["heroHeadGo" .. iter_4_4 .. "_"])
	end
end

function ActivityReforgeTrimView:IndexWaveTaskItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.curWaveCfg_.task_list[arg_5_1])
end

function ActivityReforgeTrimView:AddUIListeners()
	self:AddBtnListener(self.passiveSkillBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 2,
			viewType = 2,
			activityID = self.activityID_,
			chapterActivityID = self.chapterActivityID_,
			levelID = self.levelID_
		})
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		if self.params_.IsBattleBack then
			BattleInstance.QuitBattle(self.params_.stageData)
		else
			JumpTools.Back()
		end
	end)
	self:AddBtnListener(self.reChallengeBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_REFORGE_REBATTLE_CHECK"),
			OkCallback = function()
				local var_10_0 = ActivityReforgeData:GetCurLastWinWaveID()

				BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[var_10_0].map_id, {
					activityID = self.activityID_,
					chapterActivityID = self.chapterActivityID_,
					levelID = self.levelID_,
					waveID = var_10_0,
					skillList = ActivityReforgeData:GetPassWaveUsedSkillList(var_10_0),
					battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_10_0)
				})))
			end
		})
	end)
	self:AddBtnListener(self.nextBtn_, nil, function()
		local var_11_0, var_11_1 = ActivityReforgeData:GetCurUsingSkillList()

		if var_11_1 then
			ShowMessageBox({
				content = GetTips("ACTIVITY_REFORGE_SKILL_EMPTY_BATTLE"),
				OkCallback = function()
					local var_12_0 = ActivityReforgeData:GetCurNextWaveID()

					BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[var_12_0].map_id, {
						activityID = self.activityID_,
						chapterActivityID = self.chapterActivityID_,
						levelID = self.levelID_,
						waveID = self.curWaveID_,
						skillList = ActivityReforgeData:GetCurUsingSkillList(),
						battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_12_0)
					})))
				end
			})
		else
			local var_11_2 = ActivityReforgeData:GetCurNextWaveID()

			BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[var_11_2].map_id, {
				activityID = self.activityID_,
				chapterActivityID = self.chapterActivityID_,
				levelID = self.levelID_,
				waveID = self.curWaveID_,
				skillList = ActivityReforgeData:GetCurUsingSkillList(),
				battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_11_2)
			})))
		end
	end)
	self:AddBtnListener(self.toggleBtn_, nil, function()
		if self.curWaveInfoToggle_ == var_0_1.INFO then
			self.curWaveInfoToggle_ = var_0_1.TASK
		elseif self.curWaveInfoToggle_ == var_0_1.TASK then
			self.curWaveInfoToggle_ = var_0_1.INFO
		end

		self:RefreshWaveInfoPanelStatus()
	end)
	self:AddBtnListener(self.battleInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("activityReforgeBattleInfoView", {
			activityID = self.activityID_,
			chapterActivityID = self.chapterActivityID_,
			levelID = self.levelID_,
			waveID = ActivityReforgeData:GetCurLastWinWaveID()
		})
	end)
end

function ActivityReforgeTrimView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.chapterActivityID_ = self.params_.chapterActivityID
	self.levelID_ = self.params_.levelID
	self.levelCfg_ = ActivityReforgeLevelCfg[self.levelID_]
	self.curWaveID_ = ActivityReforgeData:GetCurNextWaveID()
	self.curWaveCfg_ = ActivityReforgeWaveCfg[self.curWaveID_]
	self.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(self.curWaveID_)
	self.curUsingPassiveSkillList_ = ActivityReforgeData:GetCurUsingPassiveSkillList()

	self:RefreshWaveInfoPanel()
	self:RefreshWaveInfoPanelStatus()
	self:RefreshSkillInfoPanel()
	self:CheckIsPopBattleInfoView()
end

function ActivityReforgeTrimView:OnTop()
	if not self.params_.IsBattleBack then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function ActivityReforgeTrimView:OnExit()
	if not self.params_.IsBattleBack then
		manager.windowBar:HideBar()
	end
end

function ActivityReforgeTrimView:RefreshWaveInfoPanel()
	for iter_18_0 = 1, 3 do
		self.heroHeadItemList_[iter_18_0]:SetData(ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID].team_info[self.curWaveTeamData_.level][iter_18_0])
	end

	self.levelText_.text = self.curWaveTeamData_.level

	if ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID].combo_skill_id > 0 then
		SetActive(self.comboSkillGo_, true)

		self.comboName_.text = GetI18NText(HeroSkillCfg[ComboSkillCfg[ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID].combo_skill_id].skill_id].name)
		self.comboSkillLevelText_.text = ComboSkillCfg[ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID].combo_skill_id].maxLevel
		self.comboIcon_.sprite = getSpriteViaConfig("ComboSkill", ComboSkillCfg[ActivityReforgeTeamCfg[self.curWaveTeamData_.teamID].combo_skill_id].skill_id)
	else
		SetActive(self.comboSkillGo_, false)
	end

	self.waveTaskList_:StartScroll(#self.curWaveCfg_.task_list)

	self.waveDesText_.text = self.curWaveCfg_.description
	self.waveIndexText_.text = "休整阶段-波次" .. table.indexof(self.levelCfg_.wave_list, self.curWaveID_)
end

function ActivityReforgeTrimView:RefreshWaveInfoPanelStatus()
	if self.curWaveInfoToggle_ == var_0_1.INFO then
		self.wavePanelController_:SetSelectedState("info")
	elseif self.curWaveInfoToggle_ == var_0_1.TASK then
		self.wavePanelController_:SetSelectedState("task")
	end
end

function ActivityReforgeTrimView:RefreshSkillInfoPanel()
	local var_20_0 = 0

	for iter_20_0 = 1, 4 do
		self.bigSkillItemList_[iter_20_0]:SetData(self.activityID_, self.chapterActivityID_, self.levelID_, iter_20_0)

		if ActivityReforgeData:GetInitiativeSkillUseNum(iter_20_0) == 1 then
			var_20_0 = var_20_0 + 1
		end
	end

	for iter_20_1 = 1, 4 do
		if self.curUsingPassiveSkillList_[iter_20_1] then
			self.smallSkillItemList_[iter_20_1]:SetData(self.activityID_, self.chapterActivityID_, self.levelID_, self.curUsingPassiveSkillList_[iter_20_1])
		else
			self.smallSkillItemList_[iter_20_1]:SetData(self.activityID_, self.chapterActivityID_, self.levelID_, 0)
		end
	end

	self.initiativeUseText_.text = var_20_0 .. "/" .. 4
	self.passiveUseText_.text = #self.curUsingPassiveSkillList_ .. "/" .. #self.passiveSkillList_
	self.overFlowText_.text = #self.curUsingPassiveSkillList_ - 4 > 0 and "+" .. #self.curUsingPassiveSkillList_ - 4 or "+" .. 0
end

function ActivityReforgeTrimView:CheckIsPopBattleInfoView()
	if self.params_.IsBattleBack and ActivityReforgeData:GetCachePopBattleInfoView() then
		ActivityReforgeData:SetCachePopBattleInfoView(false)
		JumpTools.OpenPageByJump("activityReforgeBattleInfoView", {
			activityID = self.activityID_,
			chapterActivityID = self.chapterActivityID_,
			levelID = self.levelID_,
			waveID = ActivityReforgeData:GetCurLastWinWaveID()
		})
	end
end

function ActivityReforgeTrimView:Dispose()
	if self.waveTaskList_ then
		self.waveTaskList_:Dispose()

		self.waveTaskList_ = nil
	end

	for iter_22_0 = 1, 4 do
		self.bigSkillItemList_[iter_22_0]:Dispose()

		self.bigSkillItemList_[iter_22_0] = nil
	end

	self.bigSkillItemList_ = nil

	for iter_22_1 = 1, 4 do
		self.smallSkillItemList_[iter_22_1]:Dispose()

		self.smallSkillItemList_[iter_22_1] = nil
	end

	self.smallSkillItemList_ = nil

	for iter_22_2 = 1, 3 do
		self.heroHeadItemList_[iter_22_2]:Dispose()

		self.heroHeadItemList_[iter_22_2] = nil
	end

	self.heroHeadItemList_ = nil

	self.super.Dispose(self)
end

return ActivityReforgeTrimView
