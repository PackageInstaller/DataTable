class = var_0_10000

local var_0_0 = "MaoxiV2PtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	local var_1_0 = arg_1_0.ptData
	local var_1_1, var_1_2, var_1_3 = var_1.GetLevelProgress(var_1_0)
	local var_1_4 = arg_1_0.ptData
	local var_1_5, var_1_6, var_1_7 = var_4.GetResProgress(var_1_4)

	setText = var_1_10007

	var_1_10007(arg_1_0.step, var_1_1 .. "/" .. var_1_2)

	setText = var_1_10007

	local var_1_8 = arg_1_0.progress

	if 1 <= var_1_7 then
		setColorStr = var_10

		local var_1_9

		if not var_10(var_1_5, "#80e4f9") then
			var_1_9 = var_1_5
		end

		var_1_10007(var_1_8, var_1_9 .. "/" .. var_1_6)

		setSlider = var_1_10007

		var_1_10007(arg_1_0.slider, 0, 1, var_1_7)

		return
	end
end

return var_0_1
