class = var_0_10000

local var_0_0 = "CentaurAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	setText = var_1

	var_1(arg_1_0.dayTF, arg_1_0.nday .. "/" .. #arg_1_0.taskGroup)

	eachChild = var_1

	var_1(arg_1_0.items, function(arg_2_0)
		local var_2_0 = arg_2_0:Find("get_btn")
		local var_2_1 = arg_2_0
		local var_2_2 = arg_2_0.Find(var_2_1, "got_btn")

		isActive = var_2_1

		local var_2_3 = var_2_1(var_2_2)

		setButtonEnabled = var_4

		var_4(var_2_2, false)

		setButtonEnabled = var_4

		var_4(var_2_0, not var_2_3)

		if var_2_3 then
			setActive = var_4

			var_4(var_2_0, true)
		end

		return
	end)

	return
end

return var_0_1
