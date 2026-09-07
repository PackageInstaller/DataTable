local BattleGateAirFight = class("BattleGateAirFight")

ys.Battle.BattleGateAirFight = BattleGateAirFight
BattleGateAirFight.__name = "BattleGateAirFight"

function BattleGateAirFight:Entrance(arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab,
		stageId = self.stageId,
		system = SYSTEM_AIRFIGHT
	})

	return
end

function BattleGateAirFight:Exit(arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AIRFIGHT_BATTLE)

	if self.statistics._battleScore >= ys.Battle.BattleConst.BattleScore.B and var_2_0 and not var_2_0:isEnd() then
		local var_2_1 = var_2_0:GetMaxProgress()
		local var_2_2 = var_2_0:GetPerLevelProgress()
		local var_2_3 = 0

		for iter_2_0 = 1, var_2_1 / var_2_2 do
			var_2_3 = var_2_3 + (var_2_0:getKVPList(1, iter_2_0) or 0)
		end

		local var_2_4 = pg.TimeMgr.GetInstance()

		if var_2_3 < math.min((var_2_4:DiffDay(var_2_0.data1, var_2_4:GetServerTime()) + 1) * var_2_0:GetPerDayCount(), var_2_1) then
			local var_2_5 = var_2_0:getConfig("config_client").stages
			local var_2_6 = math.floor((table.indexof(var_2_5, self.stageId) - 1) / math.floor(#var_2_5 / (var_2_1 / var_2_2))) + 1

			if (var_2_0:getKVPList(1, var_2_6) or 0) < var_2_2 and var_2_0:getKVPList(2, var_2_6) ~= 1 then
				arg_2_1:sendNotification(GAME.ACTIVITY_OPERATION, {
					cmd = 1,
					activity_id = var_2_0 and var_2_0.id,
					arg1 = var_2_6,
					statistics = self.statistics
				})

				return
			end
		end
	end

	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		statistics = self.statistics,
		score = self.statistics._battleScore,
		system = SYSTEM_AIRFIGHT
	})

	return
end

return BattleGateAirFight
