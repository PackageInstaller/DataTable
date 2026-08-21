local var_0_0 = class("ChipManagerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MimirChip/MimirChipUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.isBattle = false
	arg_3_0.tabIndex = 1

	arg_3_0:BindCfgUI()

	arg_3_0.iconImg_.immediate = true

	arg_3_0:AddListeners()

	arg_3_0.chipManagerUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshChipManagerItem), arg_3_0.uiList_, arg_3_0:GetChipManagerItem())
	arg_3_0.chipManagerInfoView_ = arg_3_0:GetChipManagerInfoView().New(arg_3_0.panelGo_, arg_3_0)

	arg_3_0.chipManagerInfoView_:RegistEnableIDFunc(handler(arg_3_0, arg_3_0.EnableChipManagerIDFunc))
end

function var_0_0.SetWindowBar(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_4_0:Back(1, {
			isSorted = true
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:SetWindowBar()

	arg_6_0.handler_ = handler(arg_6_0, arg_6_0.OnUnlockChipManager)

	manager.notify:RegistListener(UNLOCK_CHIP_MANAGER, arg_6_0.handler_)

	arg_6_0.enabledChipHandler_ = handler(arg_6_0, arg_6_0.OnBattleChipUse)

	manager.notify:RegistListener(ENABLED_CHIP, arg_6_0.enabledChipHandler_)

	if not arg_6_0.chipManagerDataTemplate_ then
		arg_6_0.chipManagerDataTemplate_ = arg_6_0:GetChipDataTemplate()
	end

	arg_6_0:SetViewParam()

	arg_6_0.chipManagerList_ = arg_6_0:GetChipManagerList()
	arg_6_0.defaultSelectID_ = arg_6_0.params_.chipManagerID or arg_6_0.chipManagerList_[1]

	arg_6_0.chipManagerUIList_:StartScroll(#arg_6_0.chipManagerList_, table.keyof(arg_6_0.chipManagerList_, arg_6_0.defaultSelectID_))
	arg_6_0:RefreshUI()
end

function var_0_0.OnUpdate(arg_7_0)
	arg_7_0.defaultSelectID_ = arg_7_0.params_.chipManagerID or arg_7_0.chipManagerList_[1]

	arg_7_0:RefreshUI()
	arg_7_0.chipManagerUIList_:Refresh()
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, arg_8_0.handler_)

	arg_8_0.handler_ = nil

	manager.notify:RemoveListener(ENABLED_CHIP, arg_8_0.enabledChipHandler_)

	arg_8_0.enabledChipHandler_ = nil
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.schemeBtn_, nil, function()
		arg_9_0:OnSchemeBtn()
	end)
end

function var_0_0.OnUnlockChipManager(arg_11_0)
	arg_11_0:RefreshUI()
	arg_11_0.chipManagerUIList_:Refresh()
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = ChipCfg[arg_12_0.defaultSelectID_]

	if arg_12_0.chipManagerInfoView_ then
		arg_12_0.chipManagerInfoView_:OnEnter()
		arg_12_0.chipManagerInfoView_:SetTemplateData(arg_12_0.chipManagerDataTemplate_)
		arg_12_0.chipManagerInfoView_:RefreshData(arg_12_0.defaultSelectID_)
	end

	arg_12_0.iconImg_.spriteSync = "TextureConfig/Managecat_l/" .. var_12_0.picture_id
end

function var_0_0.RefreshChipManagerItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.chipManagerList_[arg_13_1]

	arg_13_2:SetChipManagerID(var_13_0)

	if arg_13_0.chipManagerDataTemplate_ and arg_13_2.SetTemplateData then
		arg_13_2:SetTemplateData(arg_13_0.chipManagerDataTemplate_)
	end

	arg_13_2:RefreshUI(var_13_0 == arg_13_0.defaultSelectID_)
end

function var_0_0.RefreshManagerInfo(arg_14_0)
	local var_14_0 = ChipCfg[arg_14_0.defaultSelectID_]

	arg_14_0.chipManagerName_.text = GetI18NText(var_14_0.suit_name)
	arg_14_0.skillText_.text = GetI18NText(var_14_0.desc)
	arg_14_0.descText_.text = GetI18NText(var_14_0.profile)
	arg_14_0.textStory_.text = GetI18NText(var_14_0.story)
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, arg_15_0.handler_)

	arg_15_0.handler_ = nil

	manager.notify:RemoveListener(ENABLED_CHIP, arg_15_0.enabledChipHandler_)

	arg_15_0.enabledChipHandler_ = nil

	if arg_15_0.chipManagerInfoView_ then
		arg_15_0.chipManagerInfoView_:Dispose()

		arg_15_0.chipManagerInfoView_ = nil
	end

	if arg_15_0.chipManagerUIList_ then
		arg_15_0.chipManagerUIList_:Dispose()

		arg_15_0.chipManagerUIList_ = nil
	end
end

function var_0_0.GetChipDataTemplate(arg_16_0)
	return ChipManagerDataTemplate.New({
		id = arg_16_0.defaultSelectID_,
		unlockChipManagerIDList_ = arg_16_0:GetUnlockChipManagerList(),
		unlockChipIDList_ = arg_16_0:GetUnlockChipList()
	})
end

function var_0_0.GetChipManagerList(arg_17_0)
	local var_17_0 = ChipData:GetEnabledChipManagerID()

	return ChipTools.SortChipManager(var_17_0)
end

function var_0_0.GetUnlockChipManagerList(arg_18_0)
	return ChipData:GetUnlockChipManagerIDList()
end

function var_0_0.GetUnlockChipList(arg_19_0)
	return ChipData:GetUnlockChipIDList()
end

function var_0_0.GetChipTypeCntList(arg_20_0)
	return ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]
end

function var_0_0.GetManagerUnlockView(arg_21_0)
	return MimirChipManagerInfoView
end

function var_0_0.GetChipManagerItem(arg_22_0)
	return ChipManagerItem
end

function var_0_0.GetChipManagerInfoView(arg_23_0)
	return BattleChipManagerInfoView
end

function var_0_0.OnSchemeBtn(arg_24_0)
	return
end

function var_0_0.SetViewParam(arg_25_0)
	return
end

function var_0_0.EnableChipManagerIDFunc(arg_26_0, arg_26_1)
	return
end

return var_0_0
