class = var_0_10000

local var_0_0 = var_0_10000("BattleGateChallenge")

ys = var_1
var_1.Battle.BattleGateChallenge = var_0_0
var_0_0.__name = "BattleGateChallenge"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.mode
	local var_1_1 = arg_1_0.actId

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_1_2 = var_1_10004(var_1_10005)

	getProxy = var_1_10005
	BayProxy = var_1_10006

	local var_1_3 = var_1_10005(var_1_10006)

	getProxy = var_1_10006
	ChallengeProxy = var_1_10007

	local var_1_4 = var_1_10006(var_1_10007)

	pg = var_1_10007

	local var_1_5 = var_1_10007.battle_cost_template

	SYSTEM_CHALLENGE = var_1_10008

	local var_1_6 = var_1_5[var_1_10008].oil_cost > 0
	local var_1_7 = {}
	local var_1_8 = 0
	local var_1_9 = 0
	local var_1_10 = 0
	local var_1_11 = 0
	local var_1_12 = var_1_4:getUserChallengeInfo(var_1_0)
	local var_1_13 = var_14.getRegularFleet(var_1_12)
	local var_1_14 = var_15.getShips(var_1_13, false)

	ipairs = var_1_13

	for iter_1_0, iter_1_1 in var_1_13(var_1_14) do
		var_1_7[#var_1_7 + 1] = iter_1_1.id
	end

	local var_1_15 = var_1_2:getData()

	if var_1_6 and var_1_15.oil < var_1_11 then
		pg = var_18

		local var_1_16 = var_18.TipsMgr.GetInstance()
		local var_1_17 = var_18.ShowTips

		i18n = iter_1_0

		var_1_17(var_1_16, iter_1_0("stage_beginStage_error_noResource"))

		return
	end

	local var_1_18 = var_14:getLevel()
	local var_1_19 = var_14:getNextStageID()
	local var_1_20 = {
		var_1_18,
		var_1_0
	}

	arg_1_1.ShipVertify()

	local function var_1_21(arg_2_0)
		if var_1_6 then
			local var_2_0 = var_1_15

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_9
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 then
			pg = var_2_1

			local var_2_2 = var_2_1.gameset.battle_consume_energy.key_value

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_14) do
				iter_2_1:cosumeEnergy(var_2_2)

				local var_2_3 = var_1_3

				var_7.updateShip(var_2_3, iter_2_1)
			end
		end

		local var_2_4 = var_1_2

		var_1.updatePlayer(var_2_4, var_1_15)

		local var_2_5 = {
			prefabFleet = {},
			stageId = var_1_19
		}

		SYSTEM_CHALLENGE = var_2
		var_2_5.system = var_2
		var_2_5.actId = var_1_1
		var_2_5.token = arg_2_0.key
		var_2_5.mode = var_1_0

		local var_2_6 = arg_1_1
		local var_2_7 = var_2.sendNotification

		GAME = var_2_10004

		var_2_7(var_2_6, var_2_10004.BEGIN_STAGE_DONE, var_2_5)

		return
	end

	local function var_1_22(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10023

	local var_1_23 = var_1_10023.SendRequest

	SYSTEM_CHALLENGE = var_1_10024

	var_1_23(var_1_10024, var_1_7, {
		var_1_19,
		var_1_20
	}, var_1_21, var_1_22)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template

	SYSTEM_CHALLENGE = var_1_10003

	local var_4_1 = var_4_0[var_1_10003]

	getProxy = var_1_10003
	FleetProxy = var_1_10004

	local var_4_2 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	ChallengeProxy = var_1_10005

	local var_4_3 = var_1_10004(var_1_10005)
	local var_4_4 = arg_4_0.statistics._battleScore
	local var_4_5 = 0
	local var_4_6 = {}
	local var_4_7 = {}
	local var_4_8 = arg_4_0.mode
	local var_4_9 = var_4_3:getUserChallengeInfo(var_4_8)
	local var_4_10 = var_9.getRegularFleet(var_4_9)
	local var_4_11 = var_10.getShips(var_4_10, true)

	ipairs = var_4_10

	for iter_4_0, iter_4_1 in var_4_10(var_4_11) do
		table = var_1_10017

		var_1_10017.insert(var_4_7, iter_4_1)
	end

	local var_4_12 = {
		var_9:getLevel(),
		var_4_8
	}
	local var_4_13 = 0
	local var_4_14 = arg_4_1.GeneralPackage(arg_4_0, var_4_7)

	var_4_14.data2 = var_4_12

	local function var_4_15(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics)

		arg_4_0.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0 = arg_4_1
		local var_5_1, var_5_2 = var_1.GeneralLoot(var_5_0, arg_5_0)
		local var_5_3 = var_4_4

		ys = var_2_10004

		local var_5_4 = var_5_3 > var_2_10004.Battle.BattleConst.BattleScore.C
		local var_5_5 = arg_4_1.GeneralPlayerCosume

		SYSTEM_CHALLENGE = var_2_10005

		local var_5_6 = var_5_4
		local var_5_7 = var_4_13
		local var_5_8 = arg_5_0.player_exp

		exFlag = var_2_10009

		var_5_5(var_2_10005, var_5_6, var_5_7, var_5_8, var_2_10009)

		local var_5_9 = {}

		SYSTEM_CHALLENGE = var_2_10005
		var_5_9.system = var_2_10005
		var_5_9.statistics = arg_4_0.statistics
		var_5_9.score = var_4_4
		var_5_9.drops = var_5_1
		var_5_9.commanderExps = {}
		var_5_9.result = arg_5_0.result
		var_5_9.extraDrops = var_5_2

		local var_5_10 = arg_4_1
		local var_5_11 = var_5.sendNotification

		GAME = var_5_7

		var_5_11(var_5_10, var_5_7.FINISH_STAGE_DONE, var_5_9)

		local var_5_12 = var_0
		local var_5_13 = var_5.getShipUIDList(var_5_12)

		local function var_5_14(arg_6_0)
			if arg_4_0.statistics[arg_6_0] then
				local var_6_0 = var_0

				var_2.updateShipHP(var_6_0, arg_6_0, var_1.bp)
			end

			return
		end

		pairs = var_7

		for iter_5_0, iter_5_1 in var_7(var_5_13) do
			var_5_14(iter_5_1)
		end

		return
	end

	arg_4_1:SendRequest(var_4_14, var_4_15)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_0 = {}
	local var_7_1

	ys = var_1_10003

	local var_7_2 = var_1_10003.Battle.BattleResourceManager.GetInstance()

	getProxy = var_1_10004
	ChallengeProxy = var_1_10005

	local var_7_3 = var_1_10004(var_1_10005)
	local var_7_4 = var_4.getUserChallengeInfo(var_7_3, arg_7_0.mode)
	local var_7_5 = var_5.getRegularFleet(var_7_4)
	local var_7_6 = var_6.getShips(var_7_5, false)

	ipairs = var_7_5

	for iter_7_0, iter_7_1 in var_7_5(var_7_6) do
		table = var_1_10013

		var_1_10013.insert(var_7_0, iter_7_1)
	end

	local var_7_7 = var_6:buildBattleBuffList()
	local var_7_8 = var_5:getSubmarineFleet()
	local var_7_9 = var_6.getShips(var_7_8, false)

	ipairs = var_9

	for iter_7_2, iter_7_3 in var_9(var_7_9) do
		table = var_1_10014

		var_1_10014.insert(var_7_0, iter_7_3)
	end

	ipairs = var_9

	for iter_7_4, iter_7_5 in var_9(var_6:buildBattleBuffList()) do
		table = var_1_10014

		var_1_10014.insert(var_7_7, iter_7_5)
	end

	local var_7_10, var_7_11 = var_7_2.GetPlayerShipResource(var_7_0, arg_7_0.system)
	local var_7_12 = var_7_2.GetCommanderBuffRes(var_7_7)

	ipairs = var_11

	for iter_7_6, iter_7_7 in var_11(var_7_12) do
		table = var_1_10016

		var_1_10016.insert(var_7_10, iter_7_7)
	end

	return var_7_10, var_7_11
end

return var_0_0
