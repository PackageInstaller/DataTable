local var_0_0 = class("ChipManagerLockView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockState = arg_1_0.conditionControllerexcollection_:GetController("clear")
end

function var_0_0.SetTemplateData(arg_2_0)
	return
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.unlockBtn_, nil, function()
		if arg_3_0.isUnlock_ then
			ChipAction.UnlockChipManager(arg_3_0.chipMnagerID_)
		end
	end)
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	if arg_5_0.gameObject_ then
		SetActive(arg_5_0.gameObject_, arg_5_1)
	end
end

function var_0_0.SetChipManagerID(arg_6_0, arg_6_1)
	arg_6_0.chipMnagerID_ = arg_6_1

	local var_6_0 = ChipCfg[arg_6_1]
	local var_6_1, var_6_2, var_6_3 = IsConditionAchieved(var_6_0.new_condition)

	arg_6_0.requireText_.text = GetI18NText(ConditionCfg[var_6_0.new_condition].desc)

	if var_6_1 then
		arg_6_0.lockState:SetSelectedState("clear")
	else
		arg_6_0.lockState:SetSelectedState("notclear")
	end

	arg_6_0.isUnlock_ = var_6_1
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
