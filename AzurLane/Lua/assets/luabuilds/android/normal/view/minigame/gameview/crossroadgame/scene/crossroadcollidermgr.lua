class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadColliderMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._runningData = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._playerMgr = arg_1_3
	arg_1_0.carList = nil
	arg_1_0.roleList = nil

	return
end

function var_0_0.Step(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._runningData

	arg_2_0.carList = var_2.GetTrackCarGoList(var_2_0)

	local var_2_1 = arg_2_0._runningData

	arg_2_0.roleList = var_2.GetRoleList(var_2_1)

	local var_2_2 = {}

	ipairs = var_2_1

	for iter_2_0, iter_2_1 in var_2_1(arg_2_0.carList) do
		ipairs = var_1_10008

		for iter_2_2, iter_2_3 in var_1_10008(iter_2_1) do
			local var_2_3 = iter_2_3
			local var_2_4 = iter_2_3.GetTrack(var_2_3)

			CrossRoadGameConst = var_2_3

			if var_2_4 == var_2_3.FRONT_ROAD_NAME then
				table = var_2_4

				var_2_4.insert(var_2_2, iter_2_3)
			end
		end
	end

	arg_2_0.carList = var_2_2
	underscore = var_3
	arg_2_0.roleList = var_3.select(arg_2_0.roleList, function(arg_3_0)
		local var_3_0 = arg_3_0
		local var_3_1 = arg_3_0.GetTrack(var_3_0)

		CrossRoadGameConst = var_3_0

		if var_3_1 == var_3_0.SCENE_ROAD_NAME then
			local var_3_2 = arg_3_0
			local var_3_3 = arg_3_0.GetRunState(var_3_2)

			CrossRoadGameConst = var_3_2

			local var_3_4

			if var_3_3 == var_3_2.SHIP_STATE.crash then
				var_3_4 = false
			else
				var_3_4 = true
			end

			return var_3_4
		end
	end)
	ipairs = var_3

	for iter_2_4, iter_2_5 in var_3(arg_2_0.carList) do
		ipairs = var_1_10008

		for iter_2_6, iter_2_7 in var_1_10008(arg_2_0.roleList) do
			local var_2_5 = arg_2_0._runningData

			if var_13.CheckCarCarshRole(var_2_5, iter_2_5, iter_2_7) then
				local var_2_6 = arg_2_0._runningData

				var_13.TryUpdateUnion(var_2_6, iter_2_7)

				local var_2_7 = iter_2_7
				local var_2_8 = iter_2_7.SetRunState

				CrossRoadGameConst = var_15

				var_2_8(var_2_7, var_15.SHIP_STATE.crash)

				local var_2_9 = iter_2_5

				iter_2_5.SetCarCrashList(var_2_9, iter_2_7)

				local var_2_10 = arg_2_0._event

				CrossRoadGameConst = var_2_9

				var_2_10(var_2_9.HIT_ROLER)
			end
		end

		local var_2_11 = arg_2_0._playerMgr

		if not var_1_10008.GetCrashState(var_2_11) then
			local var_2_12 = arg_2_0._runningData

			if var_1_10008.CheckCarCarshPlayer(var_2_12, iter_2_5) then
				var_1_10008 = iter_2_5:GetPosition().x

				local var_2_13 = arg_2_0._playerMgr

				if var_1_10008 < var_9.GetPosition(var_2_13).x then
					local var_2_14 = arg_2_0._runningData

					var_1_10008.SetPlayerCrashDir(var_2_14, {
						1,
						0
					})
				else
					local var_2_15 = arg_2_0._runningData

					var_1_10008.SetPlayerCrashDir(var_2_15, {
						-1,
						0
					})
				end

				local var_2_16, var_2_17, var_2_18

				var_1_10008, var_2_16, var_2_17, var_2_18 = iter_2_5:GetCarRectPoint()

				local var_2_19 = arg_2_0._runningData

				var_12.SetPlayerCarshSize(var_2_19, var_2_17 - var_1_10008)

				local var_2_20 = arg_2_0._playerMgr

				var_12.PlayZhihuiHit(var_2_20)
			end
		end
	end

	return
end

function var_0_0.Clear(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
