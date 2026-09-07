ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleJammingWave = class("BattleJammingWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleJammingWave.__name = "BattleJammingWave"

local var_0_1 = ys.Battle.BattleJammingWave

ys.Battle.BattleJammingWave.JAMMING_ENGAGE = 1
ys.Battle.BattleJammingWave.JAMMING_DODGE = 2

function ys.Battle.BattleJammingWave.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleJammingWave:DoWave()
	var_0_1.super.DoWave(self)

	local var_2_0 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_2_1 = var_2_0:GetInitData().KizunaJamming

	if var_2_1 and table.contains(var_2_1, var_0_1.JAMMING_ENGAGE) then
		var_2_0:KizunaJamming()
	end

	self:doFinish()

	return
end

return
