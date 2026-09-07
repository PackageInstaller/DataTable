ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleClearWave = class("BattleClearWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleClearWave.__name = "BattleClearWave"

local var_0_1 = ys.Battle.BattleClearWave

function ys.Battle.BattleClearWave.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleClearWave:DoWave()
	var_0_1.super.DoWave(self)

	local var_2_0 = var_0_0.Battle.BattleState.GetInstance()
	local var_2_1 = var_2_0:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)

	var_2_1:KillAllAircraft()
	var_2_1:KillSubmarineByIFF(var_0_0.Battle.BattleConfig.FOE_CODE)
	var_2_0:GetMediatorByName(var_0_0.Battle.BattleSceneMediator.__name):AllBulletNeutralize()
	self:doPass()

	return
end

return
