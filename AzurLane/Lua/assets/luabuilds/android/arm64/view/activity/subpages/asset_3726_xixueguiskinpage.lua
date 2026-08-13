class = var_0_10000

local var_0_0 = "XixueguiSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	setText = var_1

	var_1(arg_1_0.dayTF, arg_1_0.nday .. "/" .. #arg_1_0.taskGroup)

	return
end

return var_0_1
