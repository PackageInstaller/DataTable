class = var_0_10000

local var_0_0 = "VampireSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.bg

	var_1(var_3.Find(var_1_0, "total_day"), #arg_1_0.taskGroup)

	return
end

return var_0_1
