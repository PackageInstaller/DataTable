local var_0_0 = class("BisimaiStoryActPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	setText(arg_1_0.dayTF, setColorStr(arg_1_0.nday, "#d9413d") .. setColorStr("/" .. #arg_1_0.taskGroup, "#ffffff"))

	return
end

function var_0_0.GetProgressColor(arg_2_0)
	return "#ff4644", "#ffffff"
end

return var_0_0
