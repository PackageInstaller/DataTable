local var_0_0 = class("IslandLockNpcRefreshPlayer", import(".IslandBasePerformancePlayer"))

function var_0_0.Play(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.unitIdList or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.LOCK_NPC_REFRESH, iter_1_1, IslandConst.UNIT_LIST_OBJ)
	end

	arg_1_2()

	return
end

return var_0_0
