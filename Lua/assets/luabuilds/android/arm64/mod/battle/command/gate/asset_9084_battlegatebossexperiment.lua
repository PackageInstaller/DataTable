local BattleGateBossExperiment = class("BattleGateBossExperiment")

ys.Battle.BattleGateBossExperiment = BattleGateBossExperiment
BattleGateBossExperiment.__name = "BattleGateBossExperiment"

function BattleGateBossExperiment:Entrance(arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		mainFleetId = self.mainFleetId,
		actId = self.actId,
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab,
		stageId = self.stageId,
		system = SYSTEM_BOSS_EXPERIMENT
	})

	return
end

function BattleGateBossExperiment:Exit(arg_2_1)
	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		system = SYSTEM_BOSS_EXPERIMENT,
		statistics = self.statistics,
		score = ys.Battle.BattleConst.BattleScore.S,
		commanderExps = {}
	})

	return
end

function BattleGateBossExperiment:GetPreloadList()
	local var_3_0, var_3_1 = ys.Battle.BattleGateActBoss.GetPreloadList(self)

	return var_3_0, var_3_1
end

return BattleGateBossExperiment
