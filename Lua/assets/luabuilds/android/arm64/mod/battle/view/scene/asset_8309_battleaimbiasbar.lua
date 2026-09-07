ys = ys or {}
ys.Battle.BattleAimbiasBar = class("BattleAimbiasBar")
ys.Battle.BattleAimbiasBar.__name = "BattleAimbiasBar"

local var_0_0 = ys.Battle.BattleAimbiasBar

ys.Battle.BattleAimbiasBar.WARNING_VALUE = 0.1

function ys.Battle.BattleAimbiasBar:Ctor(arg_1_1)
	self._aimBiasBar = arg_1_1
	self._aimBiasBarGO = self._aimBiasBar.gameObject
	self._progress = self._aimBiasBar:Find("bias"):GetComponent(typeof(Image))
	self._warning = self._aimBiasBar:Find("warning")
	self._lock = self._aimBiasBar:Find("lock")
	self._recovery = self._aimBiasBar:Find("recovery")

	setActive(self._lock, false)
	setActive(self._warning, false)
	setActive(self._progress, true)
	setActive(self._aimBiasBar, true)
	setActive(self._recovery, true)

	self._cacheSpeed = 0
	self._cacheWarningFlag = 0
	self._lockBlock = false

	return
end

function ys.Battle.BattleAimbiasBar:SetActive(arg_2_1)
	setActive(self._aimBiasBar, arg_2_1)

	return
end

function ys.Battle.BattleAimbiasBar.ConfigAimBias(arg_3_0, arg_3_1)
	arg_3_0._aimBiasComponent = arg_3_1
	arg_3_0._hostile = arg_3_1:IsHostile()

	return
end

function ys.Battle.BattleAimbiasBar:UpdateLockStateView()
	local var_4_0 = self._aimBiasComponent:GetCurrentState() == self._aimBiasComponent.STATE_SKILL_EXPOSE

	setActive(self._lock, var_4_0)

	if var_4_0 then
		setActive(self._recovery, false)
		setActive(self._warning, false)
	elseif self._aimBiasComponent:GetDecayRatioSpeed() < 0 then
		setActive(self._recovery, true)
	elseif not self._hostile then
		local var_4_1 = self._aimBiasComponent:GetCurrentRate()

		if var_4_1 < var_0_0.WARNING_VALUE and var_4_1 > 0 then
			setActive(self._warning, true)
		end
	end

	self._lockBlock = var_4_0

	return
end

function ys.Battle.BattleAimbiasBar:UpdateAimBiasProgress()
	local var_5_0 = self._aimBiasComponent:GetCurrentRate()

	self._progress.fillAmount = var_5_0

	local var_5_1 = self._aimBiasComponent:GetDecayRatioSpeed()
	local var_5_2 = var_5_0 - var_0_0.WARNING_VALUE

	if not self._lockBlock then
		local var_5_3 = var_5_1 < 0

		if var_5_1 * self._cacheSpeed <= 0 then
			setActive(self._recovery, var_5_3)
		end

		if not self._hostile then
			if var_5_0 <= 0 then
				setActive(self._warning, false)
			elseif not var_5_3 and var_5_2 * self._cacheWarningFlag < 0 then
				setActive(self._warning, var_5_0 < var_0_0.WARNING_VALUE)
			end
		end
	end

	if self._hostile and var_5_0 <= 0 then
		setActive(self._aimBiasBar, false)
	end

	self._cacheSpeed = var_5_1
	self._cacheWarningFlag = var_5_2

	return
end

function ys.Battle.BattleAimbiasBar.UpdateAimBiasConfig(arg_6_0)
	return
end

function ys.Battle.BattleAimbiasBar.Dispose(arg_7_0)
	arg_7_0._aimBiasBar = nil
	arg_7_0._progress = nil
	arg_7_0._warning = nil
	arg_7_0._lock = nil
	arg_7_0._aimBiasBarGO = nil

	return
end

function ys.Battle.BattleAimbiasBar:GetGO()
	return self._aimBiasBarGO
end

return
