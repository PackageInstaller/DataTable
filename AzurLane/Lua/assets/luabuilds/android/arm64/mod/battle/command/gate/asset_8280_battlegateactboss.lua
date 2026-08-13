class = var_0_10000

local var_0_0 = var_0_10000("BattleGateActBoss")

ys = var_0_10001
var_0_10001.Battle.BattleGateActBoss = var_0_0
var_0_0.__name = "BattleGateActBoss"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	BeginStageCommand = var_1_10002

	if var_1_10002.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.continuousBattleTimes
	local var_1_1 = arg_1_0.totalBattleTimes
	local var_1_2 = arg_1_0.actId

	getProxy = var_1_10005
	ActivityProxy = var_1_10007

	local var_1_3 = var_1_10005(var_1_10007)
	local var_1_4 = var_5.getActivityById(var_1_3, var_1_2)
	local var_1_5 = var_5.getConfig(var_1_4, "config_id")

	pg = var_1_3

	local var_1_6 = var_1_3.activity_event_worldboss[var_1_5]

	getProxy = var_1_4
	PlayerProxy = var_1_10010

	local var_1_7 = var_1_4(var_1_10010)

	getProxy = var_9
	BayProxy = var_1_10011

	local var_1_8 = var_9(var_1_10011)

	getProxy = var_1_10010
	FleetProxy = var_1_10012

	local var_1_9 = var_1_10010(var_1_10012)

	pg = var_1_10011

	local var_1_10 = var_1_10011.battle_cost_template

	SYSTEM_ACT_BOSS = var_1_10012

	local var_1_11 = var_1_10[var_1_10012].oil_cost > 0
	local var_1_12 = {}
	local var_1_13 = 0
	local var_1_14 = 0
	local var_1_15 = 0
	local var_1_16 = 0
	local var_1_17 = arg_1_0.stageId
	local var_1_18 = arg_1_0.mainFleetId
	local var_1_19 = var_1_9
	local var_1_20 = var_1_9.getActivityFleets(var_1_19)[var_1_2][var_1_18]
	local var_1_21 = var_1_8:getSortShipsByFleet(var_1_20)

	ipairs = var_1_19

	for iter_1_0, iter_1_1 in var_1_19(var_1_21) do
		var_1_12[#var_1_12 + 1] = iter_1_1.id
	end

	local var_1_22 = var_1_20:getStartCost().oil
	local var_1_23 = var_1_20:GetCostSum().oil
	local var_1_24 = var_1_6.use_oil_limit[var_1_18]
	local var_1_25 = var_5

	if var_5.IsOilLimit(var_1_25, var_1_17) then
		local var_1_26 = var_1_24[1]

		if 0 < var_1_26 then
			math = var_1_26
			var_1_23 = var_1_26.min(var_1_23, var_1_24[1])
		end
	end

	local var_1_27 = var_1_7
	local var_1_28 = var_1_7.getData(var_1_27)

	if var_1_11 and var_1_28.oil < var_1_23 then
		pg = var_1_25

		local var_1_29 = var_1_25.TipsMgr.GetInstance()

		var_1_25 = var_1_25.ShowTips
		i18n = var_1_10030

		var_1_25(var_1_29, var_1_10030("stage_beginStage_error_noResource"))

		return
	end

	pg = var_1_25

	local var_1_30 = var_1_25.expedition_data_template[var_1_17].dungeon_id

	ys = var_1_27

	local var_1_31 = var_1_27.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_30).fleet_prefab

	arg_1_1.ShipVertify()

	local function var_1_32(arg_2_0)
		if var_1_11 then
			local var_2_0 = var_1_28

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_22
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 then
			pg = var_2_1

			local var_2_2 = var_2_1.gameset.battle_consume_energy.key_value

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_21) do
				iter_2_1:cosumeEnergy(var_2_2)

				local var_2_3 = var_1_8

				var_7.updateShip(var_2_3, iter_2_1)
			end
		end

		local var_2_4 = var_1_7

		var_1.updatePlayer(var_2_4, var_1_28)

		local var_2_5 = {
			mainFleetId = var_1_18,
			actId = var_1_2,
			prefabFleet = var_1_31,
			stageId = var_1_17
		}

		SYSTEM_ACT_BOSS = var_2
		var_2_5.system = var_2
		var_2_5.token = arg_2_0.key
		var_2_5.continuousBattleTimes = var_1_0
		var_2_5.totalBattleTimes = var_1_1

		local var_2_6 = arg_1_1
		local var_2_7 = var_2.sendNotification

		GAME = iter_2_0

		var_2_7(var_2_6, iter_2_0.BEGIN_STAGE_DONE, var_2_5)

		return
	end

	local function var_1_33(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10031

	local var_1_34 = var_1_10031.SendRequest

	SYSTEM_ACT_BOSS = var_1_10033

	var_1_34(var_1_10033, var_1_12, {
		var_1_17
	}, var_1_32, var_1_33)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template

	SYSTEM_ACT_BOSS = var_1_10003

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
	local var_4_7 = var_6.getConfig(var_4_6, "config_id")

	pg = var_4_5

	local var_4_8 = var_4_5.activity_event_worldboss[var_4_7].use_oil_limit[arg_4_0.mainFleetId]
	local var_4_9 = var_6:IsOilLimit(arg_4_0.stageId)
	local var_4_10 = var_4_2:getActivityFleets()[arg_4_0.actId][arg_4_0.mainFleetId]
	local var_4_11
	local var_4_12 = 0
	local var_4_13 = {}
	local var_4_14 = {}
	local var_4_15 = var_4_1.oil_cost > 0

	local function var_4_16(arg_5_0, arg_5_1)
		local var_5_1

		if var_4_15 then
			local var_5_0 = arg_5_0

			var_5_1 = arg_5_0.getEndCost(var_5_0).oil

			if arg_5_1 > 0 then
				local var_5_2 = arg_5_0:getStartCost().oil

				math = var_5_0
				var_5_1 = var_5_0.clamp(arg_5_1 - var_5_2, 0, var_5_1)
			end

			var_4_12 = var_4_12 + var_5_1
		end

		table = var_5_1

		local var_5_3 = var_5_1.insertto
		local var_5_4 = var_4_13
		local var_5_5 = var_4_3

		var_5_3(var_5_4, var_5.getSortShipsByFleet(var_5_5, arg_5_0))

		table = var_5_3

		var_5_3.insertto(var_4_14, arg_5_0.commanderIds)

		return
	end

	local var_4_17 = var_4_10
	local var_4_18

	if not var_4_9 or not var_4_8[1] then
		var_4_18 = 0
	end

	var_4_16(var_4_17, var_4_18)

	if arg_4_0.statistics.submarineAid then
		local var_4_19

		if var_12[arg_4_0.mainFleetId + 10] then
			var_4_19 = var_19

			local var_4_20 = var_4_11
			local var_4_21

			if not var_4_9 or not var_4_8[2] then
				var_4_21 = 0
			end

			var_4_19(var_4_20, var_4_21)
		else
			originalPrint = var_4_19

			var_4_19("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_22 = arg_4_1.GeneralPackage(arg_4_0, var_4_13)

	var_4_22.commander_id_list = var_4_14

	local function var_4_23(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0 = arg_4_1
		local var_6_1, var_6_2 = var_1.GeneralLoot(var_6_0, arg_6_0)
		local var_6_3 = var_4_4

		ys = var_4

		local var_6_4 = var_6_3 > var_4.Battle.BattleConst.BattleScore.C
		local var_6_5 = arg_4_1.GenerateCommanderExp(arg_6_0, var_4_10, var_4_11)
		local var_6_6 = arg_4_1.GeneralPlayerCosume

		SYSTEM_ACT_BOSS = var_6_9

		var_6_6(var_6_9, var_6_4, var_4_12, arg_6_0.player_exp)

		local var_6_7
		local var_6_9

		if var_6_4 then
			var_6_7 = (function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_7_0 = var_3_10000(var_3_10002)
				local var_7_1 = var_0.getActivityById(var_7_0, arg_4_0.actId)
				local var_7_2 = arg_4_0.stageId

				return var_7_1.data1KeyValueList[1][var_7_2] == 1 and var_7_1.data1KeyValueList[2][var_7_2] <= 0
			end)()

			local var_6_8 = arg_4_1

			var_6_9 = var_6_9.sendNotification
			GAME = var_6_12

			var_6_9(var_6_8, var_6_12.ACT_BOSS_NORMAL_UPDATE, {
				stageId = arg_4_0.stageId
			})
		end

		local var_6_10 = {}

		SYSTEM_ACT_BOSS = var_6_9
		var_6_10.system = var_6_9
		var_6_10.statistics = arg_4_0.statistics
		var_6_10.score = var_4_4
		var_6_10.drops = var_6_1
		var_6_10.commanderExps = var_6_5
		var_6_10.result = arg_6_0.result
		var_6_10.extraDrops = var_6_2
		var_6_10.isLastBonus = var_6_7
		PlayerConst = var_7

		local var_6_12

		if var_7.CanDropItem(var_6_1) then
			local var_6_11 = {}

			ipairs = var_8

			for iter_6_0, iter_6_1 in var_8(var_6_1) do
				table = var_2_10013

				var_2_10013.insert(var_6_11, iter_6_1)
			end

			ipairs = var_8

			for iter_6_2, iter_6_3 in var_8(var_6_2) do
				iter_6_3.riraty = true
				table = var_13

				var_13.insert(var_6_11, iter_6_3)
			end

			getProxy = var_8
			ContextProxy = var_6_12
			var_6_12 = var_8(var_6_12)
			var_6_12 = var_8.getCurrentContext(var_6_12)

			local var_6_13 = var_8.getContextByMediator

			ContinuousOperationMediator = iter_6_2

			if var_6_13(var_6_12, iter_6_2) then
				getProxy = var_8
				ChapterProxy = var_6_12
				var_6_12 = var_8(var_6_12)

				var_8.AddActBossRewards(var_6_12, var_6_11)
			end
		end

		local var_6_14 = arg_4_1
		local var_6_15 = var_7.sendNotification

		GAME = var_6_12

		var_6_15(var_6_14, var_6_12.FINISH_STAGE_DONE, var_6_10)

		return
	end

	arg_4_1:SendRequest(var_4_22, var_4_23)

	return
end

function var_0_0.GetPreloadList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2

	ys = var_1_10004

	local var_8_3 = var_1_10004.Battle.BattleResourceManager.GetInstance()

	getProxy = var_1_10005
	FleetProxy = var_1_10007

	local var_8_4 = var_1_10005(var_1_10007)

	getProxy = var_1_10006
	BayProxy = var_1_10008

	local var_8_5 = var_1_10006(var_1_10008)

	if var_8_4:getActivityFleets()[arg_8_0.actId][arg_8_0.mainFleetId] then
		local var_8_6 = var_8.ships

		ipairs = var_1_10010

		for iter_8_2, iter_8_1 in var_1_10010(var_8_6) do
			table = var_1_10015

			var_1_10015.insert(var_8_0, var_8_5:getShipById(iter_8_1))
		end

		local var_8_7 = var_8:buildBattleBuffList()

		ipairs = var_10

		for iter_8_2, iter_8_3 in var_10(var_8_7) do
			table = var_1_10015

			var_1_10015.insert(var_8_1, iter_8_3)
		end
	end

	if var_7[arg_8_0.mainFleetId + 10] then
		local var_8_8 = var_9
		local var_8_9 = var_9.getTeamByName

		TeamType = iter_8_2

		local var_8_10 = var_8_9(var_8_8, iter_8_2.Submarine)

		ipairs = var_1_10011

		for iter_8_4, iter_8_5 in var_1_10011(var_8_10) do
			table = var_1_10016

			var_1_10016.insert(var_8_0, var_8_5:getShipById(iter_8_5))
		end

		local var_8_11 = var_9:buildBattleBuffList()

		ipairs = var_11

		for iter_8_6, iter_8_7 in var_11(var_8_11) do
			table = var_1_10016

			var_1_10016.insert(var_8_1, iter_8_7)
		end
	end

	local var_8_12, var_8_13 = var_8_3.GetPlayerShipResource(var_8_0, arg_8_0.system)
	local var_8_14 = var_8_3.GetCommanderBuffRes(var_8_1)

	ipairs = var_12

	for iter_8_8, iter_8_9 in var_12(var_8_14) do
		table = var_1_10017

		var_1_10017.insert(var_8_12, iter_8_9)
	end

	return var_8_12, var_8_13
end

return var_0_0
