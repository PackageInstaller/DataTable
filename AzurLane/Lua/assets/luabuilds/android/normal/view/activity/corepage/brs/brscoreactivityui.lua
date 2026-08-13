class = var_0_10000

local var_0_0 = "BRSCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "BRSCoreActivityUI"
end

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	setText = var_1

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "adapt/top/btn_home/text_tip/Text (Legacy)")

	i18n = var_2_0

	var_1(var_2_1, var_2_0("brs_main_tip"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.huanyingmituzhe_lan = var_1.Find(var_2_2, "adapt/mark/huanyingmituzhe_lan")

	local var_2_3 = arg_2_0._tf

	arg_2_0.huanyingmituzhe_lv = var_1.Find(var_2_3, "adapt/mark/huanyingmituzhe_lv")

	return
end

function var_0_1.selectActivity(arg_3_0, arg_3_1)
	var_0_1.super.selectActivity(arg_3_0, arg_3_1)

	SetActive = var_2

	var_2(arg_3_0.huanyingmituzhe_lan, arg_3_1.id ~= 5984)

	SetActive = var_2

	var_2(arg_3_0.huanyingmituzhe_lv, arg_3_1.id == 5984)

	return
end

return var_0_1
