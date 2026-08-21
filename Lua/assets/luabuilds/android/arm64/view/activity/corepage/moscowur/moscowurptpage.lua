local var_0_0 = class("MoscowURPtPage", import("view.activity.CorePage.CorePageNewPtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)
	setText(arg_1_0.bg:Find("exchange_btn/Text"), i18n("yumia_pt_3"))
	setText(arg_1_0.bg:Find("gray/Text"), i18n("yumia_pt_2"))
	setText(arg_1_0.bg:Find("get_btn/Text"), i18n("yumia_pt_2"))

	return
end

return var_0_0
