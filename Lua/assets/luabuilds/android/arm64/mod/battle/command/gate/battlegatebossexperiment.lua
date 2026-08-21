local var_0_0 = class("BattleGateBossExperiment")

ys.Battle.BattleGateBossExperiment = var_0_0
var_0_0.__name = "BattleGateBossExperiment"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		mainFleetId = arg_1_0.mainFleetId,
		actId = arg_1_0.actId,
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab,
		stageId = arg_1_0.stageId,
		system = SYSTEM_BOSS_EXPERIMENT
	})

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		system = SYSTEM_BOSS_EXPERIMENT,
		statistics = arg_2_0.statistics,
		score = ys.Battle.BattleConst.BattleScore.S,
		commanderExps = {}
	})

	return
end

function var_0_0.GetPreloadList(arg_3_0)
	local var_3_0, var_3_1 = ys.Battle.BattleGateActBoss.GetPreloadList(arg_3_0)

	return var_3_0, var_3_1
end

return var_0_0
