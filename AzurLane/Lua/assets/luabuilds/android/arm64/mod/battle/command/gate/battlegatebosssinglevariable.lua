local var_0_0 = class("BattleGateBossSingleVariable")

ys.Battle.BattleGateBossSingleVariable = var_0_0
var_0_0.__name = "BattleGateBossSingleVariable"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2, var_1_3, var_1_4, var_1_5

	if BeginStageCommand.DockOverload() then
		do return end

		var_1_0 = getProxy(PlayerProxy)
		var_1_1 = getProxy(FleetProxy)
		var_1_2 = getProxy(BayProxy)
		var_1_3 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE_VARIABLE].oil_cost > 0
		var_1_4 = arg_1_0.stageId
		var_1_5 = arg_1_0.mainFleetId
	end

	local var_1_6 = var_1_1:getActivityFleets()[arg_1_0.actId][arg_1_0.mainFleetId]

	for iter_1_0, iter_1_1 in ipairs((var_1_2:getSortShipsByFleet(var_1_6))) do
		({})[#{} + 1] = iter_1_1.id
	end

	local var_1_8 = var_1_0:getRawData()

	if var_1_3 and math.min(var_1_6:GetCostSum().oil, getProxy(ActivityProxy):getActivityById(arg_1_0.actId):GetEnemyDataByStageId(arg_1_0.stageId):GetOilLimit()[1]) > var_1_0:getRawData().oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local var_1_9 = var_1_6:getStartCost().oil

	BeginStageCommand.SendRequest(SYSTEM_BOSS_SINGLE_VARIABLE, {}, {
		arg_1_0.stageId,
		arg_1_0.variableBuffList
	}, function(arg_2_0)
		if var_1_3 then
			var_1_8:consume({
				gold = 0,
				oil = var_1_9
			})
		end

		if var_0.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_2:updateShip(iter_2_1)
			end
		end

		var_1_0:updatePlayer(var_1_8)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_5,
			prefabFleet = {},
			stageId = var_1_4,
			system = SYSTEM_BOSS_SINGLE_VARIABLE,
			actId = var_0,
			token = arg_2_0.key,
			variableBuffList = arg_1_0.variableBuffList,
			continuousBattleTimes = arg_1_0.continuousBattleTimes,
			totalBattleTimes = arg_1_0.totalBattleTimes,
			useVariableTicket = arg_1_0.useVariableTicket
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	local var_4_9000
	local var_4_0 = getProxy(BayProxy)
	local var_4_1 = arg_4_0.statistics._battleScore
	local var_4_2 = getProxy(ActivityProxy)
	local var_4_3 = var_4_2.getActivityById(var_4_9000, arg_4_0.actId)
	local var_4_4 = var_4_3:GetEnemyDataByStageId(arg_4_0.stageId):GetOilLimit()
	local var_4_5 = getProxy(FleetProxy):getActivityFleets()[arg_4_0.actId]
	local var_4_6
	local var_4_7 = 0
	local var_4_8 = {}
	local var_4_9 = {}
	local var_4_10 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE_VARIABLE].oil_cost > 0
	local var_4_12 = var_4_2[1] or 0

	;(function(arg_5_0, arg_5_1)
		if var_4_10 then
			local var_5_0 = arg_5_0:getEndCost().oil

			if arg_5_1 > 0 then
				var_5_0 = math.clamp(arg_5_1 - arg_5_0:getStartCost().oil, 0, var_5_0)
			end

			var_4_7 = var_4_7 + var_5_0
		end

		table.insertto(var_4_8, var_4_0:getSortShipsByFleet(arg_5_0))
		table.insertto(var_4_9, arg_5_0.commanderIds)

		return
	end)(var_4_5[arg_4_0.mainFleetId], var_4_12)

	if arg_4_0.statistics.submarineAid then
		var_4_6 = var_4_5[arg_4_0.mainFleetId + Fleet.MEGA_SUBMARINE_FLEET_OFFSET]

		if var_4_5[arg_4_0.mainFleetId + Fleet.MEGA_SUBMARINE_FLEET_OFFSET] then
			local var_4_13 = var_4_4[2] or 0

			var_4_11(var_4_5[arg_4_0.mainFleetId + Fleet.MEGA_SUBMARINE_FLEET_OFFSET], var_4_13)
		else
			originalPrint("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_14 = arg_4_1.GeneralPackage(arg_4_0, var_4_8)

	var_4_14.commander_id_list = var_4_9
	var_4_14.extra_param = var_4_3.data1 > 0 and arg_4_0.useVariableTicket == 1 and 1 or 0

	arg_4_1:SendRequest(var_4_14, function(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
		local var_6_2 = var_4_1 > ys.Battle.BattleConst.BattleScore.C
		local var_6_3 = arg_4_1.GenerateCommanderExp(arg_6_0, var_0, var_4_6)

		arg_4_1.GeneralPlayerCosume(SYSTEM_BOSS_SINGLE_VARIABLE, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_7, arg_6_0.player_exp)

		if var_6_2 then
			local var_6_4 = getProxy(ActivityProxy):getActivityById(arg_4_0.actId)

			var_6_4:AddPassStage(var_6_4:GetEnemyDataByStageId(arg_4_0.stageId):GetExpeditionId())
			getProxy(ActivityProxy):updateActivity(var_6_4)

			if arg_4_0.useVariableTicket == 1 then
				var_6_4.data1 = math.max(var_6_4.data1 - 1, 0)
			end
		end

		local var_6_5 = {
			system = SYSTEM_BOSS_SINGLE_VARIABLE,
			statistics = arg_4_0.statistics,
			score = var_4_1,
			result = arg_6_0.result,
			drops = var_6_0,
			commanderExps = var_6_3,
			extraDrops = var_6_1
		}

		if PlayerConst.CanDropItem(var_6_0) then
			for iter_6_0, iter_6_1 in ipairs(var_6_0) do
				table.insert({}, iter_6_1)
			end

			for iter_6_2, iter_6_3 in ipairs(var_6_1) do
				iter_6_3.riraty = true

				table.insert({}, iter_6_3)
			end

			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator) then
				getProxy(ChapterProxy):AddBossSingleRewards({})
			end
		end

		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_6_5)

		return
	end)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_1 = ys.Battle.BattleResourceManager.GetInstance()
	local var_7_2 = getProxy(BayProxy)
	local var_7_3 = getProxy(FleetProxy):getActivityFleets()[arg_7_0.actId]

	if var_7_3[arg_7_0.mainFleetId] then
		for iter_7_0, iter_7_1 in ipairs(var_7_3[arg_7_0.mainFleetId].ships) do
			table.insert({}, var_7_2:getShipById(iter_7_1))
		end

		for iter_7_2, iter_7_3 in ipairs((var_7_3[arg_7_0.mainFleetId]:buildBattleBuffList())) do
			table.insert({}, iter_7_3)
		end
	end

	if var_7_3[arg_7_0.mainFleetId + Fleet.MEGA_SUBMARINE_FLEET_OFFSET] then
		for iter_7_4, iter_7_5 in ipairs((var_7_4:getTeamByName(TeamType.Submarine))) do
			table.insert({}, var_7_2:getShipById(iter_7_5))
		end

		for iter_7_6, iter_7_7 in ipairs((var_7_4:buildBattleBuffList())) do
			table.insert({}, iter_7_7)
		end
	end

	local var_7_5, var_7_6 = var_7_1.GetPlayerShipResource({}, arg_7_0.system)

	for iter_7_8, iter_7_9 in ipairs((var_7_1.GetResFromBuffIDList(getProxy(ActivityProxy):getActivityById(arg_7_0.actId):GetBuffIdsByStageId(arg_7_0.stageId)))) do
		table.insert(var_7_5, iter_7_9)
	end

	for iter_7_10, iter_7_11 in ipairs(arg_7_0.variableBuffList) do
		table.insert({}, pg.strategy_data_template[iter_7_11].buff_id)
	end

	for iter_7_12, iter_7_13 in ipairs((var_7_1.GetResFromBuffIDList({}))) do
		table.insert(var_7_5, iter_7_13)
	end

	for iter_7_14, iter_7_15 in ipairs((var_7_1.GetCommanderBuffRes({}))) do
		table.insert(var_7_5, iter_7_15)
	end

	return var_7_5, var_7_6
end

return var_0_0
