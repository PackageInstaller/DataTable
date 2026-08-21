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

function ys.Battle.BattleCloakBar.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or var_0_1.FORM_RAD
	arg_1_0._cloakBar = arg_1_1
	arg_1_0._cloakBarGO = arg_1_0._cloakBar.gameObject
	arg_1_0._progress = arg_1_0._cloakBar:Find("progress"):GetComponent(typeof(Image))
	arg_1_0._restoreMark = arg_1_0._cloakBar:Find("cloak_restore")
	arg_1_0._lockProgress = arg_1_0._cloakBar:Find("lock"):GetComponent(typeof(Image))
	arg_1_0._exposeFX = arg_1_0._cloakBar:Find("top_effect")
	arg_1_0._markContainer = arg_1_0._cloakBar:Find("mark")
	arg_1_0._exposeMark = arg_1_0._cloakBar:Find("mark/2")
	arg_1_0._visionMark = arg_1_0._cloakBar:Find("mark/1")

	setActive(arg_1_0._cloakBar, true)
	setActive(arg_1_0._exposeFX, false)
	setActive(arg_1_0._exposeMark, false)
	setActive(arg_1_0._visionMark, false)

	if arg_1_2 == var_0_1.FORM_RAD then
		arg_1_0._restoreMark.localRotation = Vector3(0, 0, 0)
		arg_1_0.meterConvert = var_0_1.__radMeterConvert
		arg_1_0.restoreConvert = var_0_1.__radRestoreConvert
	else
		arg_1_0.meterConvert = var_0_1.__barMeterConvert
		arg_1_0.restoreConvert = var_0_1.__barRestoreConvert
	end

	return
end

function ys.Battle.BattleCloakBar.SetActive(arg_2_0, arg_2_1)
	setActive(arg_2_0._cloakBar, arg_2_1)

	return
end

function ys.Battle.BattleCloakBar.ConfigCloak(arg_3_0, arg_3_1)
	arg_3_0._cloakComponent = arg_3_1

	arg_3_0:initCloak()

	return
end

function ys.Battle.BattleCloakBar.UpdateCloakProgress(arg_4_0)
	arg_4_0._progress.fillAmount = arg_4_0.meterConvert(arg_4_0._cloakComponent:GetCloakValue() / arg_4_0._meterMaxValue)

	local var_4_0 = arg_4_0._cloakComponent:GetCurrentState()

	if var_4_0 == var_0_0.Battle.BattleUnitCloakComponent.STATE_CLOAK then
		setActive(arg_4_0._exposeFX, false)
	elseif var_4_0 == var_0_0.Battle.BattleUnitCloakComponent.STATE_UNCLOAK then
		setActive(arg_4_0._exposeFX, true)
	end

	if var_4_0 == var_0_0.Battle.BattleUnitCloakComponent.STATE_UNCLOAK then
		setActive(arg_4_0._exposeMark, true)
		setActive(arg_4_0._visionMark, false)
	elseif arg_4_0._cloakComponent:GetExposeSpeed() > 0 then
		setActive(arg_4_0._exposeMark, false)
		setActive(arg_4_0._visionMark, true)
	else
		setActive(arg_4_0._exposeMark, false)
		setActive(arg_4_0._visionMark, false)
	end

	return
end

local var_0_2 = Vector3.New(-1, 1, 1)
local var_0_3 = Vector3.New(-0.5, 0.5, 1)
local var_0_4 = Vector3.New(0.5, 0.5, 1)

function ys.Battle.BattleCloakBar.UpdateCloarBarPosition(arg_5_0, arg_5_1)
	if arg_5_1.x < 0 then
		arg_5_0._cloakBar.position = arg_5_1 + Vector3.right
		arg_5_0._cloakBar.localScale = Vector3.one
		arg_5_0._markContainer.localScale = var_0_4
	else
		arg_5_0._cloakBar.position = arg_5_1 + Vector3.left
		arg_5_0._cloakBar.localScale = var_0_2
		arg_5_0._markContainer.localScale = var_0_3
	end

	return
end

function ys.Battle.BattleCloakBar.UpdateCloakConfig(arg_6_0)
	arg_6_0:initCloak()

	return
end

function ys.Battle.BattleCloakBar.UpdateCloakLock(arg_7_0)
	arg_7_0._lockProgress.fillAmount = arg_7_0.meterConvert(arg_7_0._cloakComponent:GetCloakBottom() / arg_7_0._meterMaxValue)

	return
end

function ys.Battle.BattleCloakBar.initCloak(arg_8_0)
	arg_8_0._meterMaxValue = arg_8_0._cloakComponent:GetCloakMax()

	arg_8_0:updateRestoreMark()

	return
end

function ys.Battle.BattleCloakBar.updateRestoreMark(arg_9_0)
	arg_9_0.restoreConvert(arg_9_0._cloakComponent:GetCloakRestoreValue() / arg_9_0._meterMaxValue, arg_9_0._restoreMark)

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

function ys.Battle.BattleCloakBar.Dispose(arg_14_0)
	arg_14_0._cloakComponent = nil
	arg_14_0._cloakBar = nil
	arg_14_0._progress = nil
	arg_14_0._restoreMark = nil
	arg_14_0._exposeFX = nil

	Object.Destroy(arg_14_0._cloakBarGO)

	arg_14_0._cloakBarGO = nil

	return
end

return
