local var_0_0 = class("HeroChipView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Chip/ChipInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.curHeroId_ = arg_3_0.params_.HeroId
	arg_3_0.chipUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshChipItem), arg_3_0.uiList_, arg_3_0:GetChipItem())
	arg_3_0.chipLockView_ = ChipLockView.New(arg_3_0.lockPanel_)
	arg_3_0.chipTypeCntList_ = arg_3_0:GetChipTypeCntList()
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transformBtnPanel_, "conName")
end

function var_0_0.OnEnter(arg_4_0)
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

	if arg_4_0.params_.HeroId then
		arg_4_0.curHeroId_ = arg_4_0.params_.HeroId
	end

	arg_4_0.sortChipIDList_ = arg_4_0:SortChip()
	arg_4_0.defaultSelectID_ = arg_4_0.sortChipIDList_[1]

	arg_4_0.chipUIList_:StartScroll(#arg_4_0.sortChipIDList_, 1)
	arg_4_0:RefreshUI()
	SetActive(arg_4_0.goResetBtn_, false)
	SetActive(arg_4_0.filterPanel_, false)
	SetActive(arg_4_0.prohibitPanel_, false)

	arg_4_0.unlockChipHandler_ = handler(arg_4_0, arg_4_0.OnUnlockHeroChip)

	manager.notify:RegistListener(UNLOCK_HEROCHIP, arg_4_0.unlockChipHandler_)

	arg_4_0.enabledChipHandler_ = handler(arg_4_0, arg_4_0.OnEnabledHeroChip)

	manager.notify:RegistListener(ENABLED_HEROCHIP, arg_4_0.enabledChipHandler_)

	arg_4_0.clickItemHandler_ = handler(arg_4_0, arg_4_0.OnClickHeroItem)

	manager.notify:RegistListener(ON_CLICK_HEROCHIP_ITEM, arg_4_0.clickItemHandler_)
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_HEROCHIP, arg_5_0.unlockChipHandler_)
	manager.notify:RemoveListener(ENABLED_HEROCHIP, arg_5_0.enabledChipHandler_)
	manager.notify:RemoveListener(ON_CLICK_HEROCHIP_ITEM, arg_5_0.clickItemHandler_)

	arg_5_0.unlockChipHandler_ = nil
	arg_5_0.enabledChipHandler_ = nil
	arg_5_0.clickItemHandler_ = nil
end

function var_0_0.OnUpdate(arg_6_0)
	arg_6_0.defaultSelectID_ = arg_6_0.params_.selectChipID or arg_6_0.sortChipIDList_[1]

	arg_6_0:OnEnabledHeroChip()
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.useBtn_, nil, function()
		ChipAction.EnabledHeroChip(arg_7_0.curHeroId_, arg_7_0.defaultSelectID_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.unlockBtn_, nil, function()
		ChipAction.UnlockHeroChip(arg_7_0.defaultSelectID_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.unloadBtn_, nil, function()
		ChipAction.EnabledHeroChip(arg_7_0.curHeroId_, 0)
	end)
end

function var_0_0.OnUnlockHeroChip(arg_11_0)
	arg_11_0.sortChipIDList_ = arg_11_0:SortChip()

	arg_11_0:OnEnabledHeroChip()
end

function var_0_0.OnEnabledHeroChip(arg_12_0)
	arg_12_0:RefreshUI()
	arg_12_0.chipUIList_:Refresh()
end

function var_0_0.OnClickHeroItem(arg_13_0, arg_13_1)
	arg_13_0:Go("/heroChipView", {
		chipManagerID = arg_13_0.params_.chipManagerID,
		selectChipID = arg_13_1,
		selectChipIndex = arg_13_0.params_.selectChipIndex
	})
end

function var_0_0.RefreshChipItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.sortChipIDList_[arg_14_1]

	arg_14_2:SetChipID(var_14_0, arg_14_0.curHeroId_)
	arg_14_2:RefreshUI(arg_14_0.defaultSelectID_, arg_14_0.curHeroId_)
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:RefreshRightInfo()
	arg_15_0.chipLockView_:SetChipID(arg_15_0.defaultSelectID_, arg_15_0.params_.chipManagerID)
end

function var_0_0.RefreshRightInfo(arg_16_0)
	local var_16_0 = ChipCfg[arg_16_0.defaultSelectID_]

	arg_16_0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", var_16_0.picture_id)
	arg_16_0.name_.text = GetI18NText(var_16_0.suit_name)
	arg_16_0.effectText_.text = GetI18NText(var_16_0.desc)

	if var_16_0.spec_char ~= 0 then
		arg_16_0.typeText_.text = GetTips("EXCLUSIVE_CHIP")
	else
		arg_16_0.typeText_.text = GetTips("NORMAL_CHIP")
	end

	local var_16_1 = arg_16_0:GetUnlockChipIDList()

	if table.keyof(var_16_1, arg_16_0.defaultSelectID_) then
		SetActive(arg_16_0.lockPanel_, false)
	else
		SetActive(arg_16_0.lockPanel_, true)
		arg_16_0.controller_:SetSelectedState("unlock")
	end
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)

	if arg_17_0.chipUIList_ then
		arg_17_0.chipUIList_:Dispose()

		arg_17_0.chipUIList_ = nil
	end

	arg_17_0.chipLockView_:Dispose()

	arg_17_0.chipLockView_ = nil
end

function var_0_0.GetChipItem(arg_18_0)
	return HeroChipItem
end

function var_0_0.GetChipTypeCntList(arg_19_0)
	return ChipData:GetHeroChipsByHeroId(arg_19_0.curHeroId_)
end

function var_0_0.SortChip(arg_20_0)
	return ChipTools.SortChipList(ChipData:GetCurHeroChip(arg_20_0.curHeroId_), ChipData:GetHeroChipsByHeroId(arg_20_0.curHeroId_), nil, true)
end

function var_0_0.GetUnlockChipIDList(arg_21_0)
	return ChipData:GetUnlockHeroChipIDList()
end

return var_0_0
