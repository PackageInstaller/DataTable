local var_0_0 = class("RyzaAwardRePage", import("view.activity.CorePage.templatePage.CoreAwardTemplatePage"))

function var_0_0.RefreshCountText(arg_1_0, arg_1_1, arg_1_2)
	setText(arg_1_2:Find("owner/number"), string.format("%s<color=#D3C5BF>/%s</color>", arg_1_1.count, arg_1_1.config.count))

	return
end

return var_0_0
