local var_0_0 = class("BattleGateScenario")

ys.Battle.BattleGateScenario = var_0_0
var_0_0.__name = "BattleGateScenario"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if BeginStageCommand.DockOverload() then
		getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.DOCK_OVERLOADED)

		return
	end

	local var_1_0 = getProxy(PlayerProxy)
	local var_1_1 = getProxy(BayProxy)
	local var_1_2 = pg.battle_cost_template[SYSTEM_SCENARIO].oil_cost > 0
	local var_1_3 = {}
	local var_1_8 = getProxy(ChapterProxy):getActiveChapter()

	for iter_1_0, iter_1_1 in ipairs((var_1_8.fleet:getShips(false))) do
		var_1_3[#var_1_3 + 1] = iter_1_1.id
	end

	local var_1_9, var_1_10 = var_1_8:getFleetCost(var_1_8.fleet, arg_1_0.stageId)
	local var_1_12 = var_1_9.oil
	local var_1_14 = var_1_0:getData()

	if var_1_2 and var_1_9.oil + var_1_10.oil > var_1_0:getData().oil then
		getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.OIL_LACK)

		if not ItemTipPanel.ShowOilBuyTip(var_1_9.oil + var_1_10.oil) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))
		end

		return
	end

	local var_1_15 = arg_1_0.stageId
	local var_1_16 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab

	arg_1_1.ShipVertify()

	local var_1_17

	if var_1_8:getPlayType() == ChapterConst.TypeExtra then
		var_1_17 = true
	end

	local var_1_18 = var_1_8:GetExtraCostRate()

	BeginStageCommand.SendRequest(SYSTEM_SCENARIO, var_1_3, {
		var_1_15
	}, function(arg_2_0)
		if var_1_2 then
			var_1_14:consume({
				gold = 0,
				oil = var_1_12
			})
		end

		if var_0.enter_energy_cost > 0 and not var_1_17 then
			for iter_2_0, iter_2_1 in ipairs(var_1_3) do
				local var_2_0 = var_1_1:getShipById(iter_2_1)

				if var_2_0 then
					var_2_0:cosumeEnergy(pg.gameset.battle_consume_energy.key_value * var_1_18)
					var_1_1:updateShip(var_2_0)
				end
			end
		end

		var_1_0:updatePlayer(var_1_14)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = var_1_16,
			stageId = var_1_15,
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

function var_0_0.Exit(arg_4_0, arg_4_1)
	if arg_4_1.CheaterVertify() then
		return
	end

	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = getProxy(ChapterProxy)
	local var_4_3 = arg_4_0.statistics._battleScore
	local var_4_6 = {}
	local var_4_7 = var_4_2:getActiveChapter()
	local var_4_8 = var_4_7:getPlayType() == ChapterConst.TypeExtra
	local var_4_9 = var_4_7.fleet

	for iter_4_0, iter_4_1 in ipairs((var_4_7.fleet:getShips(true))) do
		table.insert(var_4_6, iter_4_1)
	end

	local var_4_10, var_4_11 = var_4_7:getFleetCost(var_4_9, arg_4_0.stageId)
	local var_4_13 = var_4_11.oil

	if arg_4_0.statistics.submarineAid then
		local var_4_14 = var_4_7:GetSubmarineFleet()

		if var_4_14 then
			local var_4_15 = 0

			for iter_4_2, iter_4_3 in ipairs(var_4_14:getShipsByTeam(TeamType.Submarine, true)) do
				if arg_4_0.statistics[iter_4_3.id] then
					table.insert(var_4_6, iter_4_3)

					var_4_15 = var_4_15 + iter_4_3:getEndBattleExpend()
				end
			end

			if var_4_8 then
				var_4_15 = 0
			end

			var_4_13 = var_4_11.oil + math.min(var_4_15, var_4_7:GetLimitOilCost(true)) * var_4_7:GetExtraCostRate()
		else
			originalPrint("finish stage error: can not find submarine fleet.")
		end
	end

	var_4_7:writeBack(var_4_3 > ys.Battle.BattleConst.BattleScore.C, arg_4_0)
	var_4_2:updateChapter(var_4_7)
	arg_4_1:SendRequest(arg_4_1.GeneralPackage(arg_4_0, var_4_6), function(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics, true)

		arg_4_0.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0, var_5_1 = arg_4_1:GeneralLoot(arg_5_0)

		arg_4_1.GeneralPlayerCosume(SYSTEM_SCENARIO, var_0, var_4_13, arg_5_0.player_exp, var_4_8)

		local var_5_2 = {
			system = SYSTEM_SCENARIO,
			statistics = arg_4_0.statistics,
			score = var_4_3,
			drops = var_5_0,
			commanderExps = arg_4_1.GenerateCommanderExp(arg_5_0, var_4_2:getActiveChapter().fleet, var_4_7:GetSubmarineFleet()),
			result = arg_5_0.result,
			extraDrops = var_5_1,
			exitCallback = arg_4_0.exitCallback
		}

		var_4_2:updateActiveChapterShips()

		local var_5_3 = var_4_2:getActiveChapter()

		var_5_3:writeDrops(var_5_0)
		var_4_2:updateChapter(var_5_3)

		if PlayerConst.CanDropItem(var_5_0) then
			for iter_5_0, iter_5_1 in ipairs(var_5_0) do
				table.insert({}, iter_5_1)
			end

			for iter_5_2, iter_5_3 in ipairs(var_5_1) do
				iter_5_3.riraty = true

				table.insert({}, iter_5_3)
			end

			local var_5_4 = getProxy(ChapterProxy):getActiveChapter(true)

			if var_5_4 then
				if var_5_4:isLoop() then
					getProxy(ChapterProxy):AddExtendChapterDataArray(var_5_4.id, "TotalDrops", {})
				end

				var_5_4:writeDrops({})
			end
		end

		local var_5_5 = var_4_2:getLastUnlockMap().id
		local var_5_6 = var_4_2:getLastUnlockMap().id

		if Map.lastMap and var_5_6 ~= var_5_5 and var_5_5 < var_5_6 then
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

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_1 = getProxy(ChapterProxy)
	local var_7_2 = var_7_1:getActiveChapter()
	local var_7_3 = ys.Battle.BattleResourceManager.GetInstance()

	for iter_7_0, iter_7_1 in ipairs((var_7_2.fleet:getShips(false))) do
		table.insert({}, iter_7_1)
	end

	local var_7_4, var_7_5 = var_7_2:getFleetBattleBuffs(var_7_2.fleet)
	local var_7_6 = var_7_1.GetChapterAuraBuffs(var_7_2)

	for iter_7_2, iter_7_3 in pairs((var_7_1.GetChapterAidBuffs(var_7_2))) do
		for iter_7_4, iter_7_5 in ipairs(iter_7_3) do
			table.insert(var_7_6, iter_7_5)
		end
	end

	local var_7_7, var_7_8 = var_7_1.getSubAidFlag(var_7_2, arg_7_0.stageId)

	if var_7_7 ~= true then
		if var_7_7 > 0 then
			for iter_7_6, iter_7_7 in ipairs((var_7_8:getShipsByTeam(TeamType.Submarine, false))) do
				table.insert({}, iter_7_7)
			end

			local var_7_9, var_7_10 = var_7_2:getFleetBattleBuffs(var_7_8)

			for iter_7_8, iter_7_9 in ipairs(var_7_9) do
				table.insert(var_7_4, iter_7_9)
			end

			for iter_7_10, iter_7_11 in ipairs(var_7_10) do
				table.insert(var_7_5, iter_7_11)
			end
		end

		local var_7_11, var_7_12 = var_7_3.GetPlayerShipResource({}, arg_7_0.system)

		for iter_7_12, iter_7_13 in ipairs((var_7_3.GetCommanderBuffRes(var_7_5))) do
			table.insert(var_7_11, iter_7_13)
		end

		for iter_7_14, iter_7_15 in ipairs((var_7_3.GetResFromBuffIDList(var_7_4))) do
			table.insert(var_7_11, iter_7_15)
		end

		for iter_7_16, iter_7_17 in ipairs((var_7_3.GetResFromBuffList(var_7_6))) do
			table.insert(var_7_11, iter_7_17)
		end

		return var_7_11, var_7_12
	end
end

return var_0_0
