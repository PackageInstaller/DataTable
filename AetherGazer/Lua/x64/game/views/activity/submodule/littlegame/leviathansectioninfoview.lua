local var_0_0 = class("LeviathanSectionInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/ChapterSectionInfoUI"
end

function var_0_0.RefreshData(arg_2_0)
	arg_2_0.lock_ = false
	arg_2_0.lockTips_ = ""
	arg_2_0.cost = 0
	arg_2_0.isFirstClear_ = false
	arg_2_0.drop_lib_id = 0
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()

	arg_4_0.multiple_ = 1
end

function var_0_0.OnEnter(arg_5_0)
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

	arg_5_0.activityID_ = arg_5_0.params_.activityID
	arg_5_0.chapterID_ = arg_5_0.params_.chapterID
	arg_5_0.stageID_ = arg_5_0.params_.section
	arg_5_0.stageType_ = arg_5_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	arg_5_0:RefreshData()
	arg_5_0:RefreshUI()
end

function var_0_0.OnUpdate(arg_6_0)
	if arg_6_0.stageID_ == arg_6_0.params_.section then
		return
	end

	arg_6_0.stageID_ = arg_6_0.params_.section

	arg_6_0:RefreshData()
	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.sectionImage_.immediate = true

	SetActive(arg_8_0.multiplePanel_, false)
	SetActive(arg_8_0.tipsPanel_, false)
	SetActive(arg_8_0.targetPanel_, false)

	arg_8_0.controller_ = ControllerUtil.GetController(arg_8_0.transform_, "name")

	arg_8_0.controller_:SetSelectedState("leviathan")

	if arg_8_0.readyTxt_ then
		arg_8_0.readyTxt_.text = GetTips("BATTLE_READY_1")
	end
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.battleBtn_, nil, function()
		local var_10_0 = BattleLeviathanLittleGameTemplate.New(arg_9_0.chapterID_, arg_9_0.activityID_)

		BattleController.GetInstance():LaunchBattle(var_10_0)
	end)
end

function var_0_0.RemoveListeners(arg_11_0)
	arg_11_0.battleBtn_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0:RefreshStageInfo()
	arg_12_0:RefreshCost()
	SetActive(arg_12_0.unlockGo_, arg_12_0.lock_)
	SetActive(arg_12_0.battleBtnGo_, not arg_12_0.lock_)

	arg_12_0.lockText_.text = GetI18NText(arg_12_0.lockTips_)
	arg_12_0.rewardView_.horizontalNormalizedPosition = 0
end

function var_0_0.RefreshStageInfo(arg_13_0)
	local var_13_0 = BattleStageTools.GetStageCfg(arg_13_0.stageType_, arg_13_0.stageID_)

	if arg_13_0.oldCfgID_ ~= var_13_0.id then
		arg_13_0.sectionName_.text = GetI18NText(var_13_0.name)
		arg_13_0.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, var_13_0.background_1)
		arg_13_0.textStory_.text = GetI18NText(var_13_0.tips)
		arg_13_0.oldCfgID_ = var_13_0.id
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveListeners()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
