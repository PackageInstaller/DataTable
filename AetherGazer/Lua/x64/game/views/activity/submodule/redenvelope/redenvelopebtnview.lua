local var_0_0 = class("RedEnvelopeBtnView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = arg_1_2

	arg_1_0:BindCfgUI()

	arg_1_0.selectController_ = arg_1_0.transform_:GetComponent("ControllerExCollection"):GetController("select")
	arg_1_0.lockController_ = arg_1_0.transform_:GetComponent("ControllerExCollection"):GetController("lock")
	arg_1_0.completedController_ = arg_1_0.transform_:GetComponent("ControllerExCollection"):GetController("completed")
end

function var_0_0.OnExit(arg_2_0)
	return
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.Refresh(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.lockController_:SetSelectedIndex(arg_4_2 < arg_4_0.index and 1 or 0)
	arg_4_0.selectController_:SetSelectedIndex(arg_4_1 == arg_4_0.index and 1 or 0)
	arg_4_0.completedController_:SetSelectedIndex(arg_4_3 and 1 or 0)
end

return var_0_0
