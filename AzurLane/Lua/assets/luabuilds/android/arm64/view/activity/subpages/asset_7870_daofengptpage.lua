class = var_0_10000

local var_0_0 = "DaofengPTPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	local var_1_0 = arg_1_0.ptData
	local var_1_1, var_1_2, var_1_3 = var_1.GetResProgress(var_1_0)

	setText = var_1_10004

	local var_1_4 = arg_1_0.progress

	setColorStr = var_1_10007

	var_1_10004(var_1_4, var_1_10007(var_1_1, "#915167") .. "/" .. var_1_2)

	Drop = var_1_10004

	local var_1_5 = var_1_10004.New
	local var_1_6 = {}

	DROP_TYPE_RESOURCE = var_7
	var_1_6.type = var_7
	var_1_6.id = arg_1_0.ptData.resId

	local var_1_7 = var_1_5(var_1_6)
	local var_1_8

	var_1_8, LoadImageSpriteAsync = var_4.getIcon(var_1_7), var_1_10005

	local var_1_9 = arg_1_0._tf

	var_1_10005(var_1_8, var_8.Find(var_1_9, "AD/icon"), false)

	return
end

return var_0_1
