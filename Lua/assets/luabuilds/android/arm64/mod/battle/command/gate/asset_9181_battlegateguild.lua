local BattleGateGuild = class("BattleGateGuild")

ys.Battle.BattleGateGuild = BattleGateGuild
BattleGateGuild.__name = "BattleGateGuild"

function BattleGateGuild:Entrance(arg_1_1)
	local var_1_0 = getProxy(PlayerProxy):getRawData()

	if pg.guildset.use_oil.key_value > var_1_0.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	local var_1_1 = BattleGateGuild.GetGuildBossMission()
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs((var_1_1:GetShipsSplitByUserID())) do
		table.insert(var_1_2, {
			ship_id = iter_1_1.shipID,
			user_id = iter_1_1.userID
		})
	end

	local var_1_3 = var_1_1:GetStageID()

	BeginStageCommand.SendRequest(SYSTEM_GUILD, var_1_1:GetMyShipIds(), {
		var_1_3
	}, function(arg_2_0)
		local var_2_0 = getProxy(GuildProxy)
		local var_2_1 = var_2_0:getData()

		var_2_1:getMemberById(var_1_0.id):AddLiveness(pg.guildset.operation_boss_guild_active.key_value)
		var_2_0:updateGuild(var_2_1)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = {},
			bossId = var_1_1.id,
			actId = var_1_1.id,
			stageId = var_1_3,
			system = SYSTEM_GUILD,
			token = arg_2_0.key
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end, var_1_2)

	return
end

function BattleGateGuild:Exit(arg_4_1)
	local var_4_0 = getProxy(FleetProxy)
	local var_4_1 = self.statistics._battleScore
	local var_4_2 = pg.guildset.use_oil.key_value
	local var_4_3 = {}
	local var_4_4 = BattleGateGuild.GetGuildBossMission()
	local var_4_5 = var_4_4:GetMainFleet()
	local var_4_6 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_5:getCommanders()) do
		table.insert(var_4_6, iter_4_1.id)
	end

	for iter_4_2, iter_4_3 in ipairs((var_4_5:GetShips())) do
		table.insert(var_4_3, iter_4_3.ship)
	end

	if self.statistics.submarineAid then
		local var_4_7 = var_4_4:GetSubFleet()

		if var_4_7 then
			for iter_4_4, iter_4_5 in ipairs((var_4_7:GetShips())) do
				if self.statistics[iter_4_5.ship.id] then
					table.insert(var_4_3, iter_4_5.ship)
				end
			end

			for iter_4_6, iter_4_7 in pairs(var_4_7:getCommanders()) do
				table.insert(var_4_6, iter_4_7.id)
			end
		else
			originalPrint("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_8 = 0
	local var_4_9 = 0

	for iter_4_8, iter_4_9 in ipairs(var_4_3) do
		if var_4_8 < self.statistics[iter_4_9.id].output then
			var_4_9 = iter_4_9.id
			var_4_8 = self.statistics[iter_4_9.id].output
		end
	end

	local var_4_10 = BattleGateGuild.GeneralPackage(self, var_4_3)

	var_4_10.commander_id_list = var_4_6

	BattleGateGuild.SendRequest(arg_4_1, var_4_10, function(arg_5_0)
		self.statistics.mvpShipID = var_4_9

		local var_5_0, var_5_1 = arg_4_1:GeneralLoot(arg_5_0)
		local var_5_2 = arg_4_1.GenerateCommanderExp(arg_5_0, var_4_5, var_4_4:GetSubFleet())

		BattleGateGuild.GeneralPlayerCosume(SYSTEM_GUILD, var_4_1 > ys.Battle.BattleConst.BattleScore.C, var_4_2, arg_5_0.player_exp, exFlag)
		BattleGateGuild.UpdateGuildBossMission()
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_GUILD,
			statistics = self.statistics,
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

function BattleGateGuild:SendRequest(arg_6_1, arg_6_2)
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
			self:RequestFailStandardProcess(arg_7_0)
		end

		return
	end)

	return
end

function BattleGateGuild.GetGuildBossMission()
	local var_9_0 = getProxy(GuildProxy):getData():GetActiveEvent()

	assert(var_9_0)

	local var_9_1 = var_9_0:GetBossMission()

	assert(var_9_1)

	return var_9_1
end

function BattleGateGuild.UpdateGuildBossMission()
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

function BattleGateGuild:GeneralPlayerCosume(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
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

function BattleGateGuild:GeneralPackage(arg_12_1)
	local var_12_0 = 0
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3 = self.system + self.stageId + self.statistics._battleScore
	local var_12_4 = getProxy(PlayerProxy):getRawData().id

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_5 = self.statistics[iter_12_1.id]

		if self.statistics[iter_12_1.id] then
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

	local var_12_10, var_12_11 = GetBattleCheckResult(var_12_3, self.token, self.statistics._totalTime)
	local var_12_12 = {}

	for iter_12_2, iter_12_3 in ipairs(self.statistics._enemyInfoList) do
		table.insert(var_12_12, {
			enemy_id = iter_12_3.id,
			damage_taken = iter_12_3.damage,
			total_hp = iter_12_3.totalHp
		})
	end

	return {
		system = self.system,
		data = self.stageId,
		score = self.statistics._battleScore,
		key = var_12_10,
		statistics = var_12_1,
		otherstatistics = var_12_2,
		kill_id_list = self.statistics.kill_id_list,
		total_time = self.statistics._totalTime,
		bot_percentage = self.statistics._botPercentage,
		extra_param = var_12_0,
		file_check = var_12_11,
		enemy_info = var_12_12,
		data2 = {},
		auto_before = self.statistics._autoInit,
		auto_switch_time = self.statistics._autoCount,
		auto_after = math.fmod(math.fmod(self.statistics._autoCount, 2) + self.statistics._autoInit, 2)
	}
end

function BattleGateGuild:GetPreloadList()
	local var_13_0 = {}
	local var_13_3 = ys.Battle.BattleResourceManager.GetInstance()
	local var_13_4 = getProxy(GuildProxy)
	local var_13_5 = var_13_4:getRawData():GetActiveEvent():GetBossMission()
	local var_13_6 = var_13_5.GetMainFleet(var_13_4)

	for iter_13_0, iter_13_1 in ipairs((var_13_6:GetShips())) do
		if iter_13_1 and iter_13_1.ship then
			table.insert(var_13_0, iter_13_1.ship)
		end
	end

	local var_13_7 = var_13_6:BuildBattleBuffList()
	local var_13_8 = var_13_5:GetSubFleet()

	for iter_13_2, iter_13_3 in ipairs((var_13_8:GetShips())) do
		if iter_13_3 and iter_13_3.ship then
			table.insert(var_13_0, iter_13_3.ship)
		end
	end

	for iter_13_4, iter_13_5 in ipairs((var_13_8:BuildBattleBuffList())) do
		table.insert(var_13_7, iter_13_5)
	end

	local var_13_9, var_13_10 = var_13_3.GetPlayerShipResource(var_13_0, self.system)

	for iter_13_6, iter_13_7 in ipairs((var_13_3.GetCommanderBuffRes(var_13_7))) do
		table.insert(var_13_9, iter_13_7)
	end

	return var_13_9, var_13_10
end

return BattleGateGuild
