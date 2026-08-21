local var_0_0 = class("SaDingSkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	setText(arg_1_0.dayTF, setColorStr(arg_1_0.nday, "#ABA9FF") .. "/" .. #arg_1_0.taskGroup)

	return
end

function var_0_0.GetProgressColor(arg_2_0)
	return "#ABA9FF", "#EBEAF7"
end

return var_0_0
