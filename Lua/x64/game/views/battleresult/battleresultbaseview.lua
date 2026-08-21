local var_0_0 = class("BattleResultBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/BattleSettlementUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.ChangeCameraToEmpty(arg_3_0)
	manager.ui.mainCamera.transform.localPosition = Vector3(0, -180, 0)
	manager.ui.mainCamera.transform.localEulerAngles = Vector3(0, 180, 0)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListener()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.tweens_ = {}
	arg_5_0.stageData = arg_5_0.params_.stageData
	arg_5_0.stageId = arg_5_0.stageData:GetStageId()
	arg_5_0.stageType = arg_5_0.stageData:GetType()
	arg_5_0.heroExp_ = {}

	BattleInstance.hideBattlePanel()
	arg_5_0:CaculateReward()
	arg_5_0:RefreshUI()
	arg_5_0:CheckBattleError()
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveTween()
	arg_7_0:RemoveTweens()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.rewardItems_) do
		iter_7_1:Dispose()
	end

	arg_7_0.rewardItems_ = nil

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.rewardItemGos_) do
		Object.Destroy(iter_7_3)
	end

	arg_7_0.rewardItemGos_ = nil
	arg_7_0.heroLv_ = nil
	arg_7_0.heroGo_ = nil
	arg_7_0.heroImg_ = nil
	arg_7_0.missionGo_ = nil
	arg_7_0.missionAchieve_ = nil
	arg_7_0.heroAddExp = nil
	arg_7_0.missionNoAchieve_ = nil
	arg_7_0.heroProgress_ = nil
	arg_7_0.missionText_ = nil
	arg_7_0.rewardList_ = nil
	arg_7_0.addExp_ = nil
	arg_7_0.stareText_ = nil
	arg_7_0.lvText_ = nil
	arg_7_0.bg_screen_ = nil
	arg_7_0.rewardListTrs_ = nil
	arg_7_0.mask_ = nil
	arg_7_0.playerLv_ = nil
	arg_7_0.btnBack_ = nil
	arg_7_0.btnBattleCount_ = nil
	arg_7_0.missionTipGo_ = nil
	arg_7_0.progress_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.itemPrefeb = arg_8_0.itemPrefeb or Asset.Load("UI/Common/CommonItem")
	arg_8_0.noInfoGos_ = {}
	arg_8_0.missionGo_ = {}
	arg_8_0.missionNoAchieve_ = {}
	arg_8_0.missionAchieve_ = {}
	arg_8_0.missionText_ = {}

	for iter_8_0 = 1, 3 do
		arg_8_0.noInfoGos_[iter_8_0] = arg_8_0["noInfo" .. iter_8_0]
		arg_8_0.missionGo_[iter_8_0] = arg_8_0["mission" .. iter_8_0]
		arg_8_0.missionNoAchieve_[iter_8_0] = arg_8_0["noachieve" .. iter_8_0]
		arg_8_0.missionAchieve_[iter_8_0] = arg_8_0["achieve" .. iter_8_0]
		arg_8_0.missionText_[iter_8_0] = arg_8_0["missionText" .. iter_8_0]
	end

	arg_8_0.heroGo_ = {}
	arg_8_0.heroLv_ = {}
	arg_8_0.heroImg_ = {}
	arg_8_0.heroAddExp = {}
	arg_8_0.heroProgress_ = {}

	for iter_8_1 = 1, 3 do
		arg_8_0.heroGo_[iter_8_1] = arg_8_0["hero" .. iter_8_1]
		arg_8_0.heroLv_[iter_8_1] = arg_8_0["heroLvText" .. iter_8_1]
		arg_8_0.heroImg_[iter_8_1] = arg_8_0["heroMaskIcon" .. iter_8_1]
		arg_8_0.heroAddExp[iter_8_1] = arg_8_0["heroAddExp" .. iter_8_1]
		arg_8_0.heroProgress_[iter_8_1] = arg_8_0["heroExpProgress" .. iter_8_1]
	end

	arg_8_0.rewardItems_ = {}
	arg_8_0.rewardItemGos_ = {}

	LeanTween.alphaCanvas(arg_8_0.mask_, 0, 0.1)
end

function var_0_0.AddListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btnBack_, nil, function()
		arg_9_0:CloseFunc()
	end)
	arg_9_0:AddBtnListener(arg_9_0.btnClose_, nil, function()
		arg_9_0:CloseFunc()
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonMask_, nil, function()
		arg_9_0:EndAnimator()
	end)
	arg_9_0:AddBtnListener(arg_9_0.btnOnceMore_, nil, function()
		local var_13_0 = arg_9_0.params_.destID
		local var_13_1 = arg_9_0.params_.stageID
		local var_13_2 = arg_9_0.stageData:GetCost()
		local var_13_3 = arg_9_0.stageData:GetMultiple()

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < var_13_2 * var_13_3 then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			BattleInstance.OnceMoreBattle(arg_9_0.stageData)
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.btnBattleCount_, nil, function()
		arg_9_0:GoToBattleStatistics()
	end)
end

function var_0_0.RemoveListener(arg_15_0)
	arg_15_0.btnBack_.onClick:RemoveAllListeners()
	arg_15_0.btnBattleCount_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_16_0)
	arg_16_0:SetLevelTitle()
	arg_16_0:RefreshRewardItemS()
	arg_16_0:RefreshMyExpS()
	arg_16_0:RefreshHeroS()
	arg_16_0:RefreshMissionS()
	arg_16_0:RefreshCommonUI()
	arg_16_0:RefreshBattleTime()
end

function var_0_0.SetLevelTitle(arg_17_0)
	local var_17_0, var_17_1 = BattleStageTools.GetChapterSectionIndex(arg_17_0.stageType, arg_17_0.stageId)

	if var_17_0 ~= "" then
		arg_17_0.stareText_.text = string.format("%s-%s", GetI18NText(var_17_0), GetI18NText(var_17_1))
	else
		arg_17_0.stareText_.text = ""
	end

	arg_17_0.lvText_.text = GetI18NText(BattleStageTools.GetStageName(arg_17_0.stageType, arg_17_0.stageId))

	arg_17_0:RefreshTitleImmediate()
end

function var_0_0.RefreshRewardItemS(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.rewardItems_) do
		iter_18_1:Show(false)
	end

	local var_18_0 = {}

	if arg_18_0.params_.rewardList then
		for iter_18_2, iter_18_3 in pairs(arg_18_0.params_.rewardList) do
			table.insert(var_18_0, iter_18_3)
		end

		var_18_0 = formatRewardCfgList(var_18_0)
		var_18_0 = mergeReward(var_18_0)
		var_18_0 = sortReward(var_18_0)
	end

	for iter_18_4 = 1, #var_18_0 do
		if not arg_18_0.rewardItems_[iter_18_4] then
			local var_18_1 = Object.Instantiate(arg_18_0.itemPrefeb, arg_18_0.rewardList_)

			arg_18_0.rewardItems_[iter_18_4] = CommonItem.New(var_18_1)

			arg_18_0.rewardItems_[iter_18_4]:RegistCallBack(function(arg_19_0)
				ShowPopItem(POP_OTHER_ITEM, {
					arg_19_0.id,
					arg_19_0.number
				})
			end)

			arg_18_0.rewardItemGos_[iter_18_4] = var_18_1

			arg_18_0.rewardItems_[iter_18_4]:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
			arg_18_0.rewardItems_[iter_18_4]:SetBottomTextColor(Color.white)
			arg_18_0.rewardItems_[iter_18_4]:Show(true)
		else
			arg_18_0.rewardItems_[iter_18_4]:Show(true)
		end

		local var_18_2 = var_18_0[iter_18_4]

		if ItemCfg[var_18_2.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_18_2.id].type then
			var_18_2.race = EquipCfg[var_18_2.id] and EquipCfg[var_18_2.id].race
		end

		arg_18_0.rewardItems_[iter_18_4]:RefreshData(rewardToItemTemplate(var_18_2))
	end
end

function var_0_0.RefreshHeroS(arg_20_0)
	local var_20_0, var_20_1 = arg_20_0.stageData:GetHeroTeam()
	local var_20_2 = arg_20_0.stageData:GetSystemHeroTeam()

	if var_20_0[2] == 0 then
		table.remove(var_20_0, 2)
		table.remove(var_20_1, 2)
		table.insert(var_20_0, 0)
		table.insert(var_20_1, 0)
	end

	local var_20_3 = arg_20_0.params_.battleResult.heroDataCollect

	for iter_20_0 = 1, 3 do
		if not var_20_0[iter_20_0] or var_20_0[iter_20_0] == 0 then
			SetActive(arg_20_0.heroGo_[iter_20_0], false)
		else
			SetActive(arg_20_0.heroGo_[iter_20_0], true)

			local var_20_4 = arg_20_0.stageData:GetHeroDataByPos(iter_20_0)
			local var_20_5 = SkinCfg[var_20_4.using_skin]

			if arg_20_0.heroImg_[iter_20_0] ~= nil then
				arg_20_0.heroImg_[iter_20_0].sprite = getSpriteViaConfig("HeroIcon", var_20_5.picture_id)
			end

			if var_20_3[iter_20_0] and arg_20_0:NeedAddExp() then
				local var_20_6 = var_20_3[iter_20_0].oldLv
				local var_20_7 = var_20_3[iter_20_0].newLv
				local var_20_8 = var_20_3[iter_20_0].oldPersent
				local var_20_9 = var_20_3[iter_20_0].newPersent

				arg_20_0.heroAddExp[iter_20_0].text = ""

				arg_20_0:RemoveTweenAt(iter_20_0)

				arg_20_0.heroExp_[iter_20_0] = var_20_3[iter_20_0].newLv + var_20_3[iter_20_0].newPersent
				arg_20_0.tweens_[iter_20_0] = LeanTween.value(arg_20_0.heroProgress_[iter_20_0].gameObject, var_20_6 + var_20_8, var_20_7 + var_20_9, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_20_0:UpdateHeroData(iter_20_0, arg_21_0)
				end)):setOnComplete(LuaHelper.VoidAction(function()
					arg_20_0:RemoveTweenAt(iter_20_0)
				end))
			else
				arg_20_0.heroAddExp[iter_20_0].text = ""
				arg_20_0.heroLv_[iter_20_0].text = var_20_4.level
				arg_20_0.heroProgress_[iter_20_0].value = 1
			end
		end
	end
end

function var_0_0.RefreshMyExpS(arg_23_0)
	local var_23_0 = arg_23_0.params_.battleResult.oldPlayerEXPInfo
	local var_23_1 = var_23_0.userLevel
	local var_23_2 = var_23_0.remain_exp
	local var_23_3 = arg_23_0.stageData:GetAddUserExp() * arg_23_0.stageData:GetMultiple()
	local var_23_4 = arg_23_0.stageData:GetActivityID()
	local var_23_5 = ActivityData:GetActivityData(var_23_4)

	if var_23_4 ~= 0 and (not var_23_5 or not var_23_5:IsActivitying()) or not arg_23_0:NeedAddExp() then
		var_23_3 = 0
	end

	local var_23_6 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_23_7 = math.min(var_23_3, var_23_6 - var_23_0.total_exp)

	if var_23_7 < 0 then
		var_23_7 = 0
	end

	local var_23_8, var_23_9 = LvTools.CheckExp(var_23_1, var_23_2 + var_23_7, "user_level_exp")

	if var_23_1 > 30 and var_23_8 - var_23_1 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_23_2), tostring(var_23_7), tostring(var_23_1), tostring(var_23_8)))
	end

	arg_23_0.newPlayerExp_ = var_23_7
	arg_23_0.addExp_.text = string.format("+%d", var_23_7)

	local var_23_10 = math.floor(var_23_2 / GameLevelSetting[var_23_1].user_level_exp * 1000) / 1000
	local var_23_11 = math.floor(var_23_9 / GameLevelSetting[var_23_8].user_level_exp * 1000) / 1000

	var_23_10 = var_23_10 > 0.99 and 0.99 or var_23_10
	var_23_11 = var_23_11 > 0.99 and 0.99 or var_23_11

	arg_23_0:RemoveTween()

	arg_23_0.userExp_ = var_23_8 + var_23_11

	if var_23_3 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_23_12 = -1

	arg_23_0.tween_ = LeanTween.value(arg_23_0.progress_.gameObject, var_23_1 + var_23_10, var_23_8 + var_23_11, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
		local var_24_0 = math.modf(arg_24_0)

		if var_23_12 == -1 then
			var_23_12 = var_24_0
		end

		if var_24_0 ~= var_23_12 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_23_12 = var_24_0
		end

		arg_23_0:UpdateUserData(arg_24_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_23_0:CheckLevelUp()

		arg_23_0.mask_.blocksRaycasts = false

		arg_23_0:RemoveTween()
	end))
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

function var_0_0.UpdateHeroData(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0, var_27_1 = math.modf(arg_27_2)

	arg_27_0.heroLv_[arg_27_1].text = string.format("%d", var_27_0)

	if LvTools.GetIsMaxLv(var_27_0, "hero") then
		arg_27_0.heroProgress_[arg_27_1].value = 1
	else
		arg_27_0.heroProgress_[arg_27_1].value = var_27_1
	end
end

function var_0_0.EndAnimator(arg_28_0)
	arg_28_0:RemoveTween()
	arg_28_0:RemoveTweens()
	manager.audio:StopEffect()

	if arg_28_0.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	arg_28_0:UpdateUserData(arg_28_0.userExp_)
	arg_28_0:CheckLevelUp()

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.heroExp_) do
		arg_28_0:UpdateHeroData(iter_28_0, iter_28_1)
	end

	arg_28_0.mask_.blocksRaycasts = false
end

function var_0_0.RemoveTween(arg_29_0)
	if arg_29_0.tween_ then
		arg_29_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_29_0.tween_.id)

		arg_29_0.tween_ = nil
	end
end

function var_0_0.RemoveTweenAt(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.tweens_[arg_30_1]

	if var_30_0 then
		var_30_0:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(var_30_0.id)
	end
end

function var_0_0.RemoveTweens(arg_31_0)
	if arg_31_0.tweens_ then
		for iter_31_0, iter_31_1 in pairs(arg_31_0.tweens_) do
			arg_31_0:RemoveTweenAt(iter_31_0)
		end

		arg_31_0.tweens_ = nil
	end
end

function var_0_0.RefreshMissionS(arg_32_0)
	SetActive(arg_32_0.missionTipGo_, true)

	local var_32_0 = arg_32_0.params_.starMissionData
	local var_32_1 = {}

	for iter_32_0 = 1, 3 do
		if var_32_0 ~= nil and var_32_0[iter_32_0] ~= nil then
			SetActive(arg_32_0.noInfoGos_[iter_32_0], false)
			SetActive(arg_32_0.missionGo_[iter_32_0], true)

			local var_32_2 = ThreeStarConditionCfg[var_32_0[iter_32_0].id]

			arg_32_0.missionText_[iter_32_0].text = GetI18NText(BattleInstance.GetStarMissionText(var_32_0[iter_32_0].id, var_32_0[iter_32_0].xData, var_32_0[iter_32_0].yData))

			local var_32_3

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_32_0.stageType then
				var_32_3 = BattleStageData:GetStageData()[arg_32_0.stageId]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == arg_32_0.stageType then
				var_32_3 = BattleBossChallengeNormalData:GetStarList(arg_32_0.stageId)
			end

			local var_32_4 = false

			if var_32_3 and var_32_3.stars and var_32_3.stars[iter_32_0] == 1 then
				var_32_4 = true
			end

			local var_32_5 = var_32_0[iter_32_0].isComplete or var_32_4

			SetActive(arg_32_0.missionNoAchieve_[iter_32_0], not var_32_5)
			SetActive(arg_32_0.missionAchieve_[iter_32_0], var_32_5)

			if var_32_5 then
				arg_32_0.missionText_[iter_32_0].color = Color.New(0.9102, 0.9351, 0.9408, 1)
			else
				arg_32_0.missionText_[iter_32_0].color = Color.New(0.6768, 0.6853, 0.6882, 1)
			end

			var_32_1[iter_32_0] = var_32_5 and 1 or 0
		else
			SetActive(arg_32_0.missionGo_[iter_32_0], false)
			SetActive(arg_32_0.noInfoGos_[iter_32_0], true)
		end
	end

	BattleInstance.RecordThreeStar(arg_32_0.stageType, arg_32_0.stageId, var_32_1)
end

function var_0_0.RefreshCommonUI(arg_33_0)
	local var_33_0 = true
	local var_33_1 = BattleStageTools.GetStageCfg(arg_33_0.stageType, arg_33_0.stageId).tag ~= BattleConst.BATTLE_TAG.STORY

	SetActive(arg_33_0.btnBattleCount_.gameObject, var_33_1)
	arg_33_0:RefreshBottomBtn()
end

function var_0_0.RefreshBottomBtn(arg_34_0)
	local var_34_0, var_34_1 = arg_34_0:NeedOnceMore()

	if var_34_1 then
		arg_34_0.onceMoreLab_.text = GetI18NText(var_34_1)
	else
		arg_34_0.onceMoreLab_.text = GetTips("CHALLENGE_ONCE_MORE")
	end

	SetActive(arg_34_0.onceMoreGo_, var_34_0)
	SetActive(arg_34_0.closeBtnGo_, var_34_0)
	SetActive(arg_34_0.closePanel_, not var_34_0)
end

function var_0_0.RefreshBattleTime(arg_35_0)
	local var_35_0 = BattleStageTools.GetStageCfg(arg_35_0.stageType, arg_35_0.stageId)

	SetActive(arg_35_0.battleTimeGo_, var_35_0.tag ~= BattleConst.BATTLE_TAG.STORY)

	if var_35_0.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	arg_35_0.battleTimeText_.text = arg_35_0:GetBattleTime()
end

function var_0_0.RefreshTitleImmediate(arg_36_0)
	if arg_36_0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_0.titleTransform_)
	end
end

function var_0_0.OnWinStoryEnd(arg_37_0)
	arg_37_0:RefreshTitleImmediate()
end

function var_0_0.GetBattleTime(arg_38_0)
	local var_38_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_38_0)
end

function var_0_0.CheckLevelUp(arg_39_0)
	local var_39_0 = arg_39_0:GetLevelUpInfoList()

	if #var_39_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_39_0
		})
	end
end

function var_0_0.GetLevelUpInfoList(arg_40_0)
	return PlayerData:GetlevelUpInfos()
end

function var_0_0.NeedAddExp(arg_41_0)
	return true
end

function var_0_0.GetRewardData(arg_42_0)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.params_.rewardList) do
		table.insert(var_42_0, iter_42_1)
	end

	return var_42_0
end

function var_0_0.CaculateReward(arg_43_0)
	arg_43_0.rewardHeroExp_ = 0

	local var_43_0 = 0

	if arg_43_0.params_.rewardList then
		for iter_43_0, iter_43_1 in ipairs(arg_43_0.params_.rewardList) do
			if ItemCfg[iter_43_1[1]].type == ItemConst.ITEM_TYPE.CURRENCY and iter_43_1[1] == CurrencyConst.CURRENCY_TYPE_HERO_EXP then
				var_43_0 = iter_43_0
			end
		end
	end

	if var_43_0 ~= 0 then
		arg_43_0.rewardHeroExp_ = arg_43_0.params_.rewardList[var_43_0][2]

		table.remove(arg_43_0.params_.rewardList, var_43_0)
	end
end

function var_0_0.OnTop(arg_44_0)
	SetActive(arg_44_0.gameObject_, true)

	arg_44_0.toStat_ = false
end

function var_0_0.OnBehind(arg_45_0)
	if arg_45_0.toStat_ then
		SetActive(arg_45_0.gameObject_, false)
	end
end

function var_0_0.GoToBattleStatistics(arg_46_0)
	arg_46_0.toStat_ = true

	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = arg_46_0.params_.stageData,
		battleTime = arg_46_0:GetBattleTime()
	})
end

function var_0_0.ShowVitalityBox(arg_47_0, arg_47_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_47_1)
	else
		arg_47_1()
	end
end

function var_0_0.ShowEquipBox(arg_48_0, arg_48_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_48_1)
	else
		arg_48_1()
	end
end

function var_0_0.CloseFunc(arg_49_0)
	OperationRecorder.Record(arg_49_0.class.__cname, "closeCombat")
	arg_49_0:ShowVitalityBox(function()
		arg_49_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_49_0.params_.stageData)
		end)
	end)
end

function var_0_0.NeedOnceMore(arg_52_0)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == arg_52_0.params_.stageData:GetType() then
		local var_52_0 = arg_52_0.params_.stageData:GetStageId()
		local var_52_1 = getChapterIDByStageID(var_52_0)
		local var_52_2 = ChapterCfg[var_52_1].section_id_list

		if var_52_2[(table.indexof(var_52_2, var_52_0) or 0) + 1] ~= nil then
			return true, GetTips("CHALLENGE_NEXT_LEVEL")
		end
	end

	return false
end

function var_0_0.CheckBattleError(arg_53_0)
	if arg_53_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_53_0:CloseFunc()
			end
		})
	end
end

return var_0_0
