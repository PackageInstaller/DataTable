local IslandLockNpcRefreshPlayer = class("IslandLockNpcRefreshPlayer", import(".IslandBasePerformancePlayer"))

function IslandLockNpcRefreshPlayer:Play(arg_1_1, arg_1_2)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1.unitIdList or {}) do
		self:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.LOCK_NPC_REFRESH, iter_1_1, IslandConst.UNIT_LIST_OBJ)
	end

	arg_1_2()

	return
end

return IslandLockNpcRefreshPlayer
