class = var_0_10000

local var_0_0 = var_0_10000("BattleGateDuel")

ys = var_0_10001
var_0_10001.Battle.BattleGateDuel = var_0_0
var_0_0.__name = "BattleGateDuel"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.mainFleetId

	if not arg_1_1.LegalFleet(arg_1_0.mainFleetId) then
		return
	end

	getProxy = var_3
	MilitaryExerciseProxy = var_5

	local var_1_1 = var_3(var_5)
	local var_1_2 = var_3.getSeasonInfo(var_1_1)
	local var_1_3

	if not var_4.canExercise(var_1_2) then
		pg = var_1_3
		var_1_2 = var_1_3.TipsMgr.GetInstance()
		var_1_3 = var_1_3.ShowTips
		i18n = var_1_10008

		var_1_3(var_1_2, var_1_10008("exercise_count_insufficient"))

		return
	end

	getProxy = var_1_3
	PlayerProxy = var_1_2

	local var_1_4 = var_1_3(var_1_2)

	getProxy = var_1_1
	BayProxy = var_1_10008

	local var_1_5 = var_1_1(var_1_10008)

	getProxy = var_1_2
	FleetProxy = var_1_10009

	local var_1_6 = var_1_2(var_1_10009)
	local var_1_7
	local var_1_8
	local var_1_9 = arg_1_0.rivalId

	getProxy = var_1_10010
	MilitaryExerciseProxy = var_1_10012

	local var_1_10 = var_1_10010(var_1_10012)
	local var_1_11 = var_10.getRivalById(var_1_10, var_1_9)

	pg = var_1_10012

	local var_1_12 = var_1_10012.battle_cost_template

	SYSTEM_DUEL = var_1_10

	local var_1_13 = var_1_12[var_1_10].oil_cost > 0
	local var_1_14 = {}
	local var_1_15 = 0
	local var_1_16 = 0
	local var_1_17 = 0
	local var_1_18 = 0
	local var_1_19 = var_1_6
	local var_1_20 = var_1_6.getFleetById(var_1_19, var_1_0)
	local var_1_21 = var_1_5:getSortShipsByFleet(var_1_20)

	ipairs = var_1_19

	for iter_1_0, iter_1_1 in var_1_19(var_1_21) do
		var_1_14[#var_1_14 + 1] = iter_1_1.id
	end

	local var_1_22 = var_1_4
	local var_1_23 = var_1_4.getData(var_1_22)

	if var_1_13 and var_1_23.oil < var_1_18 then
		pg = var_22

		local var_1_24 = var_22.TipsMgr.GetInstance()
		local var_1_25 = var_22.ShowTips

		i18n = iter_1_1

		var_1_25(var_1_24, iter_1_1("stage_beginStage_error_noResource"))

		return
	end

	local var_1_26 = 0

	ipairs = var_1_22

	for iter_1_2, iter_1_3 in var_1_22(var_1_11.mainShips) do
		var_1_26 = var_1_26 + iter_1_3.level
	end

	ipairs = var_23

	for iter_1_4, iter_1_5 in var_23(var_1_11.vanguardShips) do
		var_1_26 = var_1_26 + iter_1_5.level
	end

	local var_1_27 = RivalLevelVertiry

	arg_1_1.ShipVertify()

	local function var_1_28(arg_2_0)
		if var_1_13 then
			local var_2_0 = var_1_23

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_16
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 then
			pg = var_2_1
			var_2_1 = var_2_1.gameset.battle_consume_energy.key_value
			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_21) do
				iter_2_1:cosumeEnergy(var_2_1)

				local var_2_2 = var_1_5

				var_2_10007.updateShip(var_2_2, iter_2_1)
			end
		end

		ys = var_2_1

		local var_2_3 = var_2_1.Battle.BattleConfig.ARENA_LIST

		math = var_2

		local var_2_4 = var_2_3[var_2.random(#var_2_3)]
		local var_2_5 = var_1_4

		var_3.updatePlayer(var_2_5, var_1_23)

		local var_2_6 = {
			mainFleetId = var_1_0,
			prefabFleet = {},
			stageId = var_2_4
		}

		SYSTEM_DUEL = var_4
		var_2_6.system = var_4
		var_2_6.rivalId = var_1_9
		var_2_6.token = arg_2_0.key
		mode = var_4
		var_2_6.mode = var_4

		local var_2_7 = arg_1_1
		local var_2_8 = var_4.sendNotification

		GAME = var_2_10007

		var_2_8(var_2_7, var_2_10007.BEGIN_STAGE_DONE, var_2_6)

		return
	end

	local function var_1_29(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_25

	local var_1_30 = var_25.SendRequest

	SYSTEM_DUEL = iter_1_5

	var_1_30(iter_1_5, var_1_14, {
		var_1_9
	}, var_1_28, var_1_29)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template

	SYSTEM_DUEL = var_1_10003

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
	local var_4_9 = var_4_7:getEndCost().oil
	local var_4_10 = arg_4_1.GeneralPackage(arg_4_0, var_4_8)

	local function var_4_11(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics, false)

		arg_4_0.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0 = arg_4_1
		local var_5_1, var_5_2 = var_1.GeneralLoot(var_5_0, arg_5_0)
		local var_5_3 = var_4_4

		ys = var_4

		local var_5_4 = var_5_3 > var_4.Battle.BattleConst.BattleScore.C
		local var_5_5 = arg_4_1.GeneralPlayerCosume

		SYSTEM_DUEL = var_2_10006

		local var_5_6 = var_5_4
		local var_5_7 = var_4_9
		local var_5_8 = arg_5_0.player_exp

		exFlag = var_2_10010

		var_5_5(var_2_10006, var_5_6, var_5_7, var_5_8, var_2_10010)

		getProxy = var_5_5
		MilitaryExerciseProxy = var_2_10006

		local var_5_9 = var_5_5(var_2_10006)

		var_4.reduceExerciseCount(var_5_9)

		local var_5_10 = {}

		SYSTEM_DUEL = var_2_10006
		var_5_10.system = var_2_10006
		var_5_10.statistics = arg_4_0.statistics
		var_5_10.score = var_4_4
		var_5_10.drops = var_5_1
		var_5_10.commanderExps = {}
		var_5_10.result = arg_5_0.result
		var_5_10.extraDrops = var_5_2

		local var_5_11 = arg_4_1
		local var_5_12 = var_6.sendNotification

		GAME = var_5_8

		var_5_12(var_5_11, var_5_8.FINISH_STAGE_DONE, var_5_10)

		return
	end

	arg_4_1:SendRequest(var_4_10, var_4_11)

	return
end

function var_0_0.GetPreloadList(arg_6_0)
	local var_6_0 = {}
	local var_6_1

	getProxy = var_1_10003
	FleetProxy = var_1_10005

	local var_6_2 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_6_3 = var_1_10004(var_1_10006)
	local var_6_4 = var_6_2
	local var_6_5 = var_6_2.getFleetById(var_6_4, arg_6_0.mainFleetId)
	local var_6_6 = var_6_3:getShipsByFleet(var_6_5)

	ipairs = var_6_4

	for iter_6_0, iter_6_1 in var_6_4(var_6_6) do
		table = var_1_10012

		var_1_10012.insert(var_6_0, iter_6_1)
	end

	getProxy = var_7
	MilitaryExerciseProxy = var_9

	local var_6_7 = var_7(var_9)
	local var_6_8 = var_7.getRivalById(var_6_7, arg_6_0.rivalId)
	local var_6_9 = var_8.getShips(var_6_8)

	ipairs = var_6_7

	for iter_6_2, iter_6_3 in var_6_7(var_6_9) do
		table = var_1_10015

		var_1_10015.insert(var_6_0, iter_6_3)
	end

	ys = var_10

	local var_6_10, var_6_11 = var_10.Battle.BattleResourceManager.GetInstance().GetPlayerShipResource(var_6_0, arg_6_0.system)

	return var_6_10, var_6_11
end

return var_0_0
