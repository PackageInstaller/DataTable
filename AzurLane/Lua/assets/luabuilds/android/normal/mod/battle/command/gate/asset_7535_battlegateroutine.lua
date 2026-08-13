class = var_0_10000

local var_0_0 = var_0_10000("BattleGateRoutine")

ys = var_1
var_1.Battle.BattleGateRoutine = var_0_0
var_0_0.__name = "BattleGateRoutine"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if not arg_1_1.LegalFleet(arg_1_0.mainFleetId) then
		return
	end

	BeginStageCommand = var_2

	if var_2.DockOverload() then
		return
	end

	getProxy = var_2
	PlayerProxy = var_3

	local var_1_0 = var_2(var_3)

	getProxy = var_3
	BayProxy = var_1_10004

	local var_1_1 = var_3(var_1_10004)

	getProxy = var_1_10004
	FleetProxy = var_1_10005

	local var_1_2 = var_1_10004(var_1_10005)

	pg = var_1_10005

	local var_1_3 = var_1_10005.battle_cost_template

	SYSTEM_ROUTINE = var_1_10006

	local var_1_4 = var_1_3[var_1_10006].oil_cost > 0
	local var_1_5 = {}
	local var_1_6 = 0
	local var_1_7 = 0
	local var_1_8 = 0
	local var_1_9 = 0
	local var_1_10 = var_1_2:getFleetById(arg_1_0.mainFleetId)
	local var_1_11 = var_1_1
	local var_1_12 = var_1_1.getSortShipsByFleet(var_1_11, var_1_10)

	ipairs = var_1_11

	for iter_1_0, iter_1_1 in var_1_11(var_1_12) do
		var_1_5[#var_1_5 + 1] = iter_1_1.id
	end

	local var_1_13 = var_1_10:getStartCost().oil
	local var_1_14 = var_1_10:GetCostSum().oil
	local var_1_15 = var_1_0:getData()

	if var_1_4 and var_1_15.oil < var_1_14 then
		pg = var_17

		local var_1_16 = var_17.TipsMgr.GetInstance()
		local var_1_17 = var_17.ShowTips

		i18n = var_1_10019

		var_1_17(var_1_16, var_1_10019("stage_beginStage_error_noResource"))

		return
	end

	local var_1_18 = arg_1_0.mainFleetId
	local var_1_19 = arg_1_0.stageId

	pg = var_1_10019

	local var_1_20 = var_1_10019.expedition_data_template[var_1_19].dungeon_id

	ys = var_1_10020

	local var_1_21 = var_1_10020.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_20).fleet_prefab

	arg_1_1.ShipVertify()

	local function var_1_22(arg_2_0)
		if var_1_4 then
			local var_2_0 = var_1_15

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_13
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 then
			exFlag = var_2_1

			if not var_2_1 then
				pg = var_2_1

				local var_2_2 = var_2_1.gameset.battle_consume_energy.key_value

				ipairs = var_2

				for iter_2_0, iter_2_1 in var_2(var_1_12) do
					iter_2_1:cosumeEnergy(var_2_2)

					local var_2_3 = var_1_1

					var_7.updateShip(var_2_3, iter_2_1)
				end
			end
		end

		local var_2_4 = var_1_0

		var_1.updatePlayer(var_2_4, var_1_15)

		local var_2_5 = {
			mainFleetId = var_1_18,
			prefabFleet = var_1_21,
			stageId = var_1_19
		}

		SYSTEM_ROUTINE = var_2
		var_2_5.system = var_2
		var_2_5.token = arg_2_0.key

		local var_2_6 = arg_1_1
		local var_2_7 = var_2.sendNotification

		GAME = var_2_10004

		var_2_7(var_2_6, var_2_10004.BEGIN_STAGE_DONE, var_2_5)

		return
	end

	local function var_1_23(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10023

	local var_1_24 = var_1_10023.SendRequest

	SYSTEM_ROUTINE = var_1_10024

	var_1_24(var_1_10024, var_1_5, {
		var_1_19
	}, var_1_22, var_1_23)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template

	SYSTEM_ROUTINE = var_1_10003

	local var_4_1 = var_4_0[var_1_10003]

	getProxy = var_1_10003
	FleetProxy = var_1_10004

	local var_4_2 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_4_3 = var_1_10004(var_1_10005)
	local var_4_4 = arg_4_0.statistics._battleScore
	local var_4_5 = 0
	local var_4_6 = {}
	local var_4_7 = var_4_2:getFleetById(arg_4_0.mainFleetId)
	local var_4_8 = var_4_3:getSortShipsByFleet(var_4_7)
	local var_4_9 = var_4_7:getEndCost().oil
	local var_4_10 = arg_4_1.GeneralPackage(arg_4_0, var_4_8)

	local function var_4_11(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0 = arg_4_1
		local var_5_1, var_5_2 = var_1.GeneralLoot(var_5_0, arg_5_0)
		local var_5_3 = var_4_4

		ys = var_4

		local var_5_4 = var_5_3 > var_4.Battle.BattleConst.BattleScore.C
		local var_5_5 = arg_4_1.GeneralPlayerCosume

		SYSTEM_ROUTINE = var_2_10005

		local var_5_6 = var_5_4
		local var_5_7 = var_4_9
		local var_5_8 = arg_5_0.player_exp

		exFlag = var_2_10009

		var_5_5(var_2_10005, var_5_6, var_5_7, var_5_8, var_2_10009)

		getProxy = var_5_5
		DailyLevelProxy = var_2_10005

		local var_5_9 = var_5_5(var_2_10005)

		if var_5_4 then
			local var_5_10 = var_5_9.data

			var_5_6 = var_5_9.dailyLevelId

			local var_5_11

			if not var_5_9.data[var_5_9.dailyLevelId] then
				var_5_11 = 0
			end

			var_5_10[var_5_6] = var_5_11 + 1
		end

		local var_5_12 = var_4_4

		ys = var_5_6

		local var_5_13

		if var_5_12 == var_5_6.Battle.BattleConst.BattleScore.S then
			var_5_13 = var_5_9

			var_5_9.AddQuickStage(var_5_13, arg_4_0.stageId)
		end

		local var_5_14 = {}

		SYSTEM_ROUTINE = var_5_13
		var_5_14.system = var_5_13
		var_5_14.statistics = arg_4_0.statistics
		var_5_14.score = var_4_4
		var_5_14.drops = var_5_1
		var_5_14.commanderExps = {}
		var_5_14.result = arg_5_0.result
		var_5_14.extraDrops = var_5_2

		local var_5_15 = arg_4_1
		local var_5_16 = var_6.sendNotification

		GAME = var_5_8

		var_5_16(var_5_15, var_5_8.FINISH_STAGE_DONE, var_5_14)

		return
	end

	arg_4_1:SendRequest(var_4_10, var_4_11)

	return
end

return var_0_0
