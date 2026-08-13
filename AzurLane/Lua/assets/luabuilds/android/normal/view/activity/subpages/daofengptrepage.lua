class = var_0_10000

local var_0_0 = "DaofengPTRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	local var_1_0 = arg_1_0.ptData
	local var_1_1, var_1_2, var_1_3 = var_1.GetResProgress(var_1_0)

	setText = var_1_10004

	local var_1_4 = arg_1_0.progress

	setColorStr = var_1_10006

	var_1_10004(var_1_4, var_1_10006(var_1_1, "#915167") .. "/" .. var_1_2)

	Drop = var_1_10004

	local var_1_5 = var_1_10004.New
	local var_1_6 = {}

	DROP_TYPE_RESOURCE = var_6
	var_1_6.type = var_6
	var_1_6.id = arg_1_0.ptData.resId

	local var_1_7 = var_1_5(var_1_6)
	local var_1_8

	var_1_8, LoadImageSpriteAsync = var_4.getIcon(var_1_7), var_1_7

	local var_1_9 = arg_1_0._tf

	var_1_7(var_1_8, var_7.Find(var_1_9, "AD/icon"), false)

	return
end

return var_0_1
