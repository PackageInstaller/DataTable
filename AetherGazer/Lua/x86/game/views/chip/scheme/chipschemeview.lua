local var_0_0 = class("ChipSchemeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MimirChip/MimirPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.schemeUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshSchemeItem), arg_3_0.uiList_, arg_3_0:GetChipSchemeItem())

	arg_3_0:AddBtnListener(arg_3_0.btn_backBtn_, nil, function()
		arg_3_0:Back()
	end)
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.chipManagerID_ = arg_5_0.params_.chipManagerID
	arg_5_0.dataTemplate = arg_5_0.params_.template
	arg_5_0.sortSchemeList_ = arg_5_0:GetSchemeList()

	arg_5_0.schemeUIList_:StartScroll(#arg_5_0.sortSchemeList_, 1)
	arg_5_0:RefreshUI()

	arg_5_0.enabledSchemeHandler_ = handler(arg_5_0, arg_5_0.OnEnabledScheme)

	manager.notify:RegistListener(ENABLED_SCHEME, arg_5_0.enabledSchemeHandler_)

	arg_5_0.deleteSchemeHandler_ = handler(arg_5_0, arg_5_0.OnDeleteScheme)

	manager.notify:RegistListener(DELETE_CHIP_SCHEME, arg_5_0.deleteSchemeHandler_)

	arg_5_0.saveHandler_ = handler(arg_5_0, arg_5_0.OnSaveChipScheme)

	manager.notify:RegistListener(SAVE_CHIP_SCHEME, arg_5_0.saveHandler_)
end

function var_0_0.OnExit(arg_6_0)
	manager.notify:RemoveListener(ENABLED_SCHEME, arg_6_0.enabledSchemeHandler_)

	arg_6_0.enabledSchemeHandler_ = nil

	manager.notify:RemoveListener(DELETE_CHIP_SCHEME, arg_6_0.deleteSchemeHandler_)

	arg_6_0.deleteSchemeHandler_ = nil

	manager.notify:RemoveListener(SAVE_CHIP_SCHEME, arg_6_0.saveHandler_)

	arg_6_0.saveHandler_ = nil
	arg_6_0.useIndex = nil
end

function var_0_0.RefreshSchemeItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetTemplateData(arg_7_0.dataTemplate)
	arg_7_2:RefreshUI(arg_7_0.chipManagerID_, arg_7_1, arg_7_0.sortSchemeList_[arg_7_1], arg_7_0.useIndex)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ChipData:GetSchemeList()

	arg_8_0.numText_.text = string.format("%s/%s", table.length(var_8_0), GameSetting.ai_chip_proposal_num_max.value[1])
end

function var_0_0.GetChipSchemeItem(arg_9_0)
	return ChipSchemeItem
end

function var_0_0.GetSchemeList(arg_10_0)
	local var_10_0 = ChipTools.SortScheme(arg_10_0.chipManagerID_)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1.id == 0 then
			arg_10_0.useIndex = 1
		end
	end

	return var_10_0
end

function var_0_0.GetSchemeList(arg_11_0)
	local var_11_0 = arg_11_0:GetEquipChipList()
	local var_11_1 = ChipData:GetSchemeList()
	local var_11_2 = {
		{
			id = 0,
			name = GetTips("CURRENT_SCHEME"),
			chipList = var_11_0
		}
	}

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		local var_11_3 = #var_11_0 == #iter_11_1.chipList

		for iter_11_2, iter_11_3 in ipairs(iter_11_1.chipList) do
			if not table.keyof(var_11_0, iter_11_3) then
				var_11_3 = false

				break
			end
		end

		if var_11_3 then
			var_11_2[1] = clone(iter_11_1)
		else
			table.insert(var_11_2, clone(iter_11_1))
		end
	end

	for iter_11_4, iter_11_5 in ipairs(var_11_2) do
		if iter_11_5.id == 0 then
			arg_11_0.useIndex = 1
		end
	end

	return var_11_2
end

function var_0_0.GetEquipChipList(arg_12_0)
	print("ChipSchemeView  GetEquipChipList")

	return arg_12_0.dataTemplate:GetEquipChipList()
end

function var_0_0.OnEnabledScheme(arg_13_0)
	arg_13_0.useIndex = nil

	arg_13_0:OnDeleteScheme()
end

function var_0_0.OnDeleteScheme(arg_14_0)
	arg_14_0.sortSchemeList_ = arg_14_0:GetSchemeList()

	arg_14_0.schemeUIList_:StartScroll(#arg_14_0.sortSchemeList_)
	arg_14_0:RefreshUI()
end

function var_0_0.OnSaveChipScheme(arg_15_0, arg_15_1)
	arg_15_0.useIndex = nil
	arg_15_0.sortSchemeList_ = arg_15_0:GetSchemeList()

	arg_15_0.schemeUIList_:StartScroll(#arg_15_0.sortSchemeList_)
	arg_15_0:RefreshUI()
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	if arg_16_0.schemeUIList_ then
		arg_16_0.schemeUIList_:Dispose()

		arg_16_0.schemeUIList_ = nil
	end
end

return var_0_0
