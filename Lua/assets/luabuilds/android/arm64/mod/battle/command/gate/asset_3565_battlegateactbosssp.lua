local BattleGateActBossSP = class("BattleGateActBossSP")

ys.Battle.BattleGateActBossSP = BattleGateActBossSP
BattleGateActBossSP.__name = "BattleGateActBossSP"
BattleGateActBossSP.BattleSystem = SYSTEM_ACT_BOSS_SP

function BattleGateActBossSP:Entrance(arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = self.actId
	local var_1_1 = getProxy(ActivityProxy):getActivityById(self.actId)
	local var_1_2 = getProxy(PlayerProxy)
	local var_1_3 = var_1_2:getData()
	local var_1_4 = getProxy(BayProxy)
	local var_1_5 = getProxy(ActivityProxy):GetActivityBossRuntime(self.actId).buffIds
	local var_1_6 = self.stageId
	local var_1_7 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab
	local var_1_8 = self.mainFleetId
	local var_1_9 = getProxy(FleetProxy):getActivityFleets()[self.actId][self.mainFleetId]
	local var_1_10 = {}
	local var_1_11 = var_1_4:getSortShipsByFleet(var_1_9)

	for iter_1_0, iter_1_1 in ipairs(var_1_11) do
		var_1_10[#var_1_10 + 1] = iter_1_1.id
	end

	local var_1_12 = pg.battle_cost_template[BattleGateActBossSP.BattleSystem]
	local var_1_13 = pg.battle_cost_template[BattleGateActBossSP.BattleSystem].oil_cost > 0
	local var_1_14 = 0
	local var_1_15 = 0

	if pg.battle_cost_template[BattleGateActBossSP.BattleSystem].oil_cost > 0 then
		var_1_14 = var_1_9:getStartCost().oil
		var_1_15 = var_1_9:GetCostSum().oil
	end

	if var_1_15 > var_1_3.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(BattleGateActBossSP.BattleSystem, var_1_10, {
		var_1_6,
		var_1_5
	}, function(arg_2_0)
		if var_1_13 then
			var_1_3:consume({
				gold = 0,
				oil = var_1_14
			})
		end

		if var_1_12.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_11) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_4:updateShip(iter_2_1)
			end
		end

		var_1_2:updatePlayer(var_1_3)

		var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0)

		var_1_1:UpdateHistoryBuffs(var_1_5)
		getProxy(ActivityProxy):updateActivity(var_1_1)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_8,
			actId = var_1_0,
			prefabFleet = var_1_7,
			stageId = var_1_6,
			system = BattleGateActBossSP.BattleSystem,
			token = arg_2_0.key
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function BattleGateActBossSP:Exit(arg_4_1)
	local var_4_0 = getProxy(BayProxy)
	local var_4_1 = self.statistics._battleScore
	local var_4_2 = pg.activity_event_worldboss[getProxy(ActivityProxy):getActivityById(self.actId):getConfig("config_id")]
	local var_4_3 = getProxy(FleetProxy):getActivityFleets()[self.actId]
	local var_4_4 = var_4_3[self.mainFleetId]
	local var_4_6 = 0
	local var_4_7 = {}
	local var_4_8 = {}
	local var_4_9 = pg.battle_cost_template[BattleGateActBossSP.BattleSystem].oil_cost > 0

	local function var_4_10(arg_5_0, arg_5_1)
		if var_4_9 then
			local var_5_0 = arg_5_0:getEndCost().oil

			if arg_5_1 > 0 then
				var_5_0 = math.clamp(arg_5_1 - arg_5_0:getStartCost().oil, 0, var_5_0)
			end

			var_4_6 = var_4_6 + var_5_0
		end

		table.insertto(var_4_7, var_4_0:getSortShipsByFleet(arg_5_0))
		table.insertto(var_4_8, arg_5_0.commanderIds)

		return
	end

	var_4_10(var_4_3[self.mainFleetId], 0)

	if self.statistics.submarineAid then
		if var_4_3[self.mainFleetId + 10] then
			var_4_10(var_4_3[self.mainFleetId + 10], 0)
		else
			originalPrint("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_11 = arg_4_1.GeneralPackage(self, var_4_7)

	var_4_11.commander_id_list = var_4_8

	arg_4_1:SendRequest(var_4_11, function(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, self.statistics, true)

		self.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
		local var_6_2 = arg_4_1.GenerateCommanderExp(arg_6_0, var_4_4, var_4_3[self.mainFleetId + 10])

		arg_4_1.GeneralPlayerCosume(BattleGateActBossSP.BattleSystem, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_6, arg_6_0.player_exp)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = BattleGateActBossSP.BattleSystem,
			statistics = self.statistics,
			score = var_4_1,
			drops = var_6_0,
			commanderExps = var_6_2,
			result = arg_6_0.result,
			extraDrops = var_6_1
		})

		return
	end)

	return
end

function BattleGateActBossSP:GetPreloadList()
	local var_7_0, var_7_1 = ys.Battle.BattleGateActBoss.GetPreloadList(self)

	for iter_7_0, iter_7_1 in ipairs((ys.Battle.BattleResourceManager.GetInstance().GetResFromBuffIDList((_.map(getProxy(ActivityProxy):GetActivityBossRuntime(self.actId).buffIds, function(arg_8_0)
		return ActivityBossBuff.New({
			configId = arg_8_0
		}):GetBuffID()
	end))))) do
		table.insert(var_7_0, iter_7_1)
	end

	return var_7_0, var_7_1
end

return BattleGateActBossSP
