local var_0_0 = class("BlisterGoalItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.starController_ = arg_1_0.ndnum01Controllerexcollection_:GetController("star")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.starController_:SetSelectedState(arg_2_1 and "on" or "off")

	arg_2_0.textmeettermsText_.text = string.format(GetTips("BLISTER_TASK_DES1"), arg_2_2)
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
