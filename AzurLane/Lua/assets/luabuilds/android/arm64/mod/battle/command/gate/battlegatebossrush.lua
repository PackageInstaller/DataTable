class = var_0_10000

local var_0_0 = var_0_10000("BattleGateBossRush")

ys = var_0_10001
var_0_10001.Battle.BattleGateBossRush = var_0_0
var_0_0.__name = "BattleGateBossRush"

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

	SYSTEM_BOSS_RUSH = var_1_10007

	local var_1_5 = var_1_4[var_1_10007].oil_cost
	local var_1_6 = 0 < var_1_5

	getProxy = var_8
	ActivityProxy = var_1_10010

	local var_1_7 = var_8(var_1_10010)
	local var_1_8 = var_8.getActivityById(var_1_7, var_1_0)
	local var_1_9 = var_8.GetSeriesData(var_1_8)
	local var_1_10 = var_9.GetStaegLevel(var_1_9) + 1
	local var_1_11 = var_9:GetExpeditionIds()[var_1_10]
	local var_1_12 = var_9:GetMode()
	local var_1_13, var_1_14 = var_9:GetStageFleets(var_1_12, var_1_10)
	local var_1_15 = var_1_2:getActivityFleets()[var_1_0][var_1_13]
	local var_1_16 = var_15[var_1_14]
	local var_1_17 = {}
	local var_1_18 = var_1_3:getSortShipsByFleet(var_1_15)

	ipairs = var_1_10020

	for iter_1_0, iter_1_1 in var_1_10020(var_1_18) do
		var_1_17[#var_1_17 + 1] = iter_1_1.id
	end

	local var_1_19 = var_1_1:getRawData()
	local var_1_20 = var_1_15:GetCostSum().oil

	if var_1_6 and var_1_19.oil < var_1_20 then
		pg = var_22

		local var_1_21 = var_22.TipsMgr.GetInstance()
		local var_1_22 = var_22.ShowTips

		i18n = var_1_10025

		var_1_22(var_1_21, var_1_10025("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local var_1_23 = var_1_15:getStartCost().oil

	local function var_1_24(arg_2_0)
		if var_1_6 then
			local var_2_0 = var_1_19

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

			for iter_2_0, iter_2_1 in var_2(var_1_18) do
				iter_2_1:cosumeEnergy(var_2_2)

				local var_2_3 = var_1_3

				var_7.updateShip(var_2_3, iter_2_1)
			end
		end

		local var_2_4 = var_1_1

		var_1.updatePlayer(var_2_4, var_1_19)

		local var_2_5 = {
			prefabFleet = {},
			stageId = var_1_11
		}

		SYSTEM_BOSS_RUSH = var_2
		var_2_5.system = var_2
		var_2_5.actId = var_1_0
		var_2_5.token = arg_2_0.key
		var_2_5.continuousBattleTimes = arg_1_0.continuousBattleTimes
		var_2_5.totalBattleTimes = arg_1_0.totalBattleTimes
		var_2_5.curIndex = arg_1_0.curIndex
		var_2_5.maxIndex = arg_1_0.maxIndex

		if arg_1_0.curIndex then
			local var_2_6 = arg_1_1
			local var_2_7 = var_2.sendNotification

			GAME = iter_2_0

			var_2_7(var_2_6, iter_2_0.CONTINUE_STAGE_DONE, var_2_5)
		else
			local var_2_8 = arg_1_1
			local var_2_9 = var_2.sendNotification

			GAME = iter_2_0

			var_2_9(var_2_8, iter_2_0.BEGIN_STAGE_DONE, var_2_5)
		end

		return
	end

	local function var_1_25(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10025

	local var_1_26 = var_1_10025.SendRequest

	SYSTEM_BOSS_RUSH = var_1_10027

	var_1_26(var_1_10027, var_1_17, {
		var_1_11
	}, var_1_24, var_1_25)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.battle_cost_template

	SYSTEM_BOSS_RUSH = var_1_10003

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
	local var_4_7 = {}
	local var_4_8 = false

	;(function()
		local var_5_0 = arg_4_0.actId

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_5_1 = var_2_10001(var_2_10003)
		local var_5_2 = var_1.getActivityById(var_5_1, var_5_0)

		if not var_1.GetSeriesData(var_5_2) then
			var_4_8 = true

			return
		end

		local var_5_3 = var_2:GetStaegLevel() + 1
		local var_5_4 = var_2:GetMode()
		local var_5_5, var_5_6 = var_2:GetStageFleets(var_5_4, var_5_3)
		local var_5_7 = var_4_2
		local var_5_8 = var_7.getActivityFleets(var_5_7)[var_5_0][var_5_5]
		local var_5_9 = var_7[var_5_6]

		;(function(arg_6_0)
			table = var_3_10001

			local var_6_0 = var_3_10001.insertto
			local var_6_1 = var_4_7

			_ = var_3_10004

			var_6_0(var_6_1, var_3_10004.values(arg_6_0.commanderIds))

			table = var_6_0

			local var_6_2 = var_6_0.insertto
			local var_6_3 = var_4_6
			local var_6_4 = var_4_3

			var_6_2(var_6_3, var_4.getSortShipsByFleet(var_6_4, arg_6_0))

			return
		end)(var_5_8)

		if arg_4_0.statistics.submarineAid then
			var_10(var_5_9)
		end

		return
	end)()

	if var_4_8 then
		local var_4_9 = arg_4_1
		local var_4_10 = arg_4_1.sendNotification

		GAME = var_1_10014

		var_4_10(var_4_9, var_1_10014.FINISH_STAGE_ERROR)

		return
	end

	local var_4_11 = arg_4_1.GeneralPackage(arg_4_0, var_4_6)

	var_4_11.commander_id_list = var_4_7

	local function var_4_12(arg_7_0)
		arg_4_0.statistics.mvpShipID = arg_7_0.mvp

		local var_7_0 = {}

		SYSTEM_BOSS_RUSH = var_2
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

	arg_4_1:SendRequest(var_4_11, var_4_12)

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

	getProxy = var_1_10007
	ActivityProxy = var_1_10009

	local var_8_6 = var_1_10007(var_1_10009)
	local var_8_7 = var_7.getActivityById(var_8_6, arg_8_0.actId)
	local var_8_8 = var_7.GetSeriesData(var_8_7)
	local var_8_9 = var_8.GetStaegLevel(var_8_8) + 1
	local var_8_10 = var_8:GetFleetIds()
	local var_8_11 = var_8:GetMode()
	local var_8_12, var_8_13 = var_8:GetStageFleets(var_8_11, var_8_9)
	local var_8_14 = var_8_4:getActivityFleets()[arg_8_0.actId][var_8_12]
	local var_8_15 = var_14[var_8_13]

	if var_8_14 then
		local var_8_16 = var_8_14:GetRawShipIds()

		ipairs = var_1_10018

		for iter_8_0, iter_8_1 in var_1_10018(var_8_16) do
			table = var_1_10023

			var_1_10023.insert(var_8_0, var_8_5:getShipById(iter_8_1))
		end

		var_8_1 = var_8_14:buildBattleBuffList()
	end

	if var_8_15 then
		local var_8_17 = var_8_15:GetRawShipIds()

		ipairs = var_1_10018

		for iter_8_2, iter_8_3 in var_1_10018(var_8_17) do
			table = var_1_10023

			var_1_10023.insert(var_8_0, var_8_5:getShipById(iter_8_3))
		end

		ipairs = var_18

		for iter_8_4, iter_8_5 in var_18(var_8_15:buildBattleBuffList()) do
			table = var_1_10023

			var_1_10023.insert(var_8_1, iter_8_5)
		end
	end

	local var_8_18, var_8_19 = var_8_3.GetPlayerShipResource(var_8_0, arg_8_0.system)
	local var_8_20 = var_8_3.GetCommanderBuffRes(var_8_1)

	ipairs = var_19

	for iter_8_6, iter_8_7 in var_19(var_8_20) do
		table = var_1_10024

		var_1_10024.insert(var_8_18, iter_8_7)
	end

	return var_8_18, var_8_19
end

return var_0_0
