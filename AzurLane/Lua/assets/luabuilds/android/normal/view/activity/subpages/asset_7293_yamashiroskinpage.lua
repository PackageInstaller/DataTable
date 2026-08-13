class = var_0_10000

local var_0_0 = "YamashiroSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.dayTF
	local var_1_1 = arg_1_0.nday

	setColorStr = var_1_10004

	local var_1_2 = "/" .. #arg_1_0.taskGroup

	COLOR_WHITE = var_6

	var_1(var_1_0, var_1_1 .. var_1_10004(var_1_2, var_6))

	return
end

return var_0_1
