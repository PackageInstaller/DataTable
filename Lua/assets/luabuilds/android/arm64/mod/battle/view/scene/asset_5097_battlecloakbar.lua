ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleCloakBar = class("BattleCloakBar")
ys.Battle.BattleCloakBar.__name = "BattleCloakBar"

local var_0_1 = ys.Battle.BattleCloakBar

ys.Battle.BattleCloakBar.FORM_RAD = "radian"
ys.Battle.BattleCloakBar.FORM_BAR = "bar"
ys.Battle.BattleCloakBar.MIN = 0.31
ys.Battle.BattleCloakBar.MAX = 0.69
ys.Battle.BattleCloakBar.METER_LENGTH = ys.Battle.BattleCloakBar.MAX - ys.Battle.BattleCloakBar.MIN
ys.Battle.BattleCloakBar.MIN_ANGLE = -31
ys.Battle.BattleCloakBar.MAX_ANGLE = 33
ys.Battle.BattleCloakBar.RESTORE_LEGHTH = ys.Battle.BattleCloakBar.MAX_ANGLE - ys.Battle.BattleCloakBar.MIN_ANGLE
ys.Battle.BattleCloakBar.BAR_MIN = -62
ys.Battle.BattleCloakBar.BAR_MAX = 62
ys.Battle.BattleCloakBar.BAR_STEP = ys.Battle.BattleCloakBar.BAR_MAX - ys.Battle.BattleCloakBar.BAR_MIN

function ys.Battle.BattleCloakBar:Ctor(arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or var_0_1.FORM_RAD
	self._cloakBar = arg_1_1
	self._cloakBarGO = self._cloakBar.gameObject
	self._progress = self._cloakBar:Find("progress"):GetComponent(typeof(Image))
	self._restoreMark = self._cloakBar:Find("cloak_restore")
	self._lockProgress = self._cloakBar:Find("lock"):GetComponent(typeof(Image))
	self._exposeFX = self._cloakBar:Find("top_effect")
	self._markContainer = self._cloakBar:Find("mark")
	self._exposeMark = self._cloakBar:Find("mark/2")
	self._visionMark = self._cloakBar:Find("mark/1")

	setActive(self._cloakBar, true)
	setActive(self._exposeFX, false)
	setActive(self._exposeMark, false)
	setActive(self._visionMark, false)

	if arg_1_2 == var_0_1.FORM_RAD then
		self._restoreMark.localRotation = Vector3(0, 0, 0)
		self.meterConvert = var_0_1.__radMeterConvert
		self.restoreConvert = var_0_1.__radRestoreConvert
	else
		self.meterConvert = var_0_1.__barMeterConvert
		self.restoreConvert = var_0_1.__barRestoreConvert
	end

	return
end

function ys.Battle.BattleCloakBar:SetActive(arg_2_1)
	setActive(self._cloakBar, arg_2_1)

	return
end

function ys.Battle.BattleCloakBar:ConfigCloak(arg_3_1)
	self._cloakComponent = arg_3_1

	self:initCloak()

	return
end

function ys.Battle.BattleCloakBar:UpdateCloakProgress()
	self._progress.fillAmount = self.meterConvert(self._cloakComponent:GetCloakValue() / self._meterMaxValue)

	local var_4_0 = self._cloakComponent:GetCurrentState()

	if var_4_0 == var_0_0.Battle.BattleUnitCloakComponent.STATE_CLOAK then
		setActive(self._exposeFX, false)
	elseif var_4_0 == var_0_0.Battle.BattleUnitCloakComponent.STATE_UNCLOAK then
		setActive(self._exposeFX, true)
	end

	if var_4_0 == var_0_0.Battle.BattleUnitCloakComponent.STATE_UNCLOAK then
		setActive(self._exposeMark, true)
		setActive(self._visionMark, false)
	elseif self._cloakComponent:GetExposeSpeed() > 0 then
		setActive(self._exposeMark, false)
		setActive(self._visionMark, true)
	else
		setActive(self._exposeMark, false)
		setActive(self._visionMark, false)
	end

	return
end

local var_0_2 = Vector3.New(-1, 1, 1)
local var_0_3 = Vector3.New(-0.5, 0.5, 1)
local var_0_4 = Vector3.New(0.5, 0.5, 1)

function ys.Battle.BattleCloakBar:UpdateCloarBarPosition(arg_5_1)
	if arg_5_1.x < 0 then
		self._cloakBar.position = arg_5_1 + Vector3.right
		self._cloakBar.localScale = Vector3.one
		self._markContainer.localScale = var_0_4
	else
		self._cloakBar.position = arg_5_1 + Vector3.left
		self._cloakBar.localScale = var_0_2
		self._markContainer.localScale = var_0_3
	end

	return
end

function ys.Battle.BattleCloakBar:UpdateCloakConfig()
	self:initCloak()

	return
end

function ys.Battle.BattleCloakBar:UpdateCloakLock()
	self._lockProgress.fillAmount = self.meterConvert(self._cloakComponent:GetCloakBottom() / self._meterMaxValue)

	return
end

function ys.Battle.BattleCloakBar:initCloak()
	self._meterMaxValue = self._cloakComponent:GetCloakMax()

	self:updateRestoreMark()

	return
end

function ys.Battle.BattleCloakBar:updateRestoreMark()
	self.restoreConvert(self._cloakComponent:GetCloakRestoreValue() / self._meterMaxValue, self._restoreMark)

	return
end

function ys.Battle.BattleCloakBar.__radMeterConvert(arg_10_0)
	return var_0_1.METER_LENGTH * arg_10_0 + var_0_1.MIN
end

function ys.Battle.BattleCloakBar.__radRestoreConvert(arg_11_0, arg_11_1)
	arg_11_1.localRotation = Quaternion.Euler(0, 0, var_0_1.RESTORE_LEGHTH * arg_11_0 + var_0_1.MIN_ANGLE)

	return
end

function ys.Battle.BattleCloakBar.__barMeterConvert(arg_12_0)
	return arg_12_0
end

function ys.Battle.BattleCloakBar.__barRestoreConvert(arg_13_0, arg_13_1)
	arg_13_1.localPosition = Vector3(var_0_1.BAR_STEP * arg_13_0 + var_0_1.BAR_MIN, 0, 0)

	return
end

function ys.Battle.BattleCloakBar:Dispose()
	self._cloakComponent = nil
	self._cloakBar = nil
	self._progress = nil
	self._restoreMark = nil
	self._exposeFX = nil

	Object.Destroy(self._cloakBarGO)

	self._cloakBarGO = nil

	return
end

return
