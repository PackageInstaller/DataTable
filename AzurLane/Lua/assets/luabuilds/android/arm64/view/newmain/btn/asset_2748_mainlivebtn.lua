class = var_0_10000

local var_0_0 = "MainLiveBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	getProxy = var_1_10001
	SystemTipProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	var_1.SetIslandClickRecord(var_1_0)

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.emit

	NewMainScene = var_1_10004

	var_1_2(var_1_1, var_1_10004.OPEN_LIVEAREA)

	return
end

return var_0_1
