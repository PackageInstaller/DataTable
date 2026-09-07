local BattleGateBossRushEX = class("BattleGateBossRushEX")

ys.Battle.BattleGateBossRushEX = BattleGateBossRushEX
BattleGateBossRushEX.__name = "BattleGateBossRushEX"

function BattleGateBossRushEX:Entrance(arg_1_1)
	local var_1_0 = self.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(FleetProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = pg.battle_cost_template[SYSTEM_BOSS_RUSH_EX]
	local var_1_5 = pg.battle_cost_template[SYSTEM_BOSS_RUSH_EX].oil_cost > 0
	local var_1_7 = 0
	local var_1_9 = getProxy(ActivityProxy)
	local var_1_10 = var_1_9:getActivityById(self.actId):GetSeriesData()
	local var_1_11 = var_1_10:GetExpeditionIds()[var_1_9]
	local var_1_12, var_1_13 = var_1_10:GetStageFleets(var_1_10:GetMode(), var_1_10:GetStaegLevel() + 1)
	local var_1_16 = {}
	local var_1_17 = var_1_3:getSortShipsByFleet(var_1_2:getActivityFleets()[self.actId][var_1_12])

	for iter_1_0, iter_1_1 in ipairs(var_1_17) do
		var_1_16[#var_1_16 + 1] = iter_1_1.id
	end

	local var_1_18 = var_1_1:getRawData()

	if var_1_5 and 0 > var_1_18.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_BOSS_RUSH_EX, var_1_16, {
		var_1_11
	}, function(arg_2_0)
		if var_1_5 then
			var_1_18:consume({
				gold = 0,
				oil = var_1_7
			})
		end

		if var_1_4.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_17) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_3:updateShip(iter_2_1)
			end
		end

		var_1_1:updatePlayer(var_1_18)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = {},
			stageId = var_1_11,
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

function BattleGateBossRushEX:Exit(arg_4_1)
	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = getProxy(BayProxy)
	local var_4_3 = self.statistics._battleScore
	local var_4_4 = self.statistics._battleScore > ys.Battle.BattleConst.BattleScore.C
	local var_4_6 = {}
	local var_4_7 = {}

	;(function()
		local var_5_0 = getProxy(ActivityProxy):getActivityById(self.actId):GetSeriesData()
		local var_5_1, var_5_2 = var_5_0:GetStageFleets(var_5_0:GetMode(), var_5_0:GetStaegLevel() + 1)
		local var_5_3 = var_4_1:getActivityFleets()[self.actId]

		local function var_5_4(arg_6_0)
			table.insertto(var_4_7, _.values(arg_6_0.commanderIds))
			table.insertto(var_4_6, var_4_2:getSortShipsByFleet(arg_6_0))

			return
		end

		var_5_4(var_5_3[var_5_1])

		if self.statistics.submarineAid then
			var_5_4(var_5_3[var_5_2])
		end

		return
	end)()

	local var_4_8 = arg_4_1.GeneralPackage(self, var_4_6)

	var_4_8.commander_id_list = var_4_7

	local function var_4_9(arg_7_0)
		self.statistics.mvpShipID = arg_7_0.mvp

		local var_7_0 = {
			system = SYSTEM_BOSS_RUSH_EX,
			statistics = self.statistics,
			score = var_4_3,
			result = arg_7_0.result
		}
		local var_7_1 = getProxy(ActivityProxy):getActivityById(self.actId)

		var_7_1:GetSeriesData():PassStage(var_7_0)
		getProxy(ActivityProxy):updateActivity(var_7_1)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_7_0)

		return
	end

	seriesAsync({
		function(arg_8_0)
			if var_4_4 then
				arg_4_1:SendRequest(var_4_8, function(arg_9_0)
					arg_8_0(arg_9_0)

					return
				end)

				return
			end

			arg_8_0({})

			return
		end,
		function(arg_10_0, arg_10_1)
			var_4_9(arg_10_1)

			return
		end
	})

	return
end

function BattleGateBossRushEX:GetPreloadList()
	local var_11_0, var_11_1 = ys.Battle.BattleGateBossRush.GetPreloadList(self)

	return var_11_0, var_11_1
end

return BattleGateBossRushEX
