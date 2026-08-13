ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleClearWave = var_0_10002("BattleClearWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleClearWave.__name = "BattleClearWave"

local var_0_2 = var_0.Battle.BattleClearWave

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.DoWave(arg_2_0)
	var_0_2.super.DoWave(arg_2_0)

	local var_2_0 = var_0.Battle.BattleState.GetInstance()
	local var_2_1 = var_1.GetProxyByName(var_2_0, var_0.Battle.BattleDataProxy.__name)
	local var_2_2 = var_1:GetMediatorByName(var_0.Battle.BattleSceneMediator.__name)

	var_2_1:KillAllAircraft()
	var_2_1:KillSubmarineByIFF(var_0.Battle.BattleConfig.FOE_CODE)
	var_2_2:AllBulletNeutralize()
	arg_2_0:doPass()

	return
end

return
