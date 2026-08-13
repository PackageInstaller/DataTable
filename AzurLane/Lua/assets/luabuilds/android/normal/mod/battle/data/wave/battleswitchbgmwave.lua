ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSwitchBGMWave = var_0_10002("BattleSwitchBGMWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleSwitchBGMWave.__name = "BattleSwitchBGMWave"

local var_0_2 = var_0.Battle.BattleSwitchBGMWave

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetWaveData(arg_2_0, arg_2_1)
	var_0_2.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._bgmName = arg_2_0._param.bgm

	return
end

function var_0_2.DoWave(arg_3_0)
	var_0_2.super.DoWave(arg_3_0)

	pg = var_1

	local var_3_0 = var_1.BgmMgr.GetInstance()
	local var_3_1 = var_1.Push

	BattleScene = var_1_10003

	var_3_1(var_3_0, var_1_10003.__cname, arg_3_0._bgmName)
	arg_3_0:doPass()

	return
end

return
