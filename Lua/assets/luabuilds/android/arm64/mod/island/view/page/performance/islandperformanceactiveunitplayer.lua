local var_0_0 = class("IslandPerformanceActiveUnitPlayer", import(".IslandBasePerformancePlayer"))

function var_0_0.Play(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.unitType or IslandConst.UNIT_LIST_OBJ
	local var_1_1 = defaultValue(arg_1_1.show, true)
	local var_1_2 = arg_1_1.unitIdList or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_2) do
		arg_1_0:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.ACTIVE_OR_DISABLE_UNIT, iter_1_1, var_1_0, var_1_1)
	end

	arg_1_2()

	return
end

function var_0_0.Clear(arg_2_0)
	return
end

return var_0_0
