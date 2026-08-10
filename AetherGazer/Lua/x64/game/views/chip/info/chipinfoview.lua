local var_0_0 = class("ChipInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MimirChip/MimirChipEditUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.chipUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshChipItem), arg_3_0.uiList_, arg_3_0:GetChipItem())
	arg_3_0.chipTypeCntList_ = arg_3_0:GetChipTypeCntList() or {}
	arg_3_0.btnState = arg_3_0.btnControllerexcollection_:GetController("btn")
	arg_3_0.conditionControl = arg_3_0.conditionControllerexcollection_:GetController("clear")

	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.chipManagerDataTemplate_ = arg_4_0.params_.chipDataTemplate
	arg_4_0.chipManagerID = arg_4_0.params_.chipManagerID
	arg_4_0.noBattle_ = arg_4_0.params_.noBattle

	local var_4_0 = ChipData:GetChipManagerList()[arg_4_0.params_.chipManagerID]

	arg_4_0.sortChipIDList_ = arg_4_0:SortChip()
	arg_4_0.defaultSelectID_ = var_4_0[arg_4_0.params_.selectChipIndex] or arg_4_0.sortChipIDList_[1]

	arg_4_0.chipUIList_:StartScroll(#arg_4_0.sortChipIDList_, 1)
	arg_4_0:RefreshUI()

	arg_4_0.unlockChipHandler_ = handler(arg_4_0, arg_4_0.OnUnlockChip)

	manager.notify:RegistListener(UNLOCK_CHIP, arg_4_0.unlockChipHandler_)

	arg_4_0.enabledChipHandler_ = handler(arg_4_0, arg_4_0.OnEnabledChip)

	manager.notify:RegistListener(ENABLED_CHIP, arg_4_0.enabledChipHandler_)

	arg_4_0.clickItemHandler_ = handler(arg_4_0, arg_4_0.OnClickItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, arg_4_0.clickItemHandler_)
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP, arg_5_0.unlockChipHandler_)
	manager.notify:RemoveListener(ENABLED_CHIP, arg_5_0.enabledChipHandler_)
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, arg_5_0.clickItemHandler_)

	arg_5_0.unlockChipHandler_ = nil
	arg_5_0.enabledChipHandler_ = nil
	arg_5_0.clickItemHandler_ = nil

	manager.redPoint:unbindUIandKey(arg_5_0.unlockBtn_.transform)
end

function var_0_0.OnUpdate(arg_6_0)
	arg_6_0.defaultSelectID_ = arg_6_0.params_.selectChipID or arg_6_0.sortChipIDList_[1]

	arg_6_0:OnEnabledChip()
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.useBtn_, nil, function()
		arg_7_0.chipManagerDataTemplate_:SetUseChipId(arg_7_0.defaultSelectID_)
		manager.notify:Invoke(ENABLED_CHIP, arg_7_0.defaultSelectID)
	end)
	arg_7_0:AddBtnListener(arg_7_0.unlockBtn_, nil, function()
		ChipAction.UnlockChip(arg_7_0.defaultSelectID_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.unloadBtn_, nil, function()
		arg_7_0.chipManagerDataTemplate_:SetNoUseChipId(arg_7_0.defaultSelectID_)
		manager.notify:CallUpdateFunc(UNUSE_BATTLECHIP, arg_7_0.defaultSelectID_)
	end)
end

function var_0_0.OnUnlockChip(arg_11_0)
	arg_11_0.sortChipIDList_ = arg_11_0:SortChip()

	arg_11_0:OnEnabledChip()
end

function var_0_0.OnEnabledChip(arg_12_0)
	arg_12_0:RefreshUI()
	arg_12_0.chipUIList_:Refresh()
end

function var_0_0.OnClickItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.chipManagerDataTemplate_:GetChipInfoViewPath()

	arg_13_0:Go(var_13_0, {
		chipManagerID = arg_13_0.params_.chipManagerID,
		selectChipID = arg_13_1,
		selectChipIndex = arg_13_0.params_.selectChipIndex,
		chipDataTemplate = arg_13_0.chipManagerDataTemplate_
	})
end

function var_0_0.GetFirstUnSelectID(arg_14_0)
	local var_14_0 = arg_14_0:GetChipData()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.sortChipIDList_) do
		if not table.keyof(var_14_0, iter_14_1) then
			return iter_14_1
		end
	end

	return arg_14_0.sortChipIDList_[1]
end

function var_0_0.RefreshChipItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.sortChipIDList_[arg_15_1]

	arg_15_2:SetChipID(var_15_0)
	arg_15_2:SetTemplateData(arg_15_0.chipManagerDataTemplate_)
	arg_15_2:RefreshUI(arg_15_0.defaultSelectID_, arg_15_0.chipManagerID)
end

function var_0_0.RefreshUI(arg_16_0)
	local var_16_0 = ChipCfg[arg_16_0.defaultSelectID_]

	if var_16_0 then
		local var_16_1, var_16_2, var_16_3 = IsConditionAchieved(var_16_0.new_condition)

		arg_16_0.conditiondescireText_.text = GetI18NText(ConditionCfg[var_16_0.new_condition].desc)

		local var_16_4 = ChipCfg[arg_16_0.chipManagerID]

		arg_16_0.iconImage_.sprite = getSpriteViaConfig("ChipSkillIcon", var_16_0.picture_id)
		arg_16_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. var_16_4.picture_id)
		arg_16_0.name_.text = GetI18NText(var_16_0.suit_name)
		arg_16_0.effectText_.text = GetI18NText(var_16_0.desc)

		local var_16_5, var_16_6, var_16_7 = IsConditionAchieved(var_16_0.new_condition)
		local var_16_8 = arg_16_0.chipManagerDataTemplate_:GetIsUnlockChip(arg_16_0.defaultSelectID_)

		arg_16_0.isUnlock_ = var_16_5

		if var_16_8 == false then
			if arg_16_0.isUnlock_ then
				arg_16_0.btnState:SetSelectedState("unLock2")
				arg_16_0.conditionControl:SetSelectedState("clear")
			else
				arg_16_0.btnState:SetSelectedState("unLock1")
				arg_16_0.conditionControl:SetSelectedState("notClear")
			end
		elseif arg_16_0.noBattle_ then
			arg_16_0.btnState:SetSelectedState("hasUnLock")
		elseif arg_16_0.chipManagerDataTemplate_:GetIsUesChipID(arg_16_0.defaultSelectID_) then
			arg_16_0.btnState:SetSelectedState("unUse")
		else
			arg_16_0.btnState:SetSelectedState("use")
		end

		SetActive(arg_16_0.lockPanel_, not var_16_8)
	end

	manager.redPoint:bindUIandKey(arg_16_0.unlockBtn_.transform, string.format("%s_%s", RedPointConst.CHIP_CHIP, arg_16_0.defaultSelectID_))
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)

	if arg_17_0.chipUIList_ then
		arg_17_0.chipUIList_:Dispose()

		arg_17_0.chipUIList_ = nil
	end
end

function var_0_0.GetChipItem(arg_18_0)
	return ChipItem
end

function var_0_0.GetChipTypeCntList(arg_19_0)
	return ChipTools.GetChipTypeCntList(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP])
end

function var_0_0.GetChipData(arg_20_0)
	return (ReserveTools.GetMimirChipList(arg_20_0.reserveParams_))
end

function var_0_0.SortChip(arg_21_0)
	local var_21_0 = arg_21_0:GetChipTypeCntList() or {}

	return ChipTools.SortChip(var_21_0[-1], arg_21_0.params_.chipManagerID)
end

function var_0_0.GetUnlockChipIDList(arg_22_0)
	return ChipData:GetUnlockChipIDList()
end

return var_0_0
