ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleCloakBar = var_0_10002("BattleCloakBar")
var_0.Battle.BattleCloakBar.__name = "BattleCloakBar"

local var_0_2 = var_0.Battle.BattleCloakBar

var_0_2.FORM_RAD = "radian"
var_0_2.FORM_BAR = "bar"
var_0_2.MIN = 0.31
var_0_2.MAX = 0.69
var_0_2.METER_LENGTH = var_0_2.MAX - var_0_2.MIN
var_0_2.MIN_ANGLE = -31
var_0_2.MAX_ANGLE = 33
var_0_2.RESTORE_LEGHTH = var_0_2.MAX_ANGLE - var_0_2.MIN_ANGLE
var_0_2.BAR_MIN = -62
var_0_2.BAR_MAX = 62
var_0_2.BAR_STEP = var_0_2.BAR_MAX - var_0_2.BAR_MIN

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or var_0_2.FORM_RAD
	arg_1_0._cloakBar = arg_1_1
	arg_1_0._cloakBarGO = arg_1_0._cloakBar.gameObject

	local var_1_0 = arg_1_0._cloakBar
	local var_1_1 = var_3.Find(var_1_0, "progress")
	local var_1_2 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0._progress = var_1_2(var_1_1, var_6(var_1_10008))

	local var_1_3 = arg_1_0._cloakBar

	arg_1_0._restoreMark = var_3.Find(var_1_3, "cloak_restore")

	local var_1_4 = arg_1_0._cloakBar
	local var_1_5 = var_3.Find(var_1_4, "lock")
	local var_1_6 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0._lockProgress = var_1_6(var_1_5, var_6(var_1_10008))

	local var_1_7 = arg_1_0._cloakBar

	arg_1_0._exposeFX = var_3.Find(var_1_7, "top_effect")

	local var_1_8 = arg_1_0._cloakBar

	arg_1_0._markContainer = var_3.Find(var_1_8, "mark")

	local var_1_9 = arg_1_0._cloakBar

	arg_1_0._exposeMark = var_3.Find(var_1_9, "mark/2")

	local var_1_10 = arg_1_0._cloakBar

	arg_1_0._visionMark = var_3.Find(var_1_10, "mark/1")
	setActive = var_3

	var_3(arg_1_0._cloakBar, true)

	setActive = var_3

	var_3(arg_1_0._exposeFX, false)

	setActive = var_3

	var_3(arg_1_0._exposeMark, false)

	setActive = var_3

	var_3(arg_1_0._visionMark, false)

	if arg_1_2 == var_0_2.FORM_RAD then
		local var_1_11 = arg_1_0._restoreMark

		Vector3 = var_1_10004
		var_1_11.localRotation = var_1_10004(0, 0, 0)
		arg_1_0.meterConvert = var_0_2.__radMeterConvert
		arg_1_0.restoreConvert = var_0_2.__radRestoreConvert
	else
		arg_1_0.meterConvert = var_0_2.__barMeterConvert
		arg_1_0.restoreConvert = var_0_2.__barRestoreConvert
	end

	return
end

function var_0_2.SetActive(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._cloakBar, arg_2_1)

	return
end

function var_0_2.ConfigCloak(arg_3_0, arg_3_1)
	arg_3_0._cloakComponent = arg_3_1

	arg_3_0:initCloak()

	return
end

function var_0_2.UpdateCloakProgress(arg_4_0)
	local var_4_0 = arg_4_0._cloakComponent
	local var_4_1 = var_1.GetCloakValue(var_4_0) / arg_4_0._meterMaxValue

	arg_4_0._progress.fillAmount = arg_4_0.meterConvert(var_4_1)

	local var_4_2 = arg_4_0._cloakComponent

	if var_3.GetCurrentState(var_4_2) == var_0.Battle.BattleUnitCloakComponent.STATE_CLOAK then
		setActive = var_4

		var_4(arg_4_0._exposeFX, false)
	elseif var_3 == var_0.Battle.BattleUnitCloakComponent.STATE_UNCLOAK then
		setActive = var_4

		var_4(arg_4_0._exposeFX, true)
	end

	if var_3 == var_0.Battle.BattleUnitCloakComponent.STATE_UNCLOAK then
		setActive = var_4

		var_4(arg_4_0._exposeMark, true)

		setActive = var_4

		var_4(arg_4_0._visionMark, false)
	else
		local var_4_3 = arg_4_0._cloakComponent

		if var_4.GetExposeSpeed(var_4_3) > 0 then
			setActive = var_4

			var_4(arg_4_0._exposeMark, false)

			setActive = var_4

			var_4(arg_4_0._visionMark, true)
		else
			setActive = var_4

			var_4(arg_4_0._exposeMark, false)

			setActive = var_4

			var_4(arg_4_0._visionMark, false)
		end
	end

	return
end

Vector3 = var_2

local var_0_3 = var_2.New(-1, 1, 1)

Vector3 = var_3

local var_0_4 = var_3.New(-0.5, 0.5, 1)

Vector3 = var_4

local var_0_5 = var_4.New(0.5, 0.5, 1)

function var_0_2.UpdateCloarBarPosition(arg_5_0, arg_5_1)
	if arg_5_1.x < 0 then
		local var_5_0 = arg_5_0._cloakBar

		Vector3 = var_3
		var_5_0.position = arg_5_1 + var_3.right

		local var_5_1 = arg_5_0._cloakBar

		Vector3 = var_3
		var_5_1.localScale = var_3.one
		arg_5_0._markContainer.localScale = var_0_5
	else
		local var_5_2 = arg_5_0._cloakBar

		Vector3 = var_3
		var_5_2.position = arg_5_1 + var_3.left
		arg_5_0._cloakBar.localScale = var_0_3
		arg_5_0._markContainer.localScale = var_0_4
	end

	return
end

function var_0_2.UpdateCloakConfig(arg_6_0)
	arg_6_0:initCloak()

	return
end

function var_0_2.UpdateCloakLock(arg_7_0)
	local var_7_0 = arg_7_0._cloakComponent
	local var_7_1 = var_1.GetCloakBottom(var_7_0) / arg_7_0._meterMaxValue

	arg_7_0._lockProgress.fillAmount = arg_7_0.meterConvert(var_7_1)

	return
end

function var_0_2.initCloak(arg_8_0)
	local var_8_0 = arg_8_0._cloakComponent

	arg_8_0._meterMaxValue = var_1.GetCloakMax(var_8_0)

	arg_8_0:updateRestoreMark()

	return
end

function var_0_2.updateRestoreMark(arg_9_0)
	local var_9_0 = arg_9_0._cloakComponent
	local var_9_1 = var_1.GetCloakRestoreValue(var_9_0) / arg_9_0._meterMaxValue

	arg_9_0.restoreConvert(var_9_1, arg_9_0._restoreMark)

	return
end

function var_0_2.__radMeterConvert(arg_10_0)
	return var_0_2.METER_LENGTH * arg_10_0 + var_0_2.MIN
end

function var_0_2.__radRestoreConvert(arg_11_0, arg_11_1)
	local var_11_0 = var_0_2.RESTORE_LEGHTH * arg_11_0 + var_0_2.MIN_ANGLE

	Quaternion = var_3
	arg_11_1.localRotation = var_3.Euler(0, 0, var_11_0)

	return
end

function var_0_2.__barMeterConvert(arg_12_0)
	return arg_12_0
end

function var_0_2.__barRestoreConvert(arg_13_0, arg_13_1)
	local var_13_0 = var_0_2.BAR_STEP * arg_13_0 + var_0_2.BAR_MIN

	Vector3 = var_3
	arg_13_1.localPosition = var_3(var_13_0, 0, 0)

	return
end

function var_0_2.Dispose(arg_14_0)
	arg_14_0._cloakComponent = nil
	arg_14_0._cloakBar = nil
	arg_14_0._progress = nil
	arg_14_0._restoreMark = nil
	arg_14_0._exposeFX = nil
	Object = var_1

	var_1.Destroy(arg_14_0._cloakBarGO)

	arg_14_0._cloakBarGO = nil

	return
end

return
