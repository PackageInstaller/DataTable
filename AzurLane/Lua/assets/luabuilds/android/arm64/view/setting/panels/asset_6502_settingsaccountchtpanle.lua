class = var_0_10000

local var_0_0 = "SettingsAccountCHTPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsAccountCHPanle"))

function var_0_1.GetTitle(arg_1_0)
	return "注銷"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	setText = var_1
	findTF = var_3

	var_1(var_3(arg_2_0._tf, "delete/Text"), "注銷")

	return
end

return var_0_1
