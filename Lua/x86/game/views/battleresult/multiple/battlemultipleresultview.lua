local var_0_0 = class("BattleMultipleResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/MultipletUI"
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
	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.RewardRenderer), arg_4_0.uiList_, BattleMultipleResultReward)
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.stageData = arg_5_0.params_.stageData
	arg_5_0.stageId = arg_5_0.stageData:GetStageId()
	arg_5_0.stageType = arg_5_0.stageData:GetType()

	BattleInstance.hideBattlePanel()
	arg_5_0:RefreshUI()
	arg_5_0.rewardList_:StartScroll(#arg_5_0.params_.rewardList, 1)

	if arg_5_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_5_0:CloseFunc()
			end
		})
	end
end

function var_0_0.SetBtnOnceMore(arg_7_0)
	if arg_7_0.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT then
		SetActive(arg_7_0.btnOnceMore_.gameObject, false)
	else
		SetActive(arg_7_0.btnOnceMore_.gameObject, arg_7_0:NeedOnceMore())
	end
end

function var_0_0.NeedOnceMore(arg_8_0)
	if arg_8_0.params_.notOnceMore then
		return false
	end

	return true
end

function var_0_0.OnTop(arg_9_0)
	SetActive(arg_9_0.gameObject_, true)

	arg_9_0.toStat_ = false
end

function var_0_0.OnBehind(arg_10_0)
	if arg_10_0.toStat_ then
		SetActive(arg_10_0.gameObject_, false)
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.rewardList_ then
		arg_12_0.rewardList_:Dispose()

		arg_12_0.rewardList_ = nil
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.heroItemView_) do
		iter_12_1:Dispose()
	end

	arg_12_0.heroItemView_ = nil

	arg_12_0:RemoveTween()
	arg_12_0:RemoveTweens()

	arg_12_0.rewardItemGos_ = nil
	arg_12_0.heroLv_ = nil
	arg_12_0.heroGo_ = nil
	arg_12_0.heroImg_ = nil
	arg_12_0.missionGo_ = nil
	arg_12_0.missionAchieve_ = nil
	arg_12_0.heroAddExp = nil
	arg_12_0.missionNoAchieve_ = nil
	arg_12_0.heroProgress_ = nil
	arg_12_0.missionText_ = nil
	arg_12_0.rewardList_ = nil
	arg_12_0.addExp_ = nil
	arg_12_0.stareText_ = nil
	arg_12_0.lvText_ = nil
	arg_12_0.bg_screen_ = nil
	arg_12_0.rewardListTrs_ = nil
	arg_12_0.mask_ = nil
	arg_12_0.playerLv_ = nil
	arg_12_0.btnBack_ = nil
	arg_12_0.btnBattleCount_ = nil
	arg_12_0.missionTipGo_ = nil
	arg_12_0.progress_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.InitUI(arg_13_0)
	arg_13_0:BindCfgUI()
	LeanTween.alphaCanvas(arg_13_0.mask_, 0, 0.1)
end

function var_0_0.GetRewardData(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.params_.rewardList) do
		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			table.insert(var_14_0, iter_14_3)
		end
	end

	return var_14_0
end

function var_0_0.ShowVitalityBox(arg_15_0, arg_15_1)
	if needShowVitalityFullBox(arg_15_0:GetRewardData()) then
		showVitalitySendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function var_0_0.ShowEquipBox(arg_16_0, arg_16_1)
	if needShowBagFullBox(arg_16_0:GetRewardData()) then
		showEquipSendMail(arg_16_1)
	else
		arg_16_1()
	end
end

function var_0_0.CloseFunc(arg_17_0)
	OperationRecorder.Record(arg_17_0.class.__cname, "closeCombat")
	arg_17_0:ShowVitalityBox(function()
		arg_17_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_17_0.stageData)
		end)
	end)
end

function var_0_0.AddListener(arg_20_0)
	arg_20_0:AddBtnListener(arg_20_0.btnBack_, nil, function()
		arg_20_0:CloseFunc()
	end)
	arg_20_0:AddBtnListener(arg_20_0.btnClose_, nil, function()
		arg_20_0:CloseFunc()
	end)
	arg_20_0:AddBtnListener(arg_20_0.buttonMask_, nil, function()
		arg_20_0:EndAnimator()
	end)
	arg_20_0:AddBtnListener(arg_20_0.btnOnceMore_, nil, function()
		local var_24_0 = arg_20_0.params_.destID
		local var_24_1 = arg_20_0.params_.stageID
		local var_24_2 = arg_20_0.stageData:GetCost()
		local var_24_3 = arg_20_0.stageData:GetMultiple()
		local var_24_4 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		local var_24_5 = CurrencyConst.CURRENCY_TYPE_VITALITY

		if arg_20_0.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
			local var_24_6 = arg_20_0.stageData:GetDest()
			local var_24_7 = ActivityPt2Cfg[var_24_6]

			var_24_2 = var_24_7.cost[1][2]
			var_24_5 = var_24_7.cost[1][1]
			var_24_4 = ItemTools.getItemNum(var_24_5)
		elseif arg_20_0.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
			local var_24_8 = arg_20_0.stageData:GetDest()
			local var_24_9 = ActivityPtRouletteStageCfg[var_24_8]

			var_24_2 = var_24_9.cost[2]
			var_24_5 = var_24_9.cost[1]
			var_24_4 = ItemTools.getItemNum(var_24_5)
		end

		if var_24_4 < var_24_2 * var_24_3 then
			if var_24_5 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_24_5)))
			elseif CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			BattleInstance.OnceMoreBattle(arg_20_0.stageData)
		end
	end)
	arg_20_0:AddBtnListener(arg_20_0.btnBattleCount_, nil, function()
		arg_20_0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = arg_20_0.stageData,
			battleTime = arg_20_0:GetBattleTime()
		})
	end)
end

function var_0_0.RemoveListener(arg_26_0)
	arg_26_0.btnBack_.onClick:RemoveAllListeners()
	arg_26_0.btnClose_.onClick:RemoveAllListeners()
	arg_26_0.btnOnceMore_.onClick:RemoveAllListeners()
	arg_26_0.btnBattleCount_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_27_0)
	arg_27_0:SetLevelTitle()
	arg_27_0:RefreshMyExpS()
	arg_27_0:RefreshHeroS()
	arg_27_0:RefreshCommonUI()
	arg_27_0:SetBtnOnceMore()
	arg_27_0:RefreshBattleTime()
end

function var_0_0.SetLevelTitle(arg_28_0)
	local var_28_0, var_28_1 = BattleStageTools.GetChapterSectionIndex(arg_28_0.stageType, arg_28_0.stageId)

	if var_28_0 ~= "" then
		arg_28_0.stareText_.text = string.format("%s-%s", GetI18NText(var_28_0), GetI18NText(var_28_1))
	else
		arg_28_0.stareText_.text = ""
	end

	arg_28_0.lvText_.text = BattleStageTools.GetStageName(arg_28_0.stageType, arg_28_0.stageId)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_0.titleTransform_)
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

			table.insert(arg_29_0.heroItemView_, BattleMultipleResultHeroItem.New(var_29_3, var_29_4, arg_29_0.stageData, var_29_5))
		end
	end
end

function var_0_0.CheckLevelUp(arg_30_0)
	local var_30_0 = arg_30_0:GetLevelUpInfoList()

	if #var_30_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_30_0
		})
	end
end

function var_0_0.RefreshMyExpS(arg_31_0)
	local var_31_0 = arg_31_0.params_.battleResult.oldPlayerEXPInfo
	local var_31_1 = var_31_0.userLevel
	local var_31_2 = var_31_0.remain_exp
	local var_31_3 = arg_31_0.stageData:GetAddUserExp() * arg_31_0.stageData:GetMultiple()
	local var_31_4 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_31_5 = math.min(var_31_3, var_31_4 - var_31_0.total_exp)

	if var_31_5 < 0 then
		var_31_5 = 0
	end

	local var_31_6, var_31_7 = LvTools.CheckExp(var_31_1, var_31_2 + var_31_5, "user_level_exp")

	if var_31_1 > 30 and var_31_6 - var_31_1 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_31_2), tostring(var_31_5), tostring(var_31_1), tostring(var_31_6)))
	end

	arg_31_0.newPlayerExp_ = var_31_5
	arg_31_0.addExp_.text = string.format("+%d", var_31_5)

	local var_31_8 = math.floor(var_31_2 / GameLevelSetting[var_31_1].user_level_exp * 1000) / 1000
	local var_31_9 = math.floor(var_31_7 / GameLevelSetting[var_31_6].user_level_exp * 1000) / 1000

	var_31_8 = var_31_8 > 0.99 and 0.99 or var_31_8
	var_31_9 = var_31_9 > 0.99 and 0.99 or var_31_9

	arg_31_0:RemoveTween()

	arg_31_0.userExp_ = var_31_6 + var_31_9

	if var_31_3 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_31_10 = -1

	arg_31_0.tween_ = LeanTween.value(arg_31_0.progress_.gameObject, var_31_1 + var_31_8, var_31_6 + var_31_9, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
		local var_32_0 = math.modf(arg_32_0)

		if var_31_10 == -1 then
			var_31_10 = var_32_0
		end

		if var_32_0 ~= var_31_10 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_31_10 = var_32_0
		end

		arg_31_0:UpdateUserData(arg_32_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_31_0.mask_.blocksRaycasts = false

		arg_31_0:CheckLevelUp()
		arg_31_0:RemoveTween()
	end))
end

function var_0_0.UpdateUserData(arg_34_0, arg_34_1)
	local var_34_0, var_34_1 = math.modf(arg_34_1)
	local var_34_2 = GameLevelSetting[var_34_0].user_level_exp

	arg_34_0.playerLv_.text = string.format("%d", var_34_0)

	if LvTools.GetIsMaxLv(var_34_0, "user") then
		arg_34_0.progress_.value = 1
	else
		arg_34_0.progress_.value = var_34_1
	end
end

function var_0_0.HeroAnimator(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0, var_35_1 = math.modf(arg_35_2)

	arg_35_0.heroLv_[arg_35_1].text = string.format("%d", var_35_0)

	if LvTools.GetIsMaxLv(var_35_0, "hero") then
		arg_35_0.heroProgress_[arg_35_1].value = 1
	else
		arg_35_0.heroProgress_[arg_35_1].value = var_35_1
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

function var_0_0.RemoveTween(arg_37_0)
	if arg_37_0.tween_ then
		arg_37_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_37_0.tween_.id)

		arg_37_0.tween_ = nil
	end
end

function var_0_0.RemoveTweenAt(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.tweens_[arg_38_1]

	if var_38_0 then
		var_38_0:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(var_38_0.id)
	end
end

function var_0_0.RemoveTweens(arg_39_0)
	if arg_39_0.tweens_ then
		for iter_39_0, iter_39_1 in pairs(arg_39_0.tweens_) do
			arg_39_0:RemoveTweenAt(iter_39_0)
		end

		arg_39_0.tweens_ = nil
	end
end

function var_0_0.RefreshCommonUI(arg_40_0)
	local var_40_0 = true

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_40_0.stageType then
		local var_40_1 = BattleChapterStageCfg[arg_40_0.stageId].tag

		if BattleConst.BATTLE_TAG.STORY == var_40_1 then
			var_40_0 = false
		end
	end

	SetActive(arg_40_0.btnBattleCount_.gameObject, var_40_0)

	local var_40_2 = arg_40_0:NeedOnceMore() or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == arg_40_0.stageType

	SetActive(arg_40_0.onceMoreGo_, var_40_2)
	SetActive(arg_40_0.closeBtnGo_, var_40_2)
	SetActive(arg_40_0.closePanel_, not var_40_2)
end

function var_0_0.RefreshBattleTime(arg_41_0)
	arg_41_0.battleTimeText_.text = arg_41_0:GetBattleTime()
end

function var_0_0.GetBattleTime(arg_42_0)
	local var_42_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_42_0)
end

function var_0_0.RewardRenderer(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.params_.rewardList[arg_43_1]

	arg_43_2:SetRewardList(arg_43_1, clone(var_43_0))
end

function var_0_0.GetLevelUpInfoList(arg_44_0)
	return PlayerData:GetlevelUpInfos()
end

return var_0_0
