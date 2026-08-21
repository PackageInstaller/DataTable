local var_0_0 = class("DexiV4PtPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)

	local var_1_0, var_1_1, var_1_2 = arg_1_0.ptData:GetLevelProgress()
	local var_1_3, var_1_4, var_1_5 = arg_1_0.ptData:GetResProgress()
	local var_1_6 = var_1_5 >= 1 and setColorStr(var_1_3, COLOR_GREEN) or setColorStr(var_1_3, "#F11123")

	setText(arg_1_0.progress, var_1_6 .. setColorStr("/" .. var_1_4, "#635968"))

	return
end

return var_0_0
