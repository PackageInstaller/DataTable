class = var_0_10000

local var_0_0 = var_0_10000("BattleGateLimitChallenge")

ys = var_1
var_1.Battle.BattleGateLimitChallenge = var_0_0
var_0_0.__name = "BattleGateLimitChallenge"
SYSTEM_LIMIT_CHALLENGE = var_1
var_0_0.BattleSystem = var_1

function var_0_0.Entrance(arg_1_0, arg_1_1)
	FleetProxy = var_1_10002

	local var_1_0 = var_1_10002.CHALLENGE_FLEET_ID

	if not arg_1_1.LegalFleet(var_1_0) then
		return
	end

	getProxy = var_3
	PlayerProxy = var_4

	local var_1_1 = var_3(var_4)
	local var_1_2 = var_3.getData(var_1_1)

	getProxy = var_1_1
	FleetProxy = var_1_10006

	local var_1_3 = var_1_1(var_1_10006)

	getProxy = var_1_10006
	BayProxy = var_1_10007

	local var_1_4 = var_1_10006(var_1_10007)

	getProxy = var_1_10007
	LimitChallengeProxy = var_1_10008

	local var_1_5 = var_1_10007(var_1_10008)
	local var_1_6 = arg_1_0.stageId

	pg = var_1_10009

	local var_1_7 = var_1_10009.expedition_data_template[var_1_6].dungeon_id

	ys = var_1_10010

	local var_1_8 = var_1_10010.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_7).fleet_prefab
	local var_1_9 = var_1_3
	local var_1_10 = var_1_3.getFleetById

	FleetProxy = var_1_10013

	local var_1_11 = var_1_10(var_1_9, var_1_10013.CHALLENGE_FLEET_ID)
	local var_1_12 = {}
	local var_1_13 = var_1_4
	local var_1_14 = var_1_4.getSortShipsByFleet(var_1_13, var_1_11)

	ipairs = var_1_13

	for iter_1_0, iter_1_1 in var_1_13(var_1_14) do
		var_1_12[#var_1_12 + 1] = iter_1_1.id
	end

	pg = var_14

	local var_1_15 = var_14.battle_cost_template[var_0_0.BattleSystem].oil_cost > 0
	local var_1_16 = 0
	local var_1_17 = 0

	if var_1_15 then
		var_1_16 = var_1_11:getStartCost().oil
		var_1_17 = var_1_11:GetCostSum().oil
	end

	if var_1_15 and var_1_2.oil < var_1_17 then
		pg = var_18

		local var_1_18 = var_18.TipsMgr.GetInstance()
		local var_1_19 = var_18.ShowTips

		i18n = var_1_10020

		var_1_19(var_1_18, var_1_10020("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local function var_1_20(arg_2_0)
		if var_1_15 then
			local var_2_0 = var_1_2

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_16
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 then
			pg = var_2_1

			local var_2_2 = var_2_1.gameset.battle_consume_energy.key_value

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_14) do
				iter_2_1:cosumeEnergy(var_2_2)

				local var_2_3 = var_1_4

				var_7.updateShip(var_2_3, iter_2_1)
			end
		end

		local var_2_4 = var_0

		var_1.updatePlayer(var_2_4, var_1_2)

		local var_2_5 = {}

		mainFleetID = var_2_4
		var_2_5.mainFleetId = var_2_4
		var_2_5.prefabFleet = var_1_8
		var_2_5.stageId = var_1_6
		var_2_5.system = var_0_0.BattleSystem
		var_2_5.token = arg_2_0.key

		local var_2_6 = arg_1_1
		local var_2_7 = var_2.sendNotification

		GAME = var_2_10004

		var_2_7(var_2_6, var_2_10004.BEGIN_STAGE_DONE, var_2_5)

		return
	end

	local function var_1_21(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10020

	var_1_10020.SendRequest(var_0_0.BattleSystem, var_1_12, {
		var_1_6
	}, var_1_20, var_1_21)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template[var_0_0.BattleSystem]

	getProxy = var_3
	FleetProxy = var_1_10004

	local var_4_1 = var_3(var_1_10004)

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_4_2 = var_1_10004(var_1_10005)
	local var_4_3 = arg_4_0.statistics._battleScore
	local var_4_4 = 0
	local var_4_5 = {}
	local var_4_6 = {}
	local var_4_7 = arg_4_0.stageId
	local var_4_8 = var_4_1
	local var_4_9 = var_4_1.getFleetById

	FleetProxy = var_1_10012

	local var_4_10 = var_4_9(var_4_8, var_1_10012.CHALLENGE_FLEET_ID)
	local var_4_11

	if arg_4_0.statistics.submarineAid then
		local var_4_12 = var_4_1
		local var_4_13 = var_4_1.getFleetById

		FleetProxy = var_1_10014
		var_4_11 = var_4_13(var_4_12, var_1_10014.CHALLENGE_SUB_FLEET_ID)
	end

	;(function()
		(function(arg_6_0)
			local var_6_0 = arg_6_0:getEndCost().oil

			var_4_4 = var_4_4 + var_6_0
			table = var_2

			local var_6_1 = var_2.insertto
			local var_6_2 = var_4_6

			_ = var_3_10004

			var_6_1(var_6_2, var_3_10004.values(arg_6_0.commanderIds))

			table = var_6_1

			local var_6_3 = var_6_1.insertto
			local var_6_4 = var_4_5
			local var_6_5 = var_4_2

			var_6_3(var_6_4, var_4.getSortShipsByFleet(var_6_5, arg_6_0))

			return
		end)(var_4_10)

		if arg_4_0.statistics.submarineAid then
			var_0(var_4_11)
		end

		return
	end)()

	local var_4_14 = arg_4_1.GeneralPackage(arg_4_0, var_4_5)

	var_4_14.commander_id_list = var_4_6

	local function var_4_15(arg_7_0)
		arg_4_1.addShipsExp(arg_7_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_7_0.mvp

		local var_7_0 = arg_4_1
		local var_7_1, var_7_2 = var_1.GeneralLoot(var_7_0, arg_7_0)
		local var_7_3 = var_4_3

		ys = var_4

		local var_7_4 = var_7_3 > var_4.Battle.BattleConst.BattleScore.C
		local var_7_5 = arg_4_1.GenerateCommanderExp(arg_7_0, var_4_10, var_4_11)

		arg_4_1.GeneralPlayerCosume(var_0_0.BattleSystem, var_7_4, var_4_4, arg_7_0.player_exp)

		local var_7_6 = {
			system = var_0_0.BattleSystem,
			statistics = arg_4_0.statistics,
			score = var_4_3,
			drops = var_7_1,
			commanderExps = var_7_5,
			result = arg_7_0.result,
			extraDrops = var_7_2
		}
		local var_7_7 = arg_4_1
		local var_7_8 = var_6.sendNotification

		GAME = var_8

		var_7_8(var_7_7, var_8.FINISH_STAGE_DONE, var_7_6)

		if var_7_4 then
			LimitChallengeConst = var_7_8

			local var_7_9 = var_7_8.GetChallengeIDByStageID(var_4_7)
			local var_7_10 = arg_4_0.statistics._totalTime

			getProxy = var_8
			LimitChallengeProxy = var_9

			local var_7_11 = var_8(var_9)

			var_8.setPassTime(var_7_11, var_7_9, var_7_10)
		end

		return
	end

	arg_4_1:SendRequest(var_4_14, var_4_15)

	return
end

function var_0_0.GetPreloadList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2

	ys = var_1_10004

	local var_8_3 = var_1_10004.Battle.BattleResourceManager.GetInstance()

	FleetProxy = var_1_10005

	local var_8_4 = var_1_10005.CHALLENGE_FLEET_ID

	FleetProxy = var_1_10006

	local var_8_5 = var_1_10006.CHALLENGE_SUB_FLEET_ID

	getProxy = var_1_10007
	FleetProxy = var_1_10008

	local var_8_6 = var_1_10007(var_1_10008)
	local var_8_7 = var_7.getFleetById(var_8_6, var_8_4)
	local var_8_8 = var_7
	local var_8_9 = var_7.getFleetById(var_8_8, var_8_5)

	getProxy = var_8_8
	BayProxy = var_11

	local var_8_10 = var_8_8(var_11)

	if var_8_7 then
		local var_8_11 = var_8_7
		local var_8_12 = var_8_7.GetRawShipIds(var_8_11)

		ipairs = var_8_11

		for iter_8_0, iter_8_1 in var_8_11(var_8_12) do
			table = var_1_10017
			var_1_10017 = var_1_10017.insert
			var_1_10018 = var_8_0
			var_1_10020 = var_8_10

			var_1_10017(var_1_10018, var_8_10.getShipById(var_1_10020, iter_8_1))
		end

		var_8_1 = var_8_7:buildBattleBuffList()
	end

	if var_8_9 then
		local var_8_13 = var_8_9
		local var_8_14 = var_8_9.GetRawShipIds(var_8_13)

		ipairs = var_8_13

		for iter_8_2, iter_8_3 in var_8_13(var_8_14) do
			table = var_1_10017
			var_1_10017 = var_1_10017.insert
			var_1_10018 = var_8_0
			var_1_10020 = var_8_10

			var_1_10017(var_1_10018, var_8_10.getShipById(var_1_10020, iter_8_3))
		end

		ipairs = var_12

		for iter_8_4, iter_8_5 in var_12(var_8_9:buildBattleBuffList()) do
			table = var_1_10017

			var_1_10017.insert(var_8_1, iter_8_5)
		end
	end

	local var_8_15, var_8_16 = var_8_3.GetPlayerShipResource(var_8_0, arg_8_0.system)
	local var_8_17 = var_8_3.GetCommanderBuffRes(var_8_1)

	ipairs = var_13

	for iter_8_6, iter_8_7 in var_13(var_8_17) do
		table = var_1_10018

		var_1_10018.insert(var_8_15, iter_8_7)
	end

	LimitChallengeConst = var_13

	local var_8_18 = var_13.GetChallengeIDByStageID(arg_8_0.stageId)

	AcessWithinNull = var_14
	pg = var_15

	if var_14(var_15.expedition_constellation_challenge_template[var_8_18], "buff_id") then
		ipairs = var_15

		for iter_8_8, iter_8_9 in var_15(var_14) do
			ys = var_1_10020

			local var_8_19 = var_1_10020.Battle.BattleDataFunction.GetResFromBuff(iter_8_9.ID, iter_8_9.LV, {})

			ipairs = var_1_10020

			for iter_8_10, iter_8_11 in var_1_10020(var_8_19) do
				table = var_1_10025

				var_1_10025.insert(var_8_15, iter_8_11)
			end
		end
	end

	return var_8_15, var_8_16
end

return var_0_0
