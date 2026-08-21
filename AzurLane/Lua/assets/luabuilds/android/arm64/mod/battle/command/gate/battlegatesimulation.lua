local var_0_0 = class("BattleGateSimulation")

ys.Battle.BattleGateSimulation = var_0_0
var_0_0.__name = "BattleGateSimulation"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab,
		stageId = arg_1_0.stageId,
		system = SYSTEM_SIMULATION,
		exitCallback = arg_1_0.exitCallback,
		warnMsg = arg_1_0.warnMsg
	})

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		system = SYSTEM_SIMULATION,
		exitCallback = arg_2_0.exitCallback
	})

	return
end

return var_0_0
