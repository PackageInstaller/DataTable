class = var_0_10000

local var_0_0 = "RyzaAwardRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.templatePage.CoreAwardTemplatePage"))

function var_0_1.RefreshCountText(arg_1_0, arg_1_1, arg_1_2)
	setText = var_1_10003

	local var_1_0 = arg_1_2
	local var_1_1 = arg_1_2.Find(var_1_0, "owner/number")

	string = var_1_0

	var_1_10003(var_1_1, var_1_0.format("%s<color=#D3C5BF>/%s</color>", arg_1_1.count, arg_1_1.config.count))

	return
end

return var_0_1
