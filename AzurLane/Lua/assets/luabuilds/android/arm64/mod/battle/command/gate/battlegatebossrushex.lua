local var_0_0 = class("BattleGateBossRushEX")

ys.Battle.BattleGateBossRushEX = var_0_0
var_0_0.__name = "BattleGateBossRushEX"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = arg_1_0.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(FleetProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = pg.battle_cost_template[SYSTEM_BOSS_RUSH_EX].oil_cost > 0
	local var_1_6 = 0
	local var_1_8 = getProxy(ActivityProxy)
	local var_1_9 = var_1_8.getActivityById(var_1_9000, arg_1_0.actId):GetSeriesData()
	local var_1_10 = var_1_9:GetExpeditionIds()[var_1_8]
	local var_1_11, var_1_12 = var_1_9:GetStageFleets(var_1_9:GetMode(), var_1_9:GetStaegLevel() + 1)
	local var_1_13 = var_1_2:getActivityFleets()[arg_1_0.actId]

	for iter_1_0, iter_1_1 in ipairs((var_1_3:getSortShipsByFleet(var_1_13[var_1_11]))) do
		({})[#{} + 1] = iter_1_1.id
	end

	local var_1_15 = var_1_1:getRawData()

	if var_1_4 and 0 > var_1_1:getRawData().oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_BOSS_RUSH_EX, {}, {
		var_1_9:GetExpeditionIds()[var_1_8]
	}, function(arg_2_0)
		if var_1_4 then
			var_1_15:consume({
				gold = 0,
				oil = var_1_6
			})
		end

		if var_0.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_3:updateShip(iter_2_1)
			end
		end

		var_1_1:updatePlayer(var_1_15)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = {},
			stageId = var_1_10,
			system = SYSTEM_BOSS_RUSH_EX,
			actId = var_1_0,
			token = arg_2_0.key
		})

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
	local var_4_3 = arg_4_0.statistics._battleScore > ys.Battle.BattleConst.BattleScore.C
	local var_4_5 = {}
	local var_4_6 = {}

	;(function()
		local var_5_0 = getProxy(ActivityProxy):getActivityById(arg_4_0.actId):GetSeriesData()
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

	local var_4_7 = arg_4_1.GeneralPackage(arg_4_0, {})

	arg_4_1.GeneralPackage(arg_4_0, {}).commander_id_list = {}

	local function var_4_8(arg_7_0)
		arg_4_0.statistics.mvpShipID = arg_7_0.mvp

		local var_7_0 = getProxy(ActivityProxy):getActivityById(arg_4_0.actId)

		var_7_0:GetSeriesData():PassStage({
			system = SYSTEM_BOSS_RUSH_EX,
			statistics = arg_4_0.statistics,
			score = var_0,
			result = arg_7_0.result
		})
		getProxy(ActivityProxy):updateActivity(var_7_0)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_BOSS_RUSH_EX,
			statistics = arg_4_0.statistics,
			score = var_0,
			result = arg_7_0.result
		})

		return
	end

	seriesAsync({
		function(arg_8_0)
			if var_4_3 then
				arg_4_1:SendRequest(var_4_7, function(arg_9_0)
					arg_8_0(arg_9_0)

					return
				end)

				return
			end

			arg_8_0({})

			return
		end,
		function(arg_10_0, arg_10_1)
			var_4_8(arg_10_1)

			return
		end
	})

	return
end

function var_0_0.GetPreloadList(arg_11_0)
	local var_11_0, var_11_1 = ys.Battle.BattleGateBossRush.GetPreloadList(arg_11_0)

	return var_11_0, var_11_1
end

return var_0_0
