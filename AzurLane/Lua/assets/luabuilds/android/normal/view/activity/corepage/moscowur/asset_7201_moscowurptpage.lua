class = var_0_10000

local var_0_0 = "MoscowURPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CorePageNewPtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.bg
	local var_1_1 = var_2.Find(var_1_0, "exchange_btn/Text")

	i18n = var_1_0

	var_1(var_1_1, var_1_0("yumia_pt_3"))

	setText = var_1

	local var_1_2 = arg_1_0.bg
	local var_1_3 = var_2.Find(var_1_2, "gray/Text")

	i18n = var_1_2

	var_1(var_1_3, var_1_2("yumia_pt_2"))

	setText = var_1

	local var_1_4 = arg_1_0.bg
	local var_1_5 = var_2.Find(var_1_4, "get_btn/Text")

	i18n = var_1_4

	var_1(var_1_5, var_1_4("yumia_pt_2"))

	return
end

return var_0_1
