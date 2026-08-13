class = var_0_10000

local var_0_0 = "JapanV3FrameRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.FrameReTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	arg_1_0.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.bar = var_1.Find(var_1_0, "frame/barContent/bar")

	return
end

return var_0_1
