class = var_0_10000

local var_0_0 = "FinishStageCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().system

	if var_0_1.CheaterVertify() then
		return
	end

	SYSTEM_WORLD_BOSS = var_4

	if var_1_0 == var_4 and var_2.isSimulate then
		SYSTEM_WORLD_BOSS_SIMULATE = var_1_0
	end

	ys = var_4

	var_4.Battle.BattleGate.Gates[var_1_0].Exit(var_2, arg_1_0)

	return
end

function var_0_1.CheaterVertify()
	ys = var_1_10000

	var_1_10000.Battle.BattleState.GenerateVertifyData()

	ys = var_0

	local var_2_0, var_2_1 = var_0.Battle.BattleState.Vertify()

	if not var_2_0 then
		pg = var_1_10002

		local var_2_2 = var_1_10002.m02
		local var_2_3 = var_2.sendNotification

		GAME = var_1_10005

		var_2_3(var_2_2, var_1_10005.CHEATER_MARK, {
			reason = var_2_1
		})
	end

	return not var_2_0
end

function var_0_1.GeneralPackage(arg_3_0, arg_3_1)
	local var_3_0 = 0
	local var_3_1 = {}
	local var_3_2 = arg_3_0.system
	local var_3_3
	local var_3_4 = arg_3_0.system

	SYSTEM_DUEL = var_1_10007

	if var_3_4 == var_1_10007 then
		var_3_3 = arg_3_0.rivalId
	else
		local var_3_5 = arg_3_0.system

		SYSTEM_WORLD_BOSS = var_1_10007

		if var_3_5 == var_1_10007 then
			var_3_3 = arg_3_0.bossId
		else
			var_3_3 = arg_3_0.stageId
		end
	end

	local var_3_6 = arg_3_0.statistics._battleScore
	local var_3_7 = var_3_2 + var_3_3 + var_3_6

	ipairs = var_1_10008

	for iter_3_0, iter_3_1 in var_1_10008(arg_3_1) do
		if arg_3_0.statistics[iter_3_1.id] then
			local var_3_8 = var_13.id

			math = var_1_10015
			var_1_10015 = var_1_10015.floor(var_13.bp)
			math = var_1_10016
			var_1_10016 = var_1_10016.floor(var_13.output)
			math = var_17

			local var_3_9 = var_17.max
			local var_3_10 = 0

			math = var_1_10020

			local var_3_11 = var_3_9(var_3_10, var_1_10020.floor(var_13.damage))

			math = var_18

			local var_3_12 = var_18.floor(var_13.maxDamageOnce)

			math = var_3_10

			local var_3_13 = var_3_10.floor(var_13.gearScore)

			table = var_1_10020

			var_1_10020.insert(var_3_1, {
				ship_id = var_3_8,
				hp_rest = var_1_10015,
				damage_cause = var_1_10016,
				damage_caused = var_3_11,
				max_damage_once = var_3_12,
				ship_gear_score = var_3_13
			})

			var_3_7 = var_3_7 + var_3_8 + var_1_10015 + var_1_10016 + var_3_12
			var_3_0 = var_3_0 + iter_3_1:getShipCombatPower()
		end
	end

	GetBattleCheckResult = var_8

	local var_3_14, var_3_15 = var_8(var_3_7, arg_3_0.token, arg_3_0.statistics._totalTime)

	math = var_10

	local var_3_16 = var_10.fmod(arg_3_0.statistics._autoCount, 2)

	math = var_11

	local var_3_17 = var_11.fmod(var_3_16 + arg_3_0.statistics._autoInit, 2)

	return {
		system = var_3_2,
		data = var_3_3,
		score = var_3_6,
		key = var_3_14,
		statistics = var_3_1,
		kill_id_list = arg_3_0.statistics.kill_id_list,
		total_time = arg_3_0.statistics._totalTime,
		bot_percentage = arg_3_0.statistics._botPercentage,
		extra_param = var_3_0,
		file_check = var_3_15,
		boss_hp = arg_3_0.statistics._maxBossHP,
		enemy_info = {},
		data2 = {},
		auto_before = arg_3_0.statistics._autoInit,
		auto_switch_time = arg_3_0.statistics._autoCount,
		auto_after = var_3_17
	}
end

function var_0_1.SendRequest(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	local var_4_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_4_0, 40003, arg_4_1, 40004, function(arg_5_0)
		if arg_5_0.result == 0 or arg_5_0.result == 6 then
			arg_4_2(arg_5_0)
		else
			local var_5_0 = arg_4_0

			var_1.RequestFailStandardProcess(var_5_0, arg_5_0)
		end

		return
	end)

	return
end

function var_0_1.RequestFailStandardProcess(arg_6_0, arg_6_1)
	local var_6_1

	if arg_6_1.result == 2 then
		originalPrint = var_6_1

		var_6_1("stage_finishStage error--" .. arg_6_1.result)

		pg = var_6_1

		local var_6_0 = var_6_1.TipsMgr.GetInstance()

		var_6_1 = var_6_1.ShowTips
		errorTip = var_5

		var_6_1(var_6_0, var_5("stage_finishStage", arg_6_1.result))

		local var_6_2 = arg_6_0

		var_6_1 = arg_6_0.sendNotification
		GAME = var_5

		var_6_1(var_6_2, var_5.FINISH_STAGE_ERROR, {})
	else
		originalPrint = var_6_1

		var_6_1("stage_finishStage error--" .. arg_6_1.result)

		pg = var_6_1

		local var_6_3 = var_6_1.TipsMgr.GetInstance()
		local var_6_4 = var_2.ShowTips

		errorTip = var_5

		var_6_4(var_6_3, var_5("stage_finishStage", arg_6_1.result))
	end

	return
end

function var_0_1.addShipsExp(arg_7_0, arg_7_1, arg_7_2)
	getProxy = var_1_10003
	BayProxy = var_1_10005

	local var_7_0 = var_1_10003(var_1_10005)
	local var_7_1 = {}
	local var_7_2 = {}

	ipairs = var_1_10006

	for iter_7_0, iter_7_1 in var_1_10006(arg_7_0) do
		local var_7_3 = iter_7_1.ship_id
		local var_7_4

		if not iter_7_1.exp then
			var_7_4 = 0
		end

		local var_7_5 = iter_7_1.intimacy
		local var_7_6 = iter_7_1.energy

		if arg_7_1[var_7_3] then
			local var_7_7 = var_7_0:getShipById(var_7_3)

			var_15.addExp(var_7_7, var_7_4, arg_7_2)

			if arg_7_2 then
				pg = var_16

				if var_16.gameset.level_get_proficency.key_value < var_15.level or var_15.level == var_16 and var_15.exp > 0 then
					pg = var_17

					if var_17.ship_data_template[var_15.configId].can_get_proficency == 1 then
						getProxy = var_18
						NavalAcademyProxy = var_20

						local var_7_8 = var_18(var_20)

						var_18.AddCourseProficiency(var_7_8, var_7_4)
					end
				end
			end

			if var_7_5 then
				var_15:addLikability(var_7_5 - 16)
			end

			if var_7_6 then
				var_15:cosumeEnergy(var_7_6)
			end

			var_7_0:updateShip(var_15)
		end
	end

	return
end

function var_0_1.DeadShipEnergyCosume(arg_8_0, arg_8_1)
	pg = var_1_10002

	local var_8_0 = var_1_10002.gameset.battle_dead_energy.key_value

	getProxy = var_1_10003
	BayProxy = var_1_10005

	local var_8_1 = var_1_10003(var_1_10005)

	ipairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(arg_8_1) do
		if arg_8_0.statistics[iter_8_1.id] and var_9.bp == 0 then
			local var_8_2 = var_8_1:getShipById(iter_8_1.id)

			var_10.cosumeEnergy(var_8_2, var_8_0)
			var_8_1:updateShip(var_10)
		end
	end

	return
end

function var_0_1.GeneralPlayerCosume(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_9_0 = var_1_10005(var_1_10007)
	local var_9_1 = var_5.getData(var_9_0)

	var_6.addExp(var_9_1, arg_9_3)

	pg = var_7

	if var_7.battle_cost_template[arg_9_0].oil_cost > 0 and arg_9_1 then
		var_6:consume({
			gold = 0,
			oil = arg_9_2
		})
	end

	if var_7.attack_count > 0 and not arg_9_4 then
		if var_7.attack_count == 1 then
			var_6:increaseAttackCount()

			if arg_9_1 then
				var_6:increaseAttackWinCount()
			end
		elseif var_7.attack_count == 2 then
			var_6:increasePvpCount()

			if arg_9_1 then
				var_6:increasePvpWinCount()
			end
		end
	end

	var_5:updatePlayer(var_6)

	return
end

function var_0_1.GeneralLoot(arg_10_0, arg_10_1)
	local var_10_0 = {
		drops = arg_10_1.drop_info,
		extraDrops = arg_10_1.extra_drop_info
	}

	pairs = var_3

	for iter_10_0, iter_10_1 in var_3(var_10_0) do
		PlayerConst = var_1_10008
		var_10_0[iter_10_0] = var_1_10008.addTranDrop(iter_10_1)
		underscore = var_1_10008

		var_1_10008.each(var_10_0[iter_10_0], function(arg_11_0)
			local var_11_0 = arg_11_0.type

			DROP_TYPE_SHIP = var_2_10002

			if var_11_0 == var_2_10002 then
				pg = var_11_0

				local var_11_1 = var_11_0.ship_data_template[arg_11_0.id].group_type

				getProxy = var_2
				CollectionProxy = var_2_10004
				arg_11_0.virgin = var_2(var_2_10004) and var_2.shipGroups[var_11_1] == nil
			end

			return
		end)
	end

	return var_10_0.drops, var_10_0.extraDrops
end

function var_0_1.GenerateCommanderExp(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.commander_exp

	getProxy = var_1_10004
	CommanderProxy = var_1_10006

	local var_12_1 = var_1_10004(var_1_10006)
	local var_12_2 = (function(arg_13_0)
		local var_13_0 = arg_13_0
		local var_13_1 = arg_13_0.getCommanders(var_13_0)
		local var_13_2 = {}

		pairs = var_13_0

		for iter_13_0, iter_13_1 in var_13_0(var_13_1) do
			local var_13_3 = iter_13_1.id
			local var_13_4 = var_12_1
			local var_13_5 = var_9.getCommanderById(var_13_4, var_13_3).exp
			local var_13_6

			ipairs = var_12

			for iter_13_2, iter_13_3 in var_12(var_12_0) do
				if iter_13_3.commander_id == var_13_3 then
					var_13_6 = iter_13_3

					break
				end
			end

			local var_13_7

			if not var_13_6 or not var_13_6.exp then
				var_13_7 = 0
			end

			var_9:addExp(var_13_7)

			local var_13_8 = var_12_1

			var_13.updateCommander(var_13_8, var_9)

			table = var_13

			var_13.insert(var_13_2, {
				commander_id = var_13_3,
				exp = var_13_7,
				curExp = var_13_5
			})
		end

		return var_13_2
	end)(arg_12_1)
	local var_12_3 = {}

	if arg_12_2 then
		var_12_3 = var_5(arg_12_2)
	end

	return {
		surfaceCMD = var_12_2,
		submarineCMD = var_12_3
	}
end

return var_0_1
