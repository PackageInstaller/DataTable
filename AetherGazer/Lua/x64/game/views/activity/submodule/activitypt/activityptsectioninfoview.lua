SectionBaseView = import("game.views.sectionInfo.SectionInfoMultipleBaseView")

local var_0_0 = class("ActivityPtSectionInfoView", SectionBaseView)

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

function var_0_0.UpdateBar(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_0.RefreshData(arg_5_0)
	arg_5_0.cfg_ = BattleStageTools.GetStageCfg(arg_5_0.params_.sectionType, arg_5_0.params_.section)
	arg_5_0.cost = arg_5_0.cfg_.cost or 0

	var_0_0.super.RefreshData(arg_5_0)

	local var_5_0 = SummerActivityPtData:GetLevelChallengeCount(arg_5_0.params_.repeat_id)

	arg_5_0.lock_ = false
	arg_5_0.lockTips_ = ""
	arg_5_0.isFirstClear_ = var_5_0 == 0
	arg_5_0.drop_lib_id = arg_5_0.cfg_.drop_lib_id
end

function var_0_0.RefreshStageInfo(arg_6_0)
	arg_6_0.cfg_ = BattleStageTools.GetStageCfg(arg_6_0.params_.sectionType, arg_6_0.params_.section)

	if arg_6_0.oldCfgID_ ~= arg_6_0.cfg_.id then
		arg_6_0.sectionName_.text = GetI18NText(arg_6_0.cfg_.name)
		arg_6_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, arg_6_0.cfg_.background_1))
		arg_6_0.textStory_.text = GetI18NText(arg_6_0.cfg_.tips)
		arg_6_0.oldCfgID_ = arg_6_0.cfg_.id
		arg_6_0.tipsText_.text = GetI18NText(arg_6_0.cfg_.tips)
		arg_6_0.titleCanvasGroup_.alpha = 0
		arg_6_0.multiple_ = 1

		arg_6_0:RefreshAffix()
	end
end

function var_0_0.RefreshAffix(arg_7_0)
	local var_7_0 = arg_7_0.cfg_.affix_type

	if type(var_7_0) ~= "table" then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		arg_7_0["affixName_" .. iter_7_0].text = GetI18NText(getAffixName(iter_7_1))
		arg_7_0["affixDesc_" .. iter_7_0].text = GetI18NText(getAffixDesc(iter_7_1))
		arg_7_0["affixIcon_" .. iter_7_0].sprite = getAffixSprite(iter_7_1)

		if arg_7_0.affixGoList_[iter_7_0] then
			SetActive(arg_7_0.affixGoList_[iter_7_0], true)
		end
	end

	for iter_7_2 = #var_7_0 + 1, #arg_7_0.affixGoList_ do
		if arg_7_0.affixGoList_[iter_7_2] then
			SetActive(arg_7_0.affixGoList_[iter_7_2], false)
		end
	end
end

function var_0_0.OnClickBtn(arg_8_0)
	arg_8_0:Go("/sectionSelectHero", {
		section = arg_8_0.params_.section,
		sectionType = arg_8_0.params_.sectionType,
		activityID = arg_8_0.params_.activityID,
		multiple = arg_8_0.multiple_
	})
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.GetUnlockChallengeCnt(arg_11_0)
	if SummerActivityPtData:GetLevelChallengeCount(arg_11_0.params_.repeat_id) > 0 then
		return var_0_0.super.GetUnlockChallengeCnt(arg_11_0)
	end

	return SummerActivityPtData:GetLevelChallengeCount(arg_11_0.params_.repeat_id)
end

function var_0_0.GetChallengeCntMaxTip(arg_12_0)
	if SummerActivityPtData:GetLevelChallengeCount(arg_12_0.params_.repeat_id) > 0 then
		return var_0_0.super.GetChallengeCntMaxTip(arg_12_0)
	end

	return GetTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.affixGoList_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
