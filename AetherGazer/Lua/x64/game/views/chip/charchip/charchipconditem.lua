local var_0_0 = class("CharChipCondItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.clearController_ = arg_1_0.conEx_:GetController("clear")
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.conditionID_ = arg_3_1

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.gameObject_.name = arg_4_0.conditionID_

	local var_4_0 = ConditionCfg[arg_4_0.conditionID_]

	if not var_4_0 then
		Debug.LogError("没有找到条件: id=" .. arg_4_0.conditionID_)
	end

	arg_4_0.desc_.text = var_4_0.desc

	local var_4_1, var_4_2, var_4_3 = IsConditionAchieved(arg_4_0.conditionID_)

	arg_4_0.prog_.text = GetConditionProgressText(arg_4_0.conditionID_, var_4_2, var_4_3)

	arg_4_0.clearController_:SetSelectedState(var_4_1 and "clear" or "notclear")
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
