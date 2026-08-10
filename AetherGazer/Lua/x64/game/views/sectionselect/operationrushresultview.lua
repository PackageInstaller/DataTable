local var_0_0 = class("OperationRushResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/BattleResult/Common/BattleResultRushUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.hasSnapshot_ = GetBattleResultSnapShot()

	arg_3_0:InitUI()

	arg_3_0.btnController = arg_3_0.btnController_:GetController("btn")
	arg_3_0.multiController = arg_3_0.multiController_:GetController("double")

	arg_3_0:AddListener()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.stageData = arg_4_0.params_.stageData
	arg_4_0.stageId = arg_4_0.stageData:GetStageId()
	arg_4_0.stageType = arg_4_0.stageData:GetType()
	arg_4_0.isMultiple = arg_4_0.params_.multiple ~= nil

	BattleInstance.hideBattlePanel()
	arg_4_0:CaculateReward()
	arg_4_0:RenderView()
	manager.notify:CallUpdateFunc(ON_MULTIPLE_REWARD_COUNT_CHANGE)

	if arg_4_0.params_.chapterID and table.indexof(GameSetting.quick_battle_unique_chapter.value, arg_4_0.params_.chapterID) then
		SetActive(arg_4_0.nextStageBtn_.gameObject, false)
	else
		SetActive(arg_4_0.nextStageBtn_.gameObject, true)
	end
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.params_.callBack = nil
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.multiView:Dispose()
	arg_6_0:RemoveExpTween()

	for iter_6_0 = 1, 3 do
		arg_6_0.heroModule[iter_6_0]:Dispose()
	end

	if arg_6_0.missionView then
		arg_6_0.missionView:Dispose()
	end

	arg_6_0.spriteRef = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.heroModule = {
		BattleSettlementHeroHeadModule.New(arg_7_0.heroHead1Obj_),
		BattleSettlementHeroHeadModule.New(arg_7_0.heroHead2Obj_),
		(BattleSettlementHeroHeadModule.New(arg_7_0.heroHead3Obj_))
	}
end

function var_0_0.AddListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.confirmBtn_, nil, function()
		arg_8_0:CloseFunc()
	end)
	arg_8_0:OnAddListner()
end

function var_0_0.OnAddListner(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.nextStageBtn_, nil, function()
		arg_10_0:OnceMoreFunc()
	end)
end

function var_0_0.RenderView(arg_12_0)
	arg_12_0:RenderTitleView()
	arg_12_0:RefreshMyExpS()
	arg_12_0:RefreshHeroS()
	arg_12_0:RefreshBottomBtn()
	arg_12_0:ShowContent()
end

function var_0_0.ShowContent(arg_13_0)
	arg_13_0:onRenderMultiResultContent()
end

function var_0_0.onRenderMultiResultContent(arg_14_0)
	if not arg_14_0.multiView then
		arg_14_0.multiView = BattleSettlementMultiResultModule.New(arg_14_0.contentContainer_)
	end

	arg_14_0.multiView:RenderView({
		stageData = arg_14_0.stageData,
		rewardList = arg_14_0.params_.rewardList,
		extraReward = arg_14_0.params_.extraReward,
		rewardTimes = arg_14_0.params_.multiple
	})
	arg_14_0.multiController:SetSelectedState("false")

	if arg_14_0.params_.extraReward then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.params_.extraReward) do
			if type(iter_14_1) == "table" and #iter_14_1 > 0 then
				local var_14_0, var_14_1, var_14_2 = ActivityMultiRewardData:GetLastBattleMultiData()
				local var_14_3
				local var_14_4
				local var_14_5

				if RegressionDataNew:IsRegressionOpen() then
					var_14_3, var_14_4, var_14_5 = RegressionDataNew:GetMultipleValue()
				end

				if var_14_0 and var_14_0 > 0 and var_14_1 and var_14_1 > 0 then
					arg_14_0.multiController:SetSelectedState("true")

					arg_14_0.multiCountText_.text = var_14_0 .. "/" .. var_14_1
					arg_14_0.multiRatioText_.text = var_14_2 / 100

					break
				end

				if var_14_3 and var_14_3 > 0 then
					arg_14_0.multiController:SetSelectedState("true")

					arg_14_0.multiCountText_.text = var_14_3 .. "/" .. var_14_4
					arg_14_0.multiRatioText_.text = var_14_5 / 100

					break
				end

				arg_14_0.multiController:SetSelectedState("false")

				break
			end
		end
	end
end

function var_0_0.RenderTitleView(arg_15_0)
	local var_15_0, var_15_1 = BattleStageTools.GetChapterSectionIndex(arg_15_0.stageType, arg_15_0.stageId)
	local var_15_2 = GetI18NText(BattleStageTools.GetStageName(arg_15_0.stageType, arg_15_0.stageId)) or ""
	local var_15_3 = ""

	if var_15_0 ~= "" then
		var_15_3 = "" .. var_15_2
	else
		var_15_3 = "" .. var_15_2
	end

	if var_15_3 and var_15_3 ~= "" then
		SetActive(arg_15_0.titleObj_, true)

		arg_15_0.titleTxt_.text = var_15_3
	else
		SetActive(arg_15_0.titleObj_, false)
	end
end

function var_0_0.RefreshHeroS(arg_16_0)
	local var_16_0, var_16_1 = arg_16_0.stageData:GetHeroTeam()
	local var_16_2 = arg_16_0.stageData:GetSystemHeroTeam()

	if var_16_0[2] == 0 then
		table.remove(var_16_0, 2)
		table.remove(var_16_1, 2)
		table.insert(var_16_0, 0)
		table.insert(var_16_1, 0)
	end

	local var_16_3 = arg_16_0.params_.battleResult.heroDataCollect

	for iter_16_0 = 1, 3 do
		if not var_16_0[iter_16_0] or var_16_0[iter_16_0] == 0 then
			arg_16_0.heroModule[iter_16_0]:SetHeroData(nil)
			arg_16_0.heroModule[iter_16_0]:ShowCaptain(false)
		else
			arg_16_0.heroModule[iter_16_0]:ShowCaptain(iter_16_0 == 1)

			local var_16_4 = arg_16_0.stageData:GetHeroDataByPos(iter_16_0)

			arg_16_0.heroModule[iter_16_0]:SetHeroData({
				id = var_16_4.id,
				using_skin = var_16_4.using_skin,
				star = var_16_4.star or 0
			})

			if var_16_3[iter_16_0] and arg_16_0:NeedAddExp() then
				arg_16_0.heroModule[iter_16_0]:PlayLevelUpTween(var_16_3[iter_16_0].oldLv, var_16_3[iter_16_0].newLv, var_16_3[iter_16_0].oldPersent, var_16_3[iter_16_0].newPersent, 2)
			else
				arg_16_0.heroModule[iter_16_0]:ShowLevel(var_16_4.level, 1)
			end
		end
	end
end

function var_0_0.RefreshMyExpS(arg_17_0)
	local var_17_0 = arg_17_0.stageData:GetAddUserExp() * arg_17_0.stageData:GetMultiple()
	local var_17_1 = arg_17_0.stageData:GetActivityID()
	local var_17_2 = arg_17_0.params_.battleResult.oldPlayerEXPInfo
	local var_17_3 = var_17_2.userLevel
	local var_17_4 = var_17_2.remain_exp
	local var_17_5 = ActivityData:GetActivityData(var_17_1)

	if var_17_1 ~= 0 and (not var_17_5 or not var_17_5:IsActivitying()) or not arg_17_0:NeedAddExp() then
		var_17_0 = 0
	end

	local var_17_6 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_17_7 = math.min(var_17_0, var_17_6 - var_17_2.total_exp)

	if var_17_7 < 0 then
		var_17_7 = 0
	end

	local var_17_8, var_17_9 = LvTools.CheckExp(var_17_3, var_17_4 + var_17_7, "user_level_exp")

	if var_17_3 > 30 and var_17_8 - var_17_3 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_17_4), tostring(var_17_7), tostring(var_17_3), tostring(var_17_8)))
	end

	arg_17_0.expTxt_.text = string.format("EXP+%d", var_17_7)

	if LvTools.GetIsMaxLv(var_17_8, "user") then
		arg_17_0.lvNumTxt_.text = "--/--"
	else
		arg_17_0.lvNumTxt_.text = table.concat({
			var_17_9,
			"/",
			GameLevelSetting[var_17_8].user_level_exp
		})
	end

	local var_17_10 = math.floor(var_17_4 / GameLevelSetting[var_17_3].user_level_exp * 1000) / 1000
	local var_17_11 = math.floor(var_17_9 / GameLevelSetting[var_17_8].user_level_exp * 1000) / 1000

	var_17_10 = var_17_10 > 0.99 and 0.99 or var_17_10
	var_17_11 = var_17_11 > 0.99 and 0.99 or var_17_11

	if var_17_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	if var_17_3 == var_17_8 and math.abs(var_17_10 - var_17_11) < 0.0001 then
		SetActive(arg_17_0.maskBtn_.gameObject, false)
		arg_17_0:SetExpWithoutTween(var_17_8, var_17_11)
	else
		arg_17_0:StartExpTween(var_17_3, var_17_8, var_17_10, var_17_11)
	end
end

function var_0_0.RenderUserData(arg_18_0, arg_18_1)
	local var_18_0, var_18_1 = math.modf(arg_18_1)
	local var_18_2 = GameLevelSetting[var_18_0].user_level_exp

	arg_18_0.levelTxt_.text = string.format("%d", var_18_0)

	if LvTools.GetIsMaxLv(var_18_0, "user") then
		arg_18_0.expSlider_.value = 1
	else
		arg_18_0.expSlider_.value = var_18_1
	end
end

function var_0_0.RefreshBottomBtn(arg_19_0)
	return
end

function var_0_0.RemoveExpTween(arg_20_0)
	if arg_20_0.expTween_ then
		arg_20_0.expTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_20_0.gameObject_)

		arg_20_0.expTween_ = nil
	end
end

function var_0_0.StartExpTween(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	arg_21_0:RemoveExpTween()
	SetActive(arg_21_0.maskBtn_.gameObject, true)

	local var_21_0 = -1

	arg_21_0.tween_ = LeanTween.value(arg_21_0.expSlider_.gameObject, arg_21_1 + arg_21_3, arg_21_2 + arg_21_4, 1):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		local var_22_0 = math.modf(arg_22_0)

		if var_21_0 == -1 then
			var_21_0 = var_22_0
		end

		if var_22_0 ~= var_21_0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_21_0 = var_22_0
		end

		arg_21_0:RenderUserData(arg_22_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_21_0:CheckLevelUp()
		SetActive(arg_21_0.maskBtn_.gameObject, false)
		arg_21_0:RemoveExpTween()
	end))
end

function var_0_0.SetExpWithoutTween(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:RenderUserData(arg_24_1 + arg_24_2)
end

function var_0_0.GetPlayerInfo(arg_25_0)
	return PlayerData:GetPlayerInfo()
end

function var_0_0.GetBattleTime(arg_26_0)
	local var_26_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_26_0)
end

function var_0_0.CheckLevelUp(arg_27_0)
	local var_27_0 = arg_27_0:GetLevelUpInfoList()

	if #var_27_0 > 0 then
		PlayerAction.LevelUpFinish()
		arg_27_0:Go("levelUp", {
			levelUpInfoList = var_27_0
		})
	end
end

function var_0_0.GetLevelUpInfoList(arg_28_0)
	return PlayerData:GetlevelUpInfos()
end

function var_0_0.NeedAddExp(arg_29_0)
	return true
end

function var_0_0.GetRewardData(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.params_.rewardList) do
		table.insert(var_30_0, iter_30_1)
	end

	return var_30_0
end

function var_0_0.CheckIsMultipleReward(arg_31_0)
	if not arg_31_0.params_.rewardList then
		return false
	end

	if #arg_31_0.params_.rewardList == 0 then
		return false
	end

	if arg_31_0.params_.rewardList[1] and arg_31_0.params_.rewardList[1].id then
		return false
	end

	return true
end

function var_0_0.CaculateReward(arg_32_0)
	if arg_32_0.isMultiple or arg_32_0:CheckIsMultipleReward() then
		return
	end

	arg_32_0.rewardHeroExp_ = 0

	local var_32_0 = 0

	if arg_32_0.params_.rewardList then
		for iter_32_0, iter_32_1 in ipairs(arg_32_0.params_.rewardList) do
			if ItemCfg[iter_32_1[1]].type == ItemConst.ITEM_TYPE.CURRENCY and iter_32_1[1] == CurrencyConst.CURRENCY_TYPE_HERO_EXP then
				var_32_0 = iter_32_0
			end
		end
	end

	if var_32_0 ~= 0 then
		arg_32_0.rewardHeroExp_ = arg_32_0.params_.rewardList[var_32_0][2]

		table.remove(arg_32_0.params_.rewardList, var_32_0)
	end
end

function var_0_0.OnTop(arg_33_0)
	arg_33_0.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	arg_33_0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	arg_33_0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	if arg_33_0.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		local var_33_0 = arg_33_0.stageData:GetDest()
		local var_33_1 = ActivityPtRouletteStageCfg[var_33_0].cost[1]

		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			var_33_1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	else
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetAsLastSibling()
	SetActive(arg_33_0.gameObject_, true)

	arg_33_0.toStat_ = false
end

function var_0_0.OnBehind(arg_34_0)
	manager.windowBar:HideBar()

	if arg_34_0.lastBarList_ then
		manager.windowBar:SwitchBar(arg_34_0.lastBarList_)
	end

	if arg_34_0.lastAddBarList_ then
		for iter_34_0, iter_34_1 in ipairs(arg_34_0.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_34_1, true)
		end
	end

	if arg_34_0.lastCanClickBarList_ then
		for iter_34_2, iter_34_3 in ipairs(arg_34_0.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_34_3, true)
		end
	end

	if arg_34_0.toStat_ then
		SetActive(arg_34_0.gameObject_, false)
	end
end

function var_0_0.ShowVitalityBox(arg_35_0, arg_35_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_35_1)
	else
		arg_35_1()
	end
end

function var_0_0.ShowEquipBox(arg_36_0, arg_36_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_36_1)
	else
		arg_36_1()
	end
end

function var_0_0.CloseFunc(arg_37_0)
	arg_37_0:ShowVitalityBox(function()
		arg_37_0:ShowEquipBox(function()
			JumpTools.Back()
		end)
	end)
end

function var_0_0.OnceMoreFunc(arg_40_0)
	local var_40_0 = arg_40_0.params_.destID
	local var_40_1 = arg_40_0.params_.stageID
	local var_40_2 = arg_40_0.stageData:GetType()
	local var_40_3 = arg_40_0.stageData:GetCost()
	local var_40_4 = arg_40_0.stageData:GetMultiple()
	local var_40_5 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_40_6 = CurrencyConst.CURRENCY_TYPE_VITALITY

	if var_40_2 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		var_40_5 = CurrencyData:GetCurrencyNum(ActivityPtRouletteStageCfg[var_40_0].cost[1])
		var_40_6 = ActivityPtRouletteStageCfg[var_40_0].cost[1]
	end

	if var_40_5 < var_40_3 * var_40_4 then
		if var_40_6 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_40_6)))
		elseif CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
			JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
		end
	else
		BattleStageAction.OperationRush(arg_40_0.params_.chapterID, var_40_1, var_40_2, arg_40_0.params_.multiple, arg_40_0.params_.activityID, function()
			JumpTools.Back()
		end)
	end
end

return var_0_0
