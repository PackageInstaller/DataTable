class = var_0_10000

local var_0_0 = "ActivityExtraCommodity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".ActivityCommodity"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_shop_extra
end

function var_0_1.ShowMaintenanceTime(arg_2_0)
	return arg_2_0:getConfig("end_by_maintenance") == 1
end

function var_0_1.GetMaintenanceMonthAndDay(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("time")[2][1][2]
	local var_3_1 = var_1[2][1][3]

	return var_3_0, var_3_1
end

return var_0_1
