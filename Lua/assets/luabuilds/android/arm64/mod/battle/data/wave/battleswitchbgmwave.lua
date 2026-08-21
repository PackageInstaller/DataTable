ys = ys or {}
ys.Battle.BattleSwitchBGMWave = class("BattleSwitchBGMWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleSwitchBGMWave.__name = "BattleSwitchBGMWave"

local var_0_0 = ys.Battle.BattleSwitchBGMWave

function ys.Battle.BattleSwitchBGMWave.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleSwitchBGMWave.SetWaveData(arg_2_0, arg_2_1)
	var_0_0.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._bgmName = arg_2_0._param.bgm

	return
end

function ys.Battle.BattleSwitchBGMWave.DoWave(arg_3_0)
	var_0_0.super.DoWave(arg_3_0)
	pg.BgmMgr.GetInstance():Push(BattleScene.__cname, arg_3_0._bgmName)
	arg_3_0:doPass()

	return
end

return
