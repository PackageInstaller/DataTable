class = var_0_10000

local var_0_0 = "TargetCatchupPanel7"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseTargetCatchupPanel"))

function var_0_1.getUIName(arg_1_0)
	return "TargetCatchupPanel7"
end

function var_0_1.init(arg_2_0)
	arg_2_0.tecID = 7

	arg_2_0:initData()
	arg_2_0:initUI()

	return
end

return var_0_1
