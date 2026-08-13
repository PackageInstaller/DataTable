class = var_0_10000

local var_0_0 = var_0_10000("BattleGateTest")

ys = var_0_10001
var_0_10001.Battle.BattleGateTest = var_0_0
var_0_0.__name = "BattleGateTest"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if not arg_1_1.LegalFleet(arg_1_0.mainFleetId) then
		return
	end

	getProxy = var_2
	BayProxy = var_4

	local var_1_0 = var_2(var_4)

	getProxy = var_1_10003
	FleetProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = {}
	local var_1_3 = var_1_1
	local var_1_4 = var_1_1.getFleetById(var_1_3, arg_1_0.mainFleetId)
	local var_1_5 = var_1_0:getSortShipsByFleet(var_1_4)

	ipairs = var_1_3

	for iter_1_0, iter_1_1 in var_1_3(var_1_5) do
		var_1_2[#var_1_2 + 1] = iter_1_1.id
	end

	local var_1_6 = arg_1_0.mainFleetId
	local var_1_7 = arg_1_0.stageId

	pg = var_9

	local var_1_8 = var_9.expedition_data_template[var_1_7].dungeon_id

	local function var_1_9(arg_2_0)
		local var_2_0 = {
			mainFleetId = var_1_6,
			prefabFleet = {},
			stageId = var_1_7
		}

		SYSTEM_TEST = var_2
		var_2_0.system = var_2
		var_2_0.token = arg_2_0.key

		local var_2_1 = arg_1_1
		local var_2_2 = var_2.sendNotification

		GAME = var_2_10005

		var_2_2(var_2_1, var_2_10005.BEGIN_STAGE_DONE, var_2_0)

		return
	end

	local function var_1_10(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10012

	local var_1_11 = var_1_10012.SendRequest

	SYSTEM_TEST = var_1_10014

	var_1_11(var_1_10014, var_1_2, {
		var_1_7
	}, var_1_9, var_1_10)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template

	SYSTEM_TEST = var_1_10003

	local var_4_1 = var_4_0[var_1_10003]

	getProxy = var_1_10003
	FleetProxy = var_1_10005

	local var_4_2 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_4_3 = var_1_10004(var_1_10006)
	local var_4_4 = arg_4_0.statistics._battleScore
	local var_4_5 = 0
	local var_4_6 = {}
	local var_4_7 = var_4_2:getFleetById(arg_4_0.mainFleetId)
	local var_4_8 = var_4_3:getSortShipsByFleet(var_4_7)
	local var_4_9 = arg_4_1.GeneralPackage(arg_4_0, var_4_8)

	local function var_4_10(arg_5_0)
		arg_4_0.statistics.mvpShipID = -1

		local var_5_0 = {}

		SYSTEM_TEST = var_2
		var_5_0.system = var_2
		var_5_0.statistics = arg_4_0.statistics
		var_5_0.score = var_4_4
		var_5_0.drops = {}
		var_5_0.commanderExps = {}
		var_5_0.result = arg_5_0.result
		var_5_0.extraDrops = {}

		local var_5_1 = arg_4_1
		local var_5_2 = var_2.sendNotification

		GAME = var_2_10005

		var_5_2(var_5_1, var_2_10005.FINISH_STAGE_DONE, var_5_0)

		return
	end

	arg_4_1:SendRequest(var_4_9, var_4_10)

	return
end

return var_0_0
