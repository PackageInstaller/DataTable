class = var_0_10000

local var_0_0 = "ActivitySelectableCommodity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".ActivityCommodity"))

function var_0_1.Selectable(arg_1_0)
	return arg_1_0:getConfig("commodity_id_list") and var_1 ~= "" and #var_1 > 0
end

function var_0_1.GetFirstDropId(arg_2_0)
	return arg_2_0:getConfig("commodity_id_list")
end

return var_0_1
