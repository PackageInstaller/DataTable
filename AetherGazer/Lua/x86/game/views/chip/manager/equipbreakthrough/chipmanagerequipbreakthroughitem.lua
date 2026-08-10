local var_0_0 = class("ChipManagerEquipBreakThroughItem", import("..ChipManagerItem"))

function var_0_0.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.btn_, nil, function()
		return
	end)
end

function var_0_0.GetUnlockChipManagerList(arg_3_0)
	return {}
end

function var_0_0.GetEnabledChipManagerID(arg_4_0)
	return EquipBreakThroughMaterialData:GetChipManagerID()
end

function var_0_0.BindRedPoint(arg_5_0)
	return
end

function var_0_0.UnbindRedPoint(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	var_0_0.super.RefreshUI(arg_7_0, arg_7_1)
	SetActive(arg_7_0.lockGo_)
end

return var_0_0
