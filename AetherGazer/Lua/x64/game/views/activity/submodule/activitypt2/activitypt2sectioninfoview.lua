SectionBaseView = import("game.views.sectionInfo.SectionInfoMultipleBaseView")

local var_0_0 = class("ActivityPt2SectionInfoView", SectionBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/PTSectionInfoUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	var_0_0.super.InitUI(arg_3_0)

	arg_3_0.affixGoList_ = {}

	local var_3_0 = arg_3_0.affixContentTrans_.childCount

	for iter_3_0 = 1, var_3_0 do
		arg_3_0.affixGoList_[iter_3_0] = arg_3_0.affixContentTrans_:GetChild(iter_3_0 - 1).gameObject
	end
end

function var_0_0.AddListeners(arg_4_0)
	var_0_0.super.AddListeners(arg_4_0)
	arg_4_0:RemoveBtnListener(nil, arg_4_0.battleBtn_.transform)
	arg_4_0:AddBtnListener(arg_4_0.battleBtn_, nil, function()
		if arg_4_0.lock_ then
			ShowTips(arg_4_0.lockTips_)
		elseif arg_4_0.costId ~= 0 and ItemTools.getItemNum(arg_4_0.costId) < arg_4_0.cost * arg_4_0.multiple_ then
			if arg_4_0.costId == CurrencyConst.CURRENCY_TYPE_VITALITY then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", arg_4_0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(arg_4_0.costId)))
			end
		else
			arg_4_0:OnClickBtn()
		end
	end)
end

function var_0_0.UpdateBar(arg_6_0)
	local var_6_0 = ActivityPt2Tools.GetChallengeCurrencyID(arg_6_0.params_.mainActivityId)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		var_6_0,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(var_6_0, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function()
		if arg_6_0.params_.backCall then
			arg_6_0.params_.backCall()
		end

		arg_6_0:Back()
	end)
end

function var_0_0.RefreshData(arg_8_0)
	arg_8_0.cfg_ = BattleStageTools.GetStageCfg(arg_8_0.params_.sectionType, arg_8_0.params_.section)

	arg_8_0:RefreshCostInfo()

	local var_8_0 = 1

	for iter_8_0 = #GameSetting.challenge_multiple_count_unlock_level.value, 1, -1 do
		if ItemTools.getItemNum(arg_8_0.costId) >= arg_8_0.cost * iter_8_0 then
			var_8_0 = iter_8_0

			break
		end
	end

	arg_8_0.maxMultiple_ = var_8_0
	arg_8_0.multiple_ = arg_8_0.multiple_ or 1
	arg_8_0.challengeCnt_ = arg_8_0:GetUnlockChallengeCnt()

	local var_8_1 = 0
	local var_8_2 = ActivityCfg[arg_8_0.params_.mainActivityId].sub_activity_list

	if arg_8_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL then
		local var_8_3 = ActivityPt2Data:GetNormalData(var_8_2[1], arg_8_0.params_.repeat_id)

		var_8_1 = var_8_3 and var_8_3.clear_time or 0
	elseif arg_8_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
		local var_8_4 = ActivityPt2Data:GetChallengeData(var_8_2[2], arg_8_0.params_.repeat_id)

		var_8_1 = var_8_4 and var_8_4.clear_time or 0
	else
		local var_8_5 = ActivityPt2Data:GetHardData(var_8_2[3])

		var_8_1 = var_8_5 and var_8_5.clear_time or 0
	end

	arg_8_0.lock_ = false
	arg_8_0.lockTips_ = ""
	arg_8_0.isFirstClear_ = var_8_1 == 0
	arg_8_0.drop_lib_id = arg_8_0.cfg_.drop_lib_id
end

function var_0_0.RefreshCostInfo(arg_9_0)
	if ActivityPt2Cfg[arg_9_0.params_.repeat_id].cost[1][1] then
		arg_9_0.costId = ActivityPt2Cfg[arg_9_0.params_.repeat_id].cost[1][1]
		arg_9_0.cost = ActivityPt2Cfg[arg_9_0.params_.repeat_id].cost[1][2]
		arg_9_0.costIcon_.sprite = ItemTools.getItemLittleSprite(arg_9_0.costId)

		SetActive(arg_9_0.resourcePanel_, true)
		SetActive(arg_9_0.multiplePanel_, true)
		SetActive(arg_9_0.rewardPanel_, true)
	else
		arg_9_0.costId = 0
		arg_9_0.cost = 0

		SetActive(arg_9_0.resourcePanel_, false)
		SetActive(arg_9_0.multiplePanel_, false)
		SetActive(arg_9_0.rewardPanel_, false)
	end
end

function var_0_0.RefreshStageInfo(arg_10_0)
	arg_10_0.cfg_ = BattleStageTools.GetStageCfg(arg_10_0.params_.sectionType, arg_10_0.params_.section)

	if arg_10_0.oldCfgID_ ~= arg_10_0.cfg_.id then
		arg_10_0.sectionName_.text = GetI18NText(arg_10_0.cfg_.name)
		arg_10_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, arg_10_0.cfg_.background_1))
		arg_10_0.textStory_.text = GetI18NText(arg_10_0.cfg_.tips)
		arg_10_0.oldCfgID_ = arg_10_0.cfg_.id
		arg_10_0.tipsText_.text = arg_10_0.cfg_.tips
		arg_10_0.titleCanvasGroup_.alpha = 0
		arg_10_0.multiple_ = 1

		arg_10_0:RefreshAffix()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.textContent_)
end

function var_0_0.RefreshAffix(arg_11_0)
	local var_11_0 = arg_11_0.cfg_.affix_type

	if type(var_11_0) ~= "table" then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		arg_11_0["affixName_" .. iter_11_0].text = GetI18NText(getAffixName(iter_11_1))
		arg_11_0["affixDesc_" .. iter_11_0].text = GetI18NText(getAffixDesc(iter_11_1))
		arg_11_0["affixIcon_" .. iter_11_0].sprite = getAffixSprite(iter_11_1)

		if arg_11_0.affixGoList_[iter_11_0] then
			SetActive(arg_11_0.affixGoList_[iter_11_0], true)
		end
	end

	for iter_11_2 = #var_11_0 + 1, #arg_11_0.affixGoList_ do
		if arg_11_0.affixGoList_[iter_11_2] then
			SetActive(arg_11_0.affixGoList_[iter_11_2], false)
		end
	end
end

function var_0_0.OnClickBtn(arg_12_0)
	arg_12_0:Go("/sectionSelectHero", {
		section = arg_12_0.params_.section,
		sectionType = arg_12_0.params_.sectionType,
		activityID = arg_12_0.params_.activityId,
		multiple = arg_12_0.multiple_
	})
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0:UpdateBar()
end

function var_0_0.OnBehind(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.GetUnlockChallengeCnt(arg_15_0)
	local var_15_0 = 0
	local var_15_1 = ActivityCfg[arg_15_0.params_.mainActivityId].sub_activity_list

	if arg_15_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL then
		local var_15_2 = ActivityPt2Data:GetNormalData(var_15_1[1], arg_15_0.params_.repeat_id)

		var_15_0 = var_15_2 and var_15_2.clear_time or 0
	elseif arg_15_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
		local var_15_3 = ActivityPt2Data:GetChallengeData(var_15_1[2], arg_15_0.params_.repeat_id)

		var_15_0 = var_15_3 and var_15_3.clear_time or 0
	else
		local var_15_4 = ActivityPt2Data:GetHardData(var_15_1[3])

		var_15_0 = var_15_4 and var_15_4.clear_time or 0
	end

	if var_15_0 > 0 then
		return var_0_0.super.GetUnlockChallengeCnt(arg_15_0)
	end

	return var_15_0
end

function var_0_0.GetChallengeCntMaxTip(arg_16_0)
	local var_16_0 = 0
	local var_16_1 = ActivityCfg[arg_16_0.params_.mainActivityId].sub_activity_list

	if arg_16_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL then
		local var_16_2 = ActivityPt2Data:GetNormalData(var_16_1[1], arg_16_0.params_.repeat_id)

		var_16_0 = var_16_2 and var_16_2.clear_time or 0
	elseif arg_16_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
		local var_16_3 = ActivityPt2Data:GetChallengeData(var_16_1[2], arg_16_0.params_.repeat_id)

		var_16_0 = var_16_3 and var_16_3.clear_time or 0
	else
		local var_16_4 = ActivityPt2Data:GetHardData(var_16_1[3])

		var_16_0 = var_16_4 and var_16_4.clear_time or 0
	end

	if var_16_0 > 0 then
		return var_0_0.super.GetChallengeCntMaxTip(arg_16_0)
	end

	return GetTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.affixGoList_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
