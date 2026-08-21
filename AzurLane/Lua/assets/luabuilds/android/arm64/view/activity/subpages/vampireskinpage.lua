local var_0_0 = class("VampireSkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	setText(arg_1_0.bg:Find("total_day"), #arg_1_0.taskGroup)

	return
end

return var_0_0
