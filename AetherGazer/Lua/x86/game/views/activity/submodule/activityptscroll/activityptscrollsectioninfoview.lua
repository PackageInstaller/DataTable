SectionBaseView = import("game.views.sectionInfo.SectionInfoMultipleBaseView")

local var_0_0 = class("ActivityPtScrollSectionInfoView", SectionBaseView)
local var_0_1 = #GameSetting.challenge_multiple_count_unlock_level.value

function var_0_0.AddListeners(arg_1_0)
	var_0_0.super.AddListeners(arg_1_0)
	arg_1_0:RemoveBtnListener(nil, arg_1_0.battleBtn_.transform)
	arg_1_0:AddBtnListener(arg_1_0.battleBtn_, nil, function()
		if arg_1_0.lock_ then
			ShowTips(arg_1_0.lockTips_)
		elseif arg_1_0.costID_ ~= 0 and ItemTools.getItemNum(arg_1_0.costID_) < arg_1_0.cost_ * arg_1_0.multiple_ then
			if arg_1_0.costID_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", arg_1_0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(arg_1_0.costID_)))
			end
		else
			arg_1_0:OnClickBtn()
		end
	end)
end

function var_0_0.UpdateBar(arg_3_0)
	local var_3_0 = ActivityPtScrollTools.GetChallengeCurrencyID(arg_3_0.params_.activityId)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		var_3_0,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanClick(var_3_0, true)
	manager.windowBar:RegistBackCallBack(function()
		if arg_3_0.params_.backCall then
			arg_3_0.params_.backCall()
		end

		arg_3_0:Back()
	end)
end

function var_0_0.RefreshData(arg_5_0)
	arg_5_0.cfg_ = BattleStageTools.GetStageCfg(arg_5_0.params_.sectionType, arg_5_0.params_.section)

	arg_5_0.hideStageDescController_:SetSelectedState("false")

	arg_5_0.storyText_.text = arg_5_0.cfg_.tips

	arg_5_0:RefreshCostInfo()

	local var_5_0 = 1

	for iter_5_0 = var_0_1, 1, -1 do
		if ItemTools.getItemNum(arg_5_0.costID_) >= arg_5_0.cost_ * iter_5_0 then
			var_5_0 = iter_5_0

			break
		end
	end

	arg_5_0.maxMultiple_ = var_5_0
	arg_5_0.multiple_ = arg_5_0.multiple_ or 1
	arg_5_0.challengeCnt_ = arg_5_0:GetUnlockChallengeCnt()

	local var_5_1 = ActivityPtScrollData:GetClearList(arg_5_0.params_.activityId)
	local var_5_2 = table.indexof(var_5_1, arg_5_0.params_.section) ~= false and 1 or 0

	arg_5_0.lock_ = false
	arg_5_0.lockTips_ = ""
	arg_5_0.isFirstClear_ = var_5_2 == 0
	arg_5_0.dropLibID_ = arg_5_0.cfg_.drop_lib_id
end

function var_0_0.RefreshCostInfo(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_6_0.params_.activityId]

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if ActivityPtRouletteStageCfg[iter_6_1].stage_id == arg_6_0.params_.section then
			var_6_0 = ActivityPtRouletteStageCfg[iter_6_1].cost

			break
		end
	end

	arg_6_0.costID_ = var_6_0[1]
	arg_6_0.cost_ = var_6_0[2]
	arg_6_0.costImage_.sprite = ItemTools.getItemLittleSprite(arg_6_0.costID_)
end

function var_0_0.OnEnter(arg_7_0)
	var_0_0.super.OnEnter(arg_7_0)

	arg_7_0.activityID_ = arg_7_0.params_.activityId
end

function var_0_0.RefreshUI(arg_8_0)
	var_0_0.super.RefreshUI(arg_8_0)

	local var_8_0 = GameSetting.quick_battle_type.value
	local var_8_1 = GameSetting.quick_battle_mode.value
	local var_8_2 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_8_0.params_.activityId]
	local var_8_3 = 0

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		if ActivityPtRouletteStageCfg[iter_8_1].stage_id == arg_8_0.params_.section then
			var_8_3 = ActivityPtRouletteStageCfg[iter_8_1].mode

			break
		end
	end

	if table.indexof(var_8_0, arg_8_0.stageType_) and var_8_3 > 0 and table.indexof(var_8_1, var_8_3) then
		local var_8_4 = ActivityPtScrollData:GetClearList(arg_8_0.params_.activityId)

		if table.indexof(var_8_4, arg_8_0.params_.section) then
			arg_8_0.btnController_:SetSelectedState("rush")
		else
			arg_8_0.btnController_:SetSelectedState("cantrush")
		end
	else
		arg_8_0.btnController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshBtn(arg_9_0)
	local var_9_0 = GameSetting.quick_battle_type.value
	local var_9_1 = GameSetting.quick_battle_mode.value
	local var_9_2 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_9_0.params_.activityId]
	local var_9_3 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		if ActivityPtRouletteStageCfg[iter_9_1].stage_id == arg_9_0.params_.section then
			var_9_3 = ActivityPtRouletteStageCfg[iter_9_1].mode

			break
		end
	end

	if table.indexof(var_9_0, arg_9_0.stageType_) and var_9_3 > 0 and table.indexof(var_9_1, var_9_3) then
		local var_9_4 = ActivityPtScrollData:GetClearList(arg_9_0.params_.activityId)

		if table.indexof(var_9_4, arg_9_0.params_.section) then
			arg_9_0.btnController_:SetSelectedState("rush")
		else
			arg_9_0.btnController_:SetSelectedState("cantrush")
		end
	else
		arg_9_0.btnController_:SetSelectedState("false")
	end
end

function var_0_0.HaveCostCntFlag(arg_10_0)
	local var_10_0 = arg_10_0.cost_ * arg_10_0.multiple_

	arg_10_0.costImage_.sprite = ItemTools.getItemLittleSprite(arg_10_0.costID_)

	return var_10_0 <= ItemTools.getItemNum(arg_10_0.costID_)
end

function var_0_0.OnClickBtn(arg_11_0)
	arg_11_0:Go("/sectionSelectHero", {
		section = arg_11_0.params_.section,
		sectionType = arg_11_0.params_.sectionType,
		activityID = arg_11_0.params_.activityId,
		multiple = arg_11_0.multiple_
	})
end

function var_0_0.GetUnlockChallengeCnt(arg_12_0)
	local var_12_0 = ActivityPtScrollData:GetClearList(arg_12_0.params_.activityId)
	local var_12_1 = table.indexof(var_12_0, arg_12_0.params_.section) ~= false and 1 or 0

	if var_12_1 > 0 then
		return var_0_0.super.GetUnlockChallengeCnt(arg_12_0)
	end

	return var_12_1
end

function var_0_0.GetChallengeCntMaxTip(arg_13_0)
	local var_13_0 = ActivityPtScrollData:GetClearList(arg_13_0.params_.activityId)

	if (table.indexof(var_13_0, arg_13_0.params_.section) ~= false and 1 or 0) > 0 then
		return var_0_0.super.GetChallengeCntMaxTip(arg_13_0)
	end

	return GetTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")
end

function var_0_0.RefreshStageInfo(arg_14_0)
	local var_14_0 = BattleStageTools.GetStageCfg(arg_14_0.stageType_, arg_14_0.stageID_)

	if arg_14_0.oldCfgID_ ~= var_14_0.id then
		local var_14_1, var_14_2 = BattleStageTools.GetChapterSectionIndex(arg_14_0.stageType_, arg_14_0.stageID_)

		arg_14_0.sectionText_.text = string.format("%s-%s", GetI18NText(var_14_1), GetI18NText(var_14_2))
		arg_14_0.sectionName_.text = GetI18NText(var_14_0.name)
		arg_14_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_14_0.background_1))
		arg_14_0.oldCfgID_ = var_14_0.id
		arg_14_0.multiple_ = 1
	end
end

return var_0_0
