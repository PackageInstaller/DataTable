class = var_0_10000

local var_0_0 = "YidaliV2PTPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	local var_1_0 = arg_1_0.ptData
	local var_1_1, var_1_2, var_1_3 = var_1.GetResProgress(var_1_0)

	setText = var_1_10004

	local var_1_4 = arg_1_0.progress

	if 1 <= var_1_3 then
		setColorStr = var_7

		local var_1_5

		if not var_7(var_1_1, "#f3e0a4") then
			var_1_5 = var_1_1
		end

		var_1_10004(var_1_4, var_1_5 .. "/" .. var_1_2)

		return
	end
end

return var_0_1
