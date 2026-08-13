class = var_0_10000

local var_0_0 = "MonopolyCar2026PickPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..MonopolyCar2024.MonopolyCar2024PickPage"))

function var_0_1.getUIName(arg_1_0)
	return "MonopolyCar2026PickUI"
end

function var_0_1.UpdateList(arg_2_0)
	var_0_1.super.UpdateList(arg_2_0)

	local var_2_0 = #arg_2_0.banList == 0 and arg_2_0.turnCnt <= 1

	for iter_2_0 = 2, #arg_2_0.items do
		local var_2_1 = arg_2_0.items[iter_2_0]

		setActive = var_1_10007

		var_1_10007(var_2_1, not var_2_0)
	end

	return
end

return var_0_1
