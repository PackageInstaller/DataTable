local var_0_0 = class("FinishStageCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.system

	if var_0_0.CheaterVertify() then
		return
	end

	if var_1_1 == SYSTEM_WORLD_BOSS and var_1_0.isSimulate then
		var_1_1 = SYSTEM_WORLD_BOSS_SIMULATE
	end

	ys.Battle.BattleGate.Gates[var_1_1].Exit(var_1_0, arg_1_0)

	return
end

function var_0_0.CheaterVertify()
	ys.Battle.BattleState.GenerateVertifyData()

	local var_2_0, var_2_1 = ys.Battle.BattleState.Vertify()

	if not var_2_0 then
		pg.m02:sendNotification(GAME.CHEATER_MARK, {
			reason = var_2_1
		})
	end

	return not var_2_0
end

function var_0_0.GeneralPackage(arg_3_0, arg_3_1)
	local var_3_0 = 0
	local var_3_1 = {}
	local var_3_2 = arg_3_0.system
	local var_3_3 = arg_3_0.system == SYSTEM_DUEL and arg_3_0.rivalId or arg_3_0.system == SYSTEM_WORLD_BOSS and arg_3_0.bossId or arg_3_0.stageId
	local var_3_4 = arg_3_0.statistics._battleScore
	local var_3_5 = var_3_2 + var_3_3 + arg_3_0.statistics._battleScore

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if arg_3_0.statistics[iter_3_1.id] then
			local var_3_6 = math.floor(arg_3_0.statistics[iter_3_1.id].bp)
			local var_3_7 = math.floor(arg_3_0.statistics[iter_3_1.id].output)
			local var_3_8 = math.floor(arg_3_0.statistics[iter_3_1.id].maxDamageOnce)

			table.insert(var_3_1, {
				ship_id = arg_3_0.statistics[iter_3_1.id].id,
				hp_rest = var_3_6,
				damage_cause = var_3_7,
				damage_caused = math.max(0, math.floor(arg_3_0.statistics[iter_3_1.id].damage)),
				max_damage_once = var_3_8,
				ship_gear_score = math.floor(arg_3_0.statistics[iter_3_1.id].gearScore)
			})

			var_3_5 = var_3_5 + arg_3_0.statistics[iter_3_1.id].id + var_3_6 + var_3_7 + var_3_8
			var_3_0 = var_3_0 + iter_3_1:getShipCombatPower()
		end
	end

	local var_3_9, var_3_10 = GetBattleCheckResult(var_3_5, arg_3_0.token, arg_3_0.statistics._totalTime)

	return {
		system = var_3_2,
		data = var_3_3,
		score = var_3_4,
		key = var_3_9,
		statistics = var_3_1,
		kill_id_list = arg_3_0.statistics.kill_id_list,
		total_time = arg_3_0.statistics._totalTime,
		bot_percentage = arg_3_0.statistics._botPercentage,
		extra_param = var_3_0,
		file_check = var_3_10,
		boss_hp = arg_3_0.statistics._maxBossHP,
		enemy_info = {},
		data2 = {},
		auto_before = arg_3_0.statistics._autoInit,
		auto_switch_time = arg_3_0.statistics._autoCount,
		auto_after = math.fmod(math.fmod(arg_3_0.statistics._autoCount, 2) + arg_3_0.statistics._autoInit, 2)
	}
end

function var_0_0.SendRequest(arg_4_0, arg_4_1, arg_4_2)
	pg.ConnectionMgr.GetInstance():Send(40003, arg_4_1, 40004, function(arg_5_0)
		if arg_5_0.result == 0 or arg_5_0.result == 6 then
			arg_4_2(arg_5_0)
		else
			arg_4_0:RequestFailStandardProcess(arg_5_0)
		end

		return
	end)

	return
end

function var_0_0.RequestFailStandardProcess(arg_6_0, arg_6_1)
	if arg_6_1.result == 2 then
		originalPrint("stage_finishStage error--" .. arg_6_1.result)
		pg.TipsMgr.GetInstance():ShowTips(errorTip("stage_finishStage", arg_6_1.result))
		arg_6_0:sendNotification(GAME.FINISH_STAGE_ERROR, {})
	else
		originalPrint("stage_finishStage error--" .. arg_6_1.result)
		pg.TipsMgr.GetInstance():ShowTips(errorTip("stage_finishStage", arg_6_1.result))
	end

	return
end

function var_0_0.addShipsExp(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = getProxy(BayProxy)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		local var_7_3 = iter_7_1.exp or 0
		local var_7_4 = iter_7_1.intimacy

		if arg_7_1[iter_7_1.ship_id] then
			local var_7_5 = var_7_0:getShipById(iter_7_1.ship_id)

			var_7_5:addExp(var_7_3, arg_7_2)

			if arg_7_2 then
				if (pg.gameset.level_get_proficency.key_value < var_7_5.level or var_7_5.level == pg.gameset.level_get_proficency.key_value and var_7_5.exp > 0) and pg.ship_data_template[var_7_5.configId].can_get_proficency == 1 then
					getProxy(NavalAcademyProxy):AddCourseProficiency(var_7_3)
				end
			end

			if var_7_4 then
				var_7_5:addLikability(var_7_4 - 16)
			end

			if iter_7_1.energy then
				var_7_5:cosumeEnergy(iter_7_1.energy)
			end

			var_7_0:updateShip(var_7_5)
		end
	end

	return
end

function var_0_0.DeadShipEnergyCosume(arg_8_0, arg_8_1)
	local var_8_0 = getProxy(BayProxy)

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if arg_8_0.statistics[iter_8_1.id] and arg_8_0.statistics[iter_8_1.id].bp == 0 then
			local var_8_1 = var_8_0:getShipById(iter_8_1.id)

			var_8_1:cosumeEnergy(pg.gameset.battle_dead_energy.key_value)
			var_8_0:updateShip(var_8_1)
		end
	end

	return
end

function var_0_0.GeneralPlayerCosume(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = getProxy(PlayerProxy)
	local var_9_1 = var_9_0:getData()

	var_9_1:addExp(arg_9_3)

	if pg.battle_cost_template[arg_9_0].oil_cost > 0 and arg_9_1 then
		var_9_1:consume({
			gold = 0,
			oil = arg_9_2
		})
	end

	if pg.battle_cost_template[arg_9_0].attack_count > 0 and not arg_9_4 then
		if pg.battle_cost_template[arg_9_0].attack_count == 1 then
			var_9_1:increaseAttackCount()

			if arg_9_1 then
				var_9_1:increaseAttackWinCount()
			end
		elseif pg.battle_cost_template[arg_9_0].attack_count == 2 then
			var_9_1:increasePvpCount()

			if arg_9_1 then
				var_9_1:increasePvpWinCount()
			end
		end
	end

	var_9_0:updatePlayer(var_9_1)

	return
end

function var_0_0.GeneralLoot(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs({
		drops = arg_10_1.drop_info,
		extraDrops = arg_10_1.extra_drop_info
	}) do
		({
			drops = arg_10_1.drop_info,
			extraDrops = arg_10_1.extra_drop_info
		})[iter_10_0] = PlayerConst.addTranDrop(iter_10_1)

		underscore.each(({
			drops = arg_10_1.drop_info,
			extraDrops = arg_10_1.extra_drop_info
		})[iter_10_0], function(arg_11_0)
			if arg_11_0.type == DROP_TYPE_SHIP then
				local var_11_0 = getProxy(CollectionProxy)

				arg_11_0.virgin = var_11_0 and var_11_0.shipGroups[pg.ship_data_template[arg_11_0.id].group_type] == nil
			end

			return
		end)
	end

	return ({
		drops = arg_10_1.drop_info,
		extraDrops = arg_10_1.extra_drop_info
	}).drops, ({
		drops = arg_10_1.drop_info,
		extraDrops = arg_10_1.extra_drop_info
	}).extraDrops
end

function var_0_0.GenerateCommanderExp(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.commander_exp
	local var_12_1 = getProxy(CommanderProxy)
	local var_12_2 = {}

	if arg_12_2 then
		var_12_2 = (function(arg_13_0)
			local var_13_0 = {}

			for iter_13_0, iter_13_1 in pairs((arg_13_0:getCommanders())) do
				local var_13_1 = iter_13_1.id
				local var_13_2 = var_12_1:getCommanderById(iter_13_1.id)
				local var_13_3 = var_13_2.exp
				local var_13_4

				for iter_13_2, iter_13_3 in ipairs(var_12_0) do
					if iter_13_3.commander_id == var_13_1 then
						var_13_4 = iter_13_3

						break
					end
				end

				if var_13_4 then
					local var_13_5 = var_13_4.exp or 0

					var_13_2:addExp(var_13_5)
					var_12_1:updateCommander(var_13_2)
					table.insert(var_13_0, {
						commander_id = var_13_1,
						exp = var_13_5,
						curExp = var_13_3
					})
				end
			end

			return var_13_0
		end)(arg_12_2)
	end

	return {
		surfaceCMD = (function(arg_13_0)
			local var_13_0 = {}

			for iter_13_0, iter_13_1 in pairs((arg_13_0:getCommanders())) do
				local var_13_1 = iter_13_1.id
				local var_13_2 = var_12_1:getCommanderById(iter_13_1.id)
				local var_13_3 = var_13_2.exp
				local var_13_4

				for iter_13_2, iter_13_3 in ipairs(var_12_0) do
					if iter_13_3.commander_id == var_13_1 then
						var_13_4 = iter_13_3

						break
					end
				end

				if var_13_4 then
					local var_13_5 = var_13_4.exp or 0

					var_13_2:addExp(var_13_5)
					var_12_1:updateCommander(var_13_2)
					table.insert(var_13_0, {
						commander_id = var_13_1,
						exp = var_13_5,
						curExp = var_13_3
					})
				end
			end

			return var_13_0
		end)(arg_12_1),
		submarineCMD = var_12_2
	}
end

return var_0_0
