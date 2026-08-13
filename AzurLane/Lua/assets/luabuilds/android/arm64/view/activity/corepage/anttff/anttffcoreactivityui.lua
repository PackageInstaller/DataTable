class = var_0_10000

local var_0_0 = "ANTTFFCoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function var_0_1.getUIName(arg_1_0)
	return "ANTTFFCoreActivityUI"
end

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	setText = var_1

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "adapt/TopPage/top/deco/Text")

	i18n = var_4

	var_1(var_2_1, var_4("ANTTFFCoreActivity_title"))

	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_4

	var_1(var_2_3, var_4("ANTTFFCoreActivity_title2"))

	return
end

function var_0_1.OnToggleName(arg_3_0, arg_3_1, arg_3_2)
	setText = var_1_10003

	local var_3_0 = arg_3_1:Find("on/name")

	i18n = var_1_10006

	var_1_10003(var_3_0, var_1_10006(arg_3_2:getConfig("title_res_tag")))

	setText = var_1_10003

	local var_3_1 = arg_3_1:Find("name")

	i18n = var_6

	var_1_10003(var_3_1, var_6(arg_3_2:getConfig("title_res_tag")))

	return
end

function var_0_1.OnAnimations(arg_4_0, arg_4_1, arg_4_2)
	return
end

return var_0_1
