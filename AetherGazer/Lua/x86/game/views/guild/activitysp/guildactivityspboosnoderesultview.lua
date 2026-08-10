local var_0_0 = class("GuildActivitySPBoosNodeResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPMultipletUI"
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
	SetActive(arg_5_0.closePanel_, false)

	arg_5_0.battleController = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "battleResult")
end

function var_0_0.AddListener(arg_6_0)
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
	arg_6_0:AddBtnListener(arg_6_0.oncemoreBtn_, nil, function()
		if GuildActivitySPData:GetNodeData(arg_6_0.params_.nodeId).health > 0 or arg_6_0.params_.nodeId == GuildActivitySPData:GetMaxNodeId() then
			local var_10_0 = true

			arg_6_0:OnClickRestart(var_10_0)
		else
			ShowTips("ACTIVITY_CLUB_SP_BOSS_NODE_PASS")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_backBtn_, nil, function()
		local var_11_0 = GuildActivitySPData:GetNodeData(arg_6_0.params_.nodeId)
		local var_11_1 = true

		if arg_6_0.params_.okHandler then
			arg_6_0.params_.okHandler(var_11_1)
		end

		arg_6_0:CloseFunc()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.stageData = arg_12_0.params_.stageData
	arg_12_0.stageId = arg_12_0.stageData:GetStageId()
	arg_12_0.stageType = arg_12_0.stageData:GetType()

	if arg_12_0.params_.isSuccess then
		arg_12_0.battleController:SetSelectedState("true")
	else
		arg_12_0.battleController:SetSelectedState("false")
	end

	BattleInstance.hideBattlePanel()
	arg_12_0:RefreshUI()

	if arg_12_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_12_0:CloseFunc()
			end
		})
	end
end

function var_0_0.CloseFunc(arg_14_0)
	OperationRecorder.Record(arg_14_0.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(arg_14_0.stageData)
end

function var_0_0.ShowVitalityBox(arg_15_0, arg_15_1)
	if needShowVitalityFullBox(arg_15_0:GetRewardData()) then
		showVitalitySendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function var_0_0.RefreshUI(arg_16_0)
	arg_16_0:SetLevelTitle()
	arg_16_0:RefreshMyExpS()
	arg_16_0:RefreshHeroS()
	arg_16_0:RefreshCommonUI()
	arg_16_0:RefreshBattleTime()
	arg_16_0:RefreshScore()
	arg_16_0:RefreshAward()
end

function var_0_0.SetLevelTitle(arg_17_0)
	local var_17_0, var_17_1 = BattleStageTools.GetChapterSectionIndex(arg_17_0.stageType, arg_17_0.stageId)

	if var_17_0 ~= "" then
		arg_17_0.stareText_.text = string.format("%s-%s", var_17_0, var_17_1)
	else
		arg_17_0.stareText_.text = ""
	end

	arg_17_0.lvText_.text = BattleStageTools.GetStageName(arg_17_0.stageType, arg_17_0.stageId)

	if arg_17_0.params_.scoreType == "hp" then
		if arg_17_0.params_.title ~= nil and arg_17_0.params_.title ~= "" then
			arg_17_0.hpTitleText_.text = arg_17_0.params_.title
		end
	elseif arg_17_0.params_.title ~= nil and arg_17_0.params_.title ~= "" then
		arg_17_0.titleText_.text = arg_17_0.params_.title
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.titleTransform_)
end

function var_0_0.RefreshMyExpS(arg_18_0)
	local var_18_0 = arg_18_0.params_.battleResult.oldPlayerEXPInfo
	local var_18_1 = var_18_0.userLevel
	local var_18_2 = var_18_0.remain_exp
	local var_18_3 = arg_18_0.stageData:GetAddUserExp() * arg_18_0.stageData:GetMultiple()
	local var_18_4 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_18_5 = math.min(var_18_3, var_18_4 - var_18_0.total_exp)

	if var_18_5 < 0 then
		var_18_5 = 0
	end

	local var_18_6, var_18_7 = LvTools.CheckExp(var_18_1, var_18_2 + var_18_5, "user_level_exp")

	if var_18_1 > 30 and var_18_6 - var_18_1 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_18_2), tostring(var_18_5), tostring(var_18_1), tostring(var_18_6)))
	end

	arg_18_0.newPlayerExp_ = var_18_5
	arg_18_0.addExp_.text = string.format("+%d", var_18_5)

	local var_18_8 = math.floor(var_18_2 / GameLevelSetting[var_18_1].user_level_exp * 1000) / 1000
	local var_18_9 = math.floor(var_18_7 / GameLevelSetting[var_18_6].user_level_exp * 1000) / 1000

	var_18_8 = var_18_8 > 0.99 and 0.99 or var_18_8
	var_18_9 = var_18_9 > 0.99 and 0.99 or var_18_9

	arg_18_0:RemoveTween()

	arg_18_0.userExp_ = var_18_6 + var_18_9

	if var_18_3 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_18_10 = -1

	arg_18_0.tween_ = LeanTween.value(arg_18_0.progress_.gameObject, var_18_1 + var_18_8, var_18_6 + var_18_9, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
		local var_19_0 = math.modf(arg_19_0)

		if var_18_10 == -1 then
			var_18_10 = var_19_0
		end

		if var_19_0 ~= var_18_10 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_18_10 = var_19_0
		end

		arg_18_0:UpdateUserData(arg_19_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_18_0.mask_.blocksRaycasts = false

		arg_18_0:CheckLevelUp()
		arg_18_0:RemoveTween()
	end))
end

function var_0_0.UpdateUserData(arg_21_0, arg_21_1)
	local var_21_0, var_21_1 = math.modf(arg_21_1)
	local var_21_2 = GameLevelSetting[var_21_0].user_level_exp

	arg_21_0.playerLv_.text = string.format("%d", var_21_0)

	if LvTools.GetIsMaxLv(var_21_0, "user") then
		arg_21_0.progress_.value = 1
	else
		arg_21_0.progress_.value = var_21_1
	end
end

function var_0_0.CheckLevelUp(arg_22_0)
	local var_22_0 = arg_22_0:GetLevelUpInfoList()

	if #var_22_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_22_0
		})
	end
end

function var_0_0.GetLevelUpInfoList(arg_23_0)
	return PlayerData:GetlevelUpInfos()
end

function var_0_0.RefreshHeroS(arg_24_0)
	local var_24_0, var_24_1 = arg_24_0.stageData:GetHeroTeam()
	local var_24_2 = arg_24_0.stageData:GetSystemHeroTeam()

	for iter_24_0 = 1, 3 do
		local var_24_3 = arg_24_0[string.format("hero%s_", iter_24_0)]

		if not var_24_0[iter_24_0] or var_24_0[iter_24_0] == 0 then
			SetActive(var_24_3, false)
		else
			SetActive(var_24_3, true)

			local var_24_4 = arg_24_0.stageData:GetHeroDataByPos(iter_24_0)
			local var_24_5 = var_24_2[iter_24_0] or var_24_1[iter_24_0] ~= 0

			table.insert(arg_24_0.heroItemView_, BattleMultipleResultHeroItem.New(var_24_3, var_24_4, arg_24_0.stageData, var_24_5, arg_24_0.params_.battleResult.heroDataCollect[iter_24_0]))
		end
	end
end

function var_0_0.RefreshCommonUI(arg_25_0)
	local var_25_0 = true

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_25_0.stageType then
		local var_25_1 = BattleChapterStageCfg[arg_25_0.stageId].tag

		if BattleConst.BATTLE_TAG.STORY == var_25_1 then
			var_25_0 = false
		end
	end

	SetActive(arg_25_0.btnBattleCount_.gameObject, var_25_0)
end

function var_0_0.RefreshScore(arg_26_0)
	if arg_26_0.params_.score then
		arg_26_0.scoreText_.text = arg_26_0.params_.score
	else
		local var_26_0 = arg_26_0.stageData:GetActivityID()
		local var_26_1 = ActivityTools.GetActivityTheme(var_26_0)

		if var_26_1 == ActivityConst.THEME.SUMMER or var_26_0 == ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION then
			local var_26_2 = 0
			local var_26_3 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
			local var_26_4 = GameSetting.limit_calculation_time_score_args.value
			local var_26_5 = var_26_4[1]
			local var_26_6 = var_26_4[2]
			local var_26_7 = var_26_4[3]
			local var_26_8 = var_26_4[4]

			if var_26_3 < var_26_7 then
				var_26_2 = var_26_5 * var_26_7 + var_26_6
			elseif var_26_3 < var_26_8 then
				var_26_2 = var_26_5 * var_26_3 + var_26_6
			else
				var_26_2 = var_26_5 * var_26_8 + var_26_6
			end

			local var_26_9 = 0
			local var_26_10 = 0
			local var_26_11, var_26_12, var_26_13 = BattleTools.GetBattleStatisticsData()
			local var_26_14 = tonumber(tostring(var_26_11[1].hurt))
			local var_26_15 = GameSetting.limit_calculation_injured_score_args.value

			if var_26_14 >= var_26_15[#var_26_15][1] then
				var_26_14 = var_26_15[#var_26_15][1]
			end

			for iter_26_0, iter_26_1 in ipairs(var_26_15) do
				if var_26_14 <= iter_26_1[1] then
					var_26_9 = iter_26_1[2]

					break
				end
			end

			local var_26_16 = arg_26_0.stageData:GetDest()
			local var_26_17 = ActivityLimitCalculationCfg[var_26_16].reward_point
			local var_26_18 = math.floor((var_26_2 + var_26_9) * var_26_17 / 100)

			arg_26_0.scoreText_.text = math.ceil(var_26_18)
		elseif var_26_1 == ActivityConst.THEME.FACTORY or ActivityConst.THEME.TYR then
			local var_26_19 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

			arg_26_0.scoreText_.text = var_26_19 .. "s"
		end
	end
end

function var_0_0.RefreshAward(arg_27_0)
	if arg_27_0.params_.currencyID then
		arg_27_0.currencyIcon_.sprite = ItemTools.getItemSprite(arg_27_0.params_.currencyID)
	end

	if arg_27_0.params_.awardNum then
		arg_27_0.currencyNum_.text = arg_27_0.params_.awardNum
	end
end

function var_0_0.RefreshBattleTime(arg_28_0)
	arg_28_0.battleTimeText_.text = arg_28_0:GetBattleTime()

	local var_28_0 = arg_28_0.stageData:GetActivityID()

	SetActive(arg_28_0.battleTimeText_.gameObject, ActivityTools.GetActivityTheme(var_28_0) ~= ActivityConst.THEME.FACTORY)
end

function var_0_0.GetBattleTime(arg_29_0)
	local var_29_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_29_0)
end

function var_0_0.HeroAnimator(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0, var_30_1 = math.modf(arg_30_2)

	arg_30_0.heroLv_[arg_30_1].text = string.format("%d", var_30_0)

	if LvTools.GetIsMaxLv(var_30_0, "hero") then
		arg_30_0.heroProgress_[arg_30_1].value = 1
	else
		arg_30_0.heroProgress_[arg_30_1].value = var_30_1
	end
end

function var_0_0.RemoveTween(arg_31_0)
	if arg_31_0.tween_ then
		arg_31_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_31_0.tween_.id)

		arg_31_0.tween_ = nil
	end
end

function var_0_0.RemoveTweens(arg_32_0)
	if arg_32_0.tweens_ then
		for iter_32_0, iter_32_1 in pairs(arg_32_0.tweens_) do
			arg_32_0:RemoveTweenAt(iter_32_0)
		end

		arg_32_0.tweens_ = nil
	end
end

function var_0_0.RemoveTweenAt(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.tweens_[arg_33_1]

	if var_33_0 then
		var_33_0:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(var_33_0.id)
	end
end

function var_0_0.EndAnimator(arg_34_0)
	arg_34_0:RemoveTween()
	arg_34_0:RemoveTweens()
	manager.audio:StopEffect()

	if arg_34_0.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	arg_34_0:UpdateUserData(arg_34_0.userExp_)
	arg_34_0:CheckLevelUp()

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.heroItemView_) do
		iter_34_1:EndAnimator()
	end

	arg_34_0.mask_.blocksRaycasts = false
end

function var_0_0.OnClickRestart(arg_35_0, arg_35_1)
	if arg_35_0.params_.condition then
		local var_35_0, var_35_1 = arg_35_0.params_.condition()

		if var_35_0 then
			if arg_35_0.params_.okHandler then
				arg_35_0.params_.okHandler(arg_35_1)
			end

			BattleController.GetInstance():LaunchBattle(arg_35_0.params_.stageData)
		else
			ShowTips(var_35_1)
		end
	else
		if arg_35_0.params_.okHandler then
			arg_35_0.params_.okHandler(arg_35_1)
		end

		BattleController.GetInstance():LaunchBattle(arg_35_0.params_.stageData)
	end
end

function var_0_0.OnTop(arg_36_0)
	SetActive(arg_36_0.gameObject_, true)

	arg_36_0.toStat_ = false
end

function var_0_0.OnBehind(arg_37_0)
	if arg_37_0.toStat_ then
		SetActive(arg_37_0.gameObject_, false)
	end
end

function var_0_0.OnExit(arg_38_0)
	return
end

function var_0_0.Dispose(arg_39_0)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0.heroItemView_) do
		iter_39_1:Dispose()
	end

	arg_39_0.heroItemView_ = nil

	arg_39_0:RemoveTween()
	arg_39_0:RemoveTweens()
	var_0_0.super.Dispose(arg_39_0)
end

return var_0_0
