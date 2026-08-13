class = var_0_10000

local var_0_0 = var_0_10000("BattleGateHPShareActBoss")

ys = var_1
var_1.Battle.BattleGateHPShareActBoss = var_0_0
var_0_0.__name = "BattleGateHPShareActBoss"

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
	local var_1_3 = var_3.getConfig(var_1_2, "config_id")

	pg = var_1_2

	local var_1_4 = var_1_2.activity_event_worldboss[var_1_3]

	getProxy = var_6
	PlayerProxy = var_1_10007

	local var_1_5 = var_6(var_1_10007)

	getProxy = var_1_10007
	BayProxy = var_1_10008

	local var_1_6 = var_1_10007(var_1_10008)

	getProxy = var_1_10008
	FleetProxy = var_1_10009

	local var_1_7 = var_1_10008(var_1_10009)

	pg = var_1_10009

	local var_1_8 = var_1_10009.battle_cost_template

	SYSTEM_HP_SHARE_ACT_BOSS = var_1_10010

	local var_1_9 = var_1_8[var_1_10010].oil_cost > 0
	local var_1_10 = {}
	local var_1_11 = 0
	local var_1_12 = 0
	local var_1_13 = 0
	local var_1_14 = 0
	local var_1_15 = arg_1_0.stageId
	local var_1_16 = arg_1_0.mainFleetId
	local var_1_17 = var_1_7:getActivityFleets()[var_1_0][var_1_16]
	local var_1_18 = var_1_6
	local var_1_19 = var_1_6.getSortShipsByFleet(var_1_18, var_1_17)

	ipairs = var_1_18

	for iter_1_0, iter_1_1 in var_1_18(var_1_19) do
		var_1_10[#var_1_10 + 1] = iter_1_1.id
	end

	local var_1_20 = var_1_17:getStartCost().oil
	local var_1_21 = var_1_17:GetCostSum().oil
	local var_1_22 = var_1_4.use_oil_limit[var_1_16]

	if var_3:IsOilLimit(var_1_15) and var_1_22[1] > 0 then
		math = var_24
		var_1_21 = var_24.min(var_1_21, var_1_22[1])
	end

	local var_1_23 = var_1_5
	local var_1_24 = var_1_5.getData(var_1_23)

	pg = var_1_23

	local var_1_25 = var_1_23.activity_template[var_1_0]

	pg = var_1_10026

	local var_1_26 = var_1_10026.activity_event_worldboss[var_1_25.config_id].ticket
	local var_1_27 = var_1_5:getRawData()
	local var_1_28, var_1_29

	if var_27.getResource(var_1_27, var_1_26) <= 0 then
		pg = var_1_29
		var_1_28 = var_1_29.TipsMgr.GetInstance()
		var_1_29 = var_1_29.ShowTips
		i18n = var_29

		var_1_29(var_1_28, var_29("stage_beginStage_error_noTicket"))

		return
	end

	if var_1_9 and var_1_24.oil < var_1_21 then
		pg = var_1_29
		var_1_28 = var_1_29.TipsMgr.GetInstance()
		var_1_29 = var_1_29.ShowTips
		i18n = var_29

		var_1_29(var_1_28, var_29("stage_beginStage_error_noResource"))

		return
	end

	pg = var_1_29

	local var_1_30 = var_1_29.expedition_data_template[var_1_15].dungeon_id

	ys = var_1_28

	local var_1_31 = var_1_28.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_30).fleet_prefab

	arg_1_1.ShipVertify()

	local function var_1_32(arg_2_0)
		if var_1_9 then
			local var_2_0 = var_1_24

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_20
			})
		end

		id2res = var_1

		local var_2_1 = var_1(var_1_26)
		local var_2_2 = var_1_24

		var_2.consume(var_2_2, {
			[var_2_1] = 1
		})

		local var_2_3 = var_0.enter_energy_cost

		if 0 < var_2_3 then
			pg = var_2_3

			local var_2_4 = var_2_3.gameset.battle_consume_energy.key_value

			ipairs = var_3

			for iter_2_0, iter_2_1 in var_3(var_1_19) do
				iter_2_1:cosumeEnergy(var_2_4)

				local var_2_5 = var_1_6

				var_8.updateShip(var_2_5, iter_2_1)
			end
		end

		local var_2_6 = var_1_5

		var_2.updatePlayer(var_2_6, var_1_24)

		local var_2_7 = {
			mainFleetId = var_1_16,
			actId = var_1_0,
			prefabFleet = var_1_31,
			stageId = var_1_15
		}

		SYSTEM_HP_SHARE_ACT_BOSS = var_3
		var_2_7.system = var_3
		var_2_7.token = arg_2_0.key

		local var_2_8 = arg_1_1
		local var_2_9 = var_3.sendNotification

		GAME = var_5

		var_2_9(var_2_8, var_5.BEGIN_STAGE_DONE, var_2_7)

		return
	end

	local function var_1_33(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10031

	local var_1_34 = var_1_10031.SendRequest

	SYSTEM_HP_SHARE_ACT_BOSS = var_1_10032

	var_1_34(var_1_10032, var_1_10, {
		var_1_15
	}, var_1_32, var_1_33)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template

	SYSTEM_HP_SHARE_ACT_BOSS = var_1_10003

	local var_4_1 = var_4_0[var_1_10003]

	getProxy = var_1_10003
	FleetProxy = var_1_10004

	local var_4_2 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_4_3 = var_1_10004(var_1_10005)

	ys = var_1_10005

	local var_4_4 = var_1_10005.Battle.BattleConst.BattleScore.S
	local var_4_5 = arg_4_0.statistics

	var_4_5._battleScore = var_4_4
	getProxy = var_4_5
	ActivityProxy = var_1_10007

	local var_4_6 = var_4_5(var_1_10007)
	local var_4_7 = var_6.getActivityById(var_4_6, arg_4_0.actId)
	local var_4_8 = var_6.getConfig(var_4_7, "config_id")

	pg = var_4_7

	local var_4_9 = var_4_7.activity_event_worldboss[var_4_8].use_oil_limit[arg_4_0.mainFleetId]
	local var_4_10 = var_6:IsOilLimit(arg_4_0.stageId)
	local var_4_11 = var_4_2:getActivityFleets()[arg_4_0.actId][arg_4_0.mainFleetId]
	local var_4_12
	local var_4_13 = 0
	local var_4_14 = {}
	local var_4_15 = {}
	local var_4_16 = var_4_1.oil_cost > 0

	local function var_4_17(arg_5_0, arg_5_1)
		local var_5_0

		if var_4_16 then
			var_5_0 = arg_5_0:getEndCost().oil

			if arg_5_1 > 0 then
				local var_5_1 = arg_5_0
				local var_5_2 = arg_5_0.getStartCost(var_5_1).oil

				math = var_5_1
				var_5_0 = var_5_1.clamp(arg_5_1 - var_5_2, 0, var_5_0)
			end

			var_4_13 = var_4_13 + var_5_0
		end

		table = var_5_0

		local var_5_3 = var_5_0.insertto
		local var_5_4 = var_4_14
		local var_5_5 = var_4_3

		var_5_3(var_5_4, var_4.getSortShipsByFleet(var_5_5, arg_5_0))

		table = var_5_3

		var_5_3.insertto(var_4_15, arg_5_0.commanderIds)

		return
	end

	local var_4_18 = var_4_11
	local var_4_19

	if not var_4_10 or not var_4_9[1] then
		var_4_19 = 0
	end

	var_4_17(var_4_18, var_4_19)

	if arg_4_0.statistics.submarineAid then
		local var_4_20

		if var_12[arg_4_0.mainFleetId + 10] then
			var_4_20 = var_19

			local var_4_21 = var_4_12
			local var_4_22

			if not var_4_10 or not var_4_9[2] then
				var_4_22 = 0
			end

			var_4_20(var_4_21, var_4_22)
		else
			originalPrint = var_4_20

			var_4_20("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_23 = arg_4_1.GeneralPackage(arg_4_0, var_4_14)

	var_4_23.commander_id_list = var_4_15

	local var_4_24 = {}

	ipairs = var_22

	for iter_4_0, iter_4_1 in var_22(arg_4_0.statistics._enemyInfoList) do
		table = var_1_10027

		var_1_10027.insert(var_4_24, {
			enemy_id = iter_4_1.id,
			damage_taken = iter_4_1.damage,
			total_hp = iter_4_1.totalHp
		})
	end

	var_4_23.enemy_info = var_4_24

	local function var_4_25(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0 = arg_4_1
		local var_6_1, var_6_2 = var_1.GeneralLoot(var_6_0, arg_6_0)
		local var_6_3 = var_4_4

		ys = var_4

		local var_6_4 = var_6_3 > var_4.Battle.BattleConst.BattleScore.C
		local var_6_5 = arg_4_1.GenerateCommanderExp(arg_6_0, var_4_11, var_4_12)
		local var_6_6 = arg_4_1.GeneralPlayerCosume

		SYSTEM_HP_SHARE_ACT_BOSS = var_6

		var_6_6(var_6, var_6_4, var_4_13, arg_6_0.player_exp)

		local var_6_7 = {}

		SYSTEM_HP_SHARE_ACT_BOSS = var_6
		var_6_7.system = var_6
		var_6_7.statistics = arg_4_0.statistics
		var_6_7.score = var_4_4
		var_6_7.drops = var_6_1
		var_6_7.commanderExps = var_6_5
		var_6_7.result = arg_6_0.result
		var_6_7.extraDrops = var_6_2

		local var_6_8 = var_0

		var_6.AddStage(var_6_8, arg_4_0.stageId)

		getProxy = var_6
		ActivityProxy = var_6_8

		local var_6_9 = var_6(var_6_8)

		var_6.updateActivity(var_6_9, var_0)

		local var_6_10 = arg_4_1
		local var_6_11 = var_6.sendNotification

		GAME = var_8

		var_6_11(var_6_10, var_8.FINISH_STAGE_DONE, var_6_7)

		return
	end

	arg_4_1:SendRequest(var_4_23, var_4_25)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	ys = var_1_10001

	local var_7_0, var_7_1 = var_1_10001.Battle.BattleGateActBoss.GetPreloadList(arg_7_0)

	return var_7_0, var_7_1
end

return var_0_0
