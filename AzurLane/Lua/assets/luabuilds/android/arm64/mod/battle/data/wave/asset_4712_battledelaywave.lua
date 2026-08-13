ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleDelayWave = var_0_10002("BattleDelayWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleDelayWave.__name = "BattleDelayWave"

local var_0_2 = var_0.Battle.BattleDelayWave

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetWaveData(arg_2_0, arg_2_1)
	var_0_2.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._duration = arg_2_0._param.timeout

	return
end

function var_0_2.DoWave(arg_3_0)
	var_0_2.super.DoWave(arg_3_0)

	local var_3_0

	local function var_3_1()
		local var_4_0 = arg_3_0

		var_0.doPass(var_4_0)

		pg = var_0

		local var_4_1 = var_0.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_4_1, var_3_0)

		return
	end

	pg = var_3

	local var_3_2 = var_3.TimeMgr.GetInstance()

	var_3_0 = var_3.AddBattleTimer(var_3_2, "delayWave", 1, arg_3_0._duration, var_3_1, true)

	return
end

return
