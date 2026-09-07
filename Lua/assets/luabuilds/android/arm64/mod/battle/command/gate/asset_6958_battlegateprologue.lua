local BattleGatePrologue = class("BattleGatePrologue")

ys.Battle.BattleGatePrologue = BattleGatePrologue
BattleGatePrologue.__name = "BattleGatePrologue"

function BattleGatePrologue:Entrance(arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[PROLOGUE_DUNGEON].dungeon_id).fleet_prefab,
		stageId = PROLOGUE_DUNGEON,
		system = SYSTEM_PROLOGUE
	})

	return
end

function BattleGatePrologue:Exit(arg_2_1)
	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		system = SYSTEM_PROLOGUE
	})

	return
end

return BattleGatePrologue
