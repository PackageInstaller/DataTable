local BattleGateSimulation = class("BattleGateSimulation")

ys.Battle.BattleGateSimulation = BattleGateSimulation
BattleGateSimulation.__name = "BattleGateSimulation"

function BattleGateSimulation:Entrance(arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab,
		stageId = self.stageId,
		system = SYSTEM_SIMULATION,
		exitCallback = self.exitCallback,
		warnMsg = self.warnMsg
	})

	return
end

function BattleGateSimulation:Exit(arg_2_1)
	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		system = SYSTEM_SIMULATION,
		exitCallback = self.exitCallback
	})

	return
end

return BattleGateSimulation
