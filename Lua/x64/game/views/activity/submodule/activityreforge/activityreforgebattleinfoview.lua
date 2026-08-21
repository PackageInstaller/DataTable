local var_0_0 = class("ActivityReforgeBattleInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeBattleInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller_ = arg_4_0.controllerEx_:GetController("status")
	arg_4_0.heroHeadItemList_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.heroHeadItemList_[iter_4_0] = ActivityReforgeHeroHeadItem.New(arg_4_0["heroHeadGo" .. iter_4_0 .. "_"])
	end
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.activityID_ = arg_5_0.params_.activityID
	arg_5_0.chapterActivityID_ = arg_5_0.params_.chapterActivityID
	arg_5_0.levelID_ = arg_5_0.params_.levelID
	arg_5_0.waveID_ = arg_5_0.params_.waveID
	arg_5_0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(arg_5_0.waveID_)

	local var_5_0 = ActivityReforgeTeamCfg[arg_5_0.curWaveTeamData_.teamID]

	for iter_5_0 = 1, 3 do
		local var_5_1 = var_5_0.team_info[arg_5_0.curWaveTeamData_.level][iter_5_0]

		arg_5_0.heroHeadItemList_[iter_5_0]:SetData(var_5_1)

		local var_5_2 = HeroStandardSystemCfg[var_5_1].hero_id
		local var_5_3 = ActivityReforgeData:GetFinishWaveHeroInfo(arg_5_0.waveID_, var_5_2)
		local var_5_4
		local var_5_5 = var_5_3.leftHp <= 0 and 0 or var_5_3.leftHp / var_5_3.maxHp

		if var_5_5 <= 0.01 then
			SetActive(arg_5_0["dieGo" .. iter_5_0 .. "_"], true)

			arg_5_0["hpImage" .. iter_5_0 .. "_"].fillAmount = 0
		else
			SetActive(arg_5_0["dieGo" .. iter_5_0 .. "_"], false)

			arg_5_0["hpImage" .. iter_5_0 .. "_"].fillAmount = var_5_5
		end
	end

	arg_5_0.waveNameText_.text = ActivityReforgeWaveCfg[arg_5_0.waveID_].wave_name

	local var_5_6 = ActivityReforgeData:GetWaveFinishData(arg_5_0.waveID_)
	local var_5_7 = manager.time:DescCTime(var_5_6.useSeconds, "%M%S")
	local var_5_8 = var_5_7 % 100
	local var_5_9 = math.floor(var_5_7 / 100) % 100

	if var_5_8 < 10 then
		var_5_8 = "0" .. var_5_8
	end

	if var_5_9 < 10 then
		var_5_9 = "0" .. var_5_9
	end

	arg_5_0.timeText_.text = var_5_9 .. ":" .. var_5_8
	arg_5_0.pointText_.text = var_5_6.losePoint
	arg_5_0.useGoldText_.text = var_5_6.useGold

	local var_5_10 = ActivityReforgeLevelCfg[arg_5_0.levelID_].wave_list
	local var_5_11 = 0
	local var_5_12 = 0
	local var_5_13 = ActivityReforgeData:GetGoldMaxNum(arg_5_0.activityID_)
	local var_5_14 = 0

	for iter_5_1, iter_5_2 in pairs(var_5_10) do
		var_5_11 = var_5_11 + ActivityReforgeWaveCfg[iter_5_2].point

		if iter_5_2 ~= arg_5_0.waveID_ then
			local var_5_15 = ActivityReforgeData:GetWaveFinishData(iter_5_2)

			var_5_12 = var_5_12 + var_5_15.losePoint
			var_5_14 = var_5_14 + var_5_15.useGold
		end
	end

	arg_5_0.pointImage1_.fillAmount = (var_5_12 + var_5_6.losePoint) / var_5_11
	arg_5_0.pointImage2_.fillAmount = var_5_12 / var_5_11
	arg_5_0.useGoldImage1_.fillAmount = (var_5_14 + var_5_6.useGold) / var_5_13
	arg_5_0.useGoldImage2_.fillAmount = var_5_14 / var_5_13

	if table.indexof(var_5_10, arg_5_0.waveID_) == #var_5_10 then
		arg_5_0.isLast_ = true

		arg_5_0.controller_:SetSelectedState("last")
	else
		arg_5_0.isLast_ = false

		arg_5_0.controller_:SetSelectedState("normal")
	end
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.reBattleBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_REFORGE_REBATTLE_CHECK"),
			OkCallback = function()
				local var_9_0 = ActivityReforgeData:GetCurLastWinWaveID()
				local var_9_1 = ActivityReforgeWaveCfg[var_9_0].map_id
				local var_9_2 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, var_9_1, {
					activityID = arg_6_0.activityID_,
					chapterActivityID = arg_6_0.chapterActivityID_,
					levelID = arg_6_0.levelID_,
					waveID = var_9_0,
					skillList = ActivityReforgeData:GetPassWaveUsedSkillList(var_9_0),
					battleParams = ActivityReforgeData:GetFrontWaveBattleParams(var_9_0)
				})

				BattleController.GetInstance():LaunchBattle(var_9_2)
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.continueBtn_, nil, function()
		ActivityReforgeAction.LevelFinish(arg_6_0.chapterActivityID_, arg_6_0.levelID_, function()
			ActivityReforgeAction.RequestAllPlayerLevelData(arg_6_0.chapterActivityID_, arg_6_0.levelID_, function()
				JumpTools.OpenPageByJump("/activityReforgeBattleResultView", {
					activityID = arg_6_0.activityID_,
					chapterActivityID = arg_6_0.chapterActivityID_,
					levelID = arg_6_0.levelID_,
					IsBattleBack = arg_6_0.params_.IsBattleBack,
					stageData = arg_6_0.params_.stageData
				})
			end)
		end)
	end)
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0 = 1, 3 do
		arg_13_0.heroHeadItemList_[iter_13_0]:Dispose()

		arg_13_0.heroHeadItemList_[iter_13_0] = nil
	end

	arg_13_0.heroHeadItemList_ = nil

	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
