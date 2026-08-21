local var_0_0 = class("BattleGateChallenge")

ys.Battle.BattleGateChallenge = var_0_0
var_0_0.__name = "BattleGateChallenge"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.mode
	local var_1_1 = arg_1_0.actId
	local var_1_2 = getProxy(PlayerProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = getProxy(ChallengeProxy)
	local var_1_5 = pg.battle_cost_template[SYSTEM_CHALLENGE].oil_cost > 0
	local var_1_6 = {}
	local var_1_8 = 0
	local var_1_10 = var_1_4:getUserChallengeInfo(arg_1_0.mode)

	for iter_1_0, iter_1_1 in ipairs((var_1_10:getRegularFleet():getShips(false))) do
		var_1_6[#var_1_6 + 1] = iter_1_1.id
	end

	local var_1_11 = var_1_2:getData()
	local var_1_12

	if var_1_5 and 0 > var_1_2:getData().oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		do return end

		var_1_12 = var_1_10:getNextStageID()
	end

	;({})[1] = var_1_10:getLevel()
	;({})[2] = arg_1_0.mode

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_CHALLENGE, var_1_6, {
		var_1_10:getNextStageID(),
		{}
	}, function(arg_2_0)
		if var_1_5 then
			var_1_11:consume({
				gold = 0,
				oil = var_1_8
			})
		end

		if var_0.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_3:updateShip(iter_2_1)
			end
		end

		var_1_2:updatePlayer(var_1_11)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = {},
			stageId = var_1_12,
			system = SYSTEM_CHALLENGE,
			actId = var_1_1,
			token = arg_2_0.key,
			mode = var_1_0
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
	local var_4_2 = arg_4_0.statistics._battleScore
	local var_4_5 = getProxy(ChallengeProxy):getUserChallengeInfo(arg_4_0.mode)

	for iter_4_0, iter_4_1 in ipairs((var_4_5:getRegularFleet():getShips(true))) do
		table.insert({}, iter_4_1)
	end

	local var_4_6 = 0
	local var_4_7 = arg_4_1.GeneralPackage(arg_4_0, {})

	var_4_7.data2 = {
		var_4_5:getLevel(),
		arg_4_0.mode
	}

	arg_4_1:SendRequest(var_4_7, function(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics)

		arg_4_0.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0, var_5_1 = arg_4_1:GeneralLoot(arg_5_0)

		arg_4_1.GeneralPlayerCosume(SYSTEM_CHALLENGE, var_4_2 > ys.Battle.BattleConst.BattleScore.C, var_4_6, arg_5_0.player_exp, exFlag)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_CHALLENGE,
			statistics = arg_4_0.statistics,
			score = var_4_2,
			drops = var_5_0,
			commanderExps = {},
			result = arg_5_0.result,
			extraDrops = var_5_1
		})

		for iter_5_0, iter_5_1 in pairs((var_4_5:getShipUIDList())) do
			(function(arg_6_0)
				if arg_4_0.statistics[arg_6_0] then
					var_4_5:updateShipHP(arg_6_0, arg_4_0.statistics[arg_6_0].bp)
				end

				return
			end)(iter_5_1)
		end

		return
	end)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_1 = ys.Battle.BattleResourceManager.GetInstance()
	local var_7_2 = getProxy(ChallengeProxy):getUserChallengeInfo(arg_7_0.mode)
	local var_7_3 = var_7_2:getRegularFleet()

	for iter_7_0, iter_7_1 in ipairs((var_7_3:getShips(false))) do
		table.insert({}, iter_7_1)
	end

	local var_7_4 = var_7_3:buildBattleBuffList()
	local var_7_5 = var_7_2:getSubmarineFleet()

	for iter_7_2, iter_7_3 in ipairs((var_7_5:getShips(false))) do
		table.insert({}, iter_7_3)
	end

	for iter_7_4, iter_7_5 in ipairs(var_7_5:buildBattleBuffList()) do
		table.insert(var_7_4, iter_7_5)
	end

	local var_7_6, var_7_7 = var_7_1.GetPlayerShipResource({}, arg_7_0.system)

	for iter_7_6, iter_7_7 in ipairs((var_7_1.GetCommanderBuffRes(var_7_4))) do
		table.insert(var_7_6, iter_7_7)
	end

	return var_7_6, var_7_7
end

return var_0_0
