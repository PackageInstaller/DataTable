local BattleGateChallenge = class("BattleGateChallenge")

ys.Battle.BattleGateChallenge = BattleGateChallenge
BattleGateChallenge.__name = "BattleGateChallenge"

function BattleGateChallenge:Entrance(arg_1_1)
	local var_1_0 = self.mode
	local var_1_1 = self.actId
	local var_1_2 = getProxy(PlayerProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = pg.battle_cost_template[SYSTEM_CHALLENGE]
	local var_1_5 = pg.battle_cost_template[SYSTEM_CHALLENGE].oil_cost > 0
	local var_1_6 = {}
	local var_1_8 = 0
	local var_1_10 = getProxy(ChallengeProxy):getUserChallengeInfo(self.mode)
	local var_1_11 = var_1_10:getRegularFleet():getShips(false)

	for iter_1_0, iter_1_1 in ipairs(var_1_11) do
		var_1_6[#var_1_6 + 1] = iter_1_1.id
	end

	local var_1_12 = var_1_2:getData()
	local var_1_14
	local var_1_13

	if var_1_5 and 0 > var_1_12.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		do return end

		var_1_13 = var_1_10:getNextStageID()
		var_1_14 = {}
	end

	var_1_14[1] = var_1_10:getLevel()
	var_1_14[2] = self.mode

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_CHALLENGE, var_1_6, {
		var_1_13,
		var_1_14
	}, function(arg_2_0)
		if var_1_5 then
			var_1_12:consume({
				gold = 0,
				oil = var_1_8
			})
		end

		if var_1_4.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_11) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_3:updateShip(iter_2_1)
			end
		end

		var_1_2:updatePlayer(var_1_12)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = {},
			stageId = var_1_13,
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

function BattleGateChallenge:Exit(arg_4_1)
	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = self.statistics._battleScore
	local var_4_5 = {}
	local var_4_6 = getProxy(ChallengeProxy):getUserChallengeInfo(self.mode)

	for iter_4_0, iter_4_1 in ipairs((var_4_6:getRegularFleet():getShips(true))) do
		table.insert(var_4_5, iter_4_1)
	end

	local var_4_7 = 0
	local var_4_8 = arg_4_1.GeneralPackage(self, var_4_5)

	var_4_8.data2 = {
		var_4_6:getLevel(),
		self.mode
	}

	arg_4_1:SendRequest(var_4_8, function(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, self.statistics)

		self.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0, var_5_1 = arg_4_1:GeneralLoot(arg_5_0)

		arg_4_1.GeneralPlayerCosume(SYSTEM_CHALLENGE, var_4_2 > ys.Battle.BattleConst.BattleScore.C, var_4_7, arg_5_0.player_exp, exFlag)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_CHALLENGE,
			statistics = self.statistics,
			score = var_4_2,
			drops = var_5_0,
			commanderExps = {},
			result = arg_5_0.result,
			extraDrops = var_5_1
		})

		local function var_5_2(arg_6_0)
			if self.statistics[arg_6_0] then
				var_4_6:updateShipHP(arg_6_0, self.statistics[arg_6_0].bp)
			end

			return
		end

		for iter_5_0, iter_5_1 in pairs((var_4_6:getShipUIDList())) do
			var_5_2(iter_5_1)
		end

		return
	end)

	return
end

function BattleGateChallenge:GetPreloadList()
	local var_7_0 = {}
	local var_7_2 = ys.Battle.BattleResourceManager.GetInstance()
	local var_7_3 = getProxy(ChallengeProxy):getUserChallengeInfo(self.mode)
	local var_7_4 = var_7_3:getRegularFleet()

	for iter_7_0, iter_7_1 in ipairs((var_7_4:getShips(false))) do
		table.insert(var_7_0, iter_7_1)
	end

	local var_7_5 = var_7_4:buildBattleBuffList()
	local var_7_6 = var_7_3:getSubmarineFleet()

	for iter_7_2, iter_7_3 in ipairs((var_7_6:getShips(false))) do
		table.insert(var_7_0, iter_7_3)
	end

	for iter_7_4, iter_7_5 in ipairs(var_7_6:buildBattleBuffList()) do
		table.insert(var_7_5, iter_7_5)
	end

	local var_7_7, var_7_8 = var_7_2.GetPlayerShipResource(var_7_0, self.system)

	for iter_7_6, iter_7_7 in ipairs((var_7_2.GetCommanderBuffRes(var_7_5))) do
		table.insert(var_7_7, iter_7_7)
	end

	return var_7_7, var_7_8
end

return BattleGateChallenge
