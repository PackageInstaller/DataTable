local var_0_0 = class("LuXieErSkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	setText(arg_1_0.dayTF, setColorStr(arg_1_0.nday, "#ffffff") .. setColorStr("/" .. #arg_1_0.taskGroup, "#ffffff"))

	return
end

return var_0_0
