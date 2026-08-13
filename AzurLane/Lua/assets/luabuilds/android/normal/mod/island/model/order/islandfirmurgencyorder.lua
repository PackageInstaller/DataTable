class = var_0_10000

local var_0_0 = "IslandFirmUrgencyOrder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandUrgencyOrder"))

function var_0_1.IsFirm(arg_1_0)
	return true
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_order
end

function var_0_1.GetDisappearTime(arg_3_0)
	return arg_3_0.startTime + arg_3_0:getConfig("effective_time")
end

function var_0_1.GetAwardItemAndExp(arg_4_0)
	local var_4_0 = arg_4_0:getConfig("award")

	return arg_4_0:GenAwards(var_4_0)
end

return var_0_1
