class = var_0_10000

local var_0_0 = var_0_10000("BattleGateGuild")

ys = var_1
var_1.Battle.BattleGateGuild = var_0_0
var_0_0.__name = "BattleGateGuild"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.guildset.use_oil.key_value

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_1_1 = var_1_10003(var_1_10004)

	if var_3.getRawData(var_1_1).oil < var_1_0 then
		pg = var_4

		local var_1_2 = var_4.TipsMgr.GetInstance()
		local var_1_3 = var_4.ShowTips

		i18n = var_1_10006

		var_1_3(var_1_2, var_1_10006("stage_beginStage_error_noResource"))

		return
	end

	local var_1_4 = var_0_0.GetGuildBossMission()
	local var_1_5 = var_4.GetMyShipIds(var_1_4)
	local var_1_6 = var_4:GetShipsSplitByUserID()
	local var_1_7 = {}

	ipairs = var_1_10008

	for iter_1_0, iter_1_1 in var_1_10008(var_1_6) do
		table = var_1_10013

		var_1_10013.insert(var_1_7, {
			ship_id = iter_1_1.shipID,
			user_id = iter_1_1.userID
		})
	end

	local var_1_8 = var_4:GetStageID()

	local function var_1_9(arg_2_0)
		local var_2_0 = {
			prefabFleet = {},
			bossId = var_0.id,
			actId = var_0.id,
			stageId = var_1_8
		}

		SYSTEM_GUILD = var_2
		var_2_0.system = var_2
		var_2_0.token = arg_2_0.key
		getProxy = var_2
		GuildProxy = var_2_10003

		local var_2_1 = var_2(var_2_10003)
		local var_2_2 = var_2.getData(var_2_1)

		pg = var_2_1

		local var_2_3 = var_2_1.guildset.operation_boss_guild_active.key_value
		local var_2_4 = var_2_2:getMemberById(var_0.id)

		var_5.AddLiveness(var_2_4, var_2_3)
		var_2:updateGuild(var_2_2)

		local var_2_5 = arg_1_1
		local var_2_6 = var_6.sendNotification

		GAME = var_8

		var_2_6(var_2_5, var_8.BEGIN_STAGE_DONE, var_2_0)

		return
	end

	local function var_1_10(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = iter_1_0

	local var_1_11 = iter_1_0.SendRequest

	SYSTEM_GUILD = iter_1_1

	var_1_11(iter_1_1, var_1_5, {
		var_1_8
	}, var_1_9, var_1_10, var_1_7)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)
	local var_4_1 = arg_4_0.statistics._battleScore

	pg = var_1_10004

	local var_4_2 = var_1_10004.guildset.use_oil.key_value
	local var_4_3 = {}
	local var_4_4 = var_0_0.GetGuildBossMission()
	local var_4_5 = var_6.GetMainFleet(var_4_4)
	local var_4_6 = {}

	pairs = var_1_10009

	for iter_4_0, iter_4_1 in var_1_10009(var_4_5:getCommanders()) do
		table = var_1_10014

		var_1_10014.insert(var_4_6, iter_4_1.id)
	end

	local var_4_7 = var_4_5
	local var_4_8 = var_4_5.GetShips(var_4_7)

	ipairs = var_4_7

	for iter_4_2, iter_4_3 in var_4_7(var_4_8) do
		table = var_1_10015

		var_1_10015.insert(var_4_3, iter_4_3.ship)
	end

	local var_4_10

	if arg_4_0.statistics.submarineAid then
		local var_4_9 = var_6

		if var_6.GetSubFleet(var_4_9) then
			var_4_10 = var_10
			var_4_9 = var_10.GetShips(var_4_10)
			ipairs = var_4_10

			for iter_4_4, iter_4_5 in var_4_10(var_4_9) do
				var_1_10017 = iter_4_5.ship

				if arg_4_0.statistics[var_1_10017.id] then
					table = var_18

					var_18.insert(var_4_3, var_1_10017)
				end
			end

			pairs = var_4_10

			for iter_4_6, iter_4_7 in var_4_10(var_10:getCommanders()) do
				table = var_1_10017

				var_1_10017.insert(var_4_6, iter_4_7.id)
			end
		else
			originalPrint = var_4_9

			var_4_9("finish stage error: can not find submarin fleet.")
		end
	end

	local var_4_11 = 0
	local var_4_12 = 0

	ipairs = var_4_10

	for iter_4_8, iter_4_9 in var_4_10(var_4_3) do
		if var_4_11 < arg_4_0.statistics[iter_4_9.id].output then
			var_4_12 = iter_4_9.id
			var_4_11 = var_17.output
		end
	end

	local var_4_13 = var_0_0.GeneralPackage(arg_4_0, var_4_3)

	var_4_13.commander_id_list = var_4_6

	local function var_4_14(arg_5_0)
		arg_4_0.statistics.mvpShipID = var_4_12

		local var_5_0 = arg_4_1
		local var_5_1, var_5_2 = var_1.GeneralLoot(var_5_0, arg_5_0)
		local var_5_3 = var_4_1

		ys = var_2_10004

		local var_5_4 = var_5_3 > var_2_10004.Battle.BattleConst.BattleScore.C
		local var_5_5 = arg_4_1.GenerateCommanderExp
		local var_5_6 = arg_5_0
		local var_5_7 = var_4_5
		local var_5_8 = var_0
		local var_5_9 = var_5_5(var_5_6, var_5_7, var_7.GetSubFleet(var_5_8))
		local var_5_10 = var_0_0.GeneralPlayerCosume

		SYSTEM_GUILD = var_5_7

		local var_5_11 = var_5_4
		local var_5_12 = var_4_2
		local var_5_13 = arg_5_0.player_exp

		exFlag = var_2_10010

		var_5_10(var_5_7, var_5_11, var_5_12, var_5_13, var_2_10010)

		local var_5_14 = {}

		SYSTEM_GUILD = var_5_7
		var_5_14.system = var_5_7
		var_5_14.statistics = arg_4_0.statistics
		var_5_14.score = var_4_1
		var_5_14.drops = var_5_1
		var_5_14.commanderExps = var_5_9
		var_5_14.result = arg_5_0.result
		var_5_14.extraDrops = var_5_2

		var_0_0.UpdateGuildBossMission()

		local var_5_15 = arg_4_1
		local var_5_16 = var_6.sendNotification

		GAME = var_5_12

		var_5_16(var_5_15, var_5_12.FINISH_STAGE_DONE, var_5_14)

		return
	end

	var_0_0.SendRequest(arg_4_1, var_4_13, var_4_14)

	return
end

function var_0_0.SendRequest(arg_6_0, arg_6_1, arg_6_2)
	pg = var_1_10003

	local var_6_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_6_0, 40003, arg_6_1, 40004, function(arg_7_0)
		if arg_7_0.result == 0 or arg_7_0.result == 6 then
			arg_6_2(arg_7_0)
		elseif arg_7_0.result == 20 then
			pg = var_1

			local var_7_0 = var_1.MsgboxMgr.GetInstance()
			local var_7_1 = var_1.ShowMsgBox

			var_2_10003 = {
				hideNo = true
			}
			i18n = var_2_10004
			var_2_10003.content = var_2_10004("guild_battle_result_boss_is_death")

			function var_2_10003.onYes()
				pg = var_3_10000

				local var_8_0 = var_3_10000.m02
				local var_8_1 = var_0.sendNotification

				GAME = var_3_10002

				var_8_1(var_8_0, var_3_10002.QUIT_BATTLE)

				return
			end

			var_7_1(var_7_0, var_2_10003)
		elseif arg_7_0.result == 4 then
			pg = var_1

			local var_7_2 = var_1.m02
			local var_7_3 = var_1.sendNotification

			GAME = var_2_10003

			var_7_3(var_7_2, var_2_10003.QUIT_BATTLE)
		else
			local var_7_4 = arg_6_0

			var_1.RequestFailStandardProcess(var_7_4, arg_7_0)
		end

		return
	end)

	return
end

function var_0_0.GetGuildBossMission()
	getProxy = var_1_10000
	GuildProxy = var_1_10001

	local var_9_0 = var_1_10000(var_1_10001)
	local var_9_1 = var_0.getData(var_9_0)
	local var_9_2 = var_0.GetActiveEvent(var_9_1)

	assert = var_9_1

	var_9_1(var_9_2)

	local var_9_3 = var_9_2
	local var_9_4 = var_9_2.GetBossMission(var_9_3)

	assert = var_9_3

	var_9_3(var_9_4)

	return var_9_4
end

function var_0_0.UpdateGuildBossMission()
	getProxy = var_1_10000
	GuildProxy = var_1_10001

	local var_10_0 = var_1_10000(var_1_10001)
	local var_10_1 = var_0.getData(var_10_0)
	local var_10_2 = var_1.GetActiveEvent(var_10_1)

	assert = var_10_1

	var_10_1(var_10_2)

	local var_10_3 = var_10_2
	local var_10_4 = var_10_2.GetBossMission(var_10_3)

	assert = var_10_3

	var_10_3(var_10_4)
	var_10_4:ReduceDailyCnt()
	var_0:ResetBossRankTime()
	var_0:ResetRefreshBossTime()
	var_0:updateGuild(var_1)

	return
end

function var_0_0.GeneralPlayerCosume(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	getProxy = var_1_10005
	PlayerProxy = var_1_10006

	local var_11_0 = var_1_10005(var_1_10006)
	local var_11_1 = var_5.getData(var_11_0)

	var_6.addExp(var_11_1, arg_11_3)
	var_6:consume({
		gold = 0,
		oil = arg_11_2
	})
	var_5:updatePlayer(var_6)

	return
end

function var_0_0.GeneralPackage(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3 = arg_12_0.system
	local var_12_4 = arg_12_0.stageId
	local var_12_5 = arg_12_0.statistics._battleScore
	local var_12_6 = var_12_3 + var_12_4 + var_12_5

	getProxy = var_1_10009
	PlayerProxy = var_1_10010

	local var_12_7 = var_1_10009(var_1_10010)
	local var_12_8 = var_9.getRawData(var_12_7).id

	ipairs = var_12_7

	for iter_12_0, iter_12_1 in var_12_7(arg_12_1) do
		if arg_12_0.statistics[iter_12_1.id] then
			GuildAssaultFleet = var_16

			local var_12_9 = var_16.GetRealId(var_15.id)

			GuildAssaultFleet = var_17

			local var_12_10 = var_17.GetUserId(var_15.id)

			math = var_1_10018
			var_1_10018 = var_1_10018.floor(var_15.bp)
			math = var_19

			local var_12_11 = var_19.floor(var_15.output)

			math = var_20

			local var_12_12 = var_20.max
			local var_12_13 = 0

			math = var_1_10022

			local var_12_14 = var_12_12(var_12_13, var_1_10022.floor(var_15.damage))

			math = var_12_13

			local var_12_15 = var_12_13.floor(var_15.maxDamageOnce)

			math = var_1_10022
			var_1_10022 = var_1_10022.floor(var_15.gearScore)

			local var_12_16 = var_12_10 ~= var_12_8 and var_12_2 or var_12_1

			table = var_1_10024

			var_1_10024.insert(var_12_16, {
				ship_id = var_12_9,
				hp_rest = var_1_10018,
				damage_cause = var_12_11,
				damage_caused = var_12_14,
				max_damage_once = var_12_15,
				ship_gear_score = var_1_10022
			})

			var_12_6 = var_12_6 + var_12_9 + var_1_10018 + var_12_11 + var_12_15
			var_12_0 = var_12_0 + iter_12_1:getShipCombatPower()
		end
	end

	GetBattleCheckResult = var_10

	local var_12_17, var_12_18 = var_10(var_12_6, arg_12_0.token, arg_12_0.statistics._totalTime)
	local var_12_19 = {}

	ipairs = var_13

	for iter_12_2, iter_12_3 in var_13(arg_12_0.statistics._enemyInfoList) do
		table = var_1_10018

		var_1_10018.insert(var_12_19, {
			enemy_id = iter_12_3.id,
			damage_taken = iter_12_3.damage,
			total_hp = iter_12_3.totalHp
		})
	end

	math = var_13

	local var_12_20 = var_13.fmod(arg_12_0.statistics._autoCount, 2)

	math = var_14

	local var_12_21 = var_14.fmod(var_12_20 + arg_12_0.statistics._autoInit, 2)

	return {
		system = var_12_3,
		data = var_12_4,
		score = var_12_5,
		key = var_12_17,
		statistics = var_12_1,
		otherstatistics = var_12_2,
		kill_id_list = arg_12_0.statistics.kill_id_list,
		total_time = arg_12_0.statistics._totalTime,
		bot_percentage = arg_12_0.statistics._botPercentage,
		extra_param = var_12_0,
		file_check = var_12_18,
		enemy_info = var_12_19,
		data2 = {},
		auto_before = arg_12_0.statistics._autoInit,
		auto_switch_time = arg_12_0.statistics._autoCount,
		auto_after = var_12_21
	}
end

function var_0_0.GetPreloadList(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2

	ys = var_1_10004

	local var_13_3 = var_1_10004.Battle.BattleResourceManager.GetInstance()

	getProxy = var_1_10005
	GuildProxy = var_1_10006

	local var_13_4 = var_1_10005(var_1_10006)
	local var_13_5 = var_5.getRawData(var_13_4)
	local var_13_6 = var_5.GetActiveEvent(var_13_5)
	local var_13_7 = var_6.GetBossMission(var_13_6)
	local var_13_8 = var_7.GetMainFleet(var_13_7)
	local var_13_9 = var_8.GetShips(var_13_8)

	ipairs = var_13_8

	for iter_13_0, iter_13_1 in var_13_8(var_13_9) do
		if iter_13_1 and iter_13_1.ship then
			table = var_15

			var_15.insert(var_13_0, iter_13_1.ship)
		end
	end

	local var_13_10 = var_8:BuildBattleBuffList()
	local var_13_11 = var_7:GetSubFleet()
	local var_13_12 = var_10.GetShips(var_13_11)

	ipairs = var_13_11

	for iter_13_2, iter_13_3 in var_13_11(var_13_12) do
		if iter_13_3 and iter_13_3.ship then
			table = var_1_10017

			var_1_10017.insert(var_13_0, iter_13_3.ship)
		end
	end

	local var_13_13 = var_10:BuildBattleBuffList()

	ipairs = var_12

	for iter_13_4, iter_13_5 in var_12(var_13_13) do
		table = var_1_10017

		var_1_10017.insert(var_13_10, iter_13_5)
	end

	local var_13_14, var_13_15 = var_13_3.GetPlayerShipResource(var_13_0, arg_13_0.system)
	local var_13_16 = var_13_3.GetCommanderBuffRes(var_13_10)

	ipairs = var_14

	for iter_13_6, iter_13_7 in var_14(var_13_16) do
		table = var_1_10019

		var_1_10019.insert(var_13_14, iter_13_7)
	end

	return var_13_14, var_13_15
end

return var_0_0
