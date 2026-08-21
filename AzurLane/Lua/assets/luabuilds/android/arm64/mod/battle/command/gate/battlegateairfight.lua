local var_0_0 = class("BattleGateAirFight")

ys.Battle.BattleGateAirFight = var_0_0
var_0_0.__name = "BattleGateAirFight"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab,
		stageId = arg_1_0.stageId,
		system = SYSTEM_AIRFIGHT
	})

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AIRFIGHT_BATTLE)

	if arg_2_0.statistics._battleScore >= ys.Battle.BattleConst.BattleScore.B and var_2_0 and not var_2_0:isEnd() then
		local var_2_1 = var_2_0:GetMaxProgress()
		local var_2_2 = var_2_0:GetPerLevelProgress()
		local var_2_3 = 0

		for iter_2_0 = 1, var_2_1 / var_2_2 do
			local var_2_4 = var_2_0:getKVPList(1, iter_2_0) or 0

			var_2_3 = var_2_3 + var_2_4
		end

		local var_2_5 = pg.TimeMgr.GetInstance()

		if var_2_3 < math.min((var_2_5:DiffDay(var_2_0.data1, var_2_5:GetServerTime()) + 1) * var_2_0:GetPerDayCount(), var_2_1) then
			local var_2_6 = var_2_0:getConfig("config_client").stages
			local var_2_7 = math.floor((table.indexof(var_2_6, arg_2_0.stageId) - 1) / math.floor(#var_2_6 / (var_2_1 / var_2_2))) + 1
			local var_2_8 = var_2_0:getKVPList(1, var_2_7) or 0
			local var_2_9 = var_2_0:getKVPList(2, var_2_7) == 1

			if var_2_8 < var_2_2 and not var_2_9 then
				arg_2_1:sendNotification(GAME.ACTIVITY_OPERATION, {
					cmd = 1,
					activity_id = var_2_0 and var_2_0.id,
					arg1 = var_2_7,
					statistics = arg_2_0.statistics
				})

				return
			end
		end
	end

	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		statistics = arg_2_0.statistics,
		score = arg_2_0.statistics._battleScore,
		system = SYSTEM_AIRFIGHT
	})

	return
end

return var_0_0
