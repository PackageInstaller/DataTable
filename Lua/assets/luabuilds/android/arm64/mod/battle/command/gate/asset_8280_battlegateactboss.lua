local BattleGateActBoss = class("BattleGateActBoss")

ys.Battle.BattleGateActBoss = BattleGateActBoss
BattleGateActBoss.__name = "BattleGateActBoss"

function BattleGateActBoss:Entrance(arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = self.continuousBattleTimes
	local var_1_1 = self.totalBattleTimes
	local var_1_2 = self.actId
	local var_1_3 = getProxy(ActivityProxy):getActivityById(self.actId)
	local var_1_4 = pg.activity_event_worldboss[var_1_3:getConfig("config_id")]
	local var_1_5 = getProxy(PlayerProxy)
	local var_1_6 = getProxy(BayProxy)
	local var_1_7 = pg.battle_cost_template[SYSTEM_ACT_BOSS]
	local var_1_8 = pg.battle_cost_template[SYSTEM_ACT_BOSS].oil_cost > 0
	local var_1_9 = {}
	local var_1_14 = self.stageId
	local var_1_15 = self.mainFleetId
	local var_1_16 = getProxy(FleetProxy):getActivityFleets()[self.actId][self.mainFleetId]
	local var_1_17 = var_1_6:getSortShipsByFleet(var_1_16)

	for iter_1_0, iter_1_1 in ipairs(var_1_17) do
		var_1_9[#var_1_9 + 1] = iter_1_1.id
	end

	local var_1_18 = var_1_16:getStartCost().oil
	local var_1_19 = var_1_16:GetCostSum().oil

	if var_1_3:IsOilLimit(self.stageId) and var_1_4.use_oil_limit[self.mainFleetId][1] > 0 then
		var_1_19 = math.min(var_1_19, var_1_4.use_oil_limit[self.mainFleetId][1])
	end

	local var_1_20 = var_1_5:getData()

	if var_1_8 and var_1_19 > var_1_20.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_21 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_ACT_BOSS, var_1_9, {
		self.stageId
	}, function(arg_2_0)
		if var_1_8 then
			var_1_20:consume({
				gold = 0,
				oil = var_1_18
			})
		end

		if var_1_7.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_17) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_6:updateShip(iter_2_1)
			end
		end

		var_1_5:updatePlayer(var_1_20)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_15,
			actId = var_1_2,
			prefabFleet = var_1_21,
			stageId = var_1_14,
			system = SYSTEM_ACT_BOSS,
			token = arg_2_0.key,
			continuousBattleTimes = var_1_0,
			totalBattleTimes = var_1_1
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function BattleGateActBoss:Exit(arg_4_1)
	local var_4_0 = getProxy(BayProxy)
	local var_4_1 = self.statistics._battleScore
	local var_4_2 = getProxy(ActivityProxy):getActivityById(self.actId)
	local var_4_3 = pg.activity_event_worldboss[var_4_2:getConfig("config_id")].use_oil_limit[self.mainFleetId]
	local var_4_4 = var_4_2:IsOilLimit(self.stageId)
	local var_4_5 = getProxy(FleetProxy):getActivityFleets()[self.actId]
	local var_4_6 = var_4_5[self.mainFleetId]
	local var_4_7
	local var_4_8 = 0
	local var_4_9 = {}
	local var_4_10 = {}
	local var_4_11 = pg.battle_cost_template[SYSTEM_ACT_BOSS].oil_cost > 0

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

	arg_4_1:SendRequest(var_4_14, function(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, self.statistics, true)

		self.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
		local var_6_2 = var_4_1 > ys.Battle.BattleConst.BattleScore.C
		local var_6_3 = arg_4_1.GenerateCommanderExp(arg_6_0, var_4_6, var_4_7)

		arg_4_1.GeneralPlayerCosume(SYSTEM_ACT_BOSS, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_8, arg_6_0.player_exp)

		local var_6_4

		if var_6_2 then
			var_6_4 = (function()
				local var_7_0 = getProxy(ActivityProxy):getActivityById(self.actId)

				return var_7_0.data1KeyValueList[1][self.stageId] == 1 and var_7_0.data1KeyValueList[2][self.stageId] <= 0
			end)()

			arg_4_1:sendNotification(GAME.ACT_BOSS_NORMAL_UPDATE, {
				stageId = self.stageId
			})
		end

		local var_6_5 = {
			system = SYSTEM_ACT_BOSS,
			statistics = self.statistics,
			score = var_4_1,
			drops = var_6_0,
			commanderExps = var_6_3,
			result = arg_6_0.result,
			extraDrops = var_6_1,
			isLastBonus = var_6_4
		}

		if PlayerConst.CanDropItem(var_6_0) then
			local var_6_6 = {}

			for iter_6_0, iter_6_1 in ipairs(var_6_0) do
				table.insert(var_6_6, iter_6_1)
			end

			for iter_6_2, iter_6_3 in ipairs(var_6_1) do
				iter_6_3.riraty = true

				table.insert(var_6_6, iter_6_3)
			end

			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
				getProxy(ChapterProxy):AddActBossRewards(var_6_6)
			end
		end

		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_6_5)

		return
	end)

	return
end

function BattleGateActBoss:GetPreloadList()
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_3 = ys.Battle.BattleResourceManager.GetInstance()
	local var_8_4 = getProxy(BayProxy)
	local var_8_5 = getProxy(FleetProxy):getActivityFleets()[self.actId]

	if var_8_5[self.mainFleetId] then
		for iter_8_0, iter_8_1 in ipairs(var_8_5[self.mainFleetId].ships) do
			table.insert(var_8_0, var_8_4:getShipById(iter_8_1))
		end

		for iter_8_2, iter_8_3 in ipairs((var_8_5[self.mainFleetId]:buildBattleBuffList())) do
			table.insert(var_8_1, iter_8_3)
		end
	end

	local var_8_6 = var_8_5[self.mainFleetId + 10]

	if var_8_5[self.mainFleetId + 10] then
		for iter_8_4, iter_8_5 in ipairs((var_8_6:getTeamByName(TeamType.Submarine))) do
			table.insert(var_8_0, var_8_4:getShipById(iter_8_5))
		end

		for iter_8_6, iter_8_7 in ipairs((var_8_6:buildBattleBuffList())) do
			table.insert(var_8_1, iter_8_7)
		end
	end

	local var_8_7, var_8_8 = var_8_3.GetPlayerShipResource(var_8_0, self.system)

	for iter_8_8, iter_8_9 in ipairs((var_8_3.GetCommanderBuffRes(var_8_1))) do
		table.insert(var_8_7, iter_8_9)
	end

	return var_8_7, var_8_8
end

return BattleGateActBoss
