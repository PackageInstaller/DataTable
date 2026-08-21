local var_0_0 = class("BattleGateActBossSP")

ys.Battle.BattleGateActBossSP = var_0_0
var_0_0.__name = "BattleGateActBossSP"
var_0_0.BattleSystem = SYSTEM_ACT_BOSS_SP

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2, var_1_3, var_1_4, var_1_5, var_1_6, var_1_7

	if BeginStageCommand.DockOverload() then
		do return end

		var_1_0 = getProxy(ActivityProxy):getActivityById(arg_1_0.actId)
		var_1_1 = getProxy(PlayerProxy)
		var_1_2 = getProxy(PlayerProxy):getData()
		var_1_3 = getProxy(BayProxy)
		var_1_4 = getProxy(ActivityProxy):GetActivityBossRuntime(arg_1_0.actId).buffIds
		var_1_5 = arg_1_0.stageId
		var_1_6 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab
		var_1_7 = arg_1_0.mainFleetId
	end

	local var_1_8 = getProxy(FleetProxy):getActivityFleets()[arg_1_0.actId][arg_1_0.mainFleetId]
	local var_1_9 = {}

	for iter_1_0, iter_1_1 in ipairs((getProxy(BayProxy):getSortShipsByFleet(var_1_8))) do
		var_1_9[#var_1_9 + 1] = iter_1_1.id
	end

	local var_1_10 = 0
	local var_1_11 = 0

	if pg.battle_cost_template[var_0_0.BattleSystem].oil_cost > 0 then
		var_1_10 = var_1_8:getStartCost().oil
		var_1_11 = var_1_8:GetCostSum().oil
	end

	if var_1_11 > var_1_2.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(var_0_0.BattleSystem, var_1_9, {
		var_1_5,
		var_1_4
	}, function(arg_2_0)
		if var_0 then
			var_1_2:consume({
				gold = 0,
				oil = var_1_10
			})
		end

		if var_0.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_3:updateShip(iter_2_1)
			end
		end

		var_1_1:updatePlayer(var_1_2)

		var_1_0 = getProxy(ActivityProxy):getActivityById(var_0)

		var_1_0:UpdateHistoryBuffs(var_1_4)
		getProxy(ActivityProxy):updateActivity(var_1_0)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_7,
			actId = var_0,
			prefabFleet = var_1_6,
			stageId = var_1_5,
			system = var_0_0.BattleSystem,
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
	local var_4_0 = getProxy(BayProxy)
	local var_4_1 = arg_4_0.statistics._battleScore
	local var_4_2 = pg.activity_event_worldboss[getProxy(ActivityProxy):getActivityById(arg_4_0.actId):getConfig("config_id")]
	local var_4_3 = getProxy(FleetProxy):getActivityFleets()[arg_4_0.actId]
	local var_4_5 = 0
	local var_4_6 = {}
	local var_4_7 = {}
	local var_4_8 = pg.battle_cost_template[var_0_0.BattleSystem].oil_cost > 0

	;(function(arg_5_0, arg_5_1)
		if var_4_8 then
			local var_5_0 = arg_5_0:getEndCost().oil

			if arg_5_1 > 0 then
				var_5_0 = math.clamp(arg_5_1 - arg_5_0:getStartCost().oil, 0, var_5_0)
			end

			var_4_5 = var_4_5 + var_5_0
		end

		table.insertto(var_4_6, var_4_0:getSortShipsByFleet(arg_5_0))
		table.insertto(var_4_7, arg_5_0.commanderIds)

		return
	end)(var_4_3[arg_4_0.mainFleetId], 0)

	if arg_4_0.statistics.submarineAid then
		if var_4_3[arg_4_0.mainFleetId + 10] then
			var_4_9(var_4_3[arg_4_0.mainFleetId + 10], 0)
		else
			originalPrint("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_10 = arg_4_1.GeneralPackage(arg_4_0, var_4_6)

	var_4_10.commander_id_list = var_4_7

	arg_4_1:SendRequest(var_4_10, function(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
		local var_6_2 = arg_4_1.GenerateCommanderExp(arg_6_0, var_0, var_4_3[arg_4_0.mainFleetId + 10])

		arg_4_1.GeneralPlayerCosume(var_0_0.BattleSystem, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_5, arg_6_0.player_exp)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = var_0_0.BattleSystem,
			statistics = arg_4_0.statistics,
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

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_0, var_7_1 = ys.Battle.BattleGateActBoss.GetPreloadList(arg_7_0)

	for iter_7_0, iter_7_1 in ipairs((ys.Battle.BattleResourceManager.GetInstance().GetResFromBuffIDList((_.map(getProxy(ActivityProxy):GetActivityBossRuntime(arg_7_0.actId).buffIds, function(arg_8_0)
		return ActivityBossBuff.New({
			configId = arg_8_0
		}):GetBuffID()
	end))))) do
		table.insert(var_7_0, iter_7_1)
	end

	return var_7_0, var_7_1
end

return var_0_0
