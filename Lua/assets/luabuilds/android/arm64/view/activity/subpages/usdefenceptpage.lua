local var_0_0 = class("USDefencePTPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)

	local var_1_0, var_1_1, var_1_2 = arg_1_0.ptData:GetResProgress()
	local var_1_3 = var_1_2 >= 1 and setColorStr(var_1_0, "#588CFEFF") or var_1_0

	setText(arg_1_0.progress, var_1_3 .. "/" .. var_1_1)

	return
end

return var_0_0
