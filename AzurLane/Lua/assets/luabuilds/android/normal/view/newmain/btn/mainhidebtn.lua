class = var_0_10000

local var_0_0 = "MainHideBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.emit

	NewMainScene = var_1_10003

	var_1_1(var_1_0, var_1_10003.HIDE, true)

	return
end

return var_0_1
