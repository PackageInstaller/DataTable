class = var_0_10000

local var_0_0 = "YunLongSPCoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function var_0_1.getUIName(arg_1_0)
	return "YunLongSPCoreActivityUI"
end

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	setText = var_1

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "adapt/TopPage/top/deco/Text")

	i18n = var_4

	var_1(var_2_1, var_4("SardiniaSPCoreActivityUI_title"))

	return
end

return var_0_1
