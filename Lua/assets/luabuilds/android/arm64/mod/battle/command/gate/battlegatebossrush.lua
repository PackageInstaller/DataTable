local var_0_0 = class("BattleGateBossRush")

ys.Battle.BattleGateBossRush = var_0_0
var_0_0.__name = "BattleGateBossRush"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = arg_1_0.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(FleetProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = pg.battle_cost_template[SYSTEM_BOSS_RUSH].oil_cost > 0
	local var_1_5 = getProxy(ActivityProxy)
	local var_1_6 = var_1_5.getActivityById(var_1_9000, arg_1_0.actId):GetSeriesData()
	local var_1_7 = var_1_6:GetExpeditionIds()[var_1_5]
	local var_1_8, var_1_9 = var_1_6:GetStageFleets(var_1_6:GetMode(), var_1_6:GetStaegLevel() + 1)
	local var_1_10 = var_1_2:getActivityFleets()[arg_1_0.actId]

	for iter_1_0, iter_1_1 in ipairs((var_1_3:getSortShipsByFleet(var_1_10[var_1_8]))) do
		({})[#{} + 1] = iter_1_1.id
	end

	local var_1_12 = var_1_1:getRawData()

	if var_1_4 and var_1_10[var_1_8]:GetCostSum().oil > var_1_1:getRawData().oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local var_1_13 = var_1_10[var_1_8]:getStartCost().oil

	BeginStageCommand.SendRequest(SYSTEM_BOSS_RUSH, {}, {
		var_1_6:GetExpeditionIds()[var_1_5]
	}, function(arg_2_0)
		if var_1_4 then
			var_1_12:consume({
				gold = 0,
				oil = var_1_13
			})
		end

		if var_0.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_3:updateShip(iter_2_1)
			end
		end

		var_1_1:updatePlayer(var_1_12)

		if arg_1_0.curIndex then
			arg_1_1:sendNotification(GAME.CONTINUE_STAGE_DONE, {
				prefabFleet = {},
				stageId = var_1_7,
				system = SYSTEM_BOSS_RUSH,
				actId = var_1_0,
				token = arg_2_0.key,
				continuousBattleTimes = arg_1_0.continuousBattleTimes,
				totalBattleTimes = arg_1_0.totalBattleTimes,
				curIndex = arg_1_0.curIndex,
				maxIndex = arg_1_0.maxIndex
			})
		else
			arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
				prefabFleet = {},
				stageId = var_1_7,
				system = SYSTEM_BOSS_RUSH,
				actId = var_1_0,
				token = arg_2_0.key,
				continuousBattleTimes = arg_1_0.continuousBattleTimes,
				totalBattleTimes = arg_1_0.totalBattleTimes,
				curIndex = arg_1_0.curIndex,
				maxIndex = arg_1_0.maxIndex
			})
		end

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = getProxy(BayProxy)
	local var_4_3 = arg_4_0.statistics._battleScore
	local var_4_5 = {}
	local var_4_6 = {}
	local var_4_7 = false

	;(function()
		local var_5_0 = getProxy(ActivityProxy):getActivityById(arg_4_0.actId):GetSeriesData()

		if not var_5_0 then
			var_4_7 = true

			return
		end

		local var_5_1, var_5_2 = var_5_0:GetStageFleets(var_5_0:GetMode(), var_5_0:GetStaegLevel() + 1)
		local var_5_3 = var_4_1:getActivityFleets()[arg_4_0.actId]

		;(function(arg_6_0)
			table.insertto(var_4_6, _.values(arg_6_0.commanderIds))
			table.insertto(var_4_5, var_4_2:getSortShipsByFleet(arg_6_0))

			return
		end)(var_5_3[var_5_1])

		if arg_4_0.statistics.submarineAid then
			(function(arg_6_0)
				table.insertto(var_4_6, _.values(arg_6_0.commanderIds))
				table.insertto(var_4_5, var_4_2:getSortShipsByFleet(arg_6_0))

				return
			end)(var_5_3[var_5_2])
		end

		return
	end)()

	if false then
		arg_4_1:sendNotification(GAME.FINISH_STAGE_ERROR)

		return
	end

	local var_4_8 = arg_4_1.GeneralPackage(arg_4_0, {})

	var_4_8.commander_id_list = {}

	arg_4_1:SendRequest(var_4_8, function(arg_7_0)
		arg_4_0.statistics.mvpShipID = arg_7_0.mvp

		local var_7_0 = getProxy(ActivityProxy):getActivityById(arg_4_0.actId)

		var_7_0:GetSeriesData():PassStage({
			system = SYSTEM_BOSS_RUSH,
			statistics = arg_4_0.statistics,
			score = var_4_3,
			result = arg_7_0.result
		})
		getProxy(ActivityProxy):updateActivity(var_7_0)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_BOSS_RUSH,
			statistics = arg_4_0.statistics,
			score = var_4_3,
			result = arg_7_0.result
		})

		return
	end)

	return
end

function var_0_0.GetPreloadList(arg_8_0)
	local var_8_0 = {}
	local var_8_2 = ys.Battle.BattleResourceManager.GetInstance()
	local var_8_3 = getProxy(BayProxy)
	local var_8_4 = getProxy(ActivityProxy):getActivityById(arg_8_0.actId):GetSeriesData()
	local var_8_5 = var_8_4:GetFleetIds()
	local var_8_6, var_8_7 = var_8_4:GetStageFleets(var_8_4:GetMode(), var_8_4:GetStaegLevel() + 1)
	local var_8_8 = getProxy(FleetProxy):getActivityFleets()[arg_8_0.actId]

	if var_8_8[var_8_6] then
		for iter_8_0, iter_8_1 in ipairs((var_8_8[var_8_6]:GetRawShipIds())) do
			table.insert({}, var_8_3:getShipById(iter_8_1))
		end

		var_8_0 = var_8_8[var_8_6]:buildBattleBuffList()
	end

	if var_8_8[var_8_7] then
		for iter_8_2, iter_8_3 in ipairs((var_8_8[var_8_7]:GetRawShipIds())) do
			table.insert({}, var_8_3:getShipById(iter_8_3))
		end

		for iter_8_4, iter_8_5 in ipairs(var_8_8[var_8_7]:buildBattleBuffList()) do
			table.insert(var_8_0, iter_8_5)
		end
	end

	local var_8_9, var_8_10 = var_8_2.GetPlayerShipResource({}, arg_8_0.system)

	for iter_8_6, iter_8_7 in ipairs((var_8_2.GetCommanderBuffRes(var_8_0))) do
		table.insert(var_8_9, iter_8_7)
	end

	return var_8_9, var_8_10
end

return var_0_0
