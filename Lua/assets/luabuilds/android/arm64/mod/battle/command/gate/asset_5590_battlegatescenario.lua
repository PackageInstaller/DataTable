local BattleGateScenario = class("BattleGateScenario")

ys.Battle.BattleGateScenario = BattleGateScenario
BattleGateScenario.__name = "BattleGateScenario"

function BattleGateScenario:Entrance(arg_1_1)
	if BeginStageCommand.DockOverload() then
		getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.DOCK_OVERLOADED)

		return
	end

	local var_1_0 = getProxy(PlayerProxy)
	local var_1_1 = getProxy(BayProxy)
	local var_1_2 = pg.battle_cost_template[SYSTEM_SCENARIO]
	local var_1_3 = pg.battle_cost_template[SYSTEM_SCENARIO].oil_cost > 0
	local var_1_4 = {}
	local var_1_9 = getProxy(ChapterProxy):getActiveChapter()

	for iter_1_0, iter_1_1 in ipairs((var_1_9.fleet:getShips(false))) do
		var_1_4[#var_1_4 + 1] = iter_1_1.id
	end

	local var_1_10, var_1_11 = var_1_9:getFleetCost(var_1_9.fleet, self.stageId)
	local var_1_13 = var_1_10.oil
	local var_1_15 = var_1_0:getData()

	if var_1_3 and var_1_10.oil + var_1_11.oil > var_1_15.oil then
		getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.OIL_LACK)

		if not ItemTipPanel.ShowOilBuyTip(var_1_10.oil + var_1_11.oil) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))
		end

		return
	end

	local var_1_16 = self.stageId
	local var_1_17 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab

	arg_1_1.ShipVertify()

	local var_1_18

	if var_1_9:getPlayType() == ChapterConst.TypeExtra then
		var_1_18 = true
	end

	local var_1_19 = var_1_9:GetExtraCostRate()

	BeginStageCommand.SendRequest(SYSTEM_SCENARIO, var_1_4, {
		var_1_16
	}, function(arg_2_0)
		if var_1_3 then
			var_1_15:consume({
				gold = 0,
				oil = var_1_13
			})
		end

		if var_1_2.enter_energy_cost > 0 and not var_1_18 then
			for iter_2_0, iter_2_1 in ipairs(var_1_4) do
				local var_2_0 = var_1_1:getShipById(iter_2_1)

				if var_2_0 then
					var_2_0:cosumeEnergy(pg.gameset.battle_consume_energy.key_value * var_1_19)
					var_1_1:updateShip(var_2_0)
				end
			end
		end

		var_1_0:updatePlayer(var_1_15)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = var_1_17,
			stageId = var_1_16,
			system = SYSTEM_SCENARIO,
			token = arg_2_0.key,
			exitCallback = arg_2_0.exitCallback
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)
		getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.UNKNOWN)

		return
	end)

	return
end

function BattleGateScenario:Exit(arg_4_1)
	if arg_4_1.CheaterVertify() then
		return
	end

	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = getProxy(ChapterProxy)
	local var_4_3 = self.statistics._battleScore
	local var_4_6 = {}
	local var_4_7 = var_4_2:getActiveChapter()
	local var_4_8 = var_4_7:getPlayType() == ChapterConst.TypeExtra
	local var_4_9 = var_4_7.fleet

	for iter_4_0, iter_4_1 in ipairs((var_4_7.fleet:getShips(true))) do
		table.insert(var_4_6, iter_4_1)
	end

	local var_4_10, var_4_11 = var_4_7:getFleetCost(var_4_9, self.stageId)
	local var_4_13 = var_4_11.oil

	if self.statistics.submarineAid then
		local var_4_14 = var_4_7:GetSubmarineFleet()

		if var_4_14 then
			local var_4_15 = 0

			for iter_4_2, iter_4_3 in ipairs(var_4_14:getShipsByTeam(TeamType.Submarine, true)) do
				if self.statistics[iter_4_3.id] then
					table.insert(var_4_6, iter_4_3)

					var_4_15 = var_4_15 + iter_4_3:getEndBattleExpend()
				end
			end

			if var_4_8 then
				var_4_15 = 0
			end

			var_4_13 = var_4_13 + math.min(var_4_15, var_4_7:GetLimitOilCost(true)) * var_4_7:GetExtraCostRate()
		else
			originalPrint("finish stage error: can not find submarine fleet.")
		end
	end

	local var_4_16 = var_4_3 > ys.Battle.BattleConst.BattleScore.C

	var_4_7:writeBack(var_4_3 > ys.Battle.BattleConst.BattleScore.C, self)
	var_4_2:updateChapter(var_4_7)
	arg_4_1:SendRequest(arg_4_1.GeneralPackage(self, var_4_6), function(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, self.statistics, true)

		self.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0, var_5_1 = arg_4_1:GeneralLoot(arg_5_0)

		arg_4_1.GeneralPlayerCosume(SYSTEM_SCENARIO, var_4_16, var_4_13, arg_5_0.player_exp, var_4_8)

		local var_5_2 = {
			system = SYSTEM_SCENARIO,
			statistics = self.statistics,
			score = var_4_3,
			drops = var_5_0,
			commanderExps = arg_4_1.GenerateCommanderExp(arg_5_0, var_4_2:getActiveChapter().fleet, var_4_7:GetSubmarineFleet()),
			result = arg_5_0.result,
			extraDrops = var_5_1,
			exitCallback = self.exitCallback
		}

		var_4_2:updateActiveChapterShips()

		local var_5_3 = var_4_2:getActiveChapter()

		var_5_3:writeDrops(var_5_0)
		var_4_2:updateChapter(var_5_3)

		if PlayerConst.CanDropItem(var_5_0) then
			local var_5_4 = {}

			for iter_5_0, iter_5_1 in ipairs(var_5_0) do
				table.insert(var_5_4, iter_5_1)
			end

			for iter_5_2, iter_5_3 in ipairs(var_5_1) do
				iter_5_3.riraty = true

				table.insert(var_5_4, iter_5_3)
			end

			local var_5_5 = getProxy(ChapterProxy):getActiveChapter(true)

			if var_5_5 then
				if var_5_5:isLoop() then
					getProxy(ChapterProxy):AddExtendChapterDataArray(var_5_5.id, "TotalDrops", var_5_4)
				end

				var_5_5:writeDrops(var_5_4)
			end
		end

		local var_5_6 = var_4_2:getLastUnlockMap().id
		local var_5_7 = var_4_2:getLastUnlockMap().id

		if Map.lastMap and var_5_7 ~= var_5_6 and var_5_6 < var_5_7 then
			Map.autoNextPage = true
		end

		arg_4_1:sendNotification(GAME.CHAPTER_BATTLE_RESULT_REQUEST, {
			callback = function()
				arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_5_2)

				return
			end
		})

		return
	end)

	return
end

function BattleGateScenario:GetPreloadList()
	local var_7_0 = {}
	local var_7_2 = getProxy(ChapterProxy)
	local var_7_3 = var_7_2:getActiveChapter()
	local var_7_4 = ys.Battle.BattleResourceManager.GetInstance()

	for iter_7_0, iter_7_1 in ipairs((var_7_3.fleet:getShips(false))) do
		table.insert(var_7_0, iter_7_1)
	end

	local var_7_5, var_7_6 = var_7_3:getFleetBattleBuffs(var_7_3.fleet)
	local var_7_7 = var_7_2.GetChapterAuraBuffs(var_7_3)

	for iter_7_2, iter_7_3 in pairs((var_7_2.GetChapterAidBuffs(var_7_3))) do
		for iter_7_4, iter_7_5 in ipairs(iter_7_3) do
			table.insert(var_7_7, iter_7_5)
		end
	end

	local var_7_8, var_7_9 = var_7_2.getSubAidFlag(var_7_3, self.stageId)

	if var_7_8 ~= true then
		if var_7_8 > 0 then
			for iter_7_6, iter_7_7 in ipairs((var_7_9:getShipsByTeam(TeamType.Submarine, false))) do
				table.insert(var_7_0, iter_7_7)
			end

			local var_7_10, var_7_11 = var_7_3:getFleetBattleBuffs(var_7_9)

			for iter_7_8, iter_7_9 in ipairs(var_7_10) do
				table.insert(var_7_5, iter_7_9)
			end

			for iter_7_10, iter_7_11 in ipairs(var_7_11) do
				table.insert(var_7_6, iter_7_11)
			end
		end
	end

	local var_7_12, var_7_13 = var_7_4.GetPlayerShipResource(var_7_0, self.system)

	for iter_7_12, iter_7_13 in ipairs((var_7_4.GetCommanderBuffRes(var_7_6))) do
		table.insert(var_7_12, iter_7_13)
	end

	for iter_7_14, iter_7_15 in ipairs((var_7_4.GetResFromBuffIDList(var_7_5))) do
		table.insert(var_7_12, iter_7_15)
	end

	for iter_7_16, iter_7_17 in ipairs((var_7_4.GetResFromBuffList(var_7_7))) do
		table.insert(var_7_12, iter_7_17)
	end

	return var_7_12, var_7_13
end

return BattleGateScenario
