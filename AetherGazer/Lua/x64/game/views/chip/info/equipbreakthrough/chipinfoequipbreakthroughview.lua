local var_0_0 = class("ChipInfoEquipBreakThroughView", ChipInfoView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	SetActive(arg_1_0.goResetBtn_, false)
	SetActive(arg_1_0.goFilterPanel_, false)
	SetActive(arg_1_0.transformBtnPanel_.gameObject, false)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.useBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
	arg_2_0:AddBtnListener(arg_2_0.unlockBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
	arg_2_0:AddBtnListener(arg_2_0.resetBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
	arg_2_0:AddBtnListener(arg_2_0.unloadBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
end

function var_0_0.OnClickItem(arg_7_0, arg_7_1)
	arg_7_0:Go("/chipEquipBreakThroughInfo", {
		chipManagerID = arg_7_0.params_.chipManagerID,
		selectChipID = arg_7_1,
		selectChipIndex = arg_7_0.params_.selectChipIndex
	})
end

function var_0_0.GetChipItem(arg_8_0)
	return ChipEquipBreakThroughItem
end

function var_0_0.GetChipTypeCntList(arg_9_0)
	return ChipTools.GetChipTypeCntList(EquipBreakThroughMaterialData:GetChipList())
end

function var_0_0.GetChipData(arg_10_0)
	return EquipBreakThroughMaterialData:GetChipList()
end

function var_0_0.SortChip(arg_11_0)
	return ChipTools.SortChip(EquipBreakThroughMaterialData:GetChipList(), arg_11_0.params_.chipManagerID)
end

function var_0_0.GetUnlockChipIDList(arg_12_0)
	return EquipBreakThroughMaterialData:GetChipList()
end

function var_0_0.RefreshBtnState(arg_13_0)
	local var_13_0 = arg_13_0:GetUnlockChipIDList()

	if table.keyof(var_13_0, arg_13_0.defaultSelectID_) then
		SetActive(arg_13_0.lockPanel_, false)

		local var_13_1 = arg_13_0:GetChipData()

		if table.keyof(var_13_1, arg_13_0.defaultSelectID_) == nil then
			arg_13_0.controller_:SetSelectedState("enable")
		else
			arg_13_0.controller_:SetSelectedState("unload")
		end

		if isMutex then
			arg_13_0.controller_:SetSelectedState("unuse")
		end
	else
		SetActive(arg_13_0.lockPanel_, true)
		arg_13_0.controller_:SetSelectedState("unlock")
	end
end

return var_0_0
