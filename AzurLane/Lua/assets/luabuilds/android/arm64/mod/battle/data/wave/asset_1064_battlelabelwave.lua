ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleLabelWave = var_0_10002("BattleLabelWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleLabelWave.__name = "BattleLabelWave"

local var_0_2 = var_0.Battle.BattleLabelWave

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetWaveData(arg_2_0, arg_2_1)
	var_0_2.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._labelData = {
		op = arg_2_0._param.op,
		key = arg_2_0._param.key,
		x = arg_2_0._param.x,
		y = arg_2_0._param.y,
		dialogue = arg_2_0._param.dialogue,
		duration = arg_2_0._param.duration
	}

	return
end

function var_0_2.DoWave(arg_3_0)
	var_0_2.super.DoWave(arg_3_0)

	local var_3_0 = var_0.Battle.BattleState.GetInstance()
	local var_3_1 = var_1.GetProxyByName(var_3_0, var_0.Battle.BattleDataProxy.__name)

	var_2.DispatchCustomWarning(var_3_1, arg_3_0._labelData)
	arg_3_0:doPass()

	return
end

return
