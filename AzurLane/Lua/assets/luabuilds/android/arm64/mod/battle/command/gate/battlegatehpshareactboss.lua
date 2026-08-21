local var_0_0 = class("BattleGateHPShareActBoss")

ys.Battle.BattleGateHPShareActBoss = var_0_0
var_0_0.__name = "BattleGateHPShareActBoss"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.actId
	local var_1_1 = getProxy(ActivityProxy):getActivityById(arg_1_0.actId)
	local var_1_2 = pg.activity_event_worldboss[var_1_1:getConfig("config_id")]
	local var_1_3 = getProxy(PlayerProxy)
	local var_1_4 = getProxy(BayProxy)
	local var_1_5 = getProxy(FleetProxy)
	local var_1_6 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS].oil_cost > 0
	local var_1_7 = {}
	local var_1_12 = arg_1_0.stageId
	local var_1_13 = arg_1_0.mainFleetId
	local var_1_14 = var_1_5:getActivityFleets()[arg_1_0.actId][arg_1_0.mainFleetId]

	for iter_1_0, iter_1_1 in ipairs((var_1_4:getSortShipsByFleet(var_1_14))) do
		var_1_7[#var_1_7 + 1] = iter_1_1.id
	end

	local var_1_15 = var_1_14:getStartCost().oil
	local var_1_16 = var_1_14:GetCostSum().oil

	if var_1_1:IsOilLimit(arg_1_0.stageId) and var_1_2.use_oil_limit[arg_1_0.mainFleetId][1] > 0 then
		var_1_16 = math.min(var_1_16, var_1_2.use_oil_limit[arg_1_0.mainFleetId][1])
	end

	local var_1_17 = var_1_3:getData()

	if var_1_3:getRawData():getResource(pg.activity_event_worldboss[pg.activity_template[var_1_0].config_id].ticket) <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noTicket"))

		return
	end

	if var_1_6 and var_1_16 > var_1_17.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_18 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_HP_SHARE_ACT_BOSS, var_1_7, {
		arg_1_0.stageId
	}, function(arg_2_0)
		if var_1_6 then
			var_1_17:consume({
				gold = 0,
				oil = var_1_15
			})
		end

		;({})[id2res(var_0)] = 1

		var_1_17:consume({})

		if var_0.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_4:updateShip(iter_2_1)
			end
		end

		var_1_3:updatePlayer(var_1_17)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_13,
			actId = var_1_0,
			prefabFleet = var_1_18,
			stageId = var_1_12,
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

function var_0_0.Exit(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(BayProxy)

	arg_4_0.statistics._battleScore = ys.Battle.BattleConst.BattleScore.S

	local var_4_1 = getProxy(ActivityProxy):getActivityById(arg_4_0.actId)
	local var_4_2 = pg.activity_event_worldboss[var_4_1:getConfig("config_id")].use_oil_limit[arg_4_0.mainFleetId]
	local var_4_3 = var_4_1:IsOilLimit(arg_4_0.stageId)
	local var_4_4 = getProxy(FleetProxy):getActivityFleets()[arg_4_0.actId]
	local var_4_5
	local var_4_6 = 0
	local var_4_7 = {}
	local var_4_8 = {}
	local var_4_9 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS].oil_cost > 0
	local var_4_12 = var_4_4[arg_4_0.mainFleetId]

	if var_4_3 then
		local var_4_13 = var_4_2[1] or 0

		var_4_11(var_4_12, var_4_13)

		if arg_4_0.statistics.submarineAid then
			var_4_5 = var_4_4[arg_4_0.mainFleetId + 10]

			if var_4_4[arg_4_0.mainFleetId + 10] then
				local var_4_15 = var_4_4[arg_4_0.mainFleetId + 10]

				if var_4_3 then
					local var_4_16 = var_4_2[2] or 0

					var_4_14(var_4_15, var_4_16)

					if false then
						originalPrint("finish stage error: can not find submarin fleet.")
					end

					local var_4_17 = arg_4_1.GeneralPackage(arg_4_0, var_4_7)

					var_4_17.commander_id_list = var_4_8

					for iter_4_0, iter_4_1 in ipairs(arg_4_0.statistics._enemyInfoList) do
						table.insert({}, {
							enemy_id = iter_4_1.id,
							damage_taken = iter_4_1.damage,
							total_hp = iter_4_1.totalHp
						})
					end

					var_4_17.enemy_info = {}

					arg_4_1:SendRequest(var_4_17, function(arg_6_0)
						arg_4_1.addShipsExp(arg_6_0.ship_exp_list, arg_4_0.statistics, true)

						arg_4_0.statistics.mvpShipID = arg_6_0.mvp

						local var_6_0, var_6_1 = arg_4_1:GeneralLoot(arg_6_0)
						local var_6_2 = arg_4_1.GenerateCommanderExp(arg_6_0, var_0, var_4_5)

						arg_4_1.GeneralPlayerCosume(SYSTEM_HP_SHARE_ACT_BOSS, var_0 > ys.Battle.BattleConst.BattleScore.C, var_4_6, arg_6_0.player_exp)
						var_4_1:AddStage(arg_4_0.stageId)
						getProxy(ActivityProxy):updateActivity(var_4_1)
						arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
							system = SYSTEM_HP_SHARE_ACT_BOSS,
							statistics = arg_4_0.statistics,
							score = var_0,
							drops = var_6_0,
							commanderExps = var_6_2,
							result = arg_6_0.result,
							extraDrops = var_6_1
						})

						return
					end)

					return
				end
			end
		end
	end
end

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_0, var_7_1 = ys.Battle.BattleGateActBoss.GetPreloadList(arg_7_0)

	return var_7_0, var_7_1
end

return var_0_0
