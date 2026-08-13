class = var_0_10000

local var_0_0 = "ForestVacationSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	if arg_1_0.dayTF then
		setText = var_1

		var_1(arg_1_0.dayTF, arg_1_0.nday .. "/" .. #arg_1_0.taskGroup)
	end

	local var_1_0 = arg_1_0.uilist

	var_1.align(var_1_0, #arg_1_0.taskGroup[arg_1_0.nday])

	return
end

function var_0_1.GetProgressColor(arg_2_0)
	return "#A5AE90"
end

return var_0_1
