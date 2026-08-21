local var_0_0 = class("ActivityReforgeWaveView", ReduxView)
local var_0_1 = {
	INFO = "info",
	TASK = "task"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeWaveUI"
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

	arg_4_0.wavePanelController_ = arg_4_0.controllerEx_:GetController("wavePanel")
	arg_4_0.teamInfoController_ = arg_4_0.controllerEx_:GetController("teamInfo")
	arg_4_0.levelUpController_ = arg_4_0.controllerEx_:GetController("levelUp")
	arg_4_0.waveList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexWaveItem), arg_4_0.waveListGo_, ActivityReforgeWaveItem)
	arg_4_0.waveTaskList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexWaveTaskItem), arg_4_0.waveTaskListGo_, ActivityReforgeWaveTaskItem)
	arg_4_0.curWaveInfoToggle_ = var_0_1.INFO
	arg_4_0.waveItemClickHandle_ = handler(arg_4_0, arg_4_0.OnWaveItemClick)
	arg_4_0.curWaveIndex_ = 1
	arg_4_0.curWaveTeamData_ = nil
	arg_4_0.skillItemList_ = {}

	for iter_4_0 = 1, 4 do
		arg_4_0.skillItemList_[iter_4_0] = ActivityReforgeSkillSmallItem.New(arg_4_0["skillItemGo" .. iter_4_0 .. "_"])
	end

	arg_4_0.heroHeadItemList_ = {}

	for iter_4_1 = 1, 3 do
		arg_4_0.heroHeadItemList_[iter_4_1] = ActivityReforgeHeroHeadItem.New(arg_4_0["heroHeadGo" .. iter_4_1 .. "_"])
	end
end

function var_0_0.OnWaveItemClick(arg_5_0, arg_5_1)
	if arg_5_0.curWaveIndex_ == arg_5_1 then
		return
	end

	arg_5_0.curWaveIndex_ = arg_5_1
	arg_5_0.curWaveID_ = arg_5_0.levelCfg_.wave_list[arg_5_0.curWaveIndex_]
	arg_5_0.curWaveCfg_ = ActivityReforgeWaveCfg[arg_5_0.curWaveID_]
	arg_5_0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(arg_5_0.curWaveID_)

	arg_5_0:RefreshWaveList()
	arg_5_0:RefreshWaveInfoPanel()
	arg_5_0.wavePanelAni_:Play("WaveUI_item")
end

function var_0_0.IndexWaveItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.levelCfg_.wave_list[arg_6_1]

	arg_6_2:SetData(arg_6_1, var_6_0, arg_6_0.curWaveIndex_)
	arg_6_2:SetClickHandle(arg_6_0.waveItemClickHandle_)
end

function var_0_0.IndexWaveTaskItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.curWaveCfg_.task_list[arg_7_1]

	arg_7_2:SetData(var_7_0)
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.startBtn_, nil, function()
		if ActivityReforgeData:CheckLevelCanStart() then
			local var_9_0, var_9_1 = ActivityReforgeData:GetCurUsingSkillList()

			if var_9_1 then
				ShowMessageBox({
					content = GetTips("ACTIVITY_REFORGE_SKILL_EMPTY_BATTLE"),
					OkCallback = function()
						local var_10_0 = ActivityReforgeWaveCfg[arg_8_0.levelCfg_.wave_list[1]].map_id
						local var_10_1 = arg_8_0.levelCfg_.wave_list[1]
						local var_10_2 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, var_10_0, {
							activityID = arg_8_0.activityID_,
							chapterActivityID = arg_8_0.chapterActivityID_,
							levelID = arg_8_0.levelID_,
							waveID = var_10_1,
							skillList = var_9_0,
							battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_10_1)
						})

						BattleController.GetInstance():LaunchBattle(var_10_2)
					end
				})
			else
				local var_9_2 = ActivityReforgeWaveCfg[arg_8_0.levelCfg_.wave_list[1]].map_id
				local var_9_3 = arg_8_0.levelCfg_.wave_list[1]
				local var_9_4 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, var_9_2, {
					activityID = arg_8_0.activityID_,
					chapterActivityID = arg_8_0.chapterActivityID_,
					levelID = arg_8_0.levelID_,
					waveID = var_9_3,
					skillList = var_9_0,
					battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_9_3)
				})

				BattleController.GetInstance():LaunchBattle(var_9_4)
			end
		else
			ShowTips("ACTIVITY_REFORGE_UNFINISH_ALL_WAVE_TEAM")
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.teamBtn_, nil, function()
		JumpTools.OpenPageByJump("activityReforgeTeamView", {
			chapterActivityID = arg_8_0.chapterActivityID_,
			levelID = arg_8_0.levelID_,
			curWaveID = arg_8_0.curWaveID_
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.toggleBtn_, nil, function()
		if arg_8_0.curWaveInfoToggle_ == var_0_1.INFO then
			arg_8_0.curWaveInfoToggle_ = var_0_1.TASK
		elseif arg_8_0.curWaveInfoToggle_ == var_0_1.TASK then
			arg_8_0.curWaveInfoToggle_ = var_0_1.INFO
		end

		arg_8_0:RefreshWaveInfoPanelStatus()
	end)
	arg_8_0:AddBtnListener(arg_8_0.resetTeamLevelBtn_, nil, function()
		if arg_8_0.curWaveTeamData_ and arg_8_0.curWaveTeamData_.level > 1 then
			ActivityReforgeAction.ResetTeamLevel(arg_8_0.chapterActivityID_, arg_8_0.levelID_, arg_8_0.curWaveTeamData_.teamID)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_NO_LEVELUP")
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.teamLevelUpBtn_, nil, function()
		local var_14_0 = #ActivityReforgeTeamCfg[arg_8_0.curWaveTeamData_.teamID].team_info

		if arg_8_0.curWaveTeamData_ and var_14_0 > arg_8_0.curWaveTeamData_.level then
			ActivityReforgeAction.TeamLevelUp(arg_8_0.chapterActivityID_, arg_8_0.levelID_, arg_8_0.curWaveTeamData_.teamID, function()
				arg_8_0.teamInfoAni_:Play("LevelUp")
			end)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_LEVEL_MAX")
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.passiveSkillBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 2,
			viewType = 2,
			activityID = arg_8_0.activityID_,
			chapterActivityID = arg_8_0.chapterActivityID_,
			levelID = arg_8_0.levelID_
		})
	end)
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.activityID_ = arg_17_0.params_.activityID
	arg_17_0.chapterActivityID_ = arg_17_0.params_.chapterActivityID

	if arg_17_0.levelID_ == arg_17_0.params_.levelID then
		-- block empty
	else
		arg_17_0.levelID_ = arg_17_0.params_.levelID
		arg_17_0.curWaveIndex_ = 1
	end

	arg_17_0.levelCfg_ = ActivityReforgeLevelCfg[arg_17_0.levelID_]
	arg_17_0.curWaveID_ = arg_17_0.levelCfg_.wave_list[arg_17_0.curWaveIndex_]
	arg_17_0.curWaveCfg_ = ActivityReforgeWaveCfg[arg_17_0.curWaveID_]
	arg_17_0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(arg_17_0.curWaveID_)

	arg_17_0:RefreshWaveList()
	arg_17_0:RefreshWaveInfoPanel()
	arg_17_0:RefreshWaveInfoPanelStatus()

	for iter_17_0 = 1, 4 do
		arg_17_0.skillItemList_[iter_17_0]:SetData(arg_17_0.activityID_, arg_17_0.chapterActivityID_, arg_17_0.levelID_, iter_17_0)
	end

	local var_17_0 = #ActivityReforgeData:GetCurUsingPassiveSkillList()

	SetActive(arg_17_0.passiveNumText_.gameObject, true)

	arg_17_0.passiveNumText_.text = "+" .. var_17_0
end

function var_0_0.OnTop(arg_18_0)
	local var_18_0 = CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_18_0
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_REFORGE_GAMEHELPKEY")
end

function var_0_0.OnExit(arg_19_0)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshWaveList(arg_20_0)
	arg_20_0.waveList_:StartScroll(#arg_20_0.levelCfg_.wave_list)
end

function var_0_0.RefreshWaveInfoPanel(arg_21_0)
	arg_21_0.waveName_.text = string.format(GetTips("ACTIVITY_REFORGE_CUR_WAVE"), arg_21_0.curWaveIndex_)

	if arg_21_0.curWaveTeamData_ then
		local var_21_0 = ActivityReforgeTeamCfg[arg_21_0.curWaveTeamData_.teamID]
		local var_21_1 = var_21_0.team_info[arg_21_0.curWaveTeamData_.level]
		local var_21_2 = {}

		for iter_21_0, iter_21_1 in pairs(var_21_1) do
			table.insert(var_21_2, iter_21_1)
		end

		for iter_21_2 = 1, 3 do
			arg_21_0.heroHeadItemList_[iter_21_2]:SetData(var_21_0.team_info[arg_21_0.curWaveTeamData_.level][iter_21_2])
			arg_21_0.heroHeadItemList_[iter_21_2]:SetClickCallBack(function(arg_22_0)
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					hid = arg_22_0,
					type = HeroConst.HERO_DATA_TYPE.TRIAL,
					tempHeroList = var_21_2
				})
			end)
		end

		arg_21_0.teamInfoController_:SetSelectedState("normal")

		arg_21_0.levelText_.text = arg_21_0.curWaveTeamData_.level

		if var_21_0.combo_skill_id > 0 then
			SetActive(arg_21_0.comboSkillGo_, true)

			local var_21_3 = var_21_0.combo_skill_id
			local var_21_4 = ComboSkillCfg[var_21_3]
			local var_21_5 = HeroSkillCfg[var_21_4.skill_id]

			arg_21_0.comboName_.text = GetI18NText(var_21_5.name)
			arg_21_0.comboLevelText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), var_21_4.maxLevel)
			arg_21_0.comboIcon_.sprite = getSpriteViaConfig("ComboSkill", var_21_4.skill_id)
		else
			SetActive(arg_21_0.comboSkillGo_, false)
		end

		arg_21_0.teamLevelUpCost_.text = var_21_0.cost[arg_21_0.curWaveTeamData_.level]

		local var_21_6 = #var_21_0.team_info

		if arg_21_0.curWaveTeamData_.level == 1 then
			arg_21_0.levelUpController_:SetSelectedState("noDown")
		elseif var_21_6 <= arg_21_0.curWaveTeamData_.level then
			arg_21_0.levelUpController_:SetSelectedState("noUp")
		else
			arg_21_0.levelUpController_:SetSelectedState("mid")
		end
	else
		arg_21_0.teamInfoController_:SetSelectedState("empty")

		arg_21_0.levelText_.text = 1
	end

	arg_21_0.waveTaskList_:StartScroll(#arg_21_0.curWaveCfg_.task_list)

	arg_21_0.waveDesText_.text = arg_21_0.curWaveCfg_.description
end

function var_0_0.RefreshWaveInfoPanelStatus(arg_23_0)
	if arg_23_0.curWaveInfoToggle_ == var_0_1.INFO then
		arg_23_0.wavePanelController_:SetSelectedState("info")
	elseif arg_23_0.curWaveInfoToggle_ == var_0_1.TASK then
		arg_23_0.wavePanelController_:SetSelectedState("task")
	end
end

function var_0_0.OnActivityReforgeCurLevelUpdate(arg_24_0)
	arg_24_0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(arg_24_0.curWaveID_)

	arg_24_0:RefreshWaveList()
	arg_24_0:RefreshWaveInfoPanel()
	arg_24_0:RefreshWaveInfoPanelStatus()

	local var_24_0 = CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_24_0
	})
end

function var_0_0.Dispose(arg_25_0)
	if arg_25_0.waveList_ then
		arg_25_0.waveList_:Dispose()

		arg_25_0.waveList_ = nil
	end

	if arg_25_0.waveTaskList_ then
		arg_25_0.waveTaskList_:Dispose()

		arg_25_0.waveTaskList_ = nil
	end

	for iter_25_0 = 1, 4 do
		arg_25_0.skillItemList_[iter_25_0]:Dispose()

		arg_25_0.skillItemList_[iter_25_0] = nil
	end

	arg_25_0.skillItemList_ = nil

	for iter_25_1 = 1, 3 do
		arg_25_0.heroHeadItemList_[iter_25_1]:Dispose()

		arg_25_0.heroHeadItemList_[iter_25_1] = nil
	end

	arg_25_0.heroHeadItemList_ = nil

	arg_25_0.super.Dispose(arg_25_0)
end

return var_0_0
