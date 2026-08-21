local var_0_0 = class("SurviveSoloSectionInfoView", SectionInfoBaseView)

function var_0_0.InitUI(arg_1_0)
	arg_1_0.super.InitUI(arg_1_0)

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")

	arg_1_0.controller_:SetSelectedState("surviveSolo")

	if arg_1_0.readyTxt_ then
		arg_1_0.readyTxt_.text = GetTips("BATTLE_READY_2")
	end
end

function var_0_0.UpdateBar(arg_2_0)
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
	manager.windowBar:RegistBackCallBack(function()
		if arg_2_0.params_.backFunc then
			arg_2_0.params_.backFunc()
		end

		arg_2_0:Back()
	end)
end

function var_0_0.RefreshData(arg_4_0)
	arg_4_0.cfg_ = BattleStageTools.GetStageCfg(arg_4_0.params_.sectionType, arg_4_0.params_.section)
	arg_4_0.cost_ = arg_4_0.cfg_.cost or 0

	var_0_0.super.RefreshData(arg_4_0)

	arg_4_0.isFirstClear_ = false
	arg_4_0.drop_lib_id = 0
	arg_4_0.lockTips_ = ""
end

function var_0_0.RefreshStageInfo(arg_5_0)
	arg_5_0.cfg_ = BattleStageTools.GetStageCfg(arg_5_0.params_.sectionType, arg_5_0.params_.section)

	if arg_5_0.oldCfgID_ ~= arg_5_0.cfg_.id then
		arg_5_0.sectionName_.text = GetI18NText(arg_5_0.cfg_.name)
		arg_5_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, arg_5_0.cfg_.background_1))
		arg_5_0.textStory_.text = GetI18NText(arg_5_0.cfg_.tips)
		arg_5_0.oldCfgID_ = arg_5_0.cfg_.id
		arg_5_0.tipsText_.text = GetI18NText(arg_5_0.cfg_.tips)
		arg_5_0.titleCanvasGroup_.alpha = 0
	end
end

function var_0_0.OnClickBtn(arg_6_0)
	local var_6_0 = ActivitySoloSlayerCfg[arg_6_0.params_.activityID]
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = {}
	local var_6_4 = var_6_0.limit_type[1]

	if var_6_4 == 1 then
		table.insert(var_6_1, var_6_0.limit_type[2])
	elseif var_6_4 == 2 then
		table.insert(var_6_2, var_6_0.limit_type[2])
	elseif var_6_4 == 3 then
		table.insert(var_6_3, var_6_0.limit_type[2])
	end

	HeroData:SaveSortValue(false, 0, var_6_3, var_6_2, var_6_1)
	arg_6_0:Go("/sectionSelectHero", {
		isSorted = true,
		isHideEffect = true,
		section = arg_6_0.params_.section,
		sectionType = arg_6_0.params_.sectionType,
		activityID = arg_6_0.params_.activityID
	})
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:UpdateBar()
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
