ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleEnvironmentWave = var_0_10002("BattleEnvironmentWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleEnvironmentWave.__name = "BattleEnvironmentWave"

local var_0_2 = var_0.Battle.BattleEnvironmentWave

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	arg_1_0._spawnTimerList = {}

	return
end

function var_0_2.SetWaveData(arg_2_0, arg_2_1)
	var_0_2.super.SetWaveData(arg_2_0, arg_2_1)

	local var_2_0

	if not arg_2_1.spawn then
		var_2_0 = {}
	end

	arg_2_0._sapwnData = var_2_0
	arg_2_0._environWarning = arg_2_1.warning

	return
end

function var_0_2.DoWave(arg_3_0)
	var_0_2.super.DoWave(arg_3_0)

	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0._sapwnData) do
		if iter_3_1.delay and iter_3_1.delay > 0 then
			arg_3_0:spawnTimer(iter_3_1)
		else
			arg_3_0:doSpawn(iter_3_1)
		end
	end

	if arg_3_0._environWarning then
		local var_3_0 = var_0.Battle.BattleDataProxy.GetInstance()

		var_1.DispatchWarning(var_3_0, true)
	end

	return
end

function var_0_2.doSpawn(arg_4_0, arg_4_1)
	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_4_1 = var_2.SpawnEnvironment(var_4_0, arg_4_1)

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.doPass(var_5_0)

		return
	end

	var_4_1:ConfigCallback(var_4_2)

	return
end

function var_0_2.doPass(arg_6_0)
	if arg_6_0._environWarning then
		local var_6_0 = var_0.Battle.BattleDataProxy.GetInstance()

		var_1.DispatchWarning(var_6_0, false)
	end

	return
end

function var_0_2.spawnTimer(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = arg_7_1.delay

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.doSpawn(var_8_0, arg_7_1)

		pg = var_0

		local var_8_1 = var_0.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_8_1, var_7_0)

		return
	end

	pg = var_1_10005

	local var_7_3 = var_1_10005.TimeMgr.GetInstance()

	var_7_0 = var_5.AddBattleTimer(var_7_3, "", 1, var_7_1, var_7_2, true)
	arg_7_0._spawnTimerList[var_7_0] = true

	return
end

function var_0_2.Dispose(arg_9_0)
	pairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0._spawnTimerList) do
		pg = var_1_10006

		local var_9_0 = var_1_10006.TimeMgr.GetInstance()

		var_1_10006.RemoveBattleTimer(var_9_0, iter_9_0)
	end

	arg_9_0._spawnTimerList = nil

	return
end

return
