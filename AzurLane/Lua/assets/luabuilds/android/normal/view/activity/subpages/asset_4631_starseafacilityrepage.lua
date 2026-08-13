class = var_0_10000

local var_0_0 = "StarSeaFacilityRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	arg_1_0:PlayStory()

	if arg_1_0.dayTF then
		setText = var_1

		local var_1_0 = arg_1_0.dayTF

		tostring = var_1_10003

		var_1(var_1_0, var_1_10003(arg_1_0.nday) .. "/7")
	end

	local var_1_1 = arg_1_0.uilist

	var_1.align(var_1_1, #arg_1_0.taskGroup[arg_1_0.nday])

	return
end

return var_0_1
