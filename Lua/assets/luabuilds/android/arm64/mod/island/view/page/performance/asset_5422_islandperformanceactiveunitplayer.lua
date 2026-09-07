local IslandPerformanceActiveUnitPlayer = class("IslandPerformanceActiveUnitPlayer", import(".IslandBasePerformancePlayer"))

function IslandPerformanceActiveUnitPlayer:Play(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.unitType or IslandConst.UNIT_LIST_OBJ
	local var_1_1 = defaultValue(arg_1_1.show, true)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.unitIdList or {}) do
		self:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.ACTIVE_OR_DISABLE_UNIT, iter_1_1, var_1_0, var_1_1)
	end

	arg_1_2()

	return
end

function IslandPerformanceActiveUnitPlayer:Clear()
	return
end

return IslandPerformanceActiveUnitPlayer
