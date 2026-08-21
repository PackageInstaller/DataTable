local var_0_0 = class("BattleGateDuel")

ys.Battle.BattleGateDuel = var_0_0
var_0_0.__name = "BattleGateDuel"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.mainFleetId

	if not arg_1_1.LegalFleet(arg_1_0.mainFleetId) then
		return
	end

	local var_1_1 = getProxy(MilitaryExerciseProxy):getSeasonInfo()

	if not var_1_1:canExercise() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("exercise_count_insufficient"))

		return
	end

	local var_1_2 = getProxy(PlayerProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = getProxy(FleetProxy)
	local var_1_7 = arg_1_0.rivalId
	local var_1_8 = getProxy(MilitaryExerciseProxy):getRivalById(arg_1_0.rivalId)
	local var_1_9 = pg.battle_cost_template[SYSTEM_DUEL].oil_cost > 0
	local var_1_10 = {}
	local var_1_12 = 0

	for iter_1_0, iter_1_1 in ipairs((var_1_3:getSortShipsByFleet((var_1_4:getFleetById(arg_1_0.mainFleetId))))) do
		var_1_10[#var_1_10 + 1] = iter_1_1.id
	end

	local var_1_14 = var_1_2:getData()

	if var_1_9 and 0 > var_1_2:getData().oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_15 = 0

	for iter_1_2, iter_1_3 in ipairs(var_1_8.mainShips) do
		var_1_15 = var_1_15 + iter_1_3.level
	end

	for iter_1_4, iter_1_5 in ipairs(var_1_8.vanguardShips) do
		var_1_15 = var_1_15 + iter_1_5.level
	end

	RivalLevelVertiry = var_1_15

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_DUEL, var_1_10, {
		var_1_7
	}, function(arg_2_0)
		if var_1_9 then
			var_1_14:consume({
				gold = 0,
				oil = var_1_12
			})
		end

		if var_0.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_3:updateShip(iter_2_1)
			end
		end

		local var_2_0 = ys.Battle.BattleConfig.ARENA_LIST[math.random(#ys.Battle.BattleConfig.ARENA_LIST)]

		var_1_2:updatePlayer(var_1_14)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_0,
			prefabFleet = {},
			stageId = var_2_0,
			system = SYSTEM_DUEL,
			rivalId = var_1_7,
			token = arg_2_0.key,
			mode = mode
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	local var_4_1 = arg_4_0.statistics._battleScore
	local var_4_4 = getProxy(FleetProxy):getFleetById(arg_4_0.mainFleetId)
	local var_4_5 = var_4_4:getEndCost().oil

	arg_4_1:SendRequest(arg_4_1.GeneralPackage(arg_4_0, (getProxy(BayProxy):getSortShipsByFleet(var_4_4))), function(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics, false)

		arg_4_0.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0, var_5_1 = arg_4_1:GeneralLoot(arg_5_0)

		arg_4_1.GeneralPlayerCosume(SYSTEM_DUEL, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_5, arg_5_0.player_exp, exFlag)
		getProxy(MilitaryExerciseProxy):reduceExerciseCount()
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_DUEL,
			statistics = arg_4_0.statistics,
			score = var_4_1,
			drops = var_5_0,
			commanderExps = {},
			result = arg_5_0.result,
			extraDrops = var_5_1
		})

		return
	end)

	return
end

function var_0_0.GetPreloadList(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs((getProxy(BayProxy):getShipsByFleet((getProxy(FleetProxy):getFleetById(arg_6_0.mainFleetId))))) do
		table.insert({}, iter_6_1)
	end

	for iter_6_2, iter_6_3 in ipairs((getProxy(MilitaryExerciseProxy):getRivalById(arg_6_0.rivalId):getShips())) do
		table.insert({}, iter_6_3)
	end

	local var_6_1, var_6_2 = ys.Battle.BattleResourceManager.GetInstance().GetPlayerShipResource({}, arg_6_0.system)

	return var_6_1, var_6_2
end

return var_0_0
