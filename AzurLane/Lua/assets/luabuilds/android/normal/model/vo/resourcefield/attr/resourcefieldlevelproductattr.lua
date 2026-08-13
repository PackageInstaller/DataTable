class = var_0_10000

local var_0_0 = "ResourceFieldLevelProductAttr"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ResourceFieldProductAttr"))

function var_0_1.ReCalcValue(arg_1_0)
	arg_1_0.multiple = arg_1_0.config[arg_1_0.level].hour_time

	var_0_1.super.ReCalcValue(arg_1_0)

	return
end

return var_0_1
