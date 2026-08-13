class = var_0_10000

local var_0_0 = "IslandCoupleAction4FollowerPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCoupleActionPlayer"))

function var_0_1.EnableOrDisableUnitSyn(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local function var_1_0(arg_2_0, arg_2_1)
		if arg_2_1 then
			arg_2_0:RestartBt()
		else
			arg_2_0:StopBt()
		end

		return
	end

	isa = var_1_10005

	local var_1_1 = arg_1_1

	IslandFollowNpcUnit = var_1_10008

	if var_1_10005(var_1_1, var_1_10008) then
		var_1_0(arg_1_1, arg_1_3)
	end

	isa = var_5

	local var_1_2 = arg_1_2

	IslandFollowNpcUnit = var_1_10008

	if var_5(var_1_2, var_1_10008) then
		var_1_0(arg_1_2, arg_1_3)
	end

	return
end

function var_0_1.EnableOrDisableNavMeshObstacle(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetView()
	local var_3_1 = var_3.GetUnitListByKey

	IslandConst = var_1_10006

	local var_3_2 = var_3_1(var_3_0, var_1_10006.UNIT_LIST_FOLLOW)
	local var_3_3 = arg_3_0:GetView().player

	if arg_3_2 then
		IslandHelper = var_3_0

		var_3_0.DisableNavMeshObstacle(var_3_3._go)

		ipairs = var_3_0

		for iter_3_0, iter_3_1 in var_3_0(var_3_2) do
			if arg_3_1 ~= iter_3_1 then
				IslandHelper = var_1_10010

				var_1_10010.DisableNavMeshObstacle(iter_3_1._go)
			end
		end
	else
		IslandHelper = var_3_0

		var_3_0.EnableNavMeshObstacle(var_3_3._go)

		ipairs = var_5

		for iter_3_2, iter_3_3 in var_5(var_3_2) do
			if arg_3_1 ~= iter_3_3 then
				IslandHelper = var_1_10010

				var_1_10010.EnableNavMeshObstacle(iter_3_3._go)
			end
		end
	end

	return
end

function var_0_1.OnNavigateToPointFailed(arg_4_0)
	return
end

return var_0_1
