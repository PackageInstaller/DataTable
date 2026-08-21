local var_0_0 = class("IslandCoupleAction4FollowerPlayer", import(".IslandCoupleActionPlayer"))

function var_0_0.EnableOrDisableUnitSyn(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if isa(arg_1_1, IslandFollowNpcUnit) then
		(function(arg_2_0, arg_2_1)
			if arg_2_1 then
				arg_2_0:RestartBt()
			else
				arg_2_0:StopBt()
			end

			return
		end)(arg_1_1, arg_1_3)
	end

	if isa(arg_1_2, IslandFollowNpcUnit) then
		(function(arg_2_0, arg_2_1)
			if arg_2_1 then
				arg_2_0:RestartBt()
			else
				arg_2_0:StopBt()
			end

			return
		end)(arg_1_2, arg_1_3)
	end

	return
end

function var_0_0.EnableOrDisableNavMeshObstacle(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetView():GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW)
	local var_3_1 = arg_3_0:GetView().player

	if arg_3_2 then
		IslandHelper.DisableNavMeshObstacle(var_3_1._go)

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if arg_3_1 ~= iter_3_1 then
				IslandHelper.DisableNavMeshObstacle(iter_3_1._go)
			end
		end
	else
		IslandHelper.EnableNavMeshObstacle(var_3_1._go)

		for iter_3_2, iter_3_3 in ipairs(var_3_0) do
			if arg_3_1 ~= iter_3_3 then
				IslandHelper.EnableNavMeshObstacle(iter_3_3._go)
			end
		end
	end

	return
end

function var_0_0.OnNavigateToPointFailed(arg_4_0)
	return
end

return var_0_0
