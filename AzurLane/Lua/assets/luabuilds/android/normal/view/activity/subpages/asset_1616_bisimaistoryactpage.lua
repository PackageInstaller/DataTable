class = var_0_10000

local var_0_0 = "BisimaiStoryActPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.dayTF

	setColorStr = var_1_10003

	local var_1_1 = var_1_10003(arg_1_0.nday, "#d9413d")

	setColorStr = var_4

	var_1(var_1_0, var_1_1 .. var_4("/" .. #arg_1_0.taskGroup, "#ffffff"))

	return
end

function var_0_1.GetProgressColor(arg_2_0)
	return "#ff4644", "#ffffff"
end

return var_0_1
