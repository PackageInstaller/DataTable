local var_0_0 = class("YamashiroSkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	setText(arg_1_0.dayTF, arg_1_0.nday .. setColorStr("/" .. #arg_1_0.taskGroup, COLOR_WHITE))

	return
end

return var_0_0
