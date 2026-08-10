local var_0_0 = class("BirtndaySettingItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:BindCfgUI()

	arg_1_0.controller = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "state")
end

function var_0_0.RefreshUI(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.text_.text = arg_2_1
	arg_2_0.bigText_.text = arg_2_1

	arg_2_0.controller:SetSelectedState(arg_2_1 == arg_2_2 and "on" or "off")
end

return var_0_0
