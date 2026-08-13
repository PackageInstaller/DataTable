class = var_0_10000

local var_0_0 = "MainFormationBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	local var_1_0 = {
		fleetId = 1
	}
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.emit

	NewMainMediator = var_1_10004

	local var_1_3 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_1_2(var_1_1, var_1_3, var_1_10005.BIANDUI, var_1_0)

	return
end

function var_0_1.IsFixed(arg_2_0)
	return true
end

return var_0_1
