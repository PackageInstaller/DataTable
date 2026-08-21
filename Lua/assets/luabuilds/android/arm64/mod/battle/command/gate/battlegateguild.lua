local var_0_0 = class("BattleGateGuild")

ys.Battle.BattleGateGuild = var_0_0
var_0_0.__name = "BattleGateGuild"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if pg.guildset.use_oil.key_value > getProxy(PlayerProxy):getRawData().oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_0 = var_0_0.GetGuildBossMission()

	for iter_1_0, iter_1_1 in ipairs((var_1_0:GetShipsSplitByUserID())) do
		table.insert({}, {
			ship_id = iter_1_1.shipID,
			user_id = iter_1_1.userID
		})
	end

	BeginStageCommand.SendRequest(SYSTEM_GUILD, var_1_0:GetMyShipIds(), {
		(var_1_0:GetStageID())
	}, function(arg_2_0)
		local var_2_0 = getProxy(GuildProxy)
		local var_2_1 = var_2_0:getData()

		var_2_1:getMemberById(var_0.id):AddLiveness(pg.guildset.operation_boss_guild_active.key_value)
		var_2_0:updateGuild(var_2_1)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = {},
			bossId = var_1_0.id,
			actId = var_1_0.id,
			stageId = var_0,
			system = SYSTEM_GUILD,
			token = arg_2_0.key
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end, {})

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(FleetProxy)
	local var_4_1 = arg_4_0.statistics._battleScore
	local var_4_2 = pg.guildset.use_oil.key_value
	local var_4_3 = var_0_0.GetGuildBossMission()
	local var_4_4 = var_4_3:GetMainFleet()

	for iter_4_0, iter_4_1 in pairs(var_4_4:getCommanders()) do
		table.insert({}, iter_4_1.id)
	end

	for iter_4_2, iter_4_3 in ipairs((var_4_4:GetShips())) do
		table.insert({}, iter_4_3.ship)
	end

	if arg_4_0.statistics.submarineAid then
		local var_4_5 = var_4_3:GetSubFleet()

		if var_4_5 then
			for iter_4_4, iter_4_5 in ipairs((var_4_5:GetShips())) do
				if arg_4_0.statistics[iter_4_5.ship.id] then
					table.insert({}, iter_4_5.ship)
				end
			end

			for iter_4_6, iter_4_7 in pairs(var_4_5:getCommanders()) do
				table.insert({}, iter_4_7.id)
			end
		else
			originalPrint("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_6 = 0
	local var_4_7 = 0

	for iter_4_8, iter_4_9 in ipairs({}) do
		if var_4_6 < arg_4_0.statistics[iter_4_9.id].output then
			var_4_7 = iter_4_9.id
			var_4_6 = arg_4_0.statistics[iter_4_9.id].output
		end
	end

	local var_4_8 = var_0_0.GeneralPackage(arg_4_0, {})

	var_4_8.commander_id_list = {}

	var_0_0.SendRequest(arg_4_1, var_4_8, function(arg_5_0)
		arg_4_0.statistics.mvpShipID = var_4_7

		local var_5_0, var_5_1 = arg_4_1:GeneralLoot(arg_5_0)
		local var_5_2 = arg_4_1.GenerateCommanderExp(arg_5_0, var_4_4, var_4_3:GetSubFleet())

		var_0_0.GeneralPlayerCosume(SYSTEM_GUILD, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_2, arg_5_0.player_exp, exFlag)
		var_0_0.UpdateGuildBossMission()
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_GUILD,
			statistics = arg_4_0.statistics,
			score = var_4_1,
			drops = var_5_0,
			commanderExps = var_5_2,
			result = arg_5_0.result,
			extraDrops = var_5_1
		})

		return
	end)

	return
end

function var_0_0.SendRequest(arg_6_0, arg_6_1, arg_6_2)
	pg.ConnectionMgr.GetInstance():Send(40003, arg_6_1, 40004, function(arg_7_0)
		if arg_7_0.result == 0 or arg_7_0.result == 6 then
			arg_6_2(arg_7_0)
		elseif arg_7_0.result == 20 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("guild_battle_result_boss_is_death"),
				onYes = function()
					pg.m02:sendNotification(GAME.QUIT_BATTLE)

					return
				end
			})
		elseif arg_7_0.result == 4 then
			pg.m02:sendNotification(GAME.QUIT_BATTLE)
		else
			arg_6_0:RequestFailStandardProcess(arg_7_0)
		end

		return
	end)

	return
end

function var_0_0.GetGuildBossMission()
	local var_9_0 = getProxy(GuildProxy):getData():GetActiveEvent()

	assert(var_9_0)

	local var_9_1 = var_9_0:GetBossMission()

	assert(var_9_1)

	return var_9_1
end

function var_0_0.UpdateGuildBossMission()
	local var_10_0 = getProxy(GuildProxy)
	local var_10_1 = var_10_0:getData()
	local var_10_2 = var_10_1:GetActiveEvent()

	assert(var_10_2)

	local var_10_3 = var_10_2:GetBossMission()

	assert(var_10_3)
	var_10_3:ReduceDailyCnt()
	var_10_0:ResetBossRankTime()
	var_10_0:ResetRefreshBossTime()
	var_10_0:updateGuild(var_10_1)

	return
end

function var_0_0.GeneralPlayerCosume(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = getProxy(PlayerProxy)
	local var_11_1 = var_11_0:getData()

	var_11_1:addExp(arg_11_3)
	var_11_1:consume({
		gold = 0,
		oil = arg_11_2
	})
	var_11_0:updatePlayer(var_11_1)

	return
end

function var_0_0.GeneralPackage(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3 = arg_12_0.system + arg_12_0.stageId + arg_12_0.statistics._battleScore
	local var_12_4 = getProxy(PlayerProxy):getRawData().id

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_5 = arg_12_0.statistics[iter_12_1.id]

		if arg_12_0.statistics[iter_12_1.id] then
			local var_12_6 = GuildAssaultFleet.GetRealId(var_12_5.id)
			local var_12_7 = math.floor(var_12_5.bp)
			local var_12_8 = math.floor(var_12_5.output)
			local var_12_9 = math.floor(var_12_5.maxDamageOnce)

			table.insert(GuildAssaultFleet.GetUserId(var_12_5.id) ~= var_12_4 and var_12_2 or var_12_1, {
				ship_id = var_12_6,
				hp_rest = var_12_7,
				damage_cause = var_12_8,
				damage_caused = math.max(0, math.floor(var_12_5.damage)),
				max_damage_once = var_12_9,
				ship_gear_score = math.floor(var_12_5.gearScore)
			})

			var_12_3 = var_12_3 + var_12_6 + var_12_7 + var_12_8 + var_12_9
			var_12_0 = var_12_0 + iter_12_1:getShipCombatPower()
		end
	end

	local var_12_10, var_12_11 = GetBattleCheckResult(var_12_3, arg_12_0.token, arg_12_0.statistics._totalTime)

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.statistics._enemyInfoList) do
		table.insert({}, {
			enemy_id = iter_12_3.id,
			damage_taken = iter_12_3.damage,
			total_hp = iter_12_3.totalHp
		})
	end

	return {
		system = arg_12_0.system,
		data = arg_12_0.stageId,
		score = arg_12_0.statistics._battleScore,
		key = var_12_10,
		statistics = var_12_1,
		otherstatistics = var_12_2,
		kill_id_list = arg_12_0.statistics.kill_id_list,
		total_time = arg_12_0.statistics._totalTime,
		bot_percentage = arg_12_0.statistics._botPercentage,
		extra_param = var_12_0,
		file_check = var_12_11,
		enemy_info = {},
		data2 = {},
		auto_before = arg_12_0.statistics._autoInit,
		auto_switch_time = arg_12_0.statistics._autoCount,
		auto_after = math.fmod(math.fmod(arg_12_0.statistics._autoCount, 2) + arg_12_0.statistics._autoInit, 2)
	}
end

function var_0_0.GetPreloadList(arg_13_0)
	local var_13_9000
	local var_13_2 = ys.Battle.BattleResourceManager.GetInstance()
	local var_13_3 = getProxy(GuildProxy)
	local var_13_4 = var_13_3.getRawData(var_13_9000):GetActiveEvent():GetBossMission()
	local var_13_5 = var_13_4.GetMainFleet(var_13_3)

	for iter_13_0, iter_13_1 in ipairs((var_13_5:GetShips())) do
		if iter_13_1 and iter_13_1.ship then
			table.insert({}, iter_13_1.ship)
		end
	end

	local var_13_6 = var_13_5:BuildBattleBuffList()
	local var_13_7 = var_13_4:GetSubFleet()

	for iter_13_2, iter_13_3 in ipairs((var_13_7:GetShips())) do
		if iter_13_3 and iter_13_3.ship then
			table.insert({}, iter_13_3.ship)
		end
	end

	for iter_13_4, iter_13_5 in ipairs((var_13_7:BuildBattleBuffList())) do
		table.insert(var_13_6, iter_13_5)
	end

	local var_13_8, var_13_9 = var_13_2.GetPlayerShipResource({}, arg_13_0.system)

	for iter_13_6, iter_13_7 in ipairs((var_13_2.GetCommanderBuffRes(var_13_6))) do
		table.insert(var_13_8, iter_13_7)
	end

	return var_13_8, var_13_9
end

return var_0_0
