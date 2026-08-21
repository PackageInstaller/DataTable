local var_0_0 = class("BattleGateLimitChallenge")

ys.Battle.BattleGateLimitChallenge = var_0_0
var_0_0.__name = "BattleGateLimitChallenge"
var_0_0.BattleSystem = SYSTEM_LIMIT_CHALLENGE

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if not arg_1_1.LegalFleet(FleetProxy.CHALLENGE_FLEET_ID) then
		return
	end

	local var_1_0 = getProxy(PlayerProxy)
	local var_1_1 = var_1_0:getData()
	local var_1_2 = getProxy(BayProxy)
	local var_1_3 = getProxy(LimitChallengeProxy)
	local var_1_4 = arg_1_0.stageId
	local var_1_5 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab
	local var_1_6 = getProxy(FleetProxy):getFleetById(FleetProxy.CHALLENGE_FLEET_ID)
	local var_1_7 = {}

	for iter_1_0, iter_1_1 in ipairs((getProxy(BayProxy):getSortShipsByFleet(var_1_6))) do
		var_1_7[#var_1_7 + 1] = iter_1_1.id
	end

	local var_1_8 = pg.battle_cost_template[var_0_0.BattleSystem].oil_cost > 0
	local var_1_9 = 0
	local var_1_10 = 0

	if pg.battle_cost_template[var_0_0.BattleSystem].oil_cost > 0 then
		var_1_9 = var_1_6:getStartCost().oil
		var_1_10 = var_1_6:GetCostSum().oil
	end

	if var_1_8 and var_1_10 > var_1_1.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(var_0_0.BattleSystem, var_1_7, {
		var_1_4
	}, function(arg_2_0)
		if var_1_8 then
			var_1_1:consume({
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

		var_1_0:updatePlayer(var_1_1)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = mainFleetID,
			prefabFleet = var_1_5,
			stageId = var_1_4,
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
	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = getProxy(BayProxy)
	local var_4_3 = arg_4_0.statistics._battleScore
	local var_4_4 = 0
	local var_4_5 = {}
	local var_4_6 = {}
	local var_4_7 = arg_4_0.stageId
	local var_4_8 = var_4_1:getFleetById(FleetProxy.CHALLENGE_FLEET_ID)
	local var_4_9

	if arg_4_0.statistics.submarineAid then
		var_4_9 = var_4_1:getFleetById(FleetProxy.CHALLENGE_SUB_FLEET_ID)
	end

	;(function()
		(function(arg_6_0)
			var_4_4 = var_4_4 + arg_6_0:getEndCost().oil

			table.insertto(var_4_6, _.values(arg_6_0.commanderIds))
			table.insertto(var_4_5, var_4_2:getSortShipsByFleet(arg_6_0))

			return
		end)(var_4_8)

		if arg_4_0.statistics.submarineAid then
			(function(arg_6_0)
				var_4_4 = var_4_4 + arg_6_0:getEndCost().oil

				table.insertto(var_4_6, _.values(arg_6_0.commanderIds))
				table.insertto(var_4_5, var_4_2:getSortShipsByFleet(arg_6_0))

				return
			end)(var_4_9)
		end

		return
	end)()

	local var_4_10 = arg_4_1.GeneralPackage(arg_4_0, {})

	var_4_10.commander_id_list = {}

	arg_4_1:SendRequest(var_4_10, function(arg_7_0)
		arg_4_1.addShipsExp(arg_7_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_7_0.mvp

		local var_7_0, var_7_1 = arg_4_1:GeneralLoot(arg_7_0)
		local var_7_2 = var_4_3 > ys.Battle.BattleConst.BattleScore.C
		local var_7_3 = arg_4_1.GenerateCommanderExp(arg_7_0, var_4_8, var_4_9)

		arg_4_1.GeneralPlayerCosume(var_0_0.BattleSystem, var_4_3 > ys.Battle.BattleConst.BattleScore.C, var_4_4, arg_7_0.player_exp)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = var_0_0.BattleSystem,
			statistics = arg_4_0.statistics,
			score = var_4_3,
			drops = var_7_0,
			commanderExps = var_7_3,
			result = arg_7_0.result,
			extraDrops = var_7_1
		})

		if var_7_2 then
			getProxy(LimitChallengeProxy):setPassTime(LimitChallengeConst.GetChallengeIDByStageID(var_4_7), arg_4_0.statistics._totalTime)
		end

		return
	end)

	return
end

function var_0_0.GetPreloadList(arg_8_0)
	local var_8_0 = {}
	local var_8_2 = ys.Battle.BattleResourceManager.GetInstance()
	local var_8_3 = getProxy(FleetProxy)
	local var_8_4 = var_8_3:getFleetById(FleetProxy.CHALLENGE_FLEET_ID)
	local var_8_5 = var_8_3:getFleetById(FleetProxy.CHALLENGE_SUB_FLEET_ID)
	local var_8_6 = getProxy(BayProxy)

	if var_8_4 then
		for iter_8_0, iter_8_1 in ipairs((var_8_4:GetRawShipIds())) do
			table.insert({}, var_8_6:getShipById(iter_8_1))
		end

		var_8_0 = var_8_4:buildBattleBuffList()
	end

	if var_8_5 then
		for iter_8_2, iter_8_3 in ipairs((var_8_5:GetRawShipIds())) do
			table.insert({}, var_8_6:getShipById(iter_8_3))
		end

		for iter_8_4, iter_8_5 in ipairs(var_8_5:buildBattleBuffList()) do
			table.insert(var_8_0, iter_8_5)
		end
	end

	local var_8_7, var_8_8 = var_8_2.GetPlayerShipResource({}, arg_8_0.system)

	for iter_8_6, iter_8_7 in ipairs((var_8_2.GetCommanderBuffRes(var_8_0))) do
		table.insert(var_8_7, iter_8_7)
	end

	local var_8_9 = AcessWithinNull(pg.expedition_constellation_challenge_template[LimitChallengeConst.GetChallengeIDByStageID(arg_8_0.stageId)], "buff_id")

	if var_8_9 then
		for iter_8_8, iter_8_9 in ipairs(var_8_9) do
			for iter_8_10, iter_8_11 in ipairs((ys.Battle.BattleDataFunction.GetResFromBuff(iter_8_9.ID, iter_8_9.LV, {}))) do
				table.insert(var_8_7, iter_8_11)
			end
		end
	end

	return var_8_7, var_8_8
end

return var_0_0
