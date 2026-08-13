class = var_0_10000

local var_0_0 = var_0_10000("BattleGateAirFight")

ys = var_0_10001
var_0_10001.Battle.BattleGateAirFight = var_0_0
var_0_0.__name = "BattleGateAirFight"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.stageId

	pg = var_1_10003

	local var_1_1 = var_1_10003.expedition_data_template[var_1_0].dungeon_id

	ys = var_1_10004

	local var_1_2 = var_1_10004.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_1).fleet_prefab
	local var_1_3 = {
		prefabFleet = var_1_2,
		stageId = var_1_0
	}

	SYSTEM_AIRFIGHT = var_6
	var_1_3.system = var_6

	local var_1_4 = arg_1_1
	local var_1_5 = arg_1_1.sendNotification

	GAME = var_1_10009

	var_1_5(var_1_4, var_1_10009.BEGIN_STAGE_DONE, var_1_3)

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.getActivityByType

	ActivityConst = var_1_10005

	local var_2_2 = var_2_1(var_2_0, var_1_10005.ACTIVITY_TYPE_AIRFIGHT_BATTLE)
	local var_2_3 = arg_2_0.statistics._battleScore

	ys = var_2_0

	if var_2_3 >= var_2_0.Battle.BattleConst.BattleScore.B and var_2_2 and not var_2_2:isEnd() then
		local var_2_4 = var_2_2:GetMaxProgress()

		var_1_10007 = var_2_2

		local var_2_5 = var_2_2.GetPerDayCount(var_1_10007)

		var_1_10007 = var_2_4 / var_2_2:GetPerLevelProgress()

		local var_2_6 = 0

		for iter_2_0 = 1, var_1_10007 do
			local var_2_7

			if not var_2_2:getKVPList(1, iter_2_0) then
				var_2_7 = 0
			end

			var_2_6 = var_2_6 + var_2_7
		end

		pg = var_9

		local var_2_8 = var_9.TimeMgr.GetInstance()
		local var_2_9 = var_9.DiffDay(var_2_8, var_2_2.data1, var_9:GetServerTime()) + 1

		math = var_11

		if var_2_6 < var_11.min(var_2_9 * var_2_5, var_2_4) then
			local var_2_10 = arg_2_0.stageId
			local var_2_11 = var_2_2
			local var_2_12 = var_2_2.getConfig(var_2_11, "config_client").stages

			table = var_14

			local var_2_13 = var_14.indexof(var_2_12, var_2_10)

			math = var_2_11

			local var_2_14 = var_2_11.floor
			local var_2_15 = var_2_13 - 1

			math = var_1_10018

			local var_2_16 = var_2_14(var_2_15 / var_1_10018.floor(#var_2_12 / var_1_10007)) + 1
			local var_2_17

			if not var_2_2:getKVPList(1, var_2_16) then
				var_2_17 = 0
			end

			local var_2_18 = var_2_2:getKVPList(2, var_2_16) == 1

			if var_2_17 < var_6 and not var_2_18 then
				local var_2_19 = arg_2_1
				local var_2_20 = arg_2_1.sendNotification

				GAME = var_20

				var_2_20(var_2_19, var_20.ACTIVITY_OPERATION, {
					cmd = 1,
					activity_id = var_2_2 and var_2_2.id,
					arg1 = var_2_16,
					statistics = arg_2_0.statistics
				})

				return
			end
		end
	end

	local var_2_21 = arg_2_1
	local var_2_22 = arg_2_1.sendNotification

	GAME = var_1_10007

	local var_2_23 = var_1_10007.FINISH_STAGE_DONE
	local var_2_24 = {
		statistics = arg_2_0.statistics,
		score = arg_2_0.statistics._battleScore
	}

	SYSTEM_AIRFIGHT = var_9
	var_2_24.system = var_9

	var_2_22(var_2_21, var_2_23, var_2_24)

	return
end

return var_0_0
