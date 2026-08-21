local var_0_0 = class("YidaliV4SkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)

	if arg_1_0.dayTF then
		setText(arg_1_0.dayTF, setColorStr(arg_1_0.nday, "#b98959") .. setColorStr("/" .. #arg_1_0.taskGroup, "#5a4439"))
	end

	return
end

function var_0_0.GetProgressColor(arg_2_0)
	return "#cead74"
end

return var_0_0
