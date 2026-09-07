local BattleGateSubmarine = class("BattleGateSubmarine")

ys.Battle.BattleGateSubmarine = BattleGateSubmarine
BattleGateSubmarine.__name = "BattleGateSubmarine"

function BattleGateSubmarine:Entrance(arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab,
		stageId = self.stageId,
		system = SYSTEM_SUBMARINE_RUN
	})

	return
end

function BattleGateSubmarine:Exit(arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SUBMARINE_RUN)

	arg_2_1:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 1,
		activity_id = var_2_0 and var_2_0.id,
		statistics = self.statistics,
		arg1 = self.statistics._battleScore,
		arg2 = self.statistics.subRunResult.score
	})

	return
end

return BattleGateSubmarine
