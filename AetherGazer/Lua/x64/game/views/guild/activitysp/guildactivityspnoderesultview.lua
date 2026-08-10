local var_0_0 = class("GuildActivitySPNodeResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPEliteMultipletUI"
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
	LeanTween.alphaCanvas(arg_5_0.mask_, 0, 0.1)

	arg_5_0.resultTypeController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "resultType")
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		if arg_6_0.params_.isSuccess then
			arg_6_0:CloseFunc()
		end
	end)
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
	arg_6_0:AddBtnListener(arg_6_0.okBtn_, nil, function()
		GuildActivitySPAction.SaveEliteCombatResult(1)
		arg_6_0:CloseFunc()
	end)
	arg_6_0:AddBtnListener(arg_6_0.giveupBtn_, nil, function()
		GuildActivitySPAction.SaveEliteCombatResult(0)
		arg_6_0:CloseFunc()
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
	arg_18_0:SetLevelTitle()
	arg_18_0:RefreshMyExpS()
	arg_18_0:RefreshHeroS()
	arg_18_0:RefreshCommonUI()
	arg_18_0:RefreshBattleTime()
	arg_18_0:RefreshGuildActivityUI()
end

function var_0_0.RefreshGuildActivityUI(arg_19_0)
	local var_19_0 = arg_19_0.params_.nodeId
	local var_19_1 = ActivityClubSPCfg[var_19_0]

	if arg_19_0.params_.isSuccess then
		arg_19_0.resultTypeController_:SetSelectedState("win")
	else
		arg_19_0.resultTypeController_:SetSelectedState("attack")

		if var_19_1.type == 2 then
			local var_19_2 = GuildActivitySPData:GetSelfNodeData(var_19_0)
			local var_19_3 = var_19_2.elite_health_rate == 0 and 100 or var_19_2.elite_health_rate
			local var_19_4 = 0
			local var_19_5 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas

			if var_19_5 then
				local var_19_6

				if var_19_5:TryGetValue(27, var_19_6) then
					local var_19_7 = var_19_3 - math.ceil(var_19_5[27] * var_19_3 / 100)

					arg_19_0.progressLabel_.text = var_19_7 .. "%"
				else
					arg_19_0.progressLabel_.text = "0%"
				end
			else
				arg_19_0.progressLabel_.text = "0%"
			end

			local var_19_8 = 100 - math.ceil(var_19_5[27] * var_19_3 / 100)

			if var_19_8 > 99 then
				var_19_8 = 99
			end

			arg_19_0.totalProgressLabel_.text = var_19_8 .. "%"
		end
	end
end

function var_0_0.SetLevelTitle(arg_20_0)
	local var_20_0, var_20_1 = BattleStageTools.GetChapterSectionIndex(arg_20_0.stageType, arg_20_0.stageId)

	if var_20_0 ~= "" then
		arg_20_0.stareText_.text = string.format("%s-%s", var_20_0, var_20_1)
	else
		arg_20_0.stareText_.text = ""
	end

	arg_20_0.lvText_.text = BattleStageTools.GetStageName(arg_20_0.stageType, arg_20_0.stageId)

	if arg_20_0.params_.title ~= nil and arg_20_0.params_.title ~= "" then
		arg_20_0.titleText_.text = arg_20_0.params_.title
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_0.titleTransform_)
end

function var_0_0.RefreshMyExpS(arg_21_0)
	local var_21_0 = arg_21_0.params_.battleResult.oldPlayerEXPInfo
	local var_21_1 = var_21_0.userLevel
	local var_21_2 = var_21_0.remain_exp
	local var_21_3 = arg_21_0.stageData:GetAddUserExp() * arg_21_0.stageData:GetMultiple()
	local var_21_4 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_21_5 = math.min(var_21_3, var_21_4 - var_21_0.total_exp)

	if var_21_5 < 0 then
		var_21_5 = 0
	end

	local var_21_6, var_21_7 = LvTools.CheckExp(var_21_1, var_21_2 + var_21_5, "user_level_exp")

	if var_21_1 > 30 and var_21_6 - var_21_1 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_21_2), tostring(var_21_5), tostring(var_21_1), tostring(var_21_6)))
	end

	arg_21_0.newPlayerExp_ = var_21_5
	arg_21_0.addExp_.text = string.format("+%d", var_21_5)

	local var_21_8 = math.floor(var_21_2 / GameLevelSetting[var_21_1].user_level_exp * 1000) / 1000
	local var_21_9 = math.floor(var_21_7 / GameLevelSetting[var_21_6].user_level_exp * 1000) / 1000

	var_21_8 = var_21_8 > 0.99 and 0.99 or var_21_8
	var_21_9 = var_21_9 > 0.99 and 0.99 or var_21_9

	arg_21_0:RemoveTween()

	arg_21_0.userExp_ = var_21_6 + var_21_9

	if var_21_3 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_21_10 = -1

	arg_21_0.tween_ = LeanTween.value(arg_21_0.progress_.gameObject, var_21_1 + var_21_8, var_21_6 + var_21_9, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		local var_22_0 = math.modf(arg_22_0)

		if var_21_10 == -1 then
			var_21_10 = var_22_0
		end

		if var_22_0 ~= var_21_10 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_21_10 = var_22_0
		end

		arg_21_0:UpdateUserData(arg_22_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_21_0.mask_.blocksRaycasts = false

		arg_21_0:CheckLevelUp()
		arg_21_0:RemoveTween()
	end))
end

function var_0_0.UpdateUserData(arg_24_0, arg_24_1)
	local var_24_0, var_24_1 = math.modf(arg_24_1)
	local var_24_2 = GameLevelSetting[var_24_0].user_level_exp

	arg_24_0.playerLv_.text = string.format("%d", var_24_0)

	if LvTools.GetIsMaxLv(var_24_0, "user") then
		arg_24_0.progress_.value = 1
	else
		arg_24_0.progress_.value = var_24_1
	end
end

function var_0_0.CheckLevelUp(arg_25_0)
	local var_25_0 = arg_25_0:GetLevelUpInfoList()

	if #var_25_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_25_0
		})
	end
end

function var_0_0.GetLevelUpInfoList(arg_26_0)
	return PlayerData:GetlevelUpInfos()
end

function var_0_0.RefreshHeroS(arg_27_0)
	local var_27_0, var_27_1 = arg_27_0.stageData:GetHeroTeam()
	local var_27_2 = arg_27_0.stageData:GetSystemHeroTeam()

	for iter_27_0 = 1, 3 do
		local var_27_3 = arg_27_0[string.format("hero%s_", iter_27_0)]

		if not var_27_0[iter_27_0] or var_27_0[iter_27_0] == 0 then
			SetActive(var_27_3, false)
		else
			SetActive(var_27_3, true)

			local var_27_4 = arg_27_0.stageData:GetHeroDataByPos(iter_27_0)
			local var_27_5 = var_27_2[iter_27_0] or var_27_1[iter_27_0] ~= 0

			table.insert(arg_27_0.heroItemView_, BattleMultipleResultHeroItem.New(var_27_3, var_27_4, arg_27_0.stageData, var_27_5, arg_27_0.params_.battleResult.heroDataCollect[iter_27_0]))
		end
	end
end

function var_0_0.RefreshCommonUI(arg_28_0)
	local var_28_0 = true

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_28_0.stageType then
		local var_28_1 = BattleChapterStageCfg[arg_28_0.stageId].tag

		if BattleConst.BATTLE_TAG.STORY == var_28_1 then
			var_28_0 = false
		end
	end

	SetActive(arg_28_0.btnBattleCount_.gameObject, var_28_0)
end

function var_0_0.RefreshScore(arg_29_0)
	if arg_29_0.params_.score then
		arg_29_0.scoreText_.text = arg_29_0.params_.score
	else
		local var_29_0 = arg_29_0.stageData:GetActivityID()

		if ActivityTools.GetActivityTheme(var_29_0) == ActivityConst.THEME.SUMMER then
			local var_29_1 = 0
			local var_29_2 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
			local var_29_3 = GameSetting.limit_calculation_time_score_args.value
			local var_29_4 = var_29_3[1]
			local var_29_5 = var_29_3[2]
			local var_29_6 = var_29_3[3]
			local var_29_7 = var_29_3[4]

			if var_29_2 < var_29_6 then
				var_29_1 = var_29_4 * var_29_6 + var_29_5
			elseif var_29_2 < var_29_7 then
				var_29_1 = var_29_4 * var_29_2 + var_29_5
			else
				var_29_1 = var_29_4 * var_29_7 + var_29_5
			end

			local var_29_8 = 0
			local var_29_9 = 0
			local var_29_10, var_29_11, var_29_12 = BattleTools.GetBattleStatisticsData()
			local var_29_13 = tonumber(tostring(var_29_11.damage))
			local var_29_14 = GameSetting.limit_calculation_injured_score_args.value

			if var_29_13 >= var_29_14[#var_29_14][1] then
				var_29_13 = var_29_14[#var_29_14][1]
			end

			for iter_29_0, iter_29_1 in ipairs(var_29_14) do
				if var_29_13 <= iter_29_1[1] then
					var_29_8 = iter_29_1[2]

					break
				end
			end

			local var_29_15 = arg_29_0.stageData:GetDest()
			local var_29_16 = ActivityLimitCalculationCfg[var_29_15].reward_point
			local var_29_17 = math.floor((var_29_1 + var_29_8) * var_29_16 / 100)

			arg_29_0.scoreText_.text = math.ceil(var_29_17)
		end
	end
end

function var_0_0.RefreshBattleTime(arg_30_0)
	arg_30_0.battleTimeText_.text = arg_30_0:GetBattleTime()
end

function var_0_0.GetBattleTime(arg_31_0)
	local var_31_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_31_0)
end

function var_0_0.HeroAnimator(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0, var_32_1 = math.modf(arg_32_2)

	arg_32_0.heroLv_[arg_32_1].text = string.format("%d", var_32_0)

	if LvTools.GetIsMaxLv(var_32_0, "hero") then
		arg_32_0.heroProgress_[arg_32_1].value = 1
	else
		arg_32_0.heroProgress_[arg_32_1].value = var_32_1
	end
end

function var_0_0.RemoveTween(arg_33_0)
	if arg_33_0.tween_ then
		arg_33_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_33_0.tween_.id)

		arg_33_0.tween_ = nil
	end
end

function var_0_0.RemoveTweens(arg_34_0)
	if arg_34_0.tweens_ then
		for iter_34_0, iter_34_1 in pairs(arg_34_0.tweens_) do
			arg_34_0:RemoveTweenAt(iter_34_0)
		end

		arg_34_0.tweens_ = nil
	end
end

function var_0_0.RemoveTweenAt(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.tweens_[arg_35_1]

	if var_35_0 then
		var_35_0:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(var_35_0.id)
	end
end

function var_0_0.EndAnimator(arg_36_0)
	arg_36_0:RemoveTween()
	arg_36_0:RemoveTweens()
	manager.audio:StopEffect()

	if arg_36_0.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	arg_36_0:UpdateUserData(arg_36_0.userExp_)
	arg_36_0:CheckLevelUp()

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.heroItemView_) do
		iter_36_1:EndAnimator()
	end

	arg_36_0.mask_.blocksRaycasts = false
end

function var_0_0.OnTop(arg_37_0)
	SetActive(arg_37_0.gameObject_, true)

	arg_37_0.toStat_ = false
end

function var_0_0.OnBehind(arg_38_0)
	if arg_38_0.toStat_ then
		SetActive(arg_38_0.gameObject_, false)
	end
end

function var_0_0.OnExit(arg_39_0)
	return
end

function var_0_0.Dispose(arg_40_0)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0.heroItemView_) do
		iter_40_1:Dispose()
	end

	arg_40_0.heroItemView_ = nil

	arg_40_0:RemoveTween()
	arg_40_0:RemoveTweens()
	var_0_0.super.Dispose(arg_40_0)
end

return var_0_0
