class = var_0_10000

local var_0_0 = "MainDockBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.emit

	NewMainMediator = var_1_10004

	local var_1_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	local var_1_3 = var_1_10005.DOCKYARD
	local var_1_4 = {}

	DockyardScene = var_1_10007
	var_1_4.mode = var_1_10007.MODE_OVERVIEW

	var_1_1(var_1_0, var_1_2, var_1_3, var_1_4)

	return
end

return var_0_1
