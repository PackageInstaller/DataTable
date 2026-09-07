ys = ys or {}
ys.Battle.BattleRecoilShieldBar = class("BattleRecoilShieldBar")
ys.Battle.BattleRecoilShieldBar.__name = "BattleRecoilShieldBar"
ys.Battle.BattleRecoilShieldBar.WARNING_VALUE = 0.1

function ys.Battle.BattleRecoilShieldBar:Ctor(arg_1_1)
	self._recoilShieldBar = arg_1_1
	self._recoilShieldBarGO = self._recoilShieldBar.gameObject
	self._progress = self._recoilShieldBar:Find("shield"):GetComponent(typeof(Image))

	setActive(self._progress, true)
	setActive(self._recoilShieldBar, true)

	self._lockBlock = false

	return
end

function ys.Battle.BattleRecoilShieldBar:SetActive(arg_2_1)
	setActive(self._recoilShieldBar, arg_2_1)

	return
end

function ys.Battle.BattleRecoilShieldBar.ConfigShieldBuff(arg_3_0, arg_3_1)
	arg_3_0._recoilShieldBuffEffect = arg_3_1

	return
end

function ys.Battle.BattleRecoilShieldBar:UpdateRecoilShieldProgress()
	self._progress.fillAmount = self._recoilShieldBuffEffect:GetCurrentRate()

	return
end

function ys.Battle.BattleRecoilShieldBar.Dispose(arg_5_0)
	arg_5_0._recoilShieldBar = nil
	arg_5_0._progress = nil
	arg_5_0._recoilShieldBarGO = nil

	return
end

function ys.Battle.BattleRecoilShieldBar:GetGO()
	return self._aimBiasBarGO
end

return
