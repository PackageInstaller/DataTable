class = var_0_10000

local var_0_0 = var_0_10000("BattleGateDodgem")

ys = var_1
var_1.Battle.BattleGateDodgem = var_0_0
var_0_0.__name = "BattleGateDodgem"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.stageId

	pg = var_1_10003

	local var_1_1 = var_1_10003.expedition_data_template[var_1_0].dungeon_id

	ys = var_1_10004

	local var_1_2 = var_1_10004.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_1).fleet_prefab
	local var_1_3 = {
		prefabFleet = var_1_2,
		stageId = var_1_0
	}

	SYSTEM_DODGEM = var_1_10006
	var_1_3.system = var_1_10006

	local var_1_4 = arg_1_1
	local var_1_5 = arg_1_1.sendNotification

	GAME = var_1_10008

	var_1_5(var_1_4, var_1_10008.BEGIN_STAGE_DONE, var_1_3)

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_2_1 = var_1_10003(var_1_10004)
	local var_2_2 = var_3.getActivityByType

	ActivityConst = var_1_10005

	local var_2_3 = var_2_2(var_2_1, var_1_10005.ACTIVITY_TYPE_DODGEM)
	local var_2_4 = arg_2_1
	local var_2_5 = arg_2_1.sendNotification

	GAME = var_1_10006

	var_2_5(var_2_4, var_1_10006.ACTIVITY_OPERATION, {
		cmd = 1,
		activity_id = var_2_3 and var_2_3.id,
		statistics = var_2_0.statistics,
		arg1 = var_2_0.statistics._battleScore,
		arg2 = var_2_0.statistics.dodgemResult.score
	})

	return
end

return var_0_0
