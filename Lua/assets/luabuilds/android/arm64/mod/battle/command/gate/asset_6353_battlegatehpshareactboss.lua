local BattleGateHPShareActBoss = class("BattleGateHPShareActBoss")

ys.Battle.BattleGateHPShareActBoss = BattleGateHPShareActBoss
BattleGateHPShareActBoss.__name = "BattleGateHPShareActBoss"

function BattleGateHPShareActBoss:Entrance(arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = self.actId
	local var_1_1 = getProxy(ActivityProxy):getActivityById(self.actId)
	local var_1_2 = pg.activity_event_worldboss[var_1_1:getConfig("config_id")]
	local var_1_3 = getProxy(PlayerProxy)
	local var_1_4 = getProxy(BayProxy)
	local var_1_5 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS]
	local var_1_6 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS].oil_cost > 0
	local var_1_7 = {}
	local var_1_12 = self.stageId
	local var_1_13 = self.mainFleetId
	local var_1_14 = getProxy(FleetProxy):getActivityFleets()[self.actId][self.mainFleetId]
	local var_1_15 = var_1_4:getSortShipsByFleet(var_1_14)

	for iter_1_0, iter_1_1 in ipairs(var_1_15) do
		var_1_7[#var_1_7 + 1] = iter_1_1.id
	end

	local var_1_16 = var_1_14:getStartCost().oil
	local var_1_17 = var_1_14:GetCostSum().oil

	if var_1_1:IsOilLimit(self.stageId) and var_1_2.use_oil_limit[self.mainFleetId][1] > 0 then
		var_1_17 = math.min(var_1_17, var_1_2.use_oil_limit[self.mainFleetId][1])
	end

	local var_1_18 = var_1_3:getData()
	local var_1_19 = pg.activity_event_worldboss[pg.activity_template[var_1_0].config_id].ticket

	if var_1_3:getRawData():getResource(pg.activity_event_worldboss[pg.activity_template[var_1_0].config_id].ticket) <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noTicket"))

		return
	end

	if var_1_6 and var_1_17 > var_1_18.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_20 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_HP_SHARE_ACT_BOSS, var_1_7, {
		self.stageId
	}, function(arg_2_0)
		local var_2_0

		if var_1_6 then
			var_1_18:consume({
				gold = 0,
				oil = var_1_16
			})

			var_2_0 = {}
		end

		var_2_0[id2res(var_1_19)] = 1

		var_1_18:consume(var_2_0)

		if var_1_5.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_15) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_4:updateShip(iter_2_1)
			end
		end

		var_1_3:updatePlayer(var_1_18)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_13,
			actId = var_1_0,
			prefabFleet = var_1_20,
			stageId = var_1_12,
			system = SYSTEM_HP_SHARE_ACT_BOSS,
			token = arg_2_0.key
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function BattleGateHPShareActBoss:Exit(arg_4_1)
	local var_4_0 = getProxy(BayProxy)
	local var_4_1 = ys.Battle.BattleConst.BattleScore.S

	self.statistics._battleScore = ys.Battle.BattleConst.BattleScore.S

	local var_4_2 = getProxy(ActivityProxy):getActivityById(self.actId)
	local var_4_3 = pg.activity_event_worldboss[var_4_2:getConfig("config_id")].use_oil_limit[self.mainFleetId]
	local var_4_4 = var_4_2:IsOilLimit(self.stageId)
	local var_4_5 = getProxy(FleetProxy):getActivityFleets()[self.actId]
	local var_4_6 = var_4_5[self.mainFleetId]
	local var_4_7
	local var_4_8 = 0
	local var_4_9 = {}
	local var_4_10 = {}
	local var_4_11 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS].oil_cost > 0

	local function var_4_12(arg_5_0, arg_5_1)
		if var_4_11 then
			local var_5_0 = arg_5_0:getEndCost().oil

			if arg_5_1 > 0 then
				var_5_0 = math.clamp(arg_5_1 - arg_5_0:getStartCost().oil, 0, var_5_0)
			end

			var_4_8 = var_4_8 + var_5_0
		end

		table.insertto(var_4_9, var_4_0:getSortShipsByFleet(arg_5_0))
		table.insertto(var_4_10, arg_5_0.commanderIds)

		return
	end

	var_4_12(var_4_5[self.mainFleetId], (var_4_4 or nil) and (var_4_3[1] or 0))

	if self.statistics.submarineAid then
		var_4_7 = var_4_5[self.mainFleetId + 10]

		if var_4_5[self.mainFleetId + 10] then
			var_4_12(var_4_7, (var_4_4 or nil) and (var_4_3[2] or 0))
		else
			originalPrint("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_14 = arg_4_1.GeneralPackage(self, var_4_9)

	var_4_14.commander_id_list = var_4_10

	local var_4_15 = {}

	for iter_4_0, iter_4_1 in ipairs(self.statistics._enemyInfoList) do
		table.insert(var_4_15, {
			enemy_id = iter_4_1.id,
			damage_taken = iter_4_1.damage,
			total_hp = iter_4_1.totalHp
		})
	end

	var_4_14.enemy_info = var_4_15

	arg_4_1:SendRequest(var_4_14, function(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, self.statistics, true)

		self.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
		local var_6_2 = arg_4_1.GenerateCommanderExp(arg_6_0, var_4_6, var_4_7)

		arg_4_1.GeneralPlayerCosume(SYSTEM_HP_SHARE_ACT_BOSS, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_8, arg_6_0.player_exp)
		var_4_2:AddStage(self.stageId)
		getProxy(ActivityProxy):updateActivity(var_4_2)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_HP_SHARE_ACT_BOSS,
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

function BattleGateHPShareActBoss:GetPreloadList()
	local var_7_0, var_7_1 = ys.Battle.BattleGateActBoss.GetPreloadList(self)

	return var_7_0, var_7_1
end

return BattleGateHPShareActBoss
