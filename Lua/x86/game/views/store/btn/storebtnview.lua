local var_0_0 = class("StoreBtnView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.btnType_ = arg_1_2
	arg_1_0.btnIndex_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		manager.notify:Invoke(COMMON_BTN_TYPE_SWITCH, arg_3_0.btnType_, arg_3_0.btnIndex_)
	end)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	if arg_5_1 == arg_5_0.btnIndex_ then
		arg_5_0.controller_:SetSelectedState("false")
	else
		arg_5_0.controller_:SetSelectedState("true")
	end
end

return var_0_0
