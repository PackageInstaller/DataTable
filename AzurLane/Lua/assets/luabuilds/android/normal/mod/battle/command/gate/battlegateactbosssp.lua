class = var_0_10000

local var_0_0 = var_0_10000("BattleGateActBossSP")

ys = var_1
var_1.Battle.BattleGateActBossSP = var_0_0
var_0_0.__name = "BattleGateActBossSP"
SYSTEM_ACT_BOSS_SP = var_1
var_0_0.BattleSystem = var_1

function var_0_0.Entrance(arg_1_0, arg_1_1)
	BeginStageCommand = var_1_10002

	if var_1_10002.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.actId

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_1_1 = var_1_10003(var_1_10004)
	local var_1_2 = var_3.getActivityById(var_1_1, var_1_0)

	getProxy = var_1_1
	PlayerProxy = var_5

	local var_1_3 = var_1_1(var_5)
	local var_1_4 = var_4.getData(var_1_3)

	getProxy = var_1_3
	BayProxy = var_1_10007

	local var_1_5 = var_1_3(var_1_10007)

	getProxy = var_1_10007
	FleetProxy = var_1_10008

	local var_1_6 = var_1_10007(var_1_10008)

	getProxy = var_1_10008
	ActivityProxy = var_1_10009

	local var_1_7 = var_1_10008(var_1_10009)
	local var_1_8 = var_8.GetActivityBossRuntime(var_1_7, var_1_0).buffIds
	local var_1_9 = arg_1_0.stageId

	pg = var_10

	local var_1_10 = var_10.expedition_data_template[var_1_9].dungeon_id

	ys = var_1_10011

	local var_1_11 = var_1_10011.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_10).fleet_prefab
	local var_1_12 = arg_1_0.mainFleetId
	local var_1_13 = var_1_6:getActivityFleets()[var_1_0][var_1_12]
	local var_1_14 = {}
	local var_1_15 = var_1_5
	local var_1_16 = var_1_5.getSortShipsByFleet(var_1_15, var_1_13)

	ipairs = var_1_15

	for iter_1_0, iter_1_1 in var_1_15(var_1_16) do
		var_1_14[#var_1_14 + 1] = iter_1_1.id
	end

	pg = var_16

	local var_1_17 = var_16.battle_cost_template[var_0_0.BattleSystem].oil_cost > 0
	local var_1_18 = 0
	local var_1_19 = 0

	if var_1_17 then
		var_1_18 = var_1_13:getStartCost().oil
		var_1_19 = var_1_13:GetCostSum().oil
	end

	if var_1_4.oil < var_1_19 then
		pg = var_20

		local var_1_20 = var_20.TipsMgr.GetInstance()
		local var_1_21 = var_20.ShowTips

		i18n = var_1_10022

		var_1_21(var_1_20, var_1_10022("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local function var_1_22(arg_2_0)
		if var_1_17 then
			local var_2_0 = var_1_4

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_18
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 then
			pg = var_2_1

			local var_2_2 = var_2_1.gameset.battle_consume_energy.key_value

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_16) do
				iter_2_1:cosumeEnergy(var_2_2)

				local var_2_3 = var_1_5

				var_7.updateShip(var_2_3, iter_2_1)
			end
		end

		local var_2_4 = var_0

		var_1.updatePlayer(var_2_4, var_1_4)

		getProxy = var_1
		ActivityProxy = var_2_4

		local var_2_5 = var_1(var_2_4)

		var_1_2 = var_1.getActivityById(var_2_5, var_1_0)

		local var_2_6 = var_1_2

		var_1.UpdateHistoryBuffs(var_2_6, var_1_8)

		getProxy = var_1
		ActivityProxy = var_2_6

		local var_2_7 = var_1(var_2_6)

		var_1.updateActivity(var_2_7, var_1_2)

		local var_2_8 = {
			mainFleetId = var_1_12,
			actId = var_1_0,
			prefabFleet = var_1_11,
			stageId = var_1_9,
			system = var_0_0.BattleSystem,
			token = arg_2_0.key
		}
		local var_2_9 = arg_1_1
		local var_2_10 = var_2.sendNotification

		GAME = var_2_10004

		var_2_10(var_2_9, var_2_10004.BEGIN_STAGE_DONE, var_2_8)

		return
	end

	local function var_1_23(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10022

	var_1_10022.SendRequest(var_0_0.BattleSystem, var_1_14, {
		var_1_9,
		var_1_8
	}, var_1_22, var_1_23)

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

	getProxy = var_1_10006
	ActivityProxy = var_1_10007

	local var_4_4 = var_1_10006(var_1_10007)
	local var_4_5 = var_6.getActivityById(var_4_4, arg_4_0.actId)
	local var_4_6 = var_6.getConfig(var_4_5, "config_id")

	pg = var_4_5

	local var_4_7 = var_4_5.activity_event_worldboss[var_4_6]
	local var_4_8 = var_4_1:getActivityFleets()[arg_4_0.actId][arg_4_0.mainFleetId]
	local var_4_9
	local var_4_10 = 0
	local var_4_11 = {}
	local var_4_12 = {}
	local var_4_13 = var_4_0.oil_cost > 0

	;(function(arg_5_0, arg_5_1)
		local var_5_0

		if var_4_13 then
			var_5_0 = arg_5_0:getEndCost().oil

			if arg_5_1 > 0 then
				local var_5_1 = arg_5_0
				local var_5_2 = arg_5_0.getStartCost(var_5_1).oil

				math = var_5_1
				var_5_0 = var_5_1.clamp(arg_5_1 - var_5_2, 0, var_5_0)
			end

			var_4_10 = var_4_10 + var_5_0
		end

		table = var_5_0

		local var_5_3 = var_5_0.insertto
		local var_5_4 = var_4_11
		local var_5_5 = var_4_2

		var_5_3(var_5_4, var_4.getSortShipsByFleet(var_5_5, arg_5_0))

		table = var_5_3

		var_5_3.insertto(var_4_12, arg_5_0.commanderIds)

		return
	end)(var_4_8, 0)

	if arg_4_0.statistics.submarineAid then
		if var_10[arg_4_0.mainFleetId + 10] then
			var_17(var_12, 0)
		else
			originalPrint = var_18

			var_18("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_14 = arg_4_1.GeneralPackage(arg_4_0, var_4_11)

	var_4_14.commander_id_list = var_4_12

	local function var_4_15(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0 = arg_4_1
		local var_6_1, var_6_2 = var_1.GeneralLoot(var_6_0, arg_6_0)
		local var_6_3 = var_4_3

		ys = var_4

		local var_6_4 = var_6_3 > var_4.Battle.BattleConst.BattleScore.C
		local var_6_5 = arg_4_1.GenerateCommanderExp(arg_6_0, var_4_8, var_0[arg_4_0.mainFleetId + 10])

		arg_4_1.GeneralPlayerCosume(var_0_0.BattleSystem, var_6_4, var_4_10, arg_6_0.player_exp)

		local var_6_6 = {
			system = var_0_0.BattleSystem,
			statistics = arg_4_0.statistics,
			score = var_4_3,
			drops = var_6_1,
			commanderExps = var_6_5,
			result = arg_6_0.result,
			extraDrops = var_6_2
		}
		local var_6_7 = arg_4_1
		local var_6_8 = var_6.sendNotification

		GAME = var_8

		var_6_8(var_6_7, var_8.FINISH_STAGE_DONE, var_6_6)

		return
	end

	arg_4_1:SendRequest(var_4_14, var_4_15)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	ys = var_1_10001

	local var_7_0, var_7_1 = var_1_10001.Battle.BattleGateActBoss.GetPreloadList(arg_7_0)

	ys = var_1_10003

	local var_7_2 = var_1_10003.Battle.BattleResourceManager.GetInstance()

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_7_3 = var_1_10004(var_1_10005)
	local var_7_4 = var_4.GetActivityBossRuntime(var_7_3, arg_7_0.actId).buffIds

	_ = var_7_3

	local var_7_5 = var_7_3.map(var_7_4, function(arg_8_0)
		ActivityBossBuff = var_2_10001

		local var_8_0 = var_2_10001.New({
			configId = arg_8_0
		})

		return var_1.GetBuffID(var_8_0)
	end)
	local var_7_6 = var_7_2.GetResFromBuffIDList(var_7_5)

	ipairs = var_6

	for iter_7_0, iter_7_1 in var_6(var_7_6) do
		table = var_1_10011

		var_1_10011.insert(var_7_0, iter_7_1)
	end

	return var_7_0, var_7_1
end

return var_0_0
