class = var_0_10000

local var_0_0 = var_0_10000("BattleGatePrologue")

ys = var_1
var_1.Battle.BattleGatePrologue = var_0_0
var_0_0.__name = "BattleGatePrologue"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	PROLOGUE_DUNGEON = var_1_10002
	pg = var_1_10003

	local var_1_0 = var_1_10003.expedition_data_template[var_1_10002].dungeon_id

	ys = var_1_10004

	local var_1_1 = var_1_10004.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_0).fleet_prefab
	local var_1_2 = {
		prefabFleet = var_1_1,
		stageId = var_1_10002
	}

	SYSTEM_PROLOGUE = var_1_10006
	var_1_2.system = var_1_10006

	local var_1_3 = arg_1_1
	local var_1_4 = arg_1_1.sendNotification

	GAME = var_1_10008

	var_1_4(var_1_3, var_1_10008.BEGIN_STAGE_DONE, var_1_2)

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.sendNotification

	GAME = var_1_10004

	local var_2_2 = var_1_10004.FINISH_STAGE_DONE
	local var_2_3 = {}

	SYSTEM_PROLOGUE = var_1_10006
	var_2_3.system = var_1_10006

	var_2_1(var_2_0, var_2_2, var_2_3)

	return
end

return var_0_0
