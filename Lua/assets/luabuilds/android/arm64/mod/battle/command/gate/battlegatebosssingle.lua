local var_0_0 = class("BattleGateBossSingle")

ys.Battle.BattleGateBossSingle = var_0_0
var_0_0.__name = "BattleGateBossSingle"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2, var_1_3, var_1_4, var_1_5

	if BeginStageCommand.DockOverload() then
		do return end

		var_1_0 = getProxy(PlayerProxy)
		var_1_1 = getProxy(FleetProxy)
		var_1_2 = getProxy(BayProxy)
		var_1_3 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE].oil_cost > 0
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

	BeginStageCommand.SendRequest(SYSTEM_BOSS_SINGLE, {}, {
		arg_1_0.stageId
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
			system = SYSTEM_BOSS_SINGLE,
			actId = var_0,
			token = arg_2_0.key,
			continuousBattleTimes = arg_1_0.continuousBattleTimes,
			totalBattleTimes = arg_1_0.totalBattleTimes
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
	local var_4_3 = var_4_2.getActivityById(var_4_9000, arg_4_0.actId):GetEnemyDataByStageId(arg_4_0.stageId):GetOilLimit()
	local var_4_4 = getProxy(FleetProxy):getActivityFleets()[arg_4_0.actId]
	local var_4_5
	local var_4_6 = 0
	local var_4_7 = {}
	local var_4_8 = {}
	local var_4_9 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE].oil_cost > 0
	local var_4_11 = var_4_2[1] or 0

	;(function(arg_5_0, arg_5_1)
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
	end)(var_4_4[arg_4_0.mainFleetId], var_4_11)

	if arg_4_0.statistics.submarineAid then
		var_4_5 = var_4_4[arg_4_0.mainFleetId + 10]

		if var_4_4[arg_4_0.mainFleetId + 10] then
			local var_4_12 = var_4_3[2] or 0

			var_4_10(var_4_4[arg_4_0.mainFleetId + 10], var_4_12)
		else
			originalPrint("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_13 = arg_4_1.GeneralPackage(arg_4_0, var_4_7)

	var_4_13.commander_id_list = var_4_8

	arg_4_1:SendRequest(var_4_13, function(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
		local var_6_2 = var_4_1 > ys.Battle.BattleConst.BattleScore.C
		local var_6_3 = arg_4_1.GenerateCommanderExp(arg_6_0, var_0, var_4_5)

		arg_4_1.GeneralPlayerCosume(SYSTEM_BOSS_SINGLE, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_6, arg_6_0.player_exp)

		if var_6_2 then
			local var_6_4 = getProxy(ActivityProxy):getActivityById(arg_4_0.actId)
			local var_6_5 = var_6_4:GetEnemyDataByStageId(arg_4_0.stageId)

			var_6_4:AddDailyCount(var_6_5.id)
			var_6_4:AddPassStage(var_6_5:GetExpeditionId())
			getProxy(ActivityProxy):updateActivity(var_6_4)
		end

		local var_6_6 = {
			system = SYSTEM_BOSS_SINGLE,
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

		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_6_6)

		return
	end)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_0, var_7_1 = ys.Battle.BattleGateActBoss.GetPreloadList(arg_7_0)

	for iter_7_0, iter_7_1 in ipairs((ys.Battle.BattleResourceManager.GetInstance().GetResFromBuffIDList(getProxy(ActivityProxy):getActivityById(arg_7_0.actId):GetBuffIdsByStageId(arg_7_0.stageId)))) do
		table.insert(var_7_0, iter_7_1)
	end

	return var_7_0, var_7_1
end

return var_0_0
