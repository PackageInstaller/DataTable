local var_0_0 = class("BattleGatePrologue")

ys.Battle.BattleGatePrologue = var_0_0
var_0_0.__name = "BattleGatePrologue"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[PROLOGUE_DUNGEON].dungeon_id).fleet_prefab,
		stageId = PROLOGUE_DUNGEON,
		system = SYSTEM_PROLOGUE
	})

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		system = SYSTEM_PROLOGUE
	})

	return
end

return var_0_0
