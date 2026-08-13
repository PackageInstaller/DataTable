class = var_0_10000

local var_0_0 = "ChangFengSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	arg_1_0:PlayStory()

	SetActive = var_1

	var_1(arg_1_0.dayTF, false)

	local var_1_0 = arg_1_0.uilist

	var_1.align(var_1_0, #arg_1_0.taskGroup[arg_1_0.nday])

	return
end

function var_0_1.GetProgressColor(arg_2_0)
	return "#34424b"
end

return var_0_1
