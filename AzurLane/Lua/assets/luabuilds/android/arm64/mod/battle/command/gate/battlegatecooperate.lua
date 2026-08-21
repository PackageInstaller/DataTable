local var_0_0 = class("BattleGateCooperate")

ys.Battle.BattleGateCooperate = var_0_0
var_0_0.__name = "BattleGateCooperate"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2, var_1_3, var_1_4, var_1_5, var_1_6, var_1_7, var_1_8

	if BeginStageCommand.DockOverload() then
		do return end

		var_1_0 = getProxy(PlayerProxy)
		var_1_1 = getProxy(BayProxy)
		var_1_2 = getProxy(FleetProxy)
		var_1_3 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS].oil_cost > 0
		var_1_4 = {}
		var_1_5 = 0
		var_1_6 = 0
		var_1_7 = 0
		var_1_8 = 0
	end

	local var_1_9 = var_1_2:getActivityFleets()[arg_1_0.actId][Fleet.REGULAR_FLEET_ID]

	for iter_1_0, iter_1_1 in ipairs(var_1_9.ships) do
		var_1_4[#var_1_4 + 1] = iter_1_1
	end

	local var_1_10 = var_1_9:getStartCost().oil
	local var_1_11 = var_1_1:getSortShipsByFleet(var_1_9)
	local var_1_12 = var_1_0:getData()

	if var_1_3 and var_1_9:GetCostSum().oil > var_1_0:getData().oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_13 = arg_1_0.stageId
	local var_1_14 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab

	arg_1_1.ShipVertify()

	local var_1_15

	if chapter:getPlayType() == ChapterConst.TypeExtra then
		var_1_15 = true
	end

	BeginStageCommand.SendRequest(SYSTEM_HP_SHARE_ACT_BOSS, var_1_4, {
		var_1_13
	}, function(arg_2_0)
		if var_1_3 then
			var_1_12:consume({
				gold = 0,
				oil = var_1_10
			})
		end

		if var_0.enter_energy_cost > 0 and not var_1_15 then
			for iter_2_0, iter_2_1 in ipairs(var_1_11) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_1:updateShip(iter_2_1)
			end
		end

		var_1_0:updatePlayer(var_1_12)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = Fleet.REGULAR_FLEET_ID,
			prefabFleet = var_1_14,
			stageId = var_1_13,
			actId = var_0,
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
	if client.CheaterVertify() then
		return
	end

	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = getProxy(ChapterProxy)
	local var_4_3 = ys.Battle.BattleConst.BattleScore.S
	local var_4_7 = var_4_1:getActivityFleets()[arg_4_0.actId][arg_4_0.mainFleetId]
	local var_4_8 = bayProxy:getSortShipsByFleet(var_4_7)
	local var_4_9 = var_4_7:getEndCost().oil

	if arg_4_0.statistics.submarineAid then
		local var_4_10 = var_4_1:getActivityFleets()[arg_4_0.actId][Fleet.SUBMARINE_FLEET_ID]

		if var_4_10 then
			for iter_4_0, iter_4_1 in ipairs((bayProxy:getSortShipsByFleet(var_4_10))) do
				if arg_4_0.statistics[iter_4_1.id] then
					table.insert(var_4_8, iter_4_1)

					var_4_9 = var_4_9 + iter_4_1:getEndBattleExpend()
				end
			end
		else
			originalPrint("finish stage error: can not find submarine fleet.")
		end
	end

	local var_4_11 = client.GeneralPackage(arg_4_0, var_4_8)

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.statistics._enemyInfoList) do
		table.insert({}, {
			enemy_id = iter_4_3.id,
			damage_taken = iter_4_3.damage,
			total_hp = iter_4_3.totalHp
		})
	end

	var_4_11.enemy_info = {}

	client:SendRequest(var_4_11, function(arg_5_0)
		client.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics)

		arg_4_0.statistics.mvpShipID = arg_5_0.mvp

		local var_5_0, var_5_1 = client:GeneralLoot(arg_5_0)

		var_0_0.GeneralPlayerCosume(SYSTEM_HP_SHARE_ACT_BOSS, var_4_3 > ys.Battle.BattleConst.BattleScore.C, var_4_9, arg_5_0.player_exp)
		client:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_HP_SHARE_ACT_BOSS,
			statistics = arg_4_0.statistics,
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

return var_0_0
