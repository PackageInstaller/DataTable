local BattleGateBossSingle = class("BattleGateBossSingle")

ys.Battle.BattleGateBossSingle = BattleGateBossSingle
BattleGateBossSingle.__name = "BattleGateBossSingle"

function BattleGateBossSingle:Entrance(arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = self.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(FleetProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE]
	local var_1_5 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE].oil_cost > 0
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

	BeginStageCommand.SendRequest(SYSTEM_BOSS_SINGLE, var_1_9, {
		self.stageId
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
			system = SYSTEM_BOSS_SINGLE,
			actId = var_1_0,
			token = arg_2_0.key,
			continuousBattleTimes = self.continuousBattleTimes,
			totalBattleTimes = self.totalBattleTimes
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function BattleGateBossSingle:Exit(arg_4_1)
	local var_4_0 = getProxy(BayProxy)
	local var_4_1 = self.statistics._battleScore
	local var_4_2 = getProxy(ActivityProxy)
	local var_4_3 = var_4_2:getActivityById(self.actId):GetEnemyDataByStageId(self.stageId):GetOilLimit()
	local var_4_4 = getProxy(FleetProxy):getActivityFleets()[self.actId]
	local var_4_5 = var_4_4[self.mainFleetId]
	local var_4_6
	local var_4_7 = 0
	local var_4_8 = {}
	local var_4_9 = {}
	local var_4_10 = pg.battle_cost_template[SYSTEM_BOSS_SINGLE].oil_cost > 0

	local function var_4_11(arg_5_0, arg_5_1)
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
	end

	var_4_11(var_4_4[self.mainFleetId], var_4_2[1] or 0)

	if self.statistics.submarineAid then
		var_4_6 = var_4_4[self.mainFleetId + 10]

		if var_4_4[self.mainFleetId + 10] then
			var_4_11(var_4_6, var_4_3[2] or 0)
		else
			originalPrint("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_13 = arg_4_1.GeneralPackage(self, var_4_8)

	var_4_13.commander_id_list = var_4_9

	arg_4_1:SendRequest(var_4_13, function(arg_6_0)
		arg_4_1.addShipsExp(arg_6_0.ship_exp_list, self.statistics, true)

		self.statistics.mvpShipID = arg_6_0.mvp

		local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
		local var_6_2 = var_4_1 > ys.Battle.BattleConst.BattleScore.C
		local var_6_3 = arg_4_1.GenerateCommanderExp(arg_6_0, var_4_5, var_4_6)

		arg_4_1.GeneralPlayerCosume(SYSTEM_BOSS_SINGLE, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_7, arg_6_0.player_exp)

		if var_6_2 then
			local var_6_4 = getProxy(ActivityProxy):getActivityById(self.actId)
			local var_6_5 = var_6_4:GetEnemyDataByStageId(self.stageId)

			var_6_4:AddDailyCount(var_6_5.id)
			var_6_4:AddPassStage(var_6_5:GetExpeditionId())
			getProxy(ActivityProxy):updateActivity(var_6_4)
		end

		local var_6_6 = {
			system = SYSTEM_BOSS_SINGLE,
			statistics = self.statistics,
			score = var_4_1,
			result = arg_6_0.result,
			drops = var_6_0,
			commanderExps = var_6_3,
			extraDrops = var_6_1
		}

		if PlayerConst.CanDropItem(var_6_0) then
			local var_6_7 = {}

			for iter_6_0, iter_6_1 in ipairs(var_6_0) do
				table.insert(var_6_7, iter_6_1)
			end

			for iter_6_2, iter_6_3 in ipairs(var_6_1) do
				iter_6_3.riraty = true

				table.insert(var_6_7, iter_6_3)
			end

			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator) then
				getProxy(ChapterProxy):AddBossSingleRewards(var_6_7)
			end
		end

		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_6_6)

		return
	end)

	return
end

function BattleGateBossSingle:GetPreloadList()
	local var_7_0, var_7_1 = ys.Battle.BattleGateActBoss.GetPreloadList(self)

	for iter_7_0, iter_7_1 in ipairs((ys.Battle.BattleResourceManager.GetInstance().GetResFromBuffIDList(getProxy(ActivityProxy):getActivityById(self.actId):GetBuffIdsByStageId(self.stageId)))) do
		table.insert(var_7_0, iter_7_1)
	end

	return var_7_0, var_7_1
end

return BattleGateBossSingle
