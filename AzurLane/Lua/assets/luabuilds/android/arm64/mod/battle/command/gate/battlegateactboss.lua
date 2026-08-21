local var_0_0 = class("BattleGateActBoss")

ys.Battle.BattleGateActBoss = var_0_0
var_0_0.__name = "BattleGateActBoss"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.continuousBattleTimes
	local var_1_1 = arg_1_0.totalBattleTimes
	local var_1_2 = getProxy(ActivityProxy):getActivityById(arg_1_0.actId)
	local var_1_3 = pg.activity_event_worldboss[var_1_2:getConfig("config_id")]
	local var_1_4 = getProxy(PlayerProxy)
	local var_1_5 = getProxy(BayProxy)
	local var_1_6 = getProxy(FleetProxy)
	local var_1_7 = pg.battle_cost_template[SYSTEM_ACT_BOSS].oil_cost > 0
	local var_1_8 = {}
	local var_1_13 = arg_1_0.stageId
	local var_1_14 = arg_1_0.mainFleetId
	local var_1_15 = var_1_6:getActivityFleets()[arg_1_0.actId][arg_1_0.mainFleetId]

	for iter_1_0, iter_1_1 in ipairs((var_1_5:getSortShipsByFleet(var_1_15))) do
		var_1_8[#var_1_8 + 1] = iter_1_1.id
	end

	local var_1_16 = var_1_15:getStartCost().oil
	local var_1_17 = var_1_15:GetCostSum().oil

	if var_1_2:IsOilLimit(arg_1_0.stageId) and var_1_3.use_oil_limit[arg_1_0.mainFleetId][1] > 0 then
		var_1_17 = math.min(var_1_17, var_1_3.use_oil_limit[arg_1_0.mainFleetId][1])
	end

	local var_1_18 = var_1_4:getData()

	if var_1_7 and var_1_17 > var_1_18.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_19 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_ACT_BOSS, var_1_8, {
		arg_1_0.stageId
	}, function(arg_2_0)
		if var_1_7 then
			var_1_18:consume({
				gold = 0,
				oil = var_1_16
			})
		end

		if var_0.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_5:updateShip(iter_2_1)
			end
		end

		var_1_4:updatePlayer(var_1_18)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_14,
			actId = var_0,
			prefabFleet = var_1_19,
			stageId = var_1_13,
			system = SYSTEM_ACT_BOSS,
			token = arg_2_0.key,
			continuousBattleTimes = var_1_0,
			totalBattleTimes = var_1_1
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
	local var_4_2 = getProxy(ActivityProxy):getActivityById(arg_4_0.actId)
	local var_4_3 = pg.activity_event_worldboss[var_4_2:getConfig("config_id")].use_oil_limit[arg_4_0.mainFleetId]
	local var_4_4 = var_4_2:IsOilLimit(arg_4_0.stageId)
	local var_4_5 = getProxy(FleetProxy):getActivityFleets()[arg_4_0.actId]
	local var_4_6
	local var_4_7 = 0
	local var_4_8 = {}
	local var_4_9 = {}
	local var_4_10 = pg.battle_cost_template[SYSTEM_ACT_BOSS].oil_cost > 0
	local var_4_13 = var_4_5[arg_4_0.mainFleetId]

	if var_4_4 then
		local var_4_14 = var_4_3[1] or 0

		var_4_12(var_4_13, var_4_14)

		if arg_4_0.statistics.submarineAid then
			var_4_6 = var_4_5[arg_4_0.mainFleetId + 10]

			if var_4_5[arg_4_0.mainFleetId + 10] then
				local var_4_16 = var_4_5[arg_4_0.mainFleetId + 10]

				if var_4_4 then
					local var_4_17 = var_4_3[2] or 0

					var_4_15(var_4_16, var_4_17)

					if false then
						originalPrint("finish stage error: can not find submarin fleet.")
					end

					local var_4_18 = arg_4_1.GeneralPackage(arg_4_0, var_4_8)

					var_4_18.commander_id_list = var_4_9

					arg_4_1:SendRequest(var_4_18, function(arg_6_0)
						arg_4_1.addShipsExp(arg_6_0.ship_exp_list, arg_4_0.statistics, true)

						arg_4_0.statistics.mvpShipID = arg_6_0.mvp

						local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
						local var_6_2 = var_4_1 > ys.Battle.BattleConst.BattleScore.C
						local var_6_3 = arg_4_1.GenerateCommanderExp(arg_6_0, var_0, var_4_6)

						arg_4_1.GeneralPlayerCosume(SYSTEM_ACT_BOSS, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_7, arg_6_0.player_exp)

						local var_6_4

						if var_6_2 then
							var_6_4 = (function()
								local var_7_0 = getProxy(ActivityProxy):getActivityById(arg_4_0.actId)
								local var_7_1 = arg_4_0.stageId

								return var_7_0.data1KeyValueList[1][arg_4_0.stageId] == 1 and var_7_0.data1KeyValueList[2][var_7_1] <= 0
							end)()

							arg_4_1:sendNotification(GAME.ACT_BOSS_NORMAL_UPDATE, {
								stageId = arg_4_0.stageId
							})
						end

						local var_6_5 = {
							system = SYSTEM_ACT_BOSS,
							statistics = arg_4_0.statistics,
							score = var_4_1,
							drops = var_6_0,
							commanderExps = var_6_3,
							result = arg_6_0.result,
							extraDrops = var_6_1,
							isLastBonus = var_6_4
						}

						if PlayerConst.CanDropItem(var_6_0) then
							for iter_6_0, iter_6_1 in ipairs(var_6_0) do
								table.insert({}, iter_6_1)
							end

							for iter_6_2, iter_6_3 in ipairs(var_6_1) do
								iter_6_3.riraty = true

								table.insert({}, iter_6_3)
							end

							if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
								getProxy(ChapterProxy):AddActBossRewards({})
							end
						end

						arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_6_5)

						return
					end)

					return
				end
			end
		end
	end
end

function var_0_0.GetPreloadList(arg_8_0)
	local var_8_1 = ys.Battle.BattleResourceManager.GetInstance()
	local var_8_2 = getProxy(BayProxy)
	local var_8_3 = getProxy(FleetProxy):getActivityFleets()[arg_8_0.actId]

	if var_8_3[arg_8_0.mainFleetId] then
		for iter_8_0, iter_8_1 in ipairs(var_8_3[arg_8_0.mainFleetId].ships) do
			table.insert({}, var_8_2:getShipById(iter_8_1))
		end

		for iter_8_2, iter_8_3 in ipairs((var_8_3[arg_8_0.mainFleetId]:buildBattleBuffList())) do
			table.insert({}, iter_8_3)
		end
	end

	if var_8_3[arg_8_0.mainFleetId + 10] then
		for iter_8_4, iter_8_5 in ipairs((var_8_4:getTeamByName(TeamType.Submarine))) do
			table.insert({}, var_8_2:getShipById(iter_8_5))
		end

		for iter_8_6, iter_8_7 in ipairs((var_8_4:buildBattleBuffList())) do
			table.insert({}, iter_8_7)
		end
	end

	local var_8_5, var_8_6 = var_8_1.GetPlayerShipResource({}, arg_8_0.system)

	for iter_8_8, iter_8_9 in ipairs((var_8_1.GetCommanderBuffRes({}))) do
		table.insert(var_8_5, iter_8_9)
	end

	return var_8_5, var_8_6
end

return var_0_0
