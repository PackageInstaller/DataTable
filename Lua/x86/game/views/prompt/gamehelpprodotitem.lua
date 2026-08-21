local var_0_0 = class("GameHelpProDotItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("sel")
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_0.selectController_:SetSelectedState("state1")
	else
		arg_2_0.selectController_:SetSelectedState("state0")
	end
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
