class = var_0_10000

local var_0_0 = "CravenCheeringSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.step_txt = var_1.Find(var_1_0, "step_text")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	var_0_1.super.OnUpdateFlush(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0.step_txt

	setColorStr = var_1_10003

	var_1(var_2_0, var_1_10003(arg_2_0.nday, "#89FF59FF") .. "/" .. #arg_2_0.taskGroup)

	return
end

return var_0_1
