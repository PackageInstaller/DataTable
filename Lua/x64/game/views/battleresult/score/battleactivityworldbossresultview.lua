local var_0_0 = class("BattleScoreResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/WorldBossScoreResultUI"
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

	arg_5_0.rewardList = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.m_list, CommonItem)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.rewardDatas[arg_6_1]

	arg_6_2:RefreshData(formatReward(var_6_0))
	arg_6_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_6_0)
	end)
end

function var_0_0.AddListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btnBack_, nil, function()
		arg_8_0:CloseFunc()
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnClose_, nil, function()
		arg_8_0:CloseFunc()
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonMask_, nil, function()
		arg_8_0:EndAnimator()
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnBattleCount_, nil, function()
		arg_8_0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = arg_8_0.stageData,
			battleTime = arg_8_0:GetBattleTime()
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnOnceMore_, nil, function()
		local var_13_0 = arg_8_0.stageData:GetActivityID()

		if not ActivityTools.GetActivityIsOpenWithTip(var_13_0) then
			return
		end

		ActivityWorldBossAction.QueryBossData(var_13_0, function()
			local var_14_0 = ActivityWorldBossData:GetStageId(var_13_0)

			arg_8_0.stageData.id = var_14_0
			arg_8_0.stageData.cfg = BattleActivityWorldBossCfg[var_14_0]

			BattleController.GetInstance():LaunchBattle(arg_8_0.stageData)
		end)
	end)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.stageData = arg_15_0.params_.stageData
	arg_15_0.stageId = arg_15_0.stageData:GetStageId()
	arg_15_0.stageType = arg_15_0.stageData:GetType()

	BattleInstance.hideBattlePanel()
	arg_15_0:RefreshUI()

	if arg_15_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_15_0:CloseFunc()
			end
		})
	end
end

function var_0_0.CloseFunc(arg_17_0)
	OperationRecorder.Record(arg_17_0.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(arg_17_0.stageData)
end

function var_0_0.ShowVitalityBox(arg_18_0, arg_18_1)
	if needShowVitalityFullBox(arg_18_0:GetRewardData()) then
		showVitalitySendMail(arg_18_1)
	else
		arg_18_1()
	end
end

function var_0_0.RefreshUI(arg_19_0)
	arg_19_0:SetLevelTitle()
	arg_19_0:RefreshMyExpS()
	arg_19_0:RefreshHeroS()
	arg_19_0:RefreshCommonUI()
	arg_19_0:RefreshScore()
	arg_19_0:RefreshBattleTime()
	arg_19_0:RefreshReward()
end

function var_0_0.RefreshReward(arg_20_0)
	arg_20_0.rewardDatas = arg_20_0.params_.rewardList or {}

	arg_20_0.rewardList:StartScroll(#arg_20_0.rewardDatas)

	local var_20_0 = arg_20_0.stageData:GetActivityID()
	local var_20_1 = ActivityWorldBossData:GetMaxCoinNum(var_20_0)
	local var_20_2 = ActivityWorldBossData:GetCointCount(var_20_0)

	arg_20_0.m_coinMax.text = "/" .. var_20_1
	arg_20_0.m_coinCount.text = var_20_2
end

function var_0_0.SetLevelTitle(arg_21_0)
	local var_21_0, var_21_1 = BattleStageTools.GetChapterSectionIndex(arg_21_0.stageType, arg_21_0.stageId)

	if var_21_0 ~= "" then
		arg_21_0.stareText_.text = string.format("%s-%s", GetI18NText(var_21_0), GetI18NText(var_21_1))
	else
		arg_21_0.stareText_.text = ""
	end

	arg_21_0.lvText_.text = BattleStageTools.GetStageName(arg_21_0.stageType, arg_21_0.stageId)

	if arg_21_0.params_.title ~= nil and arg_21_0.params_.title ~= "" then
		arg_21_0.titleText_.text = GetI18NText(arg_21_0.params_.title)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.titleTransform_)
end

function var_0_0.RefreshMyExpS(arg_22_0)
	local var_22_0 = arg_22_0:GetPlayerInfo()
	local var_22_1 = arg_22_0.params_.battleResult.oldPlayerEXPInfo
	local var_22_2 = var_22_1.userLevel
	local var_22_3 = var_22_1.remain_exp
	local var_22_4 = arg_22_0.stageData:GetAddUserExp() * arg_22_0.stageData:GetMultiple()
	local var_22_5 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_22_6 = math.min(var_22_4, var_22_5 - var_22_0.total_exp)

	if var_22_6 < 0 then
		var_22_6 = 0
	end

	local var_22_7, var_22_8 = LvTools.CheckExp(var_22_2, var_22_3 + var_22_6, "user_level_exp")

	if var_22_2 > 30 and var_22_7 - var_22_2 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_22_3), tostring(var_22_6), tostring(var_22_2), tostring(var_22_7)))
	end

	arg_22_0.newPlayerExp_ = var_22_6
	arg_22_0.addExp_.text = string.format("+%d", var_22_6)

	local var_22_9 = math.floor(var_22_3 / GameLevelSetting[var_22_2].user_level_exp * 1000) / 1000
	local var_22_10 = math.floor(var_22_8 / GameLevelSetting[var_22_7].user_level_exp * 1000) / 1000

	var_22_9 = var_22_9 > 0.99 and 0.99 or var_22_9
	var_22_10 = var_22_10 > 0.99 and 0.99 or var_22_10

	arg_22_0:RemoveTween()

	arg_22_0.userExp_ = var_22_7 + var_22_10

	if var_22_4 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_22_11 = -1

	arg_22_0.tween_ = LeanTween.value(arg_22_0.progress_.gameObject, var_22_2 + var_22_9, var_22_7 + var_22_10, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
		local var_23_0 = math.modf(arg_23_0)

		if var_22_11 == -1 then
			var_22_11 = var_23_0
		end

		if var_23_0 ~= var_22_11 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_22_11 = var_23_0
		end

		arg_22_0:UpdateUserData(arg_23_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_22_0.mask_.blocksRaycasts = false

		arg_22_0:CheckLevelUp()
		arg_22_0:RemoveTween()
	end))
end

function var_0_0.GetPlayerInfo(arg_25_0)
	return PlayerData:GetPlayerInfo()
end

function var_0_0.UpdateUserData(arg_26_0, arg_26_1)
	local var_26_0, var_26_1 = math.modf(arg_26_1)
	local var_26_2 = GameLevelSetting[var_26_0].user_level_exp

	arg_26_0.playerLv_.text = string.format("%d", var_26_0)

	if LvTools.GetIsMaxLv(var_26_0, "user") then
		arg_26_0.progress_.value = 1
	else
		arg_26_0.progress_.value = var_26_1
	end
end

function var_0_0.CheckLevelUp(arg_27_0)
	local var_27_0 = arg_27_0:GetLevelUpInfoList()

	if #var_27_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_27_0
		})
	end
end

function var_0_0.GetLevelUpInfoList(arg_28_0)
	return PlayerData:GetlevelUpInfos()
end

function var_0_0.RefreshHeroS(arg_29_0)
	local var_29_0, var_29_1 = arg_29_0.stageData:GetHeroTeam()
	local var_29_2 = arg_29_0.stageData:GetSystemHeroTeam()

	for iter_29_0 = 1, 3 do
		local var_29_3 = arg_29_0[string.format("hero%s_", iter_29_0)]

		if not var_29_0[iter_29_0] or var_29_0[iter_29_0] == 0 then
			SetActive(var_29_3, false)
		else
			SetActive(var_29_3, true)

			local var_29_4 = arg_29_0.stageData:GetHeroDataByPos(iter_29_0)
			local var_29_5 = var_29_2[iter_29_0] or var_29_1[iter_29_0] ~= 0

			table.insert(arg_29_0.heroItemView_, BattleMultipleResultHeroItem.New(var_29_3, var_29_4, arg_29_0.stageData, var_29_5, arg_29_0.params_.battleResult.heroDataCollect[iter_29_0]))
		end
	end
end

function var_0_0.RefreshCommonUI(arg_30_0)
	local var_30_0 = true

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_30_0.stageType then
		local var_30_1 = BattleChapterStageCfg[arg_30_0.stageId].tag

		if BattleConst.BATTLE_TAG.STORY == var_30_1 then
			var_30_0 = false
		end
	end

	SetActive(arg_30_0.btnBattleCount_.gameObject, var_30_0)
end

function var_0_0.RefreshScore(arg_31_0)
	local var_31_0 = arg_31_0.stageData:GetActivityID()
	local var_31_1 = ActivityWorldBossData:GetBossScore(var_31_0)

	arg_31_0.scoreText_.text = var_31_1
end

function var_0_0.RefreshBattleTime(arg_32_0)
	arg_32_0.battleTimeText_.text = arg_32_0:GetBattleTime()

	local var_32_0 = arg_32_0.stageData:GetActivityID()

	SetActive(arg_32_0.battleTimeText_.gameObject, ActivityTools.GetActivityTheme(var_32_0) ~= ActivityConst.THEME.FACTORY)
end

function var_0_0.GetBattleTime(arg_33_0)
	local var_33_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_33_0)
end

function var_0_0.HeroAnimator(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0, var_34_1 = math.modf(arg_34_2)

	arg_34_0.heroLv_[arg_34_1].text = string.format("%d", var_34_0)

	if LvTools.GetIsMaxLv(var_34_0, "hero") then
		arg_34_0.heroProgress_[arg_34_1].value = 1
	else
		arg_34_0.heroProgress_[arg_34_1].value = var_34_1
	end
end

function var_0_0.RemoveTween(arg_35_0)
	if arg_35_0.tween_ then
		arg_35_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_35_0.tween_.id)

		arg_35_0.tween_ = nil
	end
end

function var_0_0.RemoveTweens(arg_36_0)
	if arg_36_0.tweens_ then
		for iter_36_0, iter_36_1 in pairs(arg_36_0.tweens_) do
			arg_36_0:RemoveTweenAt(iter_36_0)
		end

		arg_36_0.tweens_ = nil
	end
end

function var_0_0.RemoveTweenAt(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.tweens_[arg_37_1]

	if var_37_0 then
		var_37_0:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(var_37_0.id)
	end
end

function var_0_0.EndAnimator(arg_38_0)
	arg_38_0:RemoveTween()
	arg_38_0:RemoveTweens()
	manager.audio:StopEffect()

	if arg_38_0.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	arg_38_0:UpdateUserData(arg_38_0.userExp_)
	arg_38_0:CheckLevelUp()

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.heroItemView_) do
		iter_38_1:EndAnimator()
	end

	arg_38_0.mask_.blocksRaycasts = false
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
