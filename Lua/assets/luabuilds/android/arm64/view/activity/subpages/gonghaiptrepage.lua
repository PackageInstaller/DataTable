local var_0_0 = class("GongHaiPtRePage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	setText(arg_1_0.bg:Find("title"), i18n("pt_count_tip"))

	return
end

return var_0_0
