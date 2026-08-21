local var_0_0 = class("ChipLockView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.SetChipID(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.chipID_ = arg_2_1

	local var_2_0 = ChipCfg[arg_2_1]
	local var_2_1, var_2_2, var_2_3 = IsConditionAchieved(var_2_0.new_condition)

	arg_2_0.requireText_.text = GetI18NText(ConditionCfg[var_2_0.new_condition].desc)
	arg_2_0.requireNumText_.text = GetConditionProgressText(var_2_0.new_condition, var_2_2, var_2_3)
	arg_2_0.isUnlock_ = var_2_1
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
