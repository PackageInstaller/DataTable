local var_0_0 = class("NeoSkinGelideliPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	setText(arg_1_0.dayTF, arg_1_0.nday .. "/" .. #arg_1_0.taskGroup)

	return
end

return var_0_0
