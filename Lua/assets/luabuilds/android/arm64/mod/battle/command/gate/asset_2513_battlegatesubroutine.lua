local BattleGateSubRoutine = class("BattleGateSubRoutine")

ys.Battle.BattleGateSubRoutine = BattleGateSubRoutine
BattleGateSubRoutine.__name = "BattleGateSubRoutine"

function BattleGateSubRoutine:Entrance(arg_1_1)
	if not arg_1_1.LegalFleet(self.mainFleetId) then
		return
	end

	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = getProxy(PlayerProxy)
	local var_1_1 = getProxy(BayProxy)
	local var_1_2 = pg.battle_cost_template[SYSTEM_SUB_ROUTINE]
	local var_1_3 = pg.battle_cost_template[SYSTEM_SUB_ROUTINE].oil_cost > 0
	local var_1_4 = {}
	local var_1_9 = getProxy(FleetProxy):getFleetById(self.mainFleetId)
	local var_1_10 = var_1_1:getShipByTeam(var_1_9, TeamType.Submarine)

	for iter_1_0, iter_1_1 in ipairs(var_1_10) do
		var_1_4[#var_1_4 + 1] = iter_1_1.id
	end

	local var_1_11 = var_1_9:getStartCost().oil
	local var_1_12 = var_1_0:getData()

	if var_1_3 and var_1_9:GetCostSum().oil > var_1_12.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_13 = self.mainFleetId
	local var_1_14 = self.stageId
	local var_1_15 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_SUB_ROUTINE, var_1_4, {
		self.stageId
	}, function(arg_2_0)
		if var_1_3 then
			var_1_12:consume({
				gold = 0,
				oil = var_1_11
			})
		end

		if var_1_2.enter_energy_cost > 0 and not exFlag then
			for iter_2_0, iter_2_1 in ipairs(var_1_10) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_1:updateShip(iter_2_1)
			end
		end

		var_1_0:updatePlayer(var_1_12)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_13,
			prefabFleet = var_1_15,
			stageId = var_1_14,
			system = SYSTEM_SUB_ROUTINE,
			token = arg_2_0.key
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function BattleGateSubRoutine:Exit(arg_4_1)
	local var_4_1 = self.statistics._battleScore
	local var_4_4 = getProxy(FleetProxy):getFleetById(self.mainFleetId)
	local var_4_5 = var_4_4:getEndCost().oil

	arg_4_1:SendRequest(arg_4_1.GeneralPackage(self, (getProxy(BayProxy):getSortShipsByFleet(var_4_4))), function(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, self.statistics, true)

		self.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0, var_5_1 = arg_4_1:GeneralLoot(arg_5_0)
		local var_5_2 = var_4_1 > ys.Battle.BattleConst.BattleScore.C

		arg_4_1.GeneralPlayerCosume(SYSTEM_SUB_ROUTINE, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_5, arg_5_0.player_exp, exFlag)

		local var_5_3 = getProxy(DailyLevelProxy)

		if var_5_2 then
			var_5_3.data[var_5_3.dailyLevelId] = (var_5_3.data[var_5_3.dailyLevelId] or 0) + 1
		end

		if var_4_1 == ys.Battle.BattleConst.BattleScore.S then
			var_5_3:AddQuickStage(self.stageId)
		end

		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_SUB_ROUTINE,
			statistics = self.statistics,
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

return BattleGateSubRoutine
