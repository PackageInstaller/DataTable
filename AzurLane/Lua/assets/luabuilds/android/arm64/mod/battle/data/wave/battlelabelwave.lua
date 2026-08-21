ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleLabelWave = class("BattleLabelWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleLabelWave.__name = "BattleLabelWave"

local var_0_1 = ys.Battle.BattleLabelWave

function ys.Battle.BattleLabelWave.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleLabelWave.SetWaveData(arg_2_0, arg_2_1)
	var_0_1.super.SetWaveData(arg_2_0, arg_2_1)

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

function ys.Battle.BattleLabelWave.DoWave(arg_3_0)
	var_0_1.super.DoWave(arg_3_0)
	var_0_0.Battle.BattleState.GetInstance():GetProxyByName(var_0_0.Battle.BattleDataProxy.__name):DispatchCustomWarning(arg_3_0._labelData)
	arg_3_0:doPass()

	return
end

return
