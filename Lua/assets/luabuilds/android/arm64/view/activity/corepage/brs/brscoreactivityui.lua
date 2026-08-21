local var_0_0 = class("BRSCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function var_0_0.getUIName(arg_1_0)
	return "BRSCoreActivityUI"
end

function var_0_0.init(arg_2_0, ...)
	var_0_0.super.init(arg_2_0, ...)
	setText(arg_2_0._tf:Find("adapt/top/btn_home/text_tip/Text (Legacy)"), i18n("brs_main_tip"))

	arg_2_0.huanyingmituzhe_lan = arg_2_0._tf:Find("adapt/mark/huanyingmituzhe_lan")
	arg_2_0.huanyingmituzhe_lv = arg_2_0._tf:Find("adapt/mark/huanyingmituzhe_lv")

	return
end

function var_0_0.selectActivity(arg_3_0, arg_3_1)
	var_0_0.super.selectActivity(arg_3_0, arg_3_1)
	SetActive(arg_3_0.huanyingmituzhe_lan, arg_3_1.id ~= 5984)
	SetActive(arg_3_0.huanyingmituzhe_lv, arg_3_1.id == 5984)

	return
end

return var_0_0
