class = var_0_10000

local var_0_0 = "IslandPerformanceActiveUnitPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBasePerformancePlayer"))

function var_0_1.Play(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0

	if not arg_1_1.unitType then
		IslandConst = var_1_0
		var_1_0 = var_1_0.UNIT_LIST_OBJ
	end

	defaultValue = var_1_10004

	local var_1_1 = var_1_10004(arg_1_1.show, true)

	ipairs = var_5

	local var_1_2

	if not arg_1_1.unitIdList then
		var_1_2 = {}
	end

	for iter_1_0, iter_1_1 in var_5(var_1_2) do
		local var_1_3 = arg_1_0
		local var_1_4 = arg_1_0.emit

		IslandBaseScene = var_1_10012
		var_1_10012 = var_1_10012.LINK_CORE_EVENT
		IslandProxy = var_1_10013

		var_1_4(var_1_3, var_1_10012, var_1_10013.ACTIVE_OR_DISABLE_UNIT, iter_1_1, var_1_0, var_1_1)
	end

	arg_1_2()

	return
end

function var_0_1.Clear(arg_2_0)
	return
end

return var_0_1
