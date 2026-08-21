ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSpawnWave = class("BattleSpawnWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleSpawnWave.__name = "BattleSpawnWave"

local var_0_1 = ys.Battle.BattleSpawnWave

ys.Battle.BattleSpawnWave.ASYNC_TIME_GAP = 0.03

function ys.Battle.BattleSpawnWave.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0._spawnUnitList = {}
	arg_1_0._monsterList = {}
	arg_1_0._reinforceKillCount = 0
	arg_1_0._reinforceTotalKillCount = 0
	arg_1_0._airStrikeTimerList = {}
	arg_1_0._spawnTimerList = {}
	arg_1_0._reinforceSpawnTimerList = {}

	return
end

function ys.Battle.BattleSpawnWave.SetWaveData(arg_2_0, arg_2_1)
	var_0_1.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._sapwnData = arg_2_1.spawn or {}
	arg_2_0._airStrike = arg_2_1.airFighter or {}
	arg_2_0._reinforce = arg_2_1.reinforcement or {}
	arg_2_0._reinforceCount = #arg_2_0._reinforce
	arg_2_0._spawnCount = #arg_2_0._sapwnData
	arg_2_0._reinforceDuration = arg_2_0._reinforce.reinforceDuration or 0
	arg_2_0._reinforeceExpire = false
	arg_2_0._round = arg_2_0._param.round

	return
end

function ys.Battle.BattleSpawnWave.IsBossWave(arg_3_0)
	local var_3_0 = false

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._sapwnData) do
		if iter_3_1.bossData then
			var_3_0 = true
		end
	end

	return var_3_0
end

function ys.Battle.BattleSpawnWave.DoWave(arg_4_0)
	var_0_1.super.DoWave(arg_4_0)

	if arg_4_0._round then
		local var_4_0 = false
		local var_4_1 = var_0_0.Battle.BattleDataProxy.GetInstance()

		if var_4_1:GetInitData().ChallengeInfo then
			local var_4_2 = var_4_1:GetInitData().ChallengeInfo:getRound()

			if arg_4_0._round.less and var_4_2 < arg_4_0._round.less then
				var_4_0 = true
			end

			if arg_4_0._round.more and var_4_2 > arg_4_0._round.more then
				var_4_0 = true
			end

			if arg_4_0._round.equal and table.contains(arg_4_0._round.equal, var_4_2) then
				var_4_0 = true
			end
		end

		if not var_4_0 then
			arg_4_0:doPass()

			return
		end
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._airStrike) do
		if iter_4_1.delay + iter_4_0 * var_0_1.ASYNC_TIME_GAP <= 0 then
			arg_4_0:doAirStrike(iter_4_1)
		else
			arg_4_0:airStrikeTimer(iter_4_1, iter_4_1.delay + iter_4_0 * var_0_1.ASYNC_TIME_GAP)
		end
	end

	local var_4_3 = 0

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._sapwnData) do
		if iter_4_3.bossData then
			var_4_3 = var_4_3 + 1
		end
	end

	local var_4_4 = 0
	local var_4_5 = 0

	for iter_4_4, iter_4_5 in ipairs(arg_4_0._sapwnData) do
		local var_4_6 = iter_4_5.chance or 1

		if var_4_6 >= math.random() then
			if iter_4_5.bossData and var_4_3 > 1 then
				var_4_4 = var_4_4 + 1
				iter_4_5.bossData.bossCount = var_4_4
			end

			local var_4_7 = iter_4_5.delay + var_4_5

			if iter_4_5.delay + var_4_5 <= 0 then
				arg_4_0:doSpawn(iter_4_5)
			else
				arg_4_0:spawnTimer(iter_4_5, var_4_7, arg_4_0._spawnTimerList)
			end
		else
			arg_4_0._spawnCount = arg_4_0._spawnCount - 1
		end

		var_4_5 = var_4_5 + var_0_1.ASYNC_TIME_GAP
	end

	if arg_4_0._reinforce then
		arg_4_0:doReinforce(var_4_5)
	end

	if arg_4_0._spawnCount == 0 and arg_4_0._reinforceDuration == 0 then
		arg_4_0:doPass()
	end

	if arg_4_0._reinforceDuration ~= 0 then
		arg_4_0:reinforceDurationTimer(arg_4_0._reinforceDuration)
	end

	var_0_0.Battle.BattleState.GenerateVertifyData(1)

	local var_4_8, var_4_9 = var_0_0.Battle.BattleState.Vertify()

	if not var_4_8 then
		var_0_0.Battle.BattleState.GetInstance():GetCommandByName(var_0_0.Battle.BattleSingleDungeonCommand.__name):SetVertifyFail(100 + var_4_9)
	end

	return
end

function ys.Battle.BattleSpawnWave.AddMonster(arg_5_0, arg_5_1)
	if arg_5_1:GetWaveIndex() ~= arg_5_0._index then
		return
	end

	arg_5_0._monsterList[arg_5_1:GetUniqueID()] = arg_5_1

	return
end

function ys.Battle.BattleSpawnWave.RemoveMonster(arg_6_0, arg_6_1)
	arg_6_0:onWaveUnitDie(arg_6_1)

	return
end

function ys.Battle.BattleSpawnWave.doSpawn(arg_7_0, arg_7_1)
	local var_7_0 = var_0_0.Battle.BattleConst.UnitType.ENEMY_UNIT

	if arg_7_1.bossData then
		var_7_0 = var_0_0.Battle.BattleConst.UnitType.BOSS_UNIT
	end

	arg_7_0._spawnFunc(arg_7_1, arg_7_0._index, var_7_0)

	return
end

function ys.Battle.BattleSpawnWave.spawnTimer(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, arg_8_2, function()
		arg_8_3[var_8_0] = nil

		arg_8_0:doSpawn(arg_8_1)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_8_0)

		return
	end, true)

	arg_8_3[nil] = true

	return
end

function ys.Battle.BattleSpawnWave.doAirStrike(arg_10_0, arg_10_1)
	arg_10_0._airFunc(arg_10_1)

	return
end

function ys.Battle.BattleSpawnWave.airStrikeTimer(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	arg_11_0._airStrikeTimerList[pg.TimeMgr.GetInstance():AddBattleTimer("", 1, arg_11_2, function()
		arg_11_0._airStrikeTimerList[var_11_0] = nil

		arg_11_0:doAirStrike(arg_11_1)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_11_0)

		return
	end, true)] = true

	return
end

function ys.Battle.BattleSpawnWave.doReinforce(arg_13_0, arg_13_1)
	arg_13_0._reinforceKillCount = 0

	if arg_13_0._reinforeceExpire then
		return
	end

	arg_13_1 = arg_13_1 or 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._reinforce) do
		iter_13_1.reinforce = true

		if iter_13_1.delay + arg_13_1 <= 0 then
			arg_13_0:doSpawn(iter_13_1)
		else
			arg_13_0:spawnTimer(iter_13_1, iter_13_1.delay + arg_13_1, arg_13_0._reinforceSpawnTimerList)
		end

		arg_13_1 = arg_13_1 + var_0_1.ASYNC_TIME_GAP
	end

	return
end

function ys.Battle.BattleSpawnWave.reinforceTimer(arg_14_0, arg_14_1)
	arg_14_0:clearReinforceTimer()

	arg_14_0._reinforceTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, arg_14_1, function()
		arg_14_0:doReinforce()
		arg_14_0:clearReinforceTimer()

		return
	end, true)

	return
end

function ys.Battle.BattleSpawnWave.clearReinforceTimer(arg_16_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_16_0._reinforceTimer)

	arg_16_0._reinforceTimer = nil

	return
end

function ys.Battle.BattleSpawnWave.reinforceDurationTimer(arg_17_0, arg_17_1)
	arg_17_0._reinforceDurationTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, arg_17_1, function()
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_17_0._reinforceDurationTimer)

		arg_17_0._reinforeceExpire = true
		arg_17_0._reinforceDuration = nil

		arg_17_0:clearReinforceTimer()
		arg_17_0.clearTimerList(arg_17_0._reinforceSpawnTimerList)

		if arg_17_0._spawnCount == 0 then
			arg_17_0:doPass()
		end

		return
	end, true)

	return
end

function ys.Battle.BattleSpawnWave.clearReinforceDurationTimer(arg_19_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_19_0._reinforceDurationTimer)

	arg_19_0._reinforceDurationTimer = nil

	return
end

function ys.Battle.BattleSpawnWave.onWaveUnitDie(arg_20_0, arg_20_1)
	if arg_20_0._monsterList[arg_20_1] == nil then
		return
	end

	local var_20_0

	if arg_20_0._monsterList[arg_20_1]:IsReinforcement() then
		arg_20_0._reinforceKillCount = arg_20_0._reinforceKillCount + 1
		arg_20_0._reinforceTotalKillCount = arg_20_0._reinforceTotalKillCount + 1

		if arg_20_0._reinforceCount ~= 0 and arg_20_0._reinforceCount == arg_20_0._reinforceKillCount then
			var_20_0 = true
		end
	end

	local var_20_2 = 0
	local var_20_3 = 0

	for iter_20_0, iter_20_1 in pairs(arg_20_0._monsterList) do
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

function ys.Battle.BattleSpawnWave.doPass(arg_22_0)
	arg_22_0.clearTimerList(arg_22_0._spawnTimerList)
	arg_22_0.clearTimerList(arg_22_0._reinforceSpawnTimerList)
	arg_22_0:clearReinforceTimer()
	arg_22_0:clearReinforceDurationTimer()
	var_0_0.Battle.BattleDataProxy.GetInstance():KillWaveSummonMonster(arg_22_0._index)
	var_0_1.super.doPass(arg_22_0)

	return
end

function ys.Battle.BattleSpawnWave.clearTimerList(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_23_0)
	end

	return
end

function ys.Battle.BattleSpawnWave.Dispose(arg_24_0)
	arg_24_0.clearTimerList(arg_24_0._airStrikeTimerList)

	arg_24_0._airStrikeTimerList = nil

	arg_24_0.clearTimerList(arg_24_0._spawnTimerList)

	arg_24_0._spawnTimerList = nil

	arg_24_0.clearTimerList(arg_24_0._reinforceSpawnTimerList)

	arg_24_0._reinforceSpawnTimerList = nil

	arg_24_0:clearReinforceTimer()
	arg_24_0:clearReinforceDurationTimer()
	var_0_1.super.Dispose(arg_24_0)

	return
end

return
