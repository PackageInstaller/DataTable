class = var_0_10000

local var_0_0 = var_0_10000("BattleGateSubmarine")

ys = var_1
var_1.Battle.BattleGateSubmarine = var_0_0
var_0_0.__name = "BattleGateSubmarine"

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

	SYSTEM_SUBMARINE_RUN = var_1_10006
	var_1_3.system = var_1_10006

	local var_1_4 = arg_1_1
	local var_1_5 = arg_1_1.sendNotification

	GAME = var_1_10008

	var_1_5(var_1_4, var_1_10008.BEGIN_STAGE_DONE, var_1_3)

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)
	local var_2_1 = var_2.getActivityByType

	ActivityConst = var_1_10004

	local var_2_2 = var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_SUBMARINE_RUN)
	local var_2_3 = arg_2_1
	local var_2_4 = arg_2_1.sendNotification

	GAME = var_1_10005

	var_2_4(var_2_3, var_1_10005.ACTIVITY_OPERATION, {
		cmd = 1,
		activity_id = var_2_2 and var_2_2.id,
		statistics = arg_2_0.statistics,
		arg1 = arg_2_0.statistics._battleScore,
		arg2 = arg_2_0.statistics.subRunResult.score
	})

	return
end

return var_0_0
