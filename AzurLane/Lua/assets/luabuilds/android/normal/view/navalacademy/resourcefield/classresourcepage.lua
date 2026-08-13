class = var_0_10000

local var_0_0 = "ClassResourcePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ResourcePage"))

function var_0_1.getUIName(arg_1_0)
	return "ClassResourcePage"
end

function var_0_1.OnUpgrade(arg_2_0)
	local var_2_0 = arg_2_0.resourceField
	local var_2_1 = var_1.GetUpgradeType(var_2_0)
	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.emit

	ClassMediator = var_1_10004

	var_2_3(var_2_2, var_1_10004.UPGRADE_FIELD, var_2_1)

	return
end

return var_0_1
