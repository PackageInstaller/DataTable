class = var_0_10000

local var_0_0 = "GongHaiPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.bg
	local var_1_1 = var_2.Find(var_1_0, "title")

	i18n = var_1_0

	var_1(var_1_1, var_1_0("pt_count_tip"))

	return
end

return var_0_1
