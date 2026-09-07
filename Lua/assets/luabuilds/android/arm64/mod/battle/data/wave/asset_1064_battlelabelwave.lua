ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleLabelWave = class("BattleLabelWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleLabelWave.__name = "BattleLabelWave"

local var_0_1 = ys.Battle.BattleLabelWave

function ys.Battle.BattleLabelWave.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleLabelWave:SetWaveData(arg_2_1)
	var_0_1.super.SetWaveData(self, arg_2_1)

	self._labelData = {
		op = self._param.op,
		key = self._param.key,
		x = self._param.x,
		y = self._param.y,
		dialogue = self._param.dialogue,
		duration = self._param.duration
	}

	return
end

function ys.Battle.BattleLabelWave:DoWave()
	var_0_1.super.DoWave(self)
	var_0_0.Battle.BattleState.GetInstance():GetProxyByName(var_0_0.Battle.BattleDataProxy.__name):DispatchCustomWarning(self._labelData)
	self:doPass()

	return
end

return
