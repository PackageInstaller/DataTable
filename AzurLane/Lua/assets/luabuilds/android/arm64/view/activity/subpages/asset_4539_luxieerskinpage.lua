class = var_0_10000

local var_0_0 = "LuXieErSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.dayTF

	setColorStr = var_1_10004

	local var_1_1 = var_1_10004(arg_1_0.nday, "#ffffff")

	setColorStr = var_1_10005

	var_1(var_1_0, var_1_1 .. var_1_10005("/" .. #arg_1_0.taskGroup, "#ffffff"))

	return
end

return var_0_1
