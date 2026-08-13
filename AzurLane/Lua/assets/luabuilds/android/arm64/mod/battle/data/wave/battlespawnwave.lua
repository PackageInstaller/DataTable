ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSpawnWave = var_0_10002("BattleSpawnWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleSpawnWave.__name = "BattleSpawnWave"

local var_0_2 = var_0.Battle.BattleSpawnWave

var_0_2.ASYNC_TIME_GAP = 0.03

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	arg_1_0._spawnUnitList = {}
	arg_1_0._monsterList = {}
	arg_1_0._reinforceKillCount = 0
	arg_1_0._reinforceTotalKillCount = 0
	arg_1_0._airStrikeTimerList = {}
	arg_1_0._spawnTimerList = {}
	arg_1_0._reinforceSpawnTimerList = {}

	return
end

function var_0_2.SetWaveData(arg_2_0, arg_2_1)
	var_0_2.super.SetWaveData(arg_2_0, arg_2_1)

	local var_2_0

	if not arg_2_1.spawn then
		var_2_0 = {}
	end

	arg_2_0._sapwnData = var_2_0

	local var_2_1

	if not arg_2_1.airFighter then
		var_2_1 = {}
	end

	arg_2_0._airStrike = var_2_1

	local var_2_2

	if not arg_2_1.reinforcement then
		var_2_2 = {}
	end

	arg_2_0._reinforce = var_2_2
	arg_2_0._reinforceCount = #arg_2_0._reinforce
	arg_2_0._spawnCount = #arg_2_0._sapwnData

	local var_2_3

	if not arg_2_0._reinforce.reinforceDuration then
		var_2_3 = 0
	end

	arg_2_0._reinforceDuration = var_2_3
	arg_2_0._reinforeceExpire = false
	arg_2_0._round = arg_2_0._param.round

	return
end

function var_0_2.IsBossWave(arg_3_0)
	local var_3_0 = false
	local var_3_1 = arg_3_0._sapwnData

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(var_3_1) do
		if iter_3_1.bossData then
			var_3_0 = true
		end
	end

	return var_3_0
end

function var_0_2.DoWave(arg_4_0)
	var_0_2.super.DoWave(arg_4_0)

	local var_4_0

	if arg_4_0._round then
		var_4_0 = false

		local var_4_1 = var_0.Battle.BattleDataProxy.GetInstance()

		if var_2.GetInitData(var_4_1).ChallengeInfo then
			local var_4_2 = var_2:GetInitData().ChallengeInfo
			local var_4_3 = var_3.getRound(var_4_2)

			if arg_4_0._round.less and var_4_3 < arg_4_0._round.less then
				var_4_0 = true
			end

			if arg_4_0._round.more and var_4_3 > arg_4_0._round.more then
				var_4_0 = true
			end

			if arg_4_0._round.equal then
				table = var_4

				if var_4.contains(arg_4_0._round.equal, var_4_3) then
					var_4_0 = true
				end
			end
		end

		if not var_4_0 then
			arg_4_0:doPass()

			return
		end
	end

	ipairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(arg_4_0._airStrike) do
		if iter_4_1.delay + iter_4_0 * var_0_2.ASYNC_TIME_GAP <= 0 then
			arg_4_0:doAirStrike(iter_4_1)
		else
			arg_4_0:airStrikeTimer(iter_4_1, var_6)
		end
	end

	local var_4_4 = 0

	ipairs = var_2

	for iter_4_2, iter_4_3 in var_2(arg_4_0._sapwnData) do
		if iter_4_3.bossData then
			var_4_4 = var_4_4 + 1
		end
	end

	local var_4_5 = 0
	local var_4_6 = 0

	ipairs = var_4

	for iter_4_4, iter_4_5 in var_4(arg_4_0._sapwnData) do
		local var_4_7

		if not iter_4_5.chance then
			var_4_7 = 1
		end

		math = var_1_10010

		if var_1_10010.random() <= var_4_7 then
			if iter_4_5.bossData and 1 < var_4_4 then
				var_4_5 = var_4_5 + 1
				var_1_10010 = iter_4_5.bossData
				var_1_10010.bossCount = var_4_5
			end

			if iter_4_5.delay + var_4_6 <= 0 then
				arg_4_0:doSpawn(iter_4_5)
			else
				arg_4_0:spawnTimer(iter_4_5, var_1_10010, arg_4_0._spawnTimerList)
			end
		else
			arg_4_0._spawnCount = arg_4_0._spawnCount - 1
		end

		var_4_6 = var_4_6 + var_0_2.ASYNC_TIME_GAP
	end

	if arg_4_0._reinforce then
		arg_4_0:doReinforce(var_4_6)
	end

	if arg_4_0._spawnCount == 0 and arg_4_0._reinforceDuration == 0 then
		arg_4_0:doPass()
	end

	if arg_4_0._reinforceDuration ~= 0 then
		arg_4_0:reinforceDurationTimer(arg_4_0._reinforceDuration)
	end

	var_0.Battle.BattleState.GenerateVertifyData(1)

	local var_4_8, var_4_9 = var_0.Battle.BattleState.Vertify()

	if not var_4_8 then
		local var_4_10 = 100 + var_4_9
		local var_4_11 = var_0.Battle.BattleState.GetInstance()
		local var_4_12 = var_6.GetCommandByName(var_4_11, var_0.Battle.BattleSingleDungeonCommand.__name)

		var_6.SetVertifyFail(var_4_12, var_4_10)
	end

	return
end

function var_0_2.AddMonster(arg_5_0, arg_5_1)
	if arg_5_1:GetWaveIndex() ~= arg_5_0._index then
		return
	end

	arg_5_0._monsterList[arg_5_1:GetUniqueID()] = arg_5_1

	return
end

function var_0_2.RemoveMonster(arg_6_0, arg_6_1)
	arg_6_0:onWaveUnitDie(arg_6_1)

	return
end

function var_0_2.doSpawn(arg_7_0, arg_7_1)
	local var_7_0 = var_0.Battle.BattleConst.UnitType.ENEMY_UNIT

	if arg_7_1.bossData then
		var_7_0 = var_0.Battle.BattleConst.UnitType.BOSS_UNIT
	end

	arg_7_0._spawnFunc(arg_7_1, arg_7_0._index, var_7_0)

	return
end

function var_0_2.spawnTimer(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0

	local function var_8_1()
		arg_8_3[var_8_0] = nil

		local var_9_0 = arg_8_0

		var_0.doSpawn(var_9_0, arg_8_1)

		pg = var_0

		local var_9_1 = var_0.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_9_1, var_8_0)

		return
	end

	pg = var_1_10006

	local var_8_2 = var_1_10006.TimeMgr.GetInstance()

	arg_8_3[var_6.AddBattleTimer(var_8_2, "", 1, arg_8_2, var_8_1, true)] = true

	return
end

function var_0_2.doAirStrike(arg_10_0, arg_10_1)
	arg_10_0._airFunc(arg_10_1)

	return
end

function var_0_2.airStrikeTimer(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	local function var_11_1()
		arg_11_0._airStrikeTimerList[var_11_0] = nil

		local var_12_0 = arg_11_0

		var_0.doAirStrike(var_12_0, arg_11_1)

		pg = var_0

		local var_12_1 = var_0.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_12_1, var_11_0)

		return
	end

	pg = var_1_10005

	local var_11_2 = var_1_10005.TimeMgr.GetInstance()

	var_11_0 = var_5.AddBattleTimer(var_11_2, "", 1, arg_11_2, var_11_1, true)
	arg_11_0._airStrikeTimerList[var_11_0] = true

	return
end

function var_0_2.doReinforce(arg_13_0, arg_13_1)
	arg_13_0._reinforceKillCount = 0

	if arg_13_0._reinforeceExpire then
		return
	end

	arg_13_1 = arg_13_1 or 0
	ipairs = var_2

	for iter_13_0, iter_13_1 in var_2(arg_13_0._reinforce) do
		iter_13_1.reinforce = true

		if iter_13_1.delay + arg_13_1 <= 0 then
			arg_13_0:doSpawn(iter_13_1)
		else
			arg_13_0:spawnTimer(iter_13_1, var_7, arg_13_0._reinforceSpawnTimerList)
		end

		arg_13_1 = arg_13_1 + var_0_2.ASYNC_TIME_GAP
	end

	return
end

function var_0_2.reinforceTimer(arg_14_0, arg_14_1)
	arg_14_0:clearReinforceTimer()

	local function var_14_0()
		local var_15_0 = arg_14_0

		var_0.doReinforce(var_15_0)

		local var_15_1 = arg_14_0

		var_0.clearReinforceTimer(var_15_1)

		return
	end

	pg = var_1_10003

	local var_14_1 = var_1_10003.TimeMgr.GetInstance()

	arg_14_0._reinforceTimer = var_3.AddBattleTimer(var_14_1, "", 1, arg_14_1, var_14_0, true)

	return
end

function var_0_2.clearReinforceTimer(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_16_0, arg_16_0._reinforceTimer)

	arg_16_0._reinforceTimer = nil

	return
end

function var_0_2.reinforceDurationTimer(arg_17_0, arg_17_1)
	local function var_17_0()
		pg = var_2_10000

		local var_18_0 = var_2_10000.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_18_0, arg_17_0._reinforceDurationTimer)

		arg_17_0._reinforeceExpire = true
		arg_17_0._reinforceDuration = nil

		local var_18_1 = arg_17_0

		var_0.clearReinforceTimer(var_18_1)
		arg_17_0.clearTimerList(arg_17_0._reinforceSpawnTimerList)

		if arg_17_0._spawnCount == 0 then
			local var_18_2 = arg_17_0

			var_0.doPass(var_18_2)
		end

		return
	end

	pg = var_1_10003

	local var_17_1 = var_1_10003.TimeMgr.GetInstance()

	arg_17_0._reinforceDurationTimer = var_3.AddBattleTimer(var_17_1, "", 1, arg_17_1, var_17_0, true)

	return
end

function var_0_2.clearReinforceDurationTimer(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_19_0, arg_19_0._reinforceDurationTimer)

	arg_19_0._reinforceDurationTimer = nil

	return
end

function var_0_2.onWaveUnitDie(arg_20_0, arg_20_1)
	if arg_20_0._monsterList[arg_20_1] == nil then
		return
	end

	local var_20_0

	if var_2:IsReinforcement() then
		arg_20_0._reinforceKillCount = arg_20_0._reinforceKillCount + 1
		arg_20_0._reinforceTotalKillCount = arg_20_0._reinforceTotalKillCount + 1

		if arg_20_0._reinforceCount ~= 0 and arg_20_0._reinforceCount == arg_20_0._reinforceKillCount then
			var_20_0 = true
		end
	end

	local function var_20_1(arg_21_0)
		if var_20_0 and arg_21_0 then
			if arg_21_0 == 0 then
				local var_21_0 = arg_20_0

				var_1.doReinforce(var_21_0)
			else
				local var_21_1 = arg_20_0

				var_1.reinforceTimer(var_21_1, arg_21_0)
			end

			var_20_0 = false
		end

		return
	end

	local var_20_2 = 0
	local var_20_3 = 0

	pairs = var_1_10007

	for iter_20_0, iter_20_1 in var_1_10007(arg_20_0._monsterList) do
		if iter_20_1:IsAlive() == false then
			if not iter_20_1:IsReinforcement() then
				var_20_2 = var_20_2 + 1
			end
		else
			var_20_3 = var_20_3 + 1

			var_20_1(iter_20_1:GetReinforceCastTime())
		end
	end

	if arg_20_0._reinforceDuration ~= 0 and not arg_20_0._reinforeceExpire then
		var_20_1(0)
	end

	if var_20_3 == 0 and var_20_2 >= arg_20_0._spawnCount and arg_20_0._reinforceTotalKillCount >= arg_20_0._reinforceCount and (arg_20_0._reinforceDuration == 0 or arg_20_0._reinforeceExpire) then
		arg_20_0:doPass()
	end

	return
end

function var_0_2.doPass(arg_22_0)
	arg_22_0.clearTimerList(arg_22_0._spawnTimerList)
	arg_22_0.clearTimerList(arg_22_0._reinforceSpawnTimerList)
	arg_22_0:clearReinforceTimer()
	arg_22_0:clearReinforceDurationTimer()

	local var_22_0 = var_0.Battle.BattleDataProxy.GetInstance()

	var_1.KillWaveSummonMonster(var_22_0, arg_22_0._index)
	var_0_2.super.doPass(arg_22_0)

	return
end

function var_0_2.clearTimerList(arg_23_0)
	pairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001(arg_23_0) do
		pg = var_1_10006

		local var_23_0 = var_1_10006.TimeMgr.GetInstance()

		var_1_10006.RemoveBattleTimer(var_23_0, iter_23_0)
	end

	return
end

function var_0_2.Dispose(arg_24_0)
	arg_24_0.clearTimerList(arg_24_0._airStrikeTimerList)

	arg_24_0._airStrikeTimerList = nil

	arg_24_0.clearTimerList(arg_24_0._spawnTimerList)

	arg_24_0._spawnTimerList = nil

	arg_24_0.clearTimerList(arg_24_0._reinforceSpawnTimerList)

	arg_24_0._reinforceSpawnTimerList = nil

	arg_24_0:clearReinforceTimer()
	arg_24_0:clearReinforceDurationTimer()
	var_0_2.super.Dispose(arg_24_0)

	return
end

return
