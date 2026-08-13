class = var_0_10000

local var_0_0 = "TargetCatchupPanel5"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseTargetCatchupPanel"))

function var_0_1.getUIName(arg_1_0)
	return "TargetCatchupPanel5"
end

function var_0_1.init(arg_2_0)
	arg_2_0.tecID = 5

	arg_2_0:initData()
	arg_2_0:initUI()

	return
end

return var_0_1
