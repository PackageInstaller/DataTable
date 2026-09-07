ys = ys or {}
ys.Battle.BattleDelayWave = class("BattleDelayWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleDelayWave.__name = "BattleDelayWave"

local var_0_0 = ys.Battle.BattleDelayWave

function ys.Battle.BattleDelayWave.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleDelayWave:SetWaveData(arg_2_1)
	var_0_0.super.SetWaveData(self, arg_2_1)

	self._duration = self._param.timeout

	return
end

function ys.Battle.BattleDelayWave:DoWave()
	var_0_0.super.DoWave(self)

	local var_3_0

	var_3_0 = pg.TimeMgr.GetInstance():AddBattleTimer("delayWave", 1, self._duration, function()
		self:doPass()
		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_3_0)

		return
	end, true)

	return
end

return
