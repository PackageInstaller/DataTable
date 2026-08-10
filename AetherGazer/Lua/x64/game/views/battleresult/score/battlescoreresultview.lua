local var_0_0 = class("BattleScoreResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/OsirisMultipletUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.tweens_ = {}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListener()

	arg_4_0.heroItemView_ = {}
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.resultTypeController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "resultType")
	arg_5_0.scoreTypeController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "scoreType")

	LeanTween.alphaCanvas(arg_5_0.mask_, 0, 0.1)

	local var_5_0 = arg_5_0.params_.noOnceMore

	SetActive(arg_5_0.closePanel_, var_5_0)
	SetActive(arg_5_0.onceMoreGo_, not var_5_0)
	SetActive(arg_5_0.closeBtnGo_, not var_5_0)
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnBack_, nil, function()
		arg_6_0:CloseFunc()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnClose_, nil, function()
		arg_6_0:CloseFunc()
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonMask_, nil, function()
		arg_6_0:EndAnimator()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnBattleCount_, nil, function()
		arg_6_0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = arg_6_0.stageData,
			battleTime = arg_6_0:GetBattleTime()
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnOk_, nil, function()
		if arg_6_0.params_.okHandler then
			arg_6_0.params_.okHandler()
		end

		arg_6_0:CloseFunc()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnGiveUp_, nil, function()
		if arg_6_0.params_.giveUpHandler then
			arg_6_0.params_.giveUpHandler()
		end

		arg_6_0:CloseFunc()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnOnceMore_, nil, function()
		arg_6_0:OnClickRestart()
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.stageData = arg_14_0.params_.stageData
	arg_14_0.stageId = arg_14_0.stageData:GetStageId()
	arg_14_0.stageType = arg_14_0.stageData:GetType()

	BattleInstance.hideBattlePanel()
	arg_14_0:RefreshUI()

	if arg_14_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_14_0:CloseFunc()
			end
		})
	end
end

function var_0_0.CloseFunc(arg_16_0)
	OperationRecorder.Record(arg_16_0.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(arg_16_0.stageData)
end

function var_0_0.ShowVitalityBox(arg_17_0, arg_17_1)
	if needShowVitalityFullBox(arg_17_0:GetRewardData()) then
		showVitalitySendMail(arg_17_1)
	else
		arg_17_1()
	end
end

function var_0_0.RefreshUI(arg_18_0)
	if arg_18_0.params_.resultType == "choose" then
		arg_18_0.resultTypeController_:SetSelectedState("choose")
	else
		arg_18_0.resultTypeController_:SetSelectedState("score")
	end

	arg_18_0:SetLevelTitle()
	arg_18_0:RefreshMyExpS()
	arg_18_0:RefreshHeroS()
	arg_18_0:RefreshCommonUI()

	if arg_18_0.params_.scoreType == "hp" then
		arg_18_0.scoreTypeController_:SetSelectedState("hp")
		arg_18_0:RefreshHp()
	else
		arg_18_0.scoreTypeController_:SetSelectedState("score")
		arg_18_0:RefreshScore()
	end

	arg_18_0:RefreshBattleTime()
end

function var_0_0.SetLevelTitle(arg_19_0)
	local var_19_0, var_19_1 = BattleStageTools.GetChapterSectionIndex(arg_19_0.stageType, arg_19_0.stageId)

	if var_19_0 ~= "" then
		arg_19_0.stareText_.text = string.format("%s-%s", GetI18NText(var_19_0), GetI18NText(var_19_1))
	else
		arg_19_0.stareText_.text = ""
	end

	arg_19_0.lvText_.text = BattleStageTools.GetStageName(arg_19_0.stageType, arg_19_0.stageId)

	if arg_19_0.params_.scoreType == "hp" then
		if arg_19_0.params_.title ~= nil and arg_19_0.params_.title ~= "" then
			arg_19_0.hpTitleText_.text = arg_19_0.params_.title
		end
	elseif arg_19_0.params_.title ~= nil and arg_19_0.params_.title ~= "" then
		arg_19_0.titleText_.text = GetI18NText(arg_19_0.params_.title)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.titleTransform_)
end

function var_0_0.RefreshMyExpS(arg_20_0)
	local var_20_0 = arg_20_0.params_.battleResult.oldPlayerEXPInfo
	local var_20_1 = var_20_0.userLevel
	local var_20_2 = var_20_0.remain_exp
	local var_20_3 = arg_20_0.stageData:GetAddUserExp() * arg_20_0.stageData:GetMultiple()
	local var_20_4 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_20_5 = math.min(var_20_3, var_20_4 - var_20_0.total_exp)

	if var_20_5 < 0 then
		var_20_5 = 0
	end

	local var_20_6, var_20_7 = LvTools.CheckExp(var_20_1, var_20_2 + var_20_5, "user_level_exp")

	if var_20_1 > 30 and var_20_6 - var_20_1 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_20_2), tostring(var_20_5), tostring(var_20_1), tostring(var_20_6)))
	end

	arg_20_0.newPlayerExp_ = var_20_5
	arg_20_0.addExp_.text = string.format("+%d", var_20_5)

	local var_20_8 = math.floor(var_20_2 / GameLevelSetting[var_20_1].user_level_exp * 1000) / 1000
	local var_20_9 = math.floor(var_20_7 / GameLevelSetting[var_20_6].user_level_exp * 1000) / 1000

	var_20_8 = var_20_8 > 0.99 and 0.99 or var_20_8
	var_20_9 = var_20_9 > 0.99 and 0.99 or var_20_9

	arg_20_0:RemoveTween()

	arg_20_0.userExp_ = var_20_6 + var_20_9

	if var_20_3 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_20_10 = -1

	arg_20_0.tween_ = LeanTween.value(arg_20_0.progress_.gameObject, var_20_1 + var_20_8, var_20_6 + var_20_9, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
		local var_21_0 = math.modf(arg_21_0)

		if var_20_10 == -1 then
			var_20_10 = var_21_0
		end

		if var_21_0 ~= var_20_10 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_20_10 = var_21_0
		end

		arg_20_0:UpdateUserData(arg_21_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_20_0.mask_.blocksRaycasts = false

		arg_20_0:CheckLevelUp()
		arg_20_0:RemoveTween()
	end))
end

function var_0_0.UpdateUserData(arg_23_0, arg_23_1)
	local var_23_0, var_23_1 = math.modf(arg_23_1)
	local var_23_2 = GameLevelSetting[var_23_0].user_level_exp

	arg_23_0.playerLv_.text = string.format("%d", var_23_0)

	if LvTools.GetIsMaxLv(var_23_0, "user") then
		arg_23_0.progress_.value = 1
	else
		arg_23_0.progress_.value = var_23_1
	end
end

function var_0_0.CheckLevelUp(arg_24_0)
	local var_24_0 = arg_24_0:GetLevelUpInfoList()

	if #var_24_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_24_0
		})
	end
end

function var_0_0.GetLevelUpInfoList(arg_25_0)
	return PlayerData:GetlevelUpInfos()
end

function var_0_0.RefreshHeroS(arg_26_0)
	local var_26_0, var_26_1 = arg_26_0.stageData:GetHeroTeam()
	local var_26_2 = arg_26_0.stageData:GetSystemHeroTeam()

	for iter_26_0 = 1, 3 do
		local var_26_3 = arg_26_0[string.format("hero%s_", iter_26_0)]

		if not var_26_0[iter_26_0] or var_26_0[iter_26_0] == 0 then
			SetActive(var_26_3, false)
		else
			SetActive(var_26_3, true)

			local var_26_4 = arg_26_0.stageData:GetHeroDataByPos(iter_26_0)
			local var_26_5 = var_26_2[iter_26_0] or var_26_1[iter_26_0] ~= 0

			table.insert(arg_26_0.heroItemView_, BattleMultipleResultHeroItem.New(var_26_3, var_26_4, arg_26_0.stageData, var_26_5, arg_26_0.params_.battleResult.heroDataCollect[iter_26_0]))
		end
	end
end

function var_0_0.RefreshCommonUI(arg_27_0)
	local var_27_0 = true

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_27_0.stageType then
		local var_27_1 = BattleChapterStageCfg[arg_27_0.stageId].tag

		if BattleConst.BATTLE_TAG.STORY == var_27_1 then
			var_27_0 = false
		end
	end

	SetActive(arg_27_0.btnBattleCount_.gameObject, var_27_0)
end

function var_0_0.RefreshHp(arg_28_0)
	local var_28_0 = 100

	if arg_28_0.params_.hp and arg_28_0.params_.totalHp then
		var_28_0 = math.ceil(100 * arg_28_0.params_.hp / arg_28_0.params_.totalHp)
	end

	arg_28_0.hpProgressBar_.fillAmount = var_28_0 / 100
	arg_28_0.hpValueText_.text = var_28_0 .. "%"
end

function var_0_0.RefreshScore(arg_29_0)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == arg_29_0.stageType then
		arg_29_0:RefreshBossAdvanceScore()

		return
	end

	if BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == arg_29_0.stageType then
		arg_29_0.scoreText_.text = ActivityAttributeArenaData:GetArenaScore(arg_29_0.stageData:GetActivityID(), arg_29_0.stageData:GetDest())

		return
	end

	if arg_29_0.params_.score then
		arg_29_0.scoreText_.text = arg_29_0.params_.score
	else
		local var_29_0 = arg_29_0.stageData:GetActivityID()
		local var_29_1 = ActivityTools.GetActivityTheme(var_29_0)

		if var_29_1 == ActivityConst.THEME.SUMMER or var_29_0 == ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION then
			local var_29_2 = 0
			local var_29_3 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
			local var_29_4 = GameSetting.limit_calculation_time_score_args.value
			local var_29_5 = var_29_4[1]
			local var_29_6 = var_29_4[2]
			local var_29_7 = var_29_4[3]
			local var_29_8 = var_29_4[4]

			if var_29_3 < var_29_7 then
				var_29_2 = var_29_5 * var_29_7 + var_29_6
			elseif var_29_3 < var_29_8 then
				var_29_2 = var_29_5 * var_29_3 + var_29_6
			else
				var_29_2 = var_29_5 * var_29_8 + var_29_6
			end

			local var_29_9 = 0
			local var_29_10 = 0
			local var_29_11, var_29_12, var_29_13 = BattleTools.GetBattleStatisticsData()
			local var_29_14 = tonumber(tostring(var_29_11[1].hurt))
			local var_29_15 = GameSetting.limit_calculation_injured_score_args.value

			if var_29_14 >= var_29_15[#var_29_15][1] then
				var_29_14 = var_29_15[#var_29_15][1]
			end

			for iter_29_0, iter_29_1 in ipairs(var_29_15) do
				if var_29_14 <= iter_29_1[1] then
					var_29_9 = iter_29_1[2]

					break
				end
			end

			local var_29_16 = arg_29_0.stageData:GetDest()
			local var_29_17 = ActivityLimitCalculationCfg[var_29_16].reward_point
			local var_29_18 = math.floor((var_29_2 + var_29_9) * var_29_17 / 100)

			arg_29_0.scoreText_.text = math.ceil(var_29_18)
		elseif var_29_1 == ActivityConst.THEME.FACTORY or ActivityConst.THEME.TYR then
			local var_29_19 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

			arg_29_0.scoreText_.text = var_29_19 .. "s"
		end
	end
end

function var_0_0.RefreshBossAdvanceScore(arg_30_0)
	local var_30_0 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
	local var_30_1 = arg_30_0.stageData:GetBossIndex()
	local var_30_2 = BattleBossChallengeAdvanceData:GetBossList()[var_30_1]
	local var_30_3 = var_30_2.multipleIndex
	local var_30_4 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point[var_30_2.multipleIndex]
	local var_30_5 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua

	for iter_30_0, iter_30_1 in pairs(var_30_2.condition[BossConst.TYPE_STAGE]) do
		if BattleInstance.CaculateStar(arg_30_0.stageData, StageChallengeConditionPoolCfg[iter_30_1].condition, var_30_5).isComplete then
			var_30_4 = var_30_4 + StageChallengeConditionPoolCfg[iter_30_1].point
		end
	end

	for iter_30_2, iter_30_3 in pairs(var_30_2.condition[BossConst.TYPE_AFFIX]) do
		var_30_4 = var_30_4 + ActivityAffixPoolCfg[iter_30_3].point
	end

	local var_30_6 = var_30_4

	arg_30_0.scoreText_.text = var_30_6
end

function var_0_0.RefreshBattleTime(arg_31_0)
	arg_31_0.battleTimeText_.text = arg_31_0:GetBattleTime()

	local var_31_0 = arg_31_0.stageData:GetActivityID()

	SetActive(arg_31_0.battleTimeText_.gameObject, ActivityTools.GetActivityTheme(var_31_0) ~= ActivityConst.THEME.FACTORY)
end

function var_0_0.GetBattleTime(arg_32_0)
	local var_32_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_32_0)
end

function var_0_0.HeroAnimator(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0, var_33_1 = math.modf(arg_33_2)

	arg_33_0.heroLv_[arg_33_1].text = string.format("%d", var_33_0)

	if LvTools.GetIsMaxLv(var_33_0, "hero") then
		arg_33_0.heroProgress_[arg_33_1].value = 1
	else
		arg_33_0.heroProgress_[arg_33_1].value = var_33_1
	end
end

function var_0_0.RemoveTween(arg_34_0)
	if arg_34_0.tween_ then
		arg_34_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_34_0.tween_.id)

		arg_34_0.tween_ = nil
	end
end

function var_0_0.RemoveTweens(arg_35_0)
	if arg_35_0.tweens_ then
		for iter_35_0, iter_35_1 in pairs(arg_35_0.tweens_) do
			arg_35_0:RemoveTweenAt(iter_35_0)
		end

		arg_35_0.tweens_ = nil
	end
end

function var_0_0.RemoveTweenAt(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.tweens_[arg_36_1]

	if var_36_0 then
		var_36_0:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(var_36_0.id)
	end
end

function var_0_0.EndAnimator(arg_37_0)
	arg_37_0:RemoveTween()
	arg_37_0:RemoveTweens()
	manager.audio:StopEffect()

	if arg_37_0.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	arg_37_0:UpdateUserData(arg_37_0.userExp_)
	arg_37_0:CheckLevelUp()

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.heroItemView_) do
		iter_37_1:EndAnimator()
	end

	arg_37_0.mask_.blocksRaycasts = false
end

function var_0_0.OnClickRestart(arg_38_0)
	if arg_38_0.params_.condition then
		local var_38_0, var_38_1 = arg_38_0.params_.condition()

		if var_38_0 then
			BattleController.GetInstance():LaunchBattle(arg_38_0.params_.stageData)
		else
			ShowTips(var_38_1)
		end
	else
		BattleController.GetInstance():LaunchBattle(arg_38_0.params_.stageData)
	end
end

function var_0_0.OnTop(arg_39_0)
	SetActive(arg_39_0.gameObject_, true)

	arg_39_0.toStat_ = false
end

function var_0_0.OnBehind(arg_40_0)
	if arg_40_0.toStat_ then
		SetActive(arg_40_0.gameObject_, false)
	end
end

function var_0_0.OnExit(arg_41_0)
	return
end

function var_0_0.Dispose(arg_42_0)
	for iter_42_0, iter_42_1 in ipairs(arg_42_0.heroItemView_) do
		iter_42_1:Dispose()
	end

	arg_42_0.heroItemView_ = nil

	arg_42_0:RemoveTween()
	arg_42_0:RemoveTweens()
	var_0_0.super.Dispose(arg_42_0)
end

return var_0_0
