local var_0_0 = class("ForestVacationSkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	if arg_1_0.dayTF then
		setText(arg_1_0.dayTF, arg_1_0.nday .. "/" .. #arg_1_0.taskGroup)
	end

	arg_1_0.uilist:align(#arg_1_0.taskGroup[arg_1_0.nday])

	return
end

function var_0_0.GetProgressColor(arg_2_0)
	return "#A5AE90"
end

return var_0_0
