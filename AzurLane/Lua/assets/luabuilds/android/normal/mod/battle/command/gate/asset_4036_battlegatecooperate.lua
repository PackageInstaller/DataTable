class = var_0_10000

local var_0_0 = var_0_10000("BattleGateCooperate")

ys = var_1
var_1.Battle.BattleGateCooperate = var_0_0
var_0_0.__name = "BattleGateCooperate"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	BeginStageCommand = var_1_10002

	if var_1_10002.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.actId

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_1_1 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_1_2 = var_1_10004(var_1_10005)

	getProxy = var_1_10005
	FleetProxy = var_1_10006

	local var_1_3 = var_1_10005(var_1_10006)

	pg = var_1_10006

	local var_1_4 = var_1_10006.battle_cost_template

	SYSTEM_HP_SHARE_ACT_BOSS = var_1_10007

	local var_1_5 = var_1_4[var_1_10007].oil_cost > 0
	local var_1_6 = {}
	local var_1_7 = 0
	local var_1_8 = 0
	local var_1_9 = 0
	local var_1_10 = 0
	local var_1_11 = var_1_3
	local var_1_12 = var_1_3.getActivityFleets(var_1_11)[var_1_0]

	Fleet = var_1_11

	local var_1_13 = var_1_12[var_1_11.REGULAR_FLEET_ID]

	ipairs = var_14

	for iter_1_0, iter_1_1 in var_14(var_1_13.ships) do
		var_1_6[#var_1_6 + 1] = iter_1_1
	end

	local var_1_14 = var_1_13:getStartCost().oil
	local var_1_15 = var_1_13:GetCostSum().oil
	local var_1_16 = var_1_2:getSortShipsByFleet(var_1_13)
	local var_1_17 = var_1_1:getData()

	if var_1_5 and var_1_17.oil < var_1_15 then
		pg = var_18
		var_1_10019 = var_18.TipsMgr.GetInstance()

		local var_1_18 = var_18.ShowTips

		i18n = var_1_10020

		var_1_18(var_1_10019, var_1_10020("stage_beginStage_error_noResource"))

		return
	end

	local var_1_19 = arg_1_0.stageId

	pg = var_1_10019

	local var_1_20 = var_1_10019.expedition_data_template[var_1_19].dungeon_id

	ys = var_1_10020

	local var_1_21 = var_1_10020.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_20).fleet_prefab

	arg_1_1.ShipVertify()

	local var_1_22

	chapter = var_1_10022

	local var_1_23 = var_1_10022
	local var_1_24 = var_1_10022.getPlayType(var_1_23)

	ChapterConst = var_1_23

	if var_1_24 == var_1_23.TypeExtra then
		var_1_22 = true
	end

	local function var_1_25(arg_2_0)
		if var_1_5 then
			local var_2_0 = var_1_17

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_14
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 and not var_1_22 then
			pg = var_1

			local var_2_2 = var_1.gameset.battle_consume_energy.key_value

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_16) do
				iter_2_1:cosumeEnergy(var_2_2)

				local var_2_3 = var_1_2

				var_7.updateShip(var_2_3, iter_2_1)
			end
		end

		local var_2_4 = var_1_1

		var_1.updatePlayer(var_2_4, var_1_17)

		Fleet = var_1

		local var_2_5 = var_1.REGULAR_FLEET_ID
		local var_2_6 = {
			mainFleetId = var_2_5,
			prefabFleet = var_1_21,
			stageId = var_1_19,
			actId = var_1_0
		}

		SYSTEM_HP_SHARE_ACT_BOSS = var_3
		var_2_6.system = var_3
		var_2_6.token = arg_2_0.key

		local var_2_7 = arg_1_1
		local var_2_8 = var_3.sendNotification

		GAME = iter_2_0

		var_2_8(var_2_7, iter_2_0.BEGIN_STAGE_DONE, var_2_6)

		return
	end

	local function var_1_26(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10024

	local var_1_27 = var_1_10024.SendRequest

	SYSTEM_HP_SHARE_ACT_BOSS = var_1_10025

	var_1_27(var_1_10025, var_1_6, {
		var_1_19
	}, var_1_25, var_1_26)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	client = var_1_10002

	if var_1_10002.CheaterVertify() then
		return
	end

	pg = var_2

	local var_4_0 = var_2.battle_cost_template

	SYSTEM_HP_SHARE_ACT_BOSS = var_1_10003

	local var_4_1 = var_4_0[var_1_10003]

	getProxy = var_1_10003
	FleetProxy = var_1_10004

	local var_4_2 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	ChapterProxy = var_1_10005

	local var_4_3 = var_1_10004(var_1_10005)

	ys = var_1_10005

	local var_4_4 = var_1_10005.Battle.BattleConst.BattleScore.S
	local var_4_5 = 0
	local var_4_6 = 0
	local var_4_7
	local var_4_8 = var_4_2:getActivityFleets()[arg_4_0.actId][arg_4_0.mainFleetId]

	bayProxy = var_1_10012

	local var_4_9 = var_1_10012:getSortShipsByFleet(var_4_8)
	local var_4_10 = var_4_8:getEndCost().oil

	if arg_4_0.statistics.submarineAid then
		local var_4_11 = var_4_2:getActivityFleets()[arg_4_0.actId]

		Fleet = var_1_10015

		if var_4_11[var_1_10015.SUBMARINE_FLEET_ID] then
			bayProxy = var_1_10016

			local var_4_12 = var_1_10016

			var_1_10016 = var_1_10016.getSortShipsByFleet(var_4_12, var_15)
			ipairs = var_4_12

			for iter_4_0, iter_4_1 in var_4_12(var_1_10016) do
				if arg_4_0.statistics[iter_4_1.id] then
					table = var_22

					var_22.insert(var_4_9, iter_4_1)

					var_4_10 = var_4_10 + iter_4_1:getEndBattleExpend()
				end
			end
		else
			originalPrint = var_1_10016

			var_1_10016("finish stage error: can not find submarine fleet.")
		end
	end

	client = var_13

	local var_4_13 = var_13.GeneralPackage(arg_4_0, var_4_9)
	local var_4_14 = {}

	ipairs = var_15

	for iter_4_2, iter_4_3 in var_15(arg_4_0.statistics._enemyInfoList) do
		table = iter_4_0

		iter_4_0.insert(var_4_14, {
			enemy_id = iter_4_3.id,
			damage_taken = iter_4_3.damage,
			total_hp = iter_4_3.totalHp
		})
	end

	var_4_13.enemy_info = var_4_14

	local function var_4_15(arg_5_0)
		client = var_2_10001

		var_2_10001.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics)

		local var_5_0 = arg_4_0.statistics

		var_5_0.mvpShipID = arg_5_0.mvp
		client = var_5_0

		local var_5_1, var_5_2 = var_5_0:GeneralLoot(arg_5_0)
		local var_5_3 = var_4_4

		ys = var_2_10004

		local var_5_4 = var_5_3 > var_2_10004.Battle.BattleConst.BattleScore.C
		local var_5_5 = var_0_0.GeneralPlayerCosume

		SYSTEM_HP_SHARE_ACT_BOSS = var_2_10005

		var_5_5(var_2_10005, var_5_4, var_4_10, arg_5_0.player_exp)

		local var_5_6 = {}

		SYSTEM_HP_SHARE_ACT_BOSS = var_2_10005
		var_5_6.system = var_2_10005
		var_5_6.statistics = arg_4_0.statistics
		var_5_6.score = var_4_4
		var_5_6.drops = var_5_1
		var_5_6.commanderExps = {}
		var_5_6.result = arg_5_0.result
		var_5_6.extraDrops = var_5_2
		client = var_5

		local var_5_7 = var_5
		local var_5_8 = var_5.sendNotification

		GAME = var_7

		var_5_8(var_5_7, var_7.FINISH_STAGE_DONE, var_5_6)

		return
	end

	client = var_16

	var_16:SendRequest(var_4_13, var_4_15)

	return
end

return var_0_0
