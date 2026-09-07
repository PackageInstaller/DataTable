local BattleGateCooperate = class("BattleGateCooperate")

ys.Battle.BattleGateCooperate = BattleGateCooperate
BattleGateCooperate.__name = "BattleGateCooperate"

function BattleGateCooperate:Entrance(arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = self.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(BayProxy)
	local var_1_3 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS]
	local var_1_4 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS].oil_cost > 0
	local var_1_5 = {}
	local var_1_10 = getProxy(FleetProxy):getActivityFleets()[self.actId][Fleet.REGULAR_FLEET_ID]

	for iter_1_0, iter_1_1 in ipairs(var_1_10.ships) do
		var_1_5[#var_1_5 + 1] = iter_1_1
	end

	local var_1_11 = var_1_10:getStartCost().oil
	local var_1_12 = var_1_2:getSortShipsByFleet(var_1_10)
	local var_1_13 = var_1_1:getData()

	if var_1_4 and var_1_10:GetCostSum().oil > var_1_13.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_14 = self.stageId
	local var_1_15 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab

	arg_1_1.ShipVertify()

	local var_1_16

	if chapter:getPlayType() == ChapterConst.TypeExtra then
		var_1_16 = true
	end

	BeginStageCommand.SendRequest(SYSTEM_HP_SHARE_ACT_BOSS, var_1_5, {
		var_1_14
	}, function(arg_2_0)
		if var_1_4 then
			var_1_13:consume({
				gold = 0,
				oil = var_1_11
			})
		end

		if var_1_3.enter_energy_cost > 0 and not var_1_16 then
			for iter_2_0, iter_2_1 in ipairs(var_1_12) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_2:updateShip(iter_2_1)
			end
		end

		var_1_1:updatePlayer(var_1_13)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = Fleet.REGULAR_FLEET_ID,
			prefabFleet = var_1_15,
			stageId = var_1_14,
			actId = var_1_0,
			system = SYSTEM_HP_SHARE_ACT_BOSS,
			token = arg_2_0.key
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function BattleGateCooperate:Exit(arg_4_1)
	if client.CheaterVertify() then
		return
	end

	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = getProxy(ChapterProxy)
	local var_4_3 = ys.Battle.BattleConst.BattleScore.S
	local var_4_7 = var_4_1:getActivityFleets()[self.actId][self.mainFleetId]
	local var_4_8 = bayProxy:getSortShipsByFleet(var_4_7)
	local var_4_9 = var_4_7:getEndCost().oil

	if self.statistics.submarineAid then
		local var_4_10 = var_4_1:getActivityFleets()[self.actId][Fleet.SUBMARINE_FLEET_ID]

		if var_4_10 then
			for iter_4_0, iter_4_1 in ipairs((bayProxy:getSortShipsByFleet(var_4_10))) do
				if self.statistics[iter_4_1.id] then
					table.insert(var_4_8, iter_4_1)

					var_4_9 = var_4_9 + iter_4_1:getEndBattleExpend()
				end
			end
		else
			originalPrint("finish stage error: can not find submarine fleet.")
		end
	end

	local var_4_11 = client.GeneralPackage(self, var_4_8)
	local var_4_12 = {}

	for iter_4_2, iter_4_3 in ipairs(self.statistics._enemyInfoList) do
		table.insert(var_4_12, {
			enemy_id = iter_4_3.id,
			damage_taken = iter_4_3.damage,
			total_hp = iter_4_3.totalHp
		})
	end

	var_4_11.enemy_info = var_4_12

	client:SendRequest(var_4_11, function(arg_5_0)
		client.addShipsExp(arg_5_0.ship_exp_list, self.statistics)

		self.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0, var_5_1 = client:GeneralLoot(arg_5_0)

		BattleGateCooperate.GeneralPlayerCosume(SYSTEM_HP_SHARE_ACT_BOSS, var_4_3 > ys.Battle.BattleConst.BattleScore.C, var_4_9, arg_5_0.player_exp)
		client:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_HP_SHARE_ACT_BOSS,
			statistics = self.statistics,
			score = var_4_3,
			drops = var_5_0,
			commanderExps = {},
			result = arg_5_0.result,
			extraDrops = var_5_1
		})

		return
	end)

	return
end

return BattleGateCooperate
