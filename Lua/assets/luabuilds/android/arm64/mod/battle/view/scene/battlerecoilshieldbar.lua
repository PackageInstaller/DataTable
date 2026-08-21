ys = ys or {}
ys.Battle.BattleRecoilShieldBar = class("BattleRecoilShieldBar")
ys.Battle.BattleRecoilShieldBar.__name = "BattleRecoilShieldBar"
ys.Battle.BattleRecoilShieldBar.WARNING_VALUE = 0.1

function ys.Battle.BattleRecoilShieldBar.Ctor(arg_1_0, arg_1_1)
	arg_1_0._recoilShieldBar = arg_1_1
	arg_1_0._recoilShieldBarGO = arg_1_0._recoilShieldBar.gameObject
	arg_1_0._progress = arg_1_0._recoilShieldBar:Find("shield"):GetComponent(typeof(Image))

	setActive(arg_1_0._progress, true)
	setActive(arg_1_0._recoilShieldBar, true)

	arg_1_0._lockBlock = false

	return
end

function ys.Battle.BattleRecoilShieldBar.SetActive(arg_2_0, arg_2_1)
	setActive(arg_2_0._recoilShieldBar, arg_2_1)

	return
end

function ys.Battle.BattleRecoilShieldBar.ConfigShieldBuff(arg_3_0, arg_3_1)
	arg_3_0._recoilShieldBuffEffect = arg_3_1

	return
end

function ys.Battle.BattleRecoilShieldBar.UpdateRecoilShieldProgress(arg_4_0)
	arg_4_0._progress.fillAmount = arg_4_0._recoilShieldBuffEffect:GetCurrentRate()

	return
end

function ys.Battle.BattleRecoilShieldBar.Dispose(arg_5_0)
	arg_5_0._recoilShieldBar = nil
	arg_5_0._progress = nil
	arg_5_0._recoilShieldBarGO = nil

	return
end

function ys.Battle.BattleRecoilShieldBar.GetGO(arg_6_0)
	return arg_6_0._aimBiasBarGO
end

return
