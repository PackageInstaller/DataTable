class = var_0_10000

local var_0_0 = "IslandLockNpcRefreshPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBasePerformancePlayer"))

function var_0_1.Play(arg_1_0, arg_1_1, arg_1_2)
	IslandConst = var_1_10003

	local var_1_0 = var_1_10003.UNIT_LIST_OBJ

	ipairs = var_1_10004

	local var_1_1

	if not arg_1_1.unitIdList then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_1_10004(var_1_1) do
		local var_1_2 = arg_1_0
		local var_1_3 = arg_1_0.emit

		IslandBaseScene = var_1_10012
		var_1_10012 = var_1_10012.LINK_CORE_EVENT
		IslandProxy = var_1_10013

		var_1_3(var_1_2, var_1_10012, var_1_10013.LOCK_NPC_REFRESH, iter_1_1, var_1_0)
	end

	arg_1_2()

	return
end

return var_0_1
