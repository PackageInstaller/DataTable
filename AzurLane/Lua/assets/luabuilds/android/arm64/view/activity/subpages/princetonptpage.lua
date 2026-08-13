class = var_0_10000

local var_0_0 = "PrincetonPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SpTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	local var_1_0 = arg_1_0.ptData
	local var_1_1, var_1_2, var_1_3 = var_1.GetLevelProgress(var_1_0)
	local var_1_4 = arg_1_0.ptData
	local var_1_5, var_1_6, var_1_7 = var_4.GetResProgress(var_1_4)

	setText = var_1_10007

	local var_1_8 = arg_1_0.step

	setColorStr = var_1_10010

	var_1_10007(var_1_8, var_1_10010(var_1_1, "#4180FFFF") .. "/" .. var_1_2)

	setText = var_1_10007

	local var_1_9 = arg_1_0.progress

	setColorStr = var_10

	var_1_10007(var_1_9, var_10(var_1_5, "#4180FFFF") .. "/" .. var_1_6)

	return
end

return var_0_1
