class = var_0_10000

local var_0_0 = "MaoxiV3PtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	local var_1_0 = arg_1_0.ptData
	local var_1_1, var_1_2, var_1_3 = var_1.GetLevelProgress(var_1_0)
	local var_1_4 = arg_1_0.ptData
	local var_1_5, var_1_6, var_1_7 = var_4.GetResProgress(var_1_4)

	setText = var_1_10007

	local var_1_8 = arg_1_0.step

	setColorStr = var_1_10009

	local var_1_9 = var_1_1

	COLOR_WHITE = var_1_10011

	var_1_10007(var_1_8, var_1_10009(var_1_9, var_1_10011) .. "/" .. var_1_2)

	setText = var_1_10007

	local var_1_10 = arg_1_0.progress

	if 1 <= var_1_7 then
		setColorStr = var_1_13

		local var_1_11 = var_1_5

		COLOR_GREEN = var_11

		local var_1_13

		if not var_1_13(var_1_11, var_11) then
			setColorStr = var_1_13

			local var_1_12 = var_1_5

			COLOR_WHITE = var_11
			var_1_13 = var_1_13(var_1_12, var_11)
		end

		var_1_10007(var_1_10, var_1_13 .. "/" .. var_1_6)

		return
	end
end

return var_0_1
