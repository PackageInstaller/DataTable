local BattleGateBossRushCollabrate = class("BattleGateBossRushCollabrate")

ys.Battle.BattleGateBossRushCollabrate = BattleGateBossRushCollabrate
BattleGateBossRushCollabrate.__name = "BattleGateBossRushCollabrate"

function BattleGateBossRushCollabrate:Entrance(arg_1_1)
	local var_1_0 = self.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(FleetProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = pg.battle_cost_template[SYSTEM_BOSS_RUSH_COLLABRATE]
	local var_1_5 = pg.battle_cost_template[SYSTEM_BOSS_RUSH_COLLABRATE].oil_cost > 0
	local var_1_6 = getProxy(ActivityProxy)
	local var_1_7 = var_1_6:getActivityById(self.actId):GetSeriesData()
	local var_1_8 = var_1_7:GetExpeditionIds()[var_1_6]
	local var_1_9, var_1_10 = var_1_7:GetStageFleets(var_1_7:GetMode(), var_1_7:GetStaegLevel() + 1)
	local var_1_13 = {}
	local var_1_14 = var_1_3:getSortShipsByFleet(var_1_2:getActivityFleets()[self.actId][var_1_9])

	for iter_1_0, iter_1_1 in ipairs(var_1_14) do
		var_1_13[#var_1_13 + 1] = iter_1_1.id
	end

	local var_1_15 = var_1_1:getRawData()

	if var_1_5 and var_1_2:getActivityFleets()[self.actId][var_1_9]:GetCostSum().oil > var_1_15.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local var_1_16 = var_1_2:getActivityFleets()[self.actId][var_1_9]:getStartCost().oil

	BeginStageCommand.SendRequest(SYSTEM_BOSS_RUSH_COLLABRATE, var_1_13, {
		var_1_8
	}, function(arg_2_0)
		if var_1_5 then
			var_1_15:consume({
				gold = 0,
				oil = var_1_16
			})
		end

		if var_1_4.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_14) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_3:updateShip(iter_2_1)
			end
		end

		var_1_1:updatePlayer(var_1_15)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = {},
			stageId = var_1_8,
			system = SYSTEM_BOSS_RUSH_COLLABRATE,
			actId = var_1_0,
			token = arg_2_0.key,
			continuousBattleTimes = self.continuousBattleTimes,
			totalBattleTimes = self.totalBattleTimes
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function BattleGateBossRushCollabrate:Exit(arg_4_1)
	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = getProxy(BayProxy)
	local var_4_3 = self.statistics._battleScore
	local var_4_5 = {}
	local var_4_6 = {}
	local var_4_7 = false

	;(function()
		local var_5_0 = getProxy(ActivityProxy):getActivityById(self.actId):GetSeriesData()

		if not var_5_0 then
			var_4_7 = true

			return
		end

		local var_5_1, var_5_2 = var_5_0:GetStageFleets(var_5_0:GetMode(), var_5_0:GetStaegLevel() + 1)
		local var_5_3 = var_4_1:getActivityFleets()[self.actId]

		local function var_5_4(arg_6_0)
			table.insertto(var_4_6, _.values(arg_6_0.commanderIds))
			table.insertto(var_4_5, var_4_2:getSortShipsByFleet(arg_6_0))

			return
		end

		var_5_4(var_5_3[var_5_1])

		if self.statistics.submarineAid then
			var_5_4(var_5_3[var_5_2])
		end

		return
	end)()

	local var_4_8 = arg_4_1.GeneralPackage(self, var_4_5)

	var_4_8.commander_id_list = var_4_6

	arg_4_1:SendRequest(var_4_8, function(arg_7_0)
		self.statistics.mvpShipID = arg_7_0.mvp

		local var_7_0 = {
			system = SYSTEM_BOSS_RUSH_COLLABRATE,
			statistics = self.statistics,
			score = var_4_3,
			result = arg_7_0.result
		}
		local var_7_1 = getProxy(ActivityProxy):getActivityById(self.actId)

		var_7_1:GetSeriesData():PassStage(var_7_0)
		getProxy(ActivityProxy):updateActivity(var_7_1)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_7_0)

		return
	end)

	return
end

function BattleGateBossRushCollabrate:GetPreloadList()
	local var_8_0, var_8_1 = ys.Battle.BattleGateBossRush.GetPreloadList(self)
	local var_8_2 = getProxy(ActivityProxy)
	local var_8_3 = var_8_2:getActivityById(self.actId):GetSeriesData()

	if var_8_3:GetBossHpRate() <= var_8_2[1] then
		t = resMgr.GetResFromBuffIDList({
			var_8_3:getConfig("aid_buff")[2]
		})

		for iter_8_0, iter_8_1 in ipairs(t) do
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0, var_8_1
end

return BattleGateBossRushCollabrate
