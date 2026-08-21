local var_0_0 = class("NewBattleSettlementView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/BattleResult/Common/BattleResultWinUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.hasSnapshot_ = GetBattleResultSnapShot()

	arg_3_0:InitUI()

	arg_3_0.btnController = arg_3_0.btnController_:GetController("btn")
	arg_3_0.adaptComp = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.commonMaskBg_.transform)

	arg_3_0:AddListener()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.stageData = arg_4_0.params_.stageData
	arg_4_0.stageId = arg_4_0.stageData:GetStageId()
	arg_4_0.stageType = arg_4_0.stageData:GetType()
	arg_4_0.isMultiple = arg_4_0.params_.multiple ~= nil

	BattleInstance.hideBattlePanel()
	arg_4_0:RenderMaskBg()
	arg_4_0:CaculateReward()
	arg_4_0:RenderView()
	arg_4_0:PostRenderView()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
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
	arg_8_0:AddBtnListener(arg_8_0.statisticsBtn_, nil, function()
		arg_8_0:GoToBattleStatistics()
	end)
	arg_8_0:OnAddListner()
end

local function var_0_1(arg_11_0, arg_11_1)
	if arg_11_0 and not isNil(arg_11_0) then
		SetActive(arg_11_0.gameObject, arg_11_1)
	end
end

function var_0_0.OnAddListner(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.nextStageBtn_, nil, function()
		arg_12_0:OnceMoreFunc()
	end)
end

function var_0_0.RenderView(arg_14_0)
	arg_14_0:RenderTitleView()
	arg_14_0:RefreshMyExpS()
	arg_14_0:RefreshHeroS()
	arg_14_0:RenderCommonUI()
	arg_14_0:RefreshBattleTime()
	arg_14_0:RefreshBottomBtn()
	arg_14_0:ShowContent()
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

function var_0_0.RenderCommonUI(arg_16_0)
	local var_16_0 = true
	local var_16_1 = BattleStageTools.GetStageCfg(arg_16_0.stageType, arg_16_0.stageId).tag ~= BattleConst.BATTLE_TAG.STORY

	SetActive(arg_16_0.statisticsBtn_.gameObject, var_16_1)
end

function var_0_0.RefreshBattleTime(arg_17_0)
	local var_17_0 = BattleStageTools.GetStageCfg(arg_17_0.stageType, arg_17_0.stageId)

	SetActive(arg_17_0.battleTimeText_.gameObject, var_17_0.tag ~= BattleConst.BATTLE_TAG.STORY)

	if var_17_0.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	arg_17_0.battleTimeText_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		arg_17_0:GetBattleTime() or "00"
	})
end

function var_0_0.RefreshHeroS(arg_18_0)
	local var_18_0, var_18_1 = arg_18_0.stageData:GetHeroTeam()
	local var_18_2 = arg_18_0.stageData:GetSystemHeroTeam()

	if var_18_0[2] == 0 then
		table.remove(var_18_0, 2)
		table.remove(var_18_1, 2)
		table.insert(var_18_0, 0)
		table.insert(var_18_1, 0)
	end

	local var_18_3 = arg_18_0.params_.battleResult.heroDataCollect

	for iter_18_0 = 1, 3 do
		if not var_18_0[iter_18_0] or var_18_0[iter_18_0] == 0 then
			arg_18_0.heroModule[iter_18_0]:SetHeroData(nil)
			arg_18_0.heroModule[iter_18_0]:ShowCaptain(false)
		else
			arg_18_0.heroModule[iter_18_0]:ShowCaptain(iter_18_0 == 1)

			local var_18_4 = arg_18_0.stageData:GetHeroDataByPos(iter_18_0)

			arg_18_0.heroModule[iter_18_0]:SetHeroData({
				id = var_18_4.id,
				using_skin = var_18_4.using_skin,
				star = var_18_4.star or 0
			})

			if var_18_3[iter_18_0] and arg_18_0:NeedAddExp() then
				arg_18_0.heroModule[iter_18_0]:PlayLevelUpTween(var_18_3[iter_18_0].oldLv, var_18_3[iter_18_0].newLv, var_18_3[iter_18_0].oldPersent, var_18_3[iter_18_0].newPersent, 2)
			else
				arg_18_0.heroModule[iter_18_0]:ShowLevel(var_18_4.level, 1)
			end
		end
	end
end

function var_0_0.RefreshMyExpS(arg_19_0)
	local var_19_0 = arg_19_0.stageData:GetAddUserExp() * arg_19_0.stageData:GetMultiple()
	local var_19_1 = arg_19_0.stageData:GetActivityID()
	local var_19_2 = arg_19_0.params_.battleResult.oldPlayerEXPInfo
	local var_19_3 = var_19_2.userLevel
	local var_19_4 = var_19_2.remain_exp
	local var_19_5 = ActivityData:GetActivityData(var_19_1)

	if var_19_1 ~= 0 and (not var_19_5 or not var_19_5:IsActivitying()) or not arg_19_0:NeedAddExp() then
		var_19_0 = 0
	end

	local var_19_6 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_19_7 = math.min(var_19_0, var_19_6 - var_19_2.total_exp)

	if var_19_7 < 0 then
		var_19_7 = 0
	end

	local var_19_8, var_19_9 = LvTools.CheckExp(var_19_3, var_19_4 + var_19_7, "user_level_exp")

	if var_19_3 > 30 and var_19_8 - var_19_3 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_19_4), tostring(var_19_7), tostring(var_19_3), tostring(var_19_8)))
	end

	arg_19_0.expTxt_.text = string.format("EXP+%d", var_19_7)

	if LvTools.GetIsMaxLv(var_19_8, "user") then
		arg_19_0.lvNumTxt_.text = "--/--"
	else
		arg_19_0.lvNumTxt_.text = table.concat({
			var_19_9,
			"/",
			GameLevelSetting[var_19_8].user_level_exp
		})
	end

	local var_19_10 = math.floor(var_19_4 / GameLevelSetting[var_19_3].user_level_exp * 1000) / 1000
	local var_19_11 = math.floor(var_19_9 / GameLevelSetting[var_19_8].user_level_exp * 1000) / 1000

	var_19_10 = var_19_10 > 0.99 and 0.99 or var_19_10
	var_19_11 = var_19_11 > 0.99 and 0.99 or var_19_11

	if var_19_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	if var_19_3 == var_19_8 and math.abs(var_19_10 - var_19_11) < 0.0001 then
		var_0_1(arg_19_0.maskBtn_, false)
		arg_19_0:SetExpWithoutTween(var_19_8, var_19_11)
	else
		arg_19_0:StartExpTween(var_19_3, var_19_8, var_19_10, var_19_11)
	end
end

function var_0_0.RenderUserData(arg_20_0, arg_20_1)
	local var_20_0, var_20_1 = math.modf(arg_20_1)
	local var_20_2 = GameLevelSetting[var_20_0].user_level_exp

	arg_20_0.levelTxt_.text = string.format("%d", var_20_0)

	if LvTools.GetIsMaxLv(var_20_0, "user") then
		arg_20_0.expSlider_.value = 1
	else
		arg_20_0.expSlider_.value = var_20_1
	end
end

function var_0_0.RefreshBottomBtn(arg_21_0)
	local var_21_0, var_21_1 = arg_21_0:NeedOnceMore()

	if var_21_1 then
		arg_21_0.confirmBtnTxt_.text = GetI18NText(var_21_1)
	else
		arg_21_0.confirmBtnTxt_.text = GetTips("CHALLENGE_ONCE_MORE")
	end

	SetActive(arg_21_0.nextStageBtn_.gameObject, var_21_0)

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == arg_21_0.params_.stageData:GetType() then
		SetActive(arg_21_0.costImage_.gameObject, false)
	end
end

function var_0_0.RenderMaskBg(arg_22_0)
	if not arg_22_0.hasSnapshot_ then
		arg_22_0.commonMaskBg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/BattleResult/battleResult_bg_common")

		arg_22_0.adaptComp:AdaptImg()
		SetActive(arg_22_0.commonMaskBg_.gameObject, true)
		SetActive(arg_22_0.maskBg_.gameObject, false)
	else
		arg_22_0.maskBg_.texture = arg_22_0.hasSnapshot_

		SetActive(arg_22_0.commonMaskBg_.gameObject, false)
		SetActive(arg_22_0.maskBg_.gameObject, true)
	end
end

function var_0_0.RemoveExpTween(arg_23_0)
	if arg_23_0.expTween_ then
		arg_23_0.expTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_23_0.gameObject_)

		arg_23_0.expTween_ = nil
	end
end

function var_0_0.StartExpTween(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	arg_24_0:RemoveExpTween()
	var_0_1(arg_24_0.maskBtn_, true)

	local var_24_0 = -1

	arg_24_0.tween_ = LeanTween.value(arg_24_0.expSlider_.gameObject, arg_24_1 + arg_24_3, arg_24_2 + arg_24_4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
		local var_25_0 = math.modf(arg_25_0)

		if var_24_0 == -1 then
			var_24_0 = var_25_0
		end

		if var_25_0 ~= var_24_0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_24_0 = var_25_0
		end

		arg_24_0:RenderUserData(arg_25_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_24_0:CheckLevelUp()
		var_0_1(arg_24_0.maskBtn_, false)
		arg_24_0:RemoveExpTween()
	end))
end

function var_0_0.SetExpWithoutTween(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0:RenderUserData(arg_27_1 + arg_27_2)
end

function var_0_0.ShowContent(arg_28_0)
	arg_28_0:onRenderMissionContent()
end

function var_0_0.onRenderMissionContent(arg_29_0)
	if not arg_29_0.missionView then
		arg_29_0.missionView = BattleSettlementMissionModule.New(arg_29_0.contentContainer_)
	end

	local var_29_0 = arg_29_0.params_.starMissionData
	local var_29_1 = {}

	arg_29_0.missionView:RenderView(arg_29_0.stageType, arg_29_0.stageId, var_29_0)
	arg_29_0.missionView:RenderRewards(arg_29_0.params_.rewardList)
end

function var_0_0.GetPlayerInfo(arg_30_0)
	return PlayerData:GetPlayerInfo()
end

function var_0_0.GetBattleTime(arg_31_0)
	local var_31_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_31_0)
end

function var_0_0.CheckLevelUp(arg_32_0)
	local var_32_0 = arg_32_0:GetLevelUpInfoList()

	if #var_32_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_32_0
		})
	end
end

function var_0_0.GetLevelUpInfoList(arg_33_0)
	return PlayerData:GetlevelUpInfos()
end

function var_0_0.NeedAddExp(arg_34_0)
	return true
end

function var_0_0.GetRewardData(arg_35_0)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.params_.rewardList) do
		table.insert(var_35_0, iter_35_1)
	end

	return var_35_0
end

function var_0_0.CheckIsMultipleReward(arg_36_0)
	if not arg_36_0.params_.rewardList then
		return false
	end

	if #arg_36_0.params_.rewardList == 0 then
		return false
	end

	if arg_36_0.params_.rewardList[1] and arg_36_0.params_.rewardList[1].id then
		return false
	end

	return true
end

function var_0_0.CaculateReward(arg_37_0)
	if arg_37_0.isMultiple or arg_37_0:CheckIsMultipleReward() then
		return
	end

	arg_37_0.rewardHeroExp_ = 0

	local var_37_0 = 0

	if arg_37_0.params_.rewardList then
		for iter_37_0, iter_37_1 in ipairs(arg_37_0.params_.rewardList) do
			if ItemCfg[iter_37_1[1]].type == ItemConst.ITEM_TYPE.CURRENCY and iter_37_1[1] == CurrencyConst.CURRENCY_TYPE_HERO_EXP then
				var_37_0 = iter_37_0
			end
		end
	end

	if var_37_0 ~= 0 then
		arg_37_0.rewardHeroExp_ = arg_37_0.params_.rewardList[var_37_0][2]

		table.remove(arg_37_0.params_.rewardList, var_37_0)
	end
end

function var_0_0.OnTop(arg_38_0)
	SetActive(arg_38_0.gameObject_, true)

	arg_38_0.toStat_ = false
end

function var_0_0.OnBehind(arg_39_0)
	if arg_39_0.toStat_ then
		SetActive(arg_39_0.gameObject_, false)
	end
end

function var_0_0.GoToBattleStatistics(arg_40_0)
	arg_40_0.toStat_ = true

	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = arg_40_0.params_.stageData,
		battleTime = arg_40_0:GetBattleTime(),
		hasSnapshot_ = arg_40_0.hasSnapshot_
	})
end

function var_0_0.ShowVitalityBox(arg_41_0, arg_41_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_41_1)
	else
		arg_41_1()
	end
end

function var_0_0.ShowEquipBox(arg_42_0, arg_42_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_42_1)
	else
		arg_42_1()
	end
end

function var_0_0.CloseFunc(arg_43_0)
	OperationRecorder.Record(arg_43_0.class.__cname, "closeCombat")
	arg_43_0:ShowVitalityBox(function()
		arg_43_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_43_0.params_.stageData)
		end)
	end)
end

function var_0_0.NeedOnceMore(arg_46_0)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == arg_46_0.params_.stageData:GetType() then
		local var_46_0 = arg_46_0.params_.stageData:GetStageId()
		local var_46_1 = getChapterIDByStageID(var_46_0)
		local var_46_2 = ChapterCfg[var_46_1].section_id_list

		if var_46_2[(table.indexof(var_46_2, var_46_0) or 0) + 1] ~= nil then
			return true, GetTips("CHALLENGE_NEXT_LEVEL")
		end
	end

	return false
end

function var_0_0.PostRenderView(arg_47_0)
	if arg_47_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_47_0:CloseFunc()
			end
		})
	elseif arg_47_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_ACTIVITY_REFRESH then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_REFRESH_TIPS"),
			OkCallback = function()
				arg_47_0:CloseFunc()
			end
		})
	end
end

function var_0_0.OnceMoreFunc(arg_50_0)
	local var_50_0 = arg_50_0.params_.destID
	local var_50_1 = arg_50_0.params_.stageID
	local var_50_2 = arg_50_0.stageData:GetCost()
	local var_50_3 = arg_50_0.stageData:GetMultiple()
	local var_50_4 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_50_5 = CurrencyConst.CURRENCY_TYPE_VITALITY

	if arg_50_0.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
		local var_50_6 = arg_50_0.stageData:GetDest()
		local var_50_7 = ActivityPt2Cfg[var_50_6]

		var_50_2 = var_50_7.cost[1][2]
		var_50_5 = var_50_7.cost[1][1]
		var_50_4 = ItemTools.getItemNum(var_50_5)
	elseif arg_50_0.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		local var_50_8 = arg_50_0.stageData:GetDest()
		local var_50_9 = ActivityPtRouletteStageCfg[var_50_8]

		var_50_2 = var_50_9.cost[2]
		var_50_5 = var_50_9.cost[1]
		var_50_4 = ItemTools.getItemNum(var_50_5)
	end

	if var_50_4 < var_50_2 * var_50_3 then
		if var_50_5 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_50_5)))
		elseif CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
			JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
		end
	else
		BattleInstance.OnceMoreBattle(arg_50_0.stageData)
		LuaForCursor.SwitchCursor(false)
	end
end

return var_0_0
