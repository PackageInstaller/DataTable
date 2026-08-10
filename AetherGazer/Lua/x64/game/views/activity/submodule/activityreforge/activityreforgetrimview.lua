local var_0_0 = class("ActivityReforgeTrimView", ReduxView)
local var_0_1 = {
	INFO = "info",
	TASK = "task"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeTrimUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.passiveSkillList_ = {}

	for iter_4_0, iter_4_1 in pairs(ActivityReforgeSkillCfg.all) do
		if ActivityReforgeSkillCfg[iter_4_1].type == 0 then
			table.insert(arg_4_0.passiveSkillList_, iter_4_1)
		end
	end

	arg_4_0.wavePanelController_ = arg_4_0.controllerEx_:GetController("wavePanel")
	arg_4_0.waveTaskList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexWaveTaskItem), arg_4_0.waveTaskListGo_, ActivityReforgeWaveTaskItem)
	arg_4_0.curWaveInfoToggle_ = var_0_1.INFO
	arg_4_0.curWaveTeamData_ = nil
	arg_4_0.bigSkillItemList_ = {}

	for iter_4_2 = 1, 4 do
		arg_4_0.bigSkillItemList_[iter_4_2] = ActivityReforgeTrimSkillBigItem.New(arg_4_0["bigSkillItemGo" .. iter_4_2 .. "_"])
	end

	arg_4_0.smallSkillItemList_ = {}

	for iter_4_3 = 1, 4 do
		arg_4_0.smallSkillItemList_[iter_4_3] = ActivityReforgeTrimSkillSmallItem.New(arg_4_0["smallSkillItemGo" .. iter_4_3 .. "_"])
	end

	arg_4_0.heroHeadItemList_ = {}

	for iter_4_4 = 1, 3 do
		arg_4_0.heroHeadItemList_[iter_4_4] = ActivityReforgeHeroHeadItem.New(arg_4_0["heroHeadGo" .. iter_4_4 .. "_"])
	end
end

function var_0_0.IndexWaveTaskItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.curWaveCfg_.task_list[arg_5_1]

	arg_5_2:SetData(var_5_0)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.passiveSkillBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 2,
			viewType = 2,
			activityID = arg_6_0.activityID_,
			chapterActivityID = arg_6_0.chapterActivityID_,
			levelID = arg_6_0.levelID_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		if arg_6_0.params_.IsBattleBack then
			BattleInstance.QuitBattle(arg_6_0.params_.stageData)
		else
			JumpTools.Back()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.reChallengeBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_REFORGE_REBATTLE_CHECK"),
			OkCallback = function()
				local var_10_0 = ActivityReforgeData:GetCurLastWinWaveID()
				local var_10_1 = ActivityReforgeWaveCfg[var_10_0].map_id
				local var_10_2 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, var_10_1, {
					activityID = arg_6_0.activityID_,
					chapterActivityID = arg_6_0.chapterActivityID_,
					levelID = arg_6_0.levelID_,
					waveID = var_10_0,
					skillList = ActivityReforgeData:GetPassWaveUsedSkillList(var_10_0),
					battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_10_0)
				})

				BattleController.GetInstance():LaunchBattle(var_10_2)
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.nextBtn_, nil, function()
		local var_11_0, var_11_1 = ActivityReforgeData:GetCurUsingSkillList()

		if var_11_1 then
			ShowMessageBox({
				content = GetTips("ACTIVITY_REFORGE_SKILL_EMPTY_BATTLE"),
				OkCallback = function()
					local var_12_0 = ActivityReforgeData:GetCurNextWaveID()
					local var_12_1 = ActivityReforgeWaveCfg[var_12_0].map_id
					local var_12_2 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, var_12_1, {
						activityID = arg_6_0.activityID_,
						chapterActivityID = arg_6_0.chapterActivityID_,
						levelID = arg_6_0.levelID_,
						waveID = arg_6_0.curWaveID_,
						skillList = ActivityReforgeData:GetCurUsingSkillList(),
						battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_12_0)
					})

					BattleController.GetInstance():LaunchBattle(var_12_2)
				end
			})
		else
			local var_11_2 = ActivityReforgeData:GetCurNextWaveID()
			local var_11_3 = ActivityReforgeWaveCfg[var_11_2].map_id
			local var_11_4 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, var_11_3, {
				activityID = arg_6_0.activityID_,
				chapterActivityID = arg_6_0.chapterActivityID_,
				levelID = arg_6_0.levelID_,
				waveID = arg_6_0.curWaveID_,
				skillList = ActivityReforgeData:GetCurUsingSkillList(),
				battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_11_2)
			})

			BattleController.GetInstance():LaunchBattle(var_11_4)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.toggleBtn_, nil, function()
		if arg_6_0.curWaveInfoToggle_ == var_0_1.INFO then
			arg_6_0.curWaveInfoToggle_ = var_0_1.TASK
		elseif arg_6_0.curWaveInfoToggle_ == var_0_1.TASK then
			arg_6_0.curWaveInfoToggle_ = var_0_1.INFO
		end

		arg_6_0:RefreshWaveInfoPanelStatus()
	end)
	arg_6_0:AddBtnListener(arg_6_0.battleInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("activityReforgeBattleInfoView", {
			activityID = arg_6_0.activityID_,
			chapterActivityID = arg_6_0.chapterActivityID_,
			levelID = arg_6_0.levelID_,
			waveID = ActivityReforgeData:GetCurLastWinWaveID()
		})
	end)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.activityID_ = arg_15_0.params_.activityID
	arg_15_0.chapterActivityID_ = arg_15_0.params_.chapterActivityID
	arg_15_0.levelID_ = arg_15_0.params_.levelID
	arg_15_0.levelCfg_ = ActivityReforgeLevelCfg[arg_15_0.levelID_]
	arg_15_0.curWaveID_ = ActivityReforgeData:GetCurNextWaveID()
	arg_15_0.curWaveCfg_ = ActivityReforgeWaveCfg[arg_15_0.curWaveID_]
	arg_15_0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(arg_15_0.curWaveID_)
	arg_15_0.curUsingPassiveSkillList_ = ActivityReforgeData:GetCurUsingPassiveSkillList()

	arg_15_0:RefreshWaveInfoPanel()
	arg_15_0:RefreshWaveInfoPanelStatus()
	arg_15_0:RefreshSkillInfoPanel()
	arg_15_0:CheckIsPopBattleInfoView()
end

function var_0_0.OnTop(arg_16_0)
	if not arg_16_0.params_.IsBattleBack then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.OnExit(arg_17_0)
	if not arg_17_0.params_.IsBattleBack then
		manager.windowBar:HideBar()
	end
end

function var_0_0.RefreshWaveInfoPanel(arg_18_0)
	local var_18_0 = ActivityReforgeTeamCfg[arg_18_0.curWaveTeamData_.teamID]

	for iter_18_0 = 1, 3 do
		arg_18_0.heroHeadItemList_[iter_18_0]:SetData(var_18_0.team_info[arg_18_0.curWaveTeamData_.level][iter_18_0])
	end

	arg_18_0.levelText_.text = arg_18_0.curWaveTeamData_.level

	if var_18_0.combo_skill_id > 0 then
		SetActive(arg_18_0.comboSkillGo_, true)

		local var_18_1 = var_18_0.combo_skill_id
		local var_18_2 = ComboSkillCfg[var_18_1]
		local var_18_3 = HeroSkillCfg[var_18_2.skill_id]

		arg_18_0.comboName_.text = GetI18NText(var_18_3.name)
		arg_18_0.comboSkillLevelText_.text = var_18_2.maxLevel
		arg_18_0.comboIcon_.sprite = getSpriteViaConfig("ComboSkill", var_18_2.skill_id)
	else
		SetActive(arg_18_0.comboSkillGo_, false)
	end

	arg_18_0.waveTaskList_:StartScroll(#arg_18_0.curWaveCfg_.task_list)

	arg_18_0.waveDesText_.text = arg_18_0.curWaveCfg_.description
	arg_18_0.waveIndexText_.text = "休整阶段-波次" .. table.indexof(arg_18_0.levelCfg_.wave_list, arg_18_0.curWaveID_)
end

function var_0_0.RefreshWaveInfoPanelStatus(arg_19_0)
	if arg_19_0.curWaveInfoToggle_ == var_0_1.INFO then
		arg_19_0.wavePanelController_:SetSelectedState("info")
	elseif arg_19_0.curWaveInfoToggle_ == var_0_1.TASK then
		arg_19_0.wavePanelController_:SetSelectedState("task")
	end
end

function var_0_0.RefreshSkillInfoPanel(arg_20_0)
	local var_20_0 = 0

	for iter_20_0 = 1, 4 do
		arg_20_0.bigSkillItemList_[iter_20_0]:SetData(arg_20_0.activityID_, arg_20_0.chapterActivityID_, arg_20_0.levelID_, iter_20_0)

		if ActivityReforgeData:GetInitiativeSkillUseNum(iter_20_0) == 1 then
			var_20_0 = var_20_0 + 1
		end
	end

	for iter_20_1 = 1, 4 do
		if arg_20_0.curUsingPassiveSkillList_[iter_20_1] then
			arg_20_0.smallSkillItemList_[iter_20_1]:SetData(arg_20_0.activityID_, arg_20_0.chapterActivityID_, arg_20_0.levelID_, arg_20_0.curUsingPassiveSkillList_[iter_20_1])
		else
			arg_20_0.smallSkillItemList_[iter_20_1]:SetData(arg_20_0.activityID_, arg_20_0.chapterActivityID_, arg_20_0.levelID_, 0)
		end
	end

	arg_20_0.initiativeUseText_.text = var_20_0 .. "/" .. 4
	arg_20_0.passiveUseText_.text = #arg_20_0.curUsingPassiveSkillList_ .. "/" .. #arg_20_0.passiveSkillList_

	local var_20_1 = #arg_20_0.curUsingPassiveSkillList_ - 4

	if var_20_1 > 0 then
		arg_20_0.overFlowText_.text = "+" .. var_20_1
	else
		arg_20_0.overFlowText_.text = "+" .. 0
	end
end

function var_0_0.CheckIsPopBattleInfoView(arg_21_0)
	if arg_21_0.params_.IsBattleBack and ActivityReforgeData:GetCachePopBattleInfoView() then
		ActivityReforgeData:SetCachePopBattleInfoView(false)
		JumpTools.OpenPageByJump("activityReforgeBattleInfoView", {
			activityID = arg_21_0.activityID_,
			chapterActivityID = arg_21_0.chapterActivityID_,
			levelID = arg_21_0.levelID_,
			waveID = ActivityReforgeData:GetCurLastWinWaveID()
		})
	end
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.waveTaskList_ then
		arg_22_0.waveTaskList_:Dispose()

		arg_22_0.waveTaskList_ = nil
	end

	for iter_22_0 = 1, 4 do
		arg_22_0.bigSkillItemList_[iter_22_0]:Dispose()

		arg_22_0.bigSkillItemList_[iter_22_0] = nil
	end

	arg_22_0.bigSkillItemList_ = nil

	for iter_22_1 = 1, 4 do
		arg_22_0.smallSkillItemList_[iter_22_1]:Dispose()

		arg_22_0.smallSkillItemList_[iter_22_1] = nil
	end

	arg_22_0.smallSkillItemList_ = nil

	for iter_22_2 = 1, 3 do
		arg_22_0.heroHeadItemList_[iter_22_2]:Dispose()

		arg_22_0.heroHeadItemList_[iter_22_2] = nil
	end

	arg_22_0.heroHeadItemList_ = nil

	arg_22_0.super.Dispose(arg_22_0)
end

return var_0_0
