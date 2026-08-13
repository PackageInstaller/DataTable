class = var_0_10000

local var_0_0 = var_0_10000("BattleGateBossExperiment")

ys = var_1
var_1.Battle.BattleGateBossExperiment = var_0_0
var_0_0.__name = "BattleGateBossExperiment"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.actId
	local var_1_1 = arg_1_0.mainFleetId
	local var_1_2 = arg_1_0.stageId

	pg = var_1_10005

	local var_1_3 = var_1_10005.expedition_data_template[var_1_2].dungeon_id

	ys = var_1_10006

	local var_1_4 = var_1_10006.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_3).fleet_prefab
	local var_1_5 = {
		mainFleetId = var_1_1,
		actId = var_1_0,
		prefabFleet = var_1_4,
		stageId = var_1_2
	}

	SYSTEM_BOSS_EXPERIMENT = var_1_10008
	var_1_5.system = var_1_10008

	local var_1_6 = arg_1_1
	local var_1_7 = arg_1_1.sendNotification

	GAME = var_1_10010

	var_1_7(var_1_6, var_1_10010.BEGIN_STAGE_DONE, var_1_5)

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	ys = var_1_10002

	local var_2_0 = var_1_10002.Battle.BattleConst.BattleScore.S
	local var_2_1 = {}

	SYSTEM_BOSS_EXPERIMENT = var_1_10004
	var_2_1.system = var_1_10004
	var_2_1.statistics = arg_2_0.statistics
	var_2_1.score = var_2_0
	var_2_1.commanderExps = {}

	local var_2_2 = arg_2_1
	local var_2_3 = arg_2_1.sendNotification

	GAME = var_1_10006

	var_2_3(var_2_2, var_1_10006.FINISH_STAGE_DONE, var_2_1)

	return
end

function var_0_0.GetPreloadList(arg_3_0)
	ys = var_1_10001

	local var_3_0, var_3_1 = var_1_10001.Battle.BattleGateActBoss.GetPreloadList(arg_3_0)

	return var_3_0, var_3_1
end

return var_0_0
