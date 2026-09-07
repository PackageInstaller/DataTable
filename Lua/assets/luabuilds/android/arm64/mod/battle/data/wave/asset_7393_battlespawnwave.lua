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

function ys.Battle.BattleSpawnWave:SetWaveData(arg_2_1)
	var_0_1.super.SetWaveData(self, arg_2_1)

	self._sapwnData = arg_2_1.spawn or {}
	self._airStrike = arg_2_1.airFighter or {}
	self._reinforce = arg_2_1.reinforcement or {}
	self._reinforceCount = #self._reinforce
	self._spawnCount = #self._sapwnData
	self._reinforceDuration = self._reinforce.reinforceDuration or 0
	self._reinforeceExpire = false
	self._round = self._param.round

	return
end

function ys.Battle.BattleSpawnWave:IsBossWave()
	local var_3_0 = false

	for iter_3_0, iter_3_1 in ipairs(self._sapwnData) do
		if iter_3_1.bossData then
			var_3_0 = true
		end
	end

	return var_3_0
end

function ys.Battle.BattleSpawnWave:DoWave()
	var_0_1.super.DoWave(self)

	if self._round then
		local var_4_0 = false
		local var_4_1 = var_0_0.Battle.BattleDataProxy.GetInstance()

		if var_4_1:GetInitData().ChallengeInfo then
			local var_4_2 = var_4_1:GetInitData().ChallengeInfo:getRound()

			if self._round.less and var_4_2 < self._round.less then
				var_4_0 = true
			end

			if self._round.more and var_4_2 > self._round.more then
				var_4_0 = true
			end

			if self._round.equal and table.contains(self._round.equal, var_4_2) then
				var_4_0 = true
			end
		end

		if not var_4_0 then
			self:doPass()

			return
		end
	end

	for iter_4_0, iter_4_1 in ipairs(self._airStrike) do
		if iter_4_1.delay + iter_4_0 * var_0_1.ASYNC_TIME_GAP <= 0 then
			self:doAirStrike(iter_4_1)
		else
			self:airStrikeTimer(iter_4_1, iter_4_1.delay + iter_4_0 * var_0_1.ASYNC_TIME_GAP)
		end
	end

	local var_4_3 = 0

	for iter_4_2, iter_4_3 in ipairs(self._sapwnData) do
		if iter_4_3.bossData then
			var_4_3 = var_4_3 + 1
		end
	end

	local var_4_4 = 0
	local var_4_5 = 0

	for iter_4_4, iter_4_5 in ipairs(self._sapwnData) do
		if (iter_4_5.chance or 1) >= math.random() then
			if iter_4_5.bossData and var_4_3 > 1 then
				var_4_4 = var_4_4 + 1
				iter_4_5.bossData.bossCount = var_4_4
			end

			local var_4_7 = iter_4_5.delay + var_4_5

			if iter_4_5.delay + var_4_5 <= 0 then
				self:doSpawn(iter_4_5)
			else
				self:spawnTimer(iter_4_5, var_4_7, self._spawnTimerList)
			end
		else
			self._spawnCount = self._spawnCount - 1
		end

		var_4_5 = var_4_5 + var_0_1.ASYNC_TIME_GAP
	end

	if self._reinforce then
		self:doReinforce(var_4_5)
	end

	if self._spawnCount == 0 and self._reinforceDuration == 0 then
		self:doPass()
	end

	if self._reinforceDuration ~= 0 then
		self:reinforceDurationTimer(self._reinforceDuration)
	end

	var_0_0.Battle.BattleState.GenerateVertifyData(1)

	local var_4_8, var_4_9 = var_0_0.Battle.BattleState.Vertify()

	if not var_4_8 then
		var_0_0.Battle.BattleState.GetInstance():GetCommandByName(var_0_0.Battle.BattleSingleDungeonCommand.__name):SetVertifyFail(100 + var_4_9)
	end

	return
end

function ys.Battle.BattleSpawnWave:AddMonster(arg_5_1)
	if arg_5_1:GetWaveIndex() ~= self._index then
		return
	end

	self._monsterList[arg_5_1:GetUniqueID()] = arg_5_1

	return
end

function ys.Battle.BattleSpawnWave:RemoveMonster(arg_6_1)
	self:onWaveUnitDie(arg_6_1)

	return
end

function ys.Battle.BattleSpawnWave:doSpawn(arg_7_1)
	self._spawnFunc(arg_7_1, self._index, (arg_7_1.bossData or nil) and var_0_0.Battle.BattleConst.UnitType.BOSS_UNIT)

	return
end

function ys.Battle.BattleSpawnWave.spawnTimer(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0

	var_8_0 = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, arg_8_2, function()
		arg_8_3[var_8_0] = nil

		arg_8_0:doSpawn(arg_8_1)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_8_0)

		return
	end, true)
	arg_8_3[nil] = true

	return
end

function ys.Battle.BattleSpawnWave:doAirStrike(arg_10_1)
	self._airFunc(arg_10_1)

	return
end

function ys.Battle.BattleSpawnWave:airStrikeTimer(arg_11_1, arg_11_2)
	local var_11_0

	var_11_0 = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, arg_11_2, function()
		self._airStrikeTimerList[var_11_0] = nil

		self:doAirStrike(arg_11_1)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_11_0)

		return
	end, true)
	self._airStrikeTimerList[nil] = true

	return
end

function ys.Battle.BattleSpawnWave:doReinforce(arg_13_1)
	self._reinforceKillCount = 0

	if self._reinforeceExpire then
		return
	end

	arg_13_1 = arg_13_1 or 0

	for iter_13_0, iter_13_1 in ipairs(self._reinforce) do
		iter_13_1.reinforce = true

		if iter_13_1.delay + arg_13_1 <= 0 then
			self:doSpawn(iter_13_1)
		else
			self:spawnTimer(iter_13_1, iter_13_1.delay + arg_13_1, self._reinforceSpawnTimerList)
		end

		arg_13_1 = arg_13_1 + var_0_1.ASYNC_TIME_GAP
	end

	return
end

function ys.Battle.BattleSpawnWave:reinforceTimer(arg_14_1)
	self:clearReinforceTimer()

	self._reinforceTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, arg_14_1, function()
		self:doReinforce()
		self:clearReinforceTimer()

		return
	end, true)

	return
end

function ys.Battle.BattleSpawnWave:clearReinforceTimer()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._reinforceTimer)

	self._reinforceTimer = nil

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

function ys.Battle.BattleSpawnWave:clearReinforceDurationTimer()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._reinforceDurationTimer)

	self._reinforceDurationTimer = nil

	return
end

function ys.Battle.BattleSpawnWave:onWaveUnitDie(arg_20_1)
	if self._monsterList[arg_20_1] == nil then
		return
	end

	local var_20_0

	if self._monsterList[arg_20_1]:IsReinforcement() then
		self._reinforceKillCount = self._reinforceKillCount + 1
		self._reinforceTotalKillCount = self._reinforceTotalKillCount + 1

		if self._reinforceCount ~= 0 and self._reinforceCount == self._reinforceKillCount then
			var_20_0 = true
		end
	end

	local function var_20_1(arg_21_0)
		if var_20_0 and arg_21_0 then
			if arg_21_0 == 0 then
				self:doReinforce()
			else
				self:reinforceTimer(arg_21_0)
			end

			var_20_0 = false
		end

		return
	end

	local var_20_2 = 0
	local var_20_3 = 0

	for iter_20_0, iter_20_1 in pairs(self._monsterList) do
		if iter_20_1:IsAlive() == false then
			if not iter_20_1:IsReinforcement() then
				var_20_2 = var_20_2 + 1
			end
		else
			var_20_3 = var_20_3 + 1

			var_20_1(iter_20_1:GetReinforceCastTime())
		end
	end

	if self._reinforceDuration ~= 0 and not self._reinforeceExpire then
		var_20_1(0)
	end

	if var_20_3 == 0 and var_20_2 >= self._spawnCount and self._reinforceTotalKillCount >= self._reinforceCount and (self._reinforceDuration == 0 or self._reinforeceExpire) then
		self:doPass()
	end

	return
end

function ys.Battle.BattleSpawnWave:doPass()
	self.clearTimerList(self._spawnTimerList)
	self.clearTimerList(self._reinforceSpawnTimerList)
	self:clearReinforceTimer()
	self:clearReinforceDurationTimer()
	var_0_0.Battle.BattleDataProxy.GetInstance():KillWaveSummonMonster(self._index)
	var_0_1.super.doPass(self)

	return
end

function ys.Battle.BattleSpawnWave.clearTimerList(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_23_0)
	end

	return
end

function ys.Battle.BattleSpawnWave:Dispose()
	self.clearTimerList(self._airStrikeTimerList)

	self._airStrikeTimerList = nil

	self.clearTimerList(self._spawnTimerList)

	self._spawnTimerList = nil

	self.clearTimerList(self._reinforceSpawnTimerList)

	self._reinforceSpawnTimerList = nil

	self:clearReinforceTimer()
	self:clearReinforceDurationTimer()
	var_0_1.super.Dispose(self)

	return
end

return
