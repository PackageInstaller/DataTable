local var_0_0 = class("BattleGateDodgem")

ys.Battle.BattleGateDodgem = var_0_0
var_0_0.__name = "BattleGateDodgem"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab,
		stageId = arg_1_0.stageId,
		system = SYSTEM_DODGEM
	})

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_DODGEM)

	arg_2_1:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 1,
		activity_id = var_2_0 and var_2_0.id,
		statistics = arg_2_0.statistics,
		arg1 = arg_2_0.statistics._battleScore,
		arg2 = arg_2_0.statistics.dodgemResult.score
	})

	return
end

return var_0_0
