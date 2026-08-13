class = var_0_10000

local var_0_0 = "MainFdConcealablePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainConcealablePanel"))

function var_0_1.FillEmptySlot(arg_1_0, arg_1_1)
	for iter_1_0 = 1, #arg_1_1 do
		arg_1_1[iter_1_0].localPosition = arg_1_0.initPosition[iter_1_0]
	end

	return
end

return var_0_1
