class = var_0_10000

local var_0_0 = "MainDockBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.emit

	NewMainMediator = var_1_10003

	local var_1_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	local var_1_3 = var_1_10004.DOCKYARD
	local var_1_4 = {}

	DockyardScene = var_1_10006
	var_1_4.mode = var_1_10006.MODE_OVERVIEW

	var_1_1(var_1_0, var_1_2, var_1_3, var_1_4)

	return
end

return var_0_1
