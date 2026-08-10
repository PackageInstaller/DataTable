local var_0_0 = class("ChipManagerCultivateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MimirChip/MimirChipCultivateUI"
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
	arg_3_0.chipUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshChipItem), arg_3_0.chipuilistUilist_, arg_3_0:GetChipItem())
	arg_3_0.chipManagerInfoView_ = arg_3_0:GetChipManagerInfoView().New(arg_3_0.panelGo_, arg_3_0)
	arg_3_0.chipInfoView_ = arg_3_0:GetChipInfoView().New(arg_3_0.panel2Go_, arg_3_0)
	arg_3_0.isbattleControl = arg_3_0.leftControllerexcollection_:GetController("is_BattleSet")
	arg_3_0.leftSelectControl = arg_3_0.contentControllerexcollection_:GetController("select")
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_4_0:Back(1, {
			isSorted = true
		})
	end)

	arg_4_0.handler_ = handler(arg_4_0, arg_4_0.OnUnlockChipManager)

	manager.notify:RegistListener(UNLOCK_CHIP_MANAGER, arg_4_0.handler_)

	arg_4_0.unlockChipHandler_ = handler(arg_4_0, arg_4_0.OnUnlockChip)

	manager.notify:RegistListener(UNLOCK_CHIP, arg_4_0.unlockChipHandler_)

	arg_4_0.chipManagerList_ = arg_4_0:GetChipManagerList()
	arg_4_0.defaultSelectID_ = arg_4_0.params_.chipManagerID or arg_4_0.chipManagerList_[1]
	arg_4_0.chipManagerDataTemplate_ = ChipManagerDataTemplate.New({
		id = arg_4_0.defaultSelectID_,
		unlockChipManagerIDList_ = ChipData:GetUnlockChipManagerIDList(),
		unlockChipIDList_ = ChipData:GetUnlockChipIDList()
	})

	arg_4_0.chipManagerUIList_:StartScroll(#arg_4_0.chipManagerList_, table.keyof(arg_4_0.chipManagerList_, arg_4_0.defaultSelectID_))

	arg_4_0.chipList_ = arg_4_0:GetChipTypeCntList() or {}

	arg_4_0.chipUIList_:StartScroll(#arg_4_0.chipList_)

	arg_4_0.clickItemHandler_ = handler(arg_4_0, arg_4_0.OnClickChipItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, arg_4_0.clickItemHandler_)

	arg_4_0.defaultSelectChipID_ = arg_4_0.params_.chipID or arg_4_0.chipList_[1]

	arg_4_0:RefreshUI()
	arg_4_0.chipManagerUIList_:Refresh()
	arg_4_0.chipUIList_:Refresh()
end

function var_0_0.OnUpdate(arg_6_0)
	arg_6_0.defaultSelectID_ = arg_6_0.params_.chipManagerID or arg_6_0.chipManagerList_[1]

	arg_6_0:RefreshUI()
	arg_6_0.chipManagerUIList_:Refresh()
	arg_6_0.chipUIList_:Refresh()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, arg_7_0.handler_)

	arg_7_0.handler_ = nil

	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, arg_7_0.clickItemHandler_)
	manager.notify:RemoveListener(UNLOCK_CHIP, arg_7_0.unlockChipHandler_)

	arg_7_0.clickItemHandler_ = nil

	if arg_7_0.chipManagerInfoView_ then
		arg_7_0.chipManagerInfoView_:OnExit()
	end

	if arg_7_0.chipInfoView_ then
		arg_7_0.chipInfoView_:OnExit()
	end

	manager.redPoint:unbindUIandKey(arg_7_0.notice1_)
	manager.redPoint:unbindUIandKey(arg_7_0.notice2_)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.mimirBtn_, nil, function()
		arg_8_0.leftSelectControl:SetSelectedState("state0")

		arg_8_0.tabIndex = 1

		arg_8_0:UpdateRightView(arg_8_0.tabIndex)
	end)
	arg_8_0:AddBtnListener(arg_8_0.mimirchipBtn_, nil, function()
		arg_8_0.leftSelectControl:SetSelectedState("state1")

		arg_8_0.tabIndex = 2

		arg_8_0:UpdateRightView(arg_8_0.tabIndex)
	end)
end

function var_0_0.UpdateRightView(arg_11_0, arg_11_1)
	arg_11_0.curIndex = arg_11_1

	local var_11_0 = {
		arg_11_0.chipManagerInfoView_,
		arg_11_0.chipInfoView_
	}
	local var_11_1 = {
		arg_11_0.defaultSelectID_,
		arg_11_0.defaultSelectChipID_
	}
	local var_11_2 = var_11_0[arg_11_0.curIndex]
	local var_11_3 = var_11_1[arg_11_0.curIndex]

	if var_11_2 and var_11_2.Enter then
		var_11_2:Enter()
	end

	if var_11_2 and var_11_2.RefreshData then
		if var_11_2.SetTemplateData then
			var_11_2:SetTemplateData(arg_11_0.chipManagerDataTemplate_)
		end

		var_11_2:RefreshData(var_11_3)
	end
end

function var_0_0.OnClickChipItem(arg_12_0, arg_12_1)
	arg_12_0.defaultSelectChipID_ = arg_12_1

	arg_12_0:Go("/chipManager", {
		chipManagerID = arg_12_0.defaultSelectID_,
		chipID = arg_12_1,
		defaultSelectChipID_ = arg_12_0.chipManagerID_
	})
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:UpdateRightView(arg_13_0.tabIndex)

	local var_13_0 = ChipCfg[arg_13_0.defaultSelectID_]

	arg_13_0.iconImg_.spriteSync = "TextureConfig/Managecat_l/" .. var_13_0.picture_id

	local var_13_1 = #(arg_13_0.chipManagerList_ or {})
	local var_13_2 = #(arg_13_0.chipManagerDataTemplate_.unlockChipManagerIDList_ or {})

	arg_13_0.numText1_.text = string.format("%s/%s", var_13_2 or 0, var_13_1 or 0)

	local var_13_3 = #(arg_13_0.chipList_ or {})
	local var_13_4 = #(arg_13_0.chipManagerDataTemplate_.unlockChipIDList_ or {})

	arg_13_0.numText2_.text = string.format("%s/%s", var_13_4, var_13_3)

	manager.redPoint:bindUIandKey(arg_13_0.notice1_, RedPointConst.CHIP_MANAGER_CHIP, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(arg_13_0.notice2_, RedPointConst.CHIP_CHIP, {
		x = 0,
		y = 0
	})
end

function var_0_0.OnUnlockChipManager(arg_14_0)
	arg_14_0:RefreshUI()
	arg_14_0.chipManagerUIList_:Refresh()
end

function var_0_0.OnUnlockChip(arg_15_0)
	arg_15_0:RefreshUI()
	arg_15_0.chipUIList_:Refresh()
end

function var_0_0.RefreshChipManagerItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.chipManagerList_[arg_16_1]

	arg_16_2:SetTemplateData(arg_16_0.chipManagerDataTemplate_)
	arg_16_2:SetChipManagerID(var_16_0)
	arg_16_2:RefreshUI(var_16_0 == arg_16_0.defaultSelectID_)
end

function var_0_0.RefreshChipItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.chipList_[arg_17_1]

	arg_17_2:SetTemplateData(arg_17_0.chipManagerDataTemplate_)
	arg_17_2:SetChipID(var_17_0)
	arg_17_2:RefreshUI(arg_17_0.defaultSelectChipID_)
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)

	if arg_18_0.chipInfoView_ then
		arg_18_0.chipInfoView_:Dispose()

		arg_18_0.chipInfoView_ = nil
	end

	if arg_18_0.chipManagerInfoView_ then
		arg_18_0.chipManagerInfoView_:Dispose()

		arg_18_0.chipManagerInfoView_ = nil
	end

	if arg_18_0.chipManagerUIList_ then
		arg_18_0.chipManagerUIList_:Dispose()

		arg_18_0.chipManagerUIList_ = nil
	end

	if arg_18_0.chipUIList_ then
		arg_18_0.chipUIList_:Dispose()

		arg_18_0.chipUIList_ = nil
	end
end

function var_0_0.GetChipManagerList(arg_19_0)
	local var_19_0 = ChipData:GetEnabledChipManagerID()

	return ChipTools.SortChipManager(var_19_0)
end

function var_0_0.GetUnlockChipManagerList(arg_20_0)
	return ChipData:GetUnlockChipManagerIDList()
end

function var_0_0.GetChipTypeCntList(arg_21_0)
	local var_21_0 = ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]

	if manager.guide:IsPlaying() then
		table.sort(var_21_0, function(arg_22_0, arg_22_1)
			return arg_22_0 == 105
		end)
	else
		table.sort(var_21_0, function(arg_23_0, arg_23_1)
			if arg_21_0.chipManagerDataTemplate_ then
				local var_23_0 = ChipTools.GetChipCanLocked(arg_23_0) and 1 or 0
				local var_23_1 = ChipTools.GetChipCanLocked(arg_23_1) and 1 or 0
				local var_23_2 = arg_21_0.chipManagerDataTemplate_:GetIsUnlockChip(arg_23_0) and 2 or var_23_0
				local var_23_3 = arg_21_0.chipManagerDataTemplate_:GetIsUnlockChip(arg_23_1) and 2 or var_23_1

				if var_23_2 ~= var_23_3 then
					return var_23_3 < var_23_2
				end
			end

			return arg_23_0 < arg_23_1
		end)
	end

	return var_21_0
end

function var_0_0.GetManagerUnlockView(arg_24_0)
	return ChipManagerUnlockView
end

function var_0_0.GetChipManagerItem(arg_25_0)
	return ChipManagerItem
end

function var_0_0.GetChipItem(arg_26_0)
	return ChipItem
end

function var_0_0.GetChipManagerInfoView(arg_27_0)
	return MimirChipManagerInfoView
end

function var_0_0.GetChipInfoView(arg_28_0)
	return MimirChipInfoView
end

function var_0_0.RecordStay(arg_29_0, arg_29_1)
	local var_29_0 = math.floor((Time.realtimeSinceStartup - arg_29_0.storyTime) * 1000)

	if arg_29_1 == "1" then
		OperationRecorder.RecordStayView("STAY_VIEW_AI_STORY", var_29_0, arg_29_0.defaultSelectID_)
	end

	arg_29_0.storyTime = Time.realtimeSinceStartup
end

return var_0_0
