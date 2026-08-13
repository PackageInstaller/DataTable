class = var_0_10000

local var_0_0 = "NeihuadaSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.dayTF

	setColorStr = var_1_10003

	var_1(var_1_0, var_1_10003(arg_1_0.nday, "#edb46b") .. "/" .. #arg_1_0.taskGroup)

	return
end

function var_0_1.GetProgressColor(arg_2_0)
	return "#edb46b"
end

return var_0_1
