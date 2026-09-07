ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleEnvironmentWave = class("BattleEnvironmentWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleEnvironmentWave.__name = "BattleEnvironmentWave"

local var_0_1 = ys.Battle.BattleEnvironmentWave

function ys.Battle.BattleEnvironmentWave.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0._spawnTimerList = {}

	return
end

function ys.Battle.BattleEnvironmentWave.SetWaveData(arg_2_0, arg_2_1)
	var_0_1.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._sapwnData = arg_2_1.spawn or {}
	arg_2_0._environWarning = arg_2_1.warning

	return
end

function ys.Battle.BattleEnvironmentWave:DoWave()
	var_0_1.super.DoWave(self)

	for iter_3_0, iter_3_1 in ipairs(self._sapwnData) do
		if iter_3_1.delay and iter_3_1.delay > 0 then
			self:spawnTimer(iter_3_1)
		else
			self:doSpawn(iter_3_1)
		end
	end

	if self._environWarning then
		var_0_0.Battle.BattleDataProxy.GetInstance():DispatchWarning(true)
	end

	return
end

function ys.Battle.BattleEnvironmentWave.doSpawn(arg_4_0, arg_4_1)
	var_0_0.Battle.BattleDataProxy.GetInstance():SpawnEnvironment(arg_4_1):ConfigCallback(function()
		arg_4_0:doPass()

		return
	end)

	return
end

function ys.Battle.BattleEnvironmentWave:doPass()
	if self._environWarning then
		var_0_0.Battle.BattleDataProxy.GetInstance():DispatchWarning(false)
	end

	return
end

function ys.Battle.BattleEnvironmentWave:spawnTimer(arg_7_1)
	local var_7_0

	var_7_0 = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, arg_7_1.delay, function()
		self:doSpawn(arg_7_1)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_7_0)

		return
	end, true)
	self._spawnTimerList[nil] = true

	return
end

function ys.Battle.BattleEnvironmentWave:Dispose()
	for iter_9_0, iter_9_1 in pairs(self._spawnTimerList) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_9_0)
	end

	self._spawnTimerList = nil

	return
end

return
