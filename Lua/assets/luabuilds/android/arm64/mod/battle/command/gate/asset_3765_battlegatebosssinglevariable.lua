local BattleGateBossSingleVariable = class("BattleGateBossSingleVariable")

ys.Battle.BattleGateBossSingleVariable = BattleGateBossSingleVariable
BattleGateBossSingleVariable.__name = "BattleGateBossSingleVariable"

function BattleGateBossSingleVariable:Entrance(arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = self.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(FleetProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE_VARIABLE]
	local var_1_5 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE_VARIABLE].oil_cost > 0
	local var_1_6 = self.stageId
	local var_1_7 = self.mainFleetId
	local var_1_8 = var_1_2:getActivityFleets()[self.actId][self.mainFleetId]
	local var_1_9 = {}
	local var_1_10 = var_1_3:getSortShipsByFleet(var_1_8)

	for iter_1_0, iter_1_1 in ipairs(var_1_10) do
		var_1_9[#var_1_9 + 1] = iter_1_1.id
	end

	local var_1_12 = var_1_1:getRawData()

	if var_1_5 and math.min(var_1_8:GetCostSum().oil, getProxy(ActivityProxy):getActivityById(self.actId):GetEnemyDataByStageId(self.stageId):GetOilLimit()[1]) > var_1_12.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local var_1_13 = var_1_8:getStartCost().oil

	BeginStageCommand.SendRequest(SYSTEM_BOSS_SINGLE_VARIABLE, var_1_9, {
		self.stageId,
		self.variableBuffList
	}, function(arg_2_0)
		if var_1_5 then
			var_1_12:consume({
				gold = 0,
				oil = var_1_13
			})
		end

		if var_1_4.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_10) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_3:updateShip(iter_2_1)
			end
		end

		var_1_1:updatePlayer(var_1_12)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_7,
			prefabFleet = {},
			stageId = var_1_6,
			system = SYSTEM_BOSS_SINGLE_VARIABLE,
			actId = var_1_0,
			token = arg_2_0.key,
			variableBuffList = self.variableBuffList,
			continuousBattleTimes = self.continuousBattleTimes,
			totalBattleTimes = self.totalBattleTimes,
			useVariableTicket = self.useVariableTicket
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function BattleGateBossSingleVariable:Exit(arg_4_1)
	local var_4_0 = getProxy(BayProxy)
	local var_4_1 = self.statistics._battleScore
	local var_4_2 = getProxy(ActivityProxy)
	local var_4_3 = var_4_2:getActivityById(self.actId)
	local var_4_4 = var_4_3:GetEnemyDataByStageId(self.stageId):GetOilLimit()
	local var_4_5 = getProxy(FleetProxy):getActivityFleets()[self.actId]
	local var_4_6 = var_4_5[self.mainFleetId]
	local var_4_7
	local var_4_8 = 0
	local var_4_9 = {}
	local var_4_10 = {}
	local var_4_11 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE_VARIABLE].oil_cost > 0

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

	var_4_12(var_4_5[self.mainFleetId], var_4_2[1] or 0)

	if self.statistics.submarineAid then
		var_4_7 = var_4_5[self.mainFleetId + Fleet.MEGA_SUBMARINE_FLEET_OFFSET]

		if var_4_5[self.mainFleetId + Fleet.MEGA_SUBMARINE_FLEET_OFFSET] then
			var_4_12(var_4_7, var_4_4[2] or 0)
		else
			originalPrint("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_14 = arg_4_1.GeneralPackage(self, var_4_9)

	var_4_14.commander_id_list = var_4_10
	var_4_14.extra_param = var_4_3.data1 > 0 and self.useVariableTicket == 1 and 1 or 0

	arg_4_1:SendRequest(var_4_14, function(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, self.statistics, true)

		self.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
		local var_6_2 = var_4_1 > ys.Battle.BattleConst.BattleScore.C
		local var_6_3 = arg_4_1.GenerateCommanderExp(arg_6_0, var_4_6, var_4_7)

		arg_4_1.GeneralPlayerCosume(SYSTEM_BOSS_SINGLE_VARIABLE, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_8, arg_6_0.player_exp)

		if var_6_2 then
			local var_6_4 = getProxy(ActivityProxy):getActivityById(self.actId)

			var_6_4:AddPassStage(var_6_4:GetEnemyDataByStageId(self.stageId):GetExpeditionId())
			getProxy(ActivityProxy):updateActivity(var_6_4)

			if self.useVariableTicket == 1 then
				var_6_4.data1 = math.max(var_6_4.data1 - 1, 0)
			end
		end

		local var_6_5 = {
			system = SYSTEM_BOSS_SINGLE_VARIABLE,
			statistics = self.statistics,
			score = var_4_1,
			result = arg_6_0.result,
			drops = var_6_0,
			commanderExps = var_6_3,
			extraDrops = var_6_1
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

			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator) then
				getProxy(ChapterProxy):AddBossSingleRewards(var_6_6)
			end
		end

		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_6_5)

		return
	end)

	return
end

function BattleGateBossSingleVariable:GetPreloadList()
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_3 = ys.Battle.BattleResourceManager.GetInstance()
	local var_7_4 = getProxy(BayProxy)
	local var_7_5 = getProxy(FleetProxy):getActivityFleets()[self.actId]

	if var_7_5[self.mainFleetId] then
		for iter_7_0, iter_7_1 in ipairs(var_7_5[self.mainFleetId].ships) do
			table.insert(var_7_0, var_7_4:getShipById(iter_7_1))
		end

		for iter_7_2, iter_7_3 in ipairs((var_7_5[self.mainFleetId]:buildBattleBuffList())) do
			table.insert(var_7_1, iter_7_3)
		end
	end

	local var_7_6 = var_7_5[self.mainFleetId + Fleet.MEGA_SUBMARINE_FLEET_OFFSET]

	if var_7_5[self.mainFleetId + Fleet.MEGA_SUBMARINE_FLEET_OFFSET] then
		for iter_7_4, iter_7_5 in ipairs((var_7_6:getTeamByName(TeamType.Submarine))) do
			table.insert(var_7_0, var_7_4:getShipById(iter_7_5))
		end

		for iter_7_6, iter_7_7 in ipairs((var_7_6:buildBattleBuffList())) do
			table.insert(var_7_1, iter_7_7)
		end
	end

	local var_7_7, var_7_8 = var_7_3.GetPlayerShipResource(var_7_0, self.system)

	for iter_7_8, iter_7_9 in ipairs((var_7_3.GetResFromBuffIDList(getProxy(ActivityProxy):getActivityById(self.actId):GetBuffIdsByStageId(self.stageId)))) do
		table.insert(var_7_7, iter_7_9)
	end

	local var_7_9 = {}

	for iter_7_10, iter_7_11 in ipairs(self.variableBuffList) do
		table.insert(var_7_9, pg.strategy_data_template[iter_7_11].buff_id)
	end

	for iter_7_12, iter_7_13 in ipairs((var_7_3.GetResFromBuffIDList(var_7_9))) do
		table.insert(var_7_7, iter_7_13)
	end

	for iter_7_14, iter_7_15 in ipairs((var_7_3.GetCommanderBuffRes(var_7_1))) do
		table.insert(var_7_7, iter_7_15)
	end

	return var_7_7, var_7_8
end

return BattleGateBossSingleVariable
