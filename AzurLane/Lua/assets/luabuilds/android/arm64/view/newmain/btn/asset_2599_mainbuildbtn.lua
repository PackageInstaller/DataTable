class = var_0_10000

local var_0_0 = "MainBuildBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.emit

	NewMainMediator = var_1_10004

	local var_1_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_1_1(var_1_0, var_1_2, var_1_10005.GETBOAT)

	return
end

return var_0_1
