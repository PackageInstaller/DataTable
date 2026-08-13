class = var_0_10000

local var_0_0 = "HuanMengMainPtHybridPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewPtHybridTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	local var_1_0 = arg_1_0.ptData
	local var_1_1, var_1_2, var_1_3 = var_1.GetResProgress(var_1_0)

	setText = var_1_10004

	local var_1_4 = arg_1_0.progress

	setColorStr = var_1_10007

	local var_1_5 = var_1_10007(var_1_1, "#bcbaec")
	local var_1_6 = "/"

	setColorStr = var_9

	var_1_10004(var_1_4, var_1_5 .. var_1_6 .. var_9(var_1_2, "#faf1f3"))

	return
end

return var_0_1
