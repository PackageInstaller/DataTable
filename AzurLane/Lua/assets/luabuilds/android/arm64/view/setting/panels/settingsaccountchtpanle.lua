local var_0_0 = class("SettingsAccountCHTPanle", import(".SettingsAccountCHPanle"))

function var_0_0.GetTitle(arg_1_0)
	return "注銷"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	setText(findTF(arg_2_0._tf, "delete/Text"), "注銷")

	return
end

return var_0_0
