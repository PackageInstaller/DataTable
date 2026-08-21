local var_0_0 = class("ChaoZhiPtPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)

	local var_1_0, var_1_1, var_1_2 = arg_1_0.ptData:GetResProgress()

	setText(arg_1_0.progress, setColorStr(var_1_0, "#ffeab7") .. setColorStr("/" .. var_1_1, "#ffda7e"))

	return
end

return var_0_0
