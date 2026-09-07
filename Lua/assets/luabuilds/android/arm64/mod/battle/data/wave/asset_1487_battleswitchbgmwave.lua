ys = ys or {}
ys.Battle.BattleSwitchBGMWave = class("BattleSwitchBGMWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleSwitchBGMWave.__name = "BattleSwitchBGMWave"

local var_0_0 = ys.Battle.BattleSwitchBGMWave

function ys.Battle.BattleSwitchBGMWave.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleSwitchBGMWave:SetWaveData(arg_2_1)
	var_0_0.super.SetWaveData(self, arg_2_1)

	self._bgmName = self._param.bgm

	return
end

function ys.Battle.BattleSwitchBGMWave:DoWave()
	var_0_0.super.DoWave(self)
	pg.BgmMgr.GetInstance():Push(BattleScene.__cname, self._bgmName)
	self:doPass()

	return
end

return
