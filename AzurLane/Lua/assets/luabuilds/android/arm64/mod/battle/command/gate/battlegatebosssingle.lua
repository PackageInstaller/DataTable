class = var_0_10000

local var_0_0 = var_0_10000("BattleGateBossSingle")

ys = var_0_10001
var_0_10001.Battle.BattleGateBossSingle = var_0_0
var_0_0.__name = "BattleGateBossSingle"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	BeginStageCommand = var_1_10002

	if var_1_10002.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.actId

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	FleetProxy = var_1_10006

	local var_1_2 = var_1_10004(var_1_10006)

	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_1_3 = var_1_10005(var_1_10007)

	pg = var_1_10006

	local var_1_4 = var_1_10006.battle_cost_template

	SYSTEM_BOSS_SINGLE = var_1_10007

	local var_1_5 = var_1_4[var_1_10007].oil_cost
	local var_1_6 = 0 < var_1_5

	getProxy = var_8
	ActivityProxy = var_1_10010

	local var_1_7 = var_8(var_1_10010)
	local var_1_8 = var_8.getActivityById(var_1_7, var_1_0)
	local var_1_9 = arg_1_0.stageId
	local var_1_10 = arg_1_0.mainFleetId
	local var_1_11 = var_1_2:getActivityFleets()[var_1_0][var_1_10]
	local var_1_12 = {}
	local var_1_13 = var_1_3:getSortShipsByFleet(var_1_11)

	ipairs = var_1_10014

	for iter_1_0, iter_1_1 in var_1_10014(var_1_13) do
		var_1_12[#var_1_12 + 1] = iter_1_1.id
	end

	local var_1_14 = var_1_8:GetEnemyDataByStageId(var_1_9)
	local var_1_15 = 0
	local var_1_16 = var_1_1:getRawData()
	local var_1_17 = var_1_11
	local var_1_18 = var_1_11.GetCostSum(var_1_17).oil
	local var_1_19 = var_1_14:GetOilLimit()

	math = var_1_17

	local var_1_20 = var_1_17.min(var_1_18, var_1_19[1])

	if var_1_6 and var_1_16.oil < var_1_20 then
		pg = var_19

		local var_1_21 = var_19.TipsMgr.GetInstance()
		local var_1_22 = var_19.ShowTips

		i18n = var_22

		var_1_22(var_1_21, var_22("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local var_1_23 = var_1_11:getStartCost().oil

	local function var_1_24(arg_2_0)
		if var_1_6 then
			local var_2_0 = var_1_16

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_23
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 then
			pg = var_2_1

			local var_2_2 = var_2_1.gameset.battle_consume_energy.key_value

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_13) do
				iter_2_1:cosumeEnergy(var_2_2)

				local var_2_3 = var_1_3

				var_7.updateShip(var_2_3, iter_2_1)
			end
		end

		local var_2_4 = var_1_1

		var_1.updatePlayer(var_2_4, var_1_16)

		local var_2_5 = {
			mainFleetId = var_1_10,
			prefabFleet = {},
			stageId = var_1_9
		}

		SYSTEM_BOSS_SINGLE = var_2
		var_2_5.system = var_2
		var_2_5.actId = var_1_0
		var_2_5.token = arg_2_0.key
		var_2_5.continuousBattleTimes = arg_1_0.continuousBattleTimes
		var_2_5.totalBattleTimes = arg_1_0.totalBattleTimes

		local var_2_6 = arg_1_1
		local var_2_7 = var_2.sendNotification

		GAME = iter_2_0

		var_2_7(var_2_6, iter_2_0.BEGIN_STAGE_DONE, var_2_5)

		return
	end

	local function var_1_25(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_22

	local var_1_26 = var_22.SendRequest

	SYSTEM_BOSS_SINGLE = var_1_10024

	var_1_26(var_1_10024, var_1_12, {
		var_1_9
	}, var_1_24, var_1_25)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template

	SYSTEM_BOSS_SINGLE = var_1_10003

	local var_4_1 = var_4_0[var_1_10003]

	getProxy = var_1_10003
	FleetProxy = var_1_10005

	local var_4_2 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_4_3 = var_1_10004(var_1_10006)
	local var_4_4 = arg_4_0.statistics._battleScore

	getProxy = var_1_10006
	ActivityProxy = var_1_10008

	local var_4_5 = var_1_10006(var_1_10008)
	local var_4_6 = var_6.getActivityById(var_4_5, arg_4_0.actId)
	local var_4_7 = var_6.GetEnemyDataByStageId(var_4_6, arg_4_0.stageId)
	local var_4_8 = var_7.GetOilLimit(var_4_7)
	local var_4_9 = var_4_2:getActivityFleets()[arg_4_0.actId][arg_4_0.mainFleetId]
	local var_4_10
	local var_4_11 = 0
	local var_4_12 = {}
	local var_4_13 = {}
	local var_4_14 = var_4_1.oil_cost > 0

	local function var_4_15(arg_5_0, arg_5_1)
		local var_5_1

		if var_4_14 then
			local var_5_0 = arg_5_0

			var_5_1 = arg_5_0.getEndCost(var_5_0).oil

			if arg_5_1 > 0 then
				local var_5_2 = arg_5_0:getStartCost().oil

				math = var_5_0
				var_5_1 = var_5_0.clamp(arg_5_1 - var_5_2, 0, var_5_1)
			end

			var_4_11 = var_4_11 + var_5_1
		end

		table = var_5_1

		local var_5_3 = var_5_1.insertto
		local var_5_4 = var_4_12
		local var_5_5 = var_4_3

		var_5_3(var_5_4, var_5.getSortShipsByFleet(var_5_5, arg_5_0))

		table = var_5_3

		var_5_3.insertto(var_4_13, arg_5_0.commanderIds)

		return
	end

	local var_4_16 = var_4_9
	local var_4_17

	if not var_4_8[1] then
		var_4_17 = 0
	end

	var_4_15(var_4_16, var_4_17)

	if arg_4_0.statistics.submarineAid then
		local var_4_18

		if var_10[arg_4_0.mainFleetId + 10] then
			var_4_18 = var_17

			local var_4_19 = var_4_10
			local var_4_20

			if not var_4_8[2] then
				var_4_20 = 0
			end

			var_4_18(var_4_19, var_4_20)
		else
			originalPrint = var_4_18

			var_4_18("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_21 = arg_4_1.GeneralPackage(arg_4_0, var_4_12)

	var_4_21.commander_id_list = var_4_13

	local function var_4_22(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0 = arg_4_1
		local var_6_1, var_6_2 = var_1.GeneralLoot(var_6_0, arg_6_0)
		local var_6_3 = var_4_4

		ys = var_4

		local var_6_4 = var_6_3 > var_4.Battle.BattleConst.BattleScore.C
		local var_6_5 = arg_4_1.GenerateCommanderExp(arg_6_0, var_4_9, var_4_10)
		local var_6_6 = arg_4_1.GeneralPlayerCosume

		SYSTEM_BOSS_SINGLE = var_6_7

		var_6_6(var_6_7, var_6_4, var_4_11, arg_6_0.player_exp)

		local var_6_7, var_6_9, var_6_10

		if var_6_4 then
			getProxy = var_6_6
			ActivityProxy = var_6_7
			var_6_7 = var_6_6(var_6_7)

			local var_6_8 = var_5.getActivityById(var_6_7, arg_4_0.actId)

			var_6_9 = var_5.GetEnemyDataByStageId(var_6_8, arg_4_0.stageId)
			var_6_10 = var_5

			var_5.AddDailyCount(var_6_10, var_6_9.id)

			var_6_10 = var_5
			var_6_7 = var_5.AddPassStage
			var_2_10012 = var_6_9

			var_6_7(var_6_10, var_6_9.GetExpeditionId(var_2_10012))

			getProxy = var_6_7
			ActivityProxy = var_6_10
			var_6_10 = var_6_7(var_6_10)

			var_6_7.updateActivity(var_6_10, var_5)
		end

		local var_6_11 = {}

		SYSTEM_BOSS_SINGLE = var_6_9
		var_6_11.system = var_6_9
		var_6_11.statistics = arg_4_0.statistics
		var_6_11.score = var_4_4
		var_6_11.result = arg_6_0.result
		var_6_11.drops = var_6_1
		var_6_11.commanderExps = var_6_5
		var_6_11.extraDrops = var_6_2
		PlayerConst = var_6

		if var_6.CanDropItem(var_6_1) then
			local var_6_12 = {}

			ipairs = var_6_7

			for iter_6_0, iter_6_1 in var_6_7(var_6_1) do
				table = var_2_10012

				var_2_10012.insert(var_6_12, iter_6_1)
			end

			ipairs = var_7

			for iter_6_2, iter_6_3 in var_7(var_6_2) do
				iter_6_3.riraty = true
				table = var_12

				var_12.insert(var_6_12, iter_6_3)
			end

			getProxy = var_7
			ContextProxy = var_6_10
			var_6_10 = var_7(var_6_10)
			var_6_10 = var_7.getCurrentContext(var_6_10)

			local var_6_13 = var_7.getContextByMediator

			BossSingleContinuousOperationMediator = iter_6_2

			if var_6_13(var_6_10, iter_6_2) then
				getProxy = var_7
				ChapterProxy = var_6_10
				var_6_10 = var_7(var_6_10)

				var_7.AddBossSingleRewards(var_6_10, var_6_12)
			end
		end

		local var_6_14 = arg_4_1
		local var_6_15 = var_6.sendNotification

		GAME = var_6_10

		var_6_15(var_6_14, var_6_10.FINISH_STAGE_DONE, var_6_11)

		return
	end

	arg_4_1:SendRequest(var_4_21, var_4_22)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	ys = var_1_10001

	local var_7_0, var_7_1 = var_1_10001.Battle.BattleGateActBoss.GetPreloadList(arg_7_0)

	getProxy = var_3
	ActivityProxy = var_1_10005

	local var_7_2 = var_3(var_1_10005)
	local var_7_3 = var_3.getActivityById(var_7_2, arg_7_0.actId)

	ys = var_1_10004

	local var_7_4 = var_1_10004.Battle.BattleResourceManager.GetInstance().GetResFromBuffIDList(var_7_3:GetBuffIdsByStageId(arg_7_0.stageId))

	ipairs = var_6

	for iter_7_0, iter_7_1 in var_6(var_7_4) do
		table = var_1_10011

		var_1_10011.insert(var_7_0, iter_7_1)
	end

	return var_7_0, var_7_1
end

return var_0_0
