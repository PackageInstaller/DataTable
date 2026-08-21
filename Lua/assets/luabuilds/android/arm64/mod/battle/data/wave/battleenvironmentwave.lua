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

function ys.Battle.BattleEnvironmentWave.DoWave(arg_3_0)
	var_0_1.super.DoWave(arg_3_0)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._sapwnData) do
		if iter_3_1.delay and iter_3_1.delay > 0 then
			arg_3_0:spawnTimer(iter_3_1)
		else
			arg_3_0:doSpawn(iter_3_1)
		end
	end

	if arg_3_0._environWarning then
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

function ys.Battle.BattleEnvironmentWave.doPass(arg_6_0)
	if arg_6_0._environWarning then
		var_0_0.Battle.BattleDataProxy.GetInstance():DispatchWarning(false)
	end

	return
end

function ys.Battle.BattleEnvironmentWave.spawnTimer(arg_7_0, arg_7_1)
	local var_7_0

	arg_7_0._spawnTimerList[pg.TimeMgr.GetInstance():AddBattleTimer("", 1, arg_7_1.delay, function()
		arg_7_0:doSpawn(arg_7_1)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_7_0)

		return
	end, true)] = true

	return
end

function ys.Battle.BattleEnvironmentWave.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._spawnTimerList) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_9_0)
	end

	arg_9_0._spawnTimerList = nil

	return
end

return
