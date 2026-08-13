class = var_0_10000

local var_0_0 = var_0_10000("BattleGateBossRushEX")

ys = var_0_10001
var_0_10001.Battle.BattleGateBossRushEX = var_0_0
var_0_0.__name = "BattleGateBossRushEX"

function var_0_0.Entrance(arg_1_0, arg_1_1)
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

	SYSTEM_BOSS_RUSH_EX = var_1_10007

	local var_1_5 = var_1_4[var_1_10007].oil_cost > 0
	local var_1_6 = 0
	local var_1_7 = 0
	local var_1_8 = 0
	local var_1_9 = 0

	getProxy = var_1_10012
	ActivityProxy = var_1_10014

	local var_1_10 = var_1_10012(var_1_10014)
	local var_1_11 = var_12.getActivityById(var_1_10, var_1_0)
	local var_1_12 = var_12.GetSeriesData(var_1_11)
	local var_1_13 = var_13.GetStaegLevel(var_1_12) + 1
	local var_1_14 = var_13:GetExpeditionIds()[var_1_13]
	local var_1_15 = var_13:GetMode()
	local var_1_16, var_1_17 = var_13:GetStageFleets(var_1_15, var_1_13)
	local var_1_18 = var_1_2:getActivityFleets()[var_1_0][var_1_16]
	local var_1_19 = var_19[var_1_17]
	local var_1_20 = {}
	local var_1_21 = var_1_3:getSortShipsByFleet(var_1_18)

	ipairs = var_1_10024

	for iter_1_0, iter_1_1 in var_1_10024(var_1_21) do
		var_1_20[#var_1_20 + 1] = iter_1_1.id
	end

	local var_1_22 = var_1_1:getRawData()

	if var_1_5 and var_1_22.oil < var_1_9 then
		pg = var_25
		iter_1_0 = var_25.TipsMgr.GetInstance()

		local var_1_23 = var_25.ShowTips

		i18n = iter_1_1

		var_1_23(iter_1_0, iter_1_1("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local function var_1_24(arg_2_0)
		if var_1_5 then
			local var_2_0 = var_1_22

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_7
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 then
			pg = var_2_1

			local var_2_2 = var_2_1.gameset.battle_consume_energy.key_value

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_21) do
				iter_2_1:cosumeEnergy(var_2_2)

				local var_2_3 = var_1_3

				var_7.updateShip(var_2_3, iter_2_1)
			end
		end

		local var_2_4 = var_1_1

		var_1.updatePlayer(var_2_4, var_1_22)

		local var_2_5 = {
			prefabFleet = {},
			stageId = var_1_14
		}

		SYSTEM_BOSS_RUSH_EX = var_2
		var_2_5.system = var_2
		var_2_5.actId = var_1_0
		var_2_5.token = arg_2_0.key

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

	BeginStageCommand = iter_1_0

	local var_1_26 = iter_1_0.SendRequest

	SYSTEM_BOSS_RUSH_EX = var_1_10029

	var_1_26(var_1_10029, var_1_20, {
		var_1_14
	}, var_1_24, var_1_25)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template

	SYSTEM_BOSS_RUSH_EX = var_1_10003

	local var_4_1 = var_4_0[var_1_10003]

	getProxy = var_1_10003
	FleetProxy = var_1_10005

	local var_4_2 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_4_3 = var_1_10004(var_1_10006)
	local var_4_4 = arg_4_0.statistics._battleScore

	ys = var_1_10006

	local var_4_5 = var_4_4 > var_1_10006.Battle.BattleConst.BattleScore.C
	local var_4_6 = 0
	local var_4_7 = {}
	local var_4_8 = {}

	;(function()
		local var_5_0 = arg_4_0.actId

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_5_1 = var_2_10001(var_2_10003)
		local var_5_2 = var_1.getActivityById(var_5_1, var_5_0)
		local var_5_3 = var_1.GetSeriesData(var_5_2)
		local var_5_4 = var_2.GetStaegLevel(var_5_3) + 1
		local var_5_5 = var_2:GetMode()
		local var_5_6, var_5_7 = var_2:GetStageFleets(var_5_5, var_5_4)
		local var_5_8 = var_4_2
		local var_5_9 = var_7.getActivityFleets(var_5_8)[var_5_0][var_5_6]
		local var_5_10 = var_7[var_5_7]

		;(function(arg_6_0)
			table = var_3_10001

			local var_6_0 = var_3_10001.insertto
			local var_6_1 = var_4_8

			_ = var_3_10004

			var_6_0(var_6_1, var_3_10004.values(arg_6_0.commanderIds))

			table = var_6_0

			local var_6_2 = var_6_0.insertto
			local var_6_3 = var_4_7
			local var_6_4 = var_4_3

			var_6_2(var_6_3, var_4.getSortShipsByFleet(var_6_4, arg_6_0))

			return
		end)(var_5_9)

		if arg_4_0.statistics.submarineAid then
			var_10(var_5_10)
		end

		return
	end)()

	local var_4_9 = arg_4_1.GeneralPackage(arg_4_0, var_4_7)

	var_4_9.commander_id_list = var_4_8

	local function var_4_10(arg_7_0)
		arg_4_0.statistics.mvpShipID = arg_7_0.mvp

		local var_7_0 = {}

		SYSTEM_BOSS_RUSH_EX = var_2
		var_7_0.system = var_2
		var_7_0.statistics = arg_4_0.statistics
		var_7_0.score = var_4_4
		var_7_0.result = arg_7_0.result

		local var_7_1 = arg_4_0.actId

		getProxy = var_2_10003
		ActivityProxy = var_2_10005

		local var_7_2 = var_2_10003(var_2_10005)
		local var_7_3 = var_3.getActivityById(var_7_2, var_7_1)
		local var_7_4 = var_3.GetSeriesData(var_7_3)

		var_4.PassStage(var_7_4, var_7_0)

		getProxy = var_5
		ActivityProxy = var_7_4

		local var_7_5 = var_5(var_7_4)

		var_5.updateActivity(var_7_5, var_3)

		local var_7_6 = arg_4_1
		local var_7_7 = var_5.sendNotification

		GAME = var_8

		var_7_7(var_7_6, var_8.FINISH_STAGE_DONE, var_7_0)

		return
	end

	seriesAsync = var_13

	var_13({
		function(arg_8_0)
			if var_4_5 then
				local var_8_0 = arg_4_1

				var_1.SendRequest(var_8_0, var_4_9, function(arg_9_0)
					arg_8_0(arg_9_0)

					return
				end)

				return
			end

			arg_8_0({})

			return
		end,
		function(arg_10_0, arg_10_1)
			var_4_10(arg_10_1)

			return
		end
	})

	return
end

function var_0_0.GetPreloadList(arg_11_0)
	ys = var_1_10001

	local var_11_0, var_11_1 = var_1_10001.Battle.BattleGateBossRush.GetPreloadList(arg_11_0)

	return var_11_0, var_11_1
end

return var_0_0
