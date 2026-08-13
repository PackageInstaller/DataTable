ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleVariable
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleConfig

singletonClass = var_0_10004

local var_0_4 = var_0_10004("BattleCameraUtil")

var_0.Battle.BattleCameraUtil = var_0_4
var_0_4.__name = "BattleCameraUtil"
var_0_4.FOCUS_PILOT = "FOCUS_PILOT"
var_0_4.TWEEN_TO_CHARACTER = "TWEEN_TO_CHARACTER"
var_0_4.FOLLOW_GESTURE = "FOLLOW_GESTURE"

function var_0_4.Ctor(arg_1_0)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	pg = var_1

	local var_1_0 = var_1.UIMgr.GetInstance()
	local var_1_1 = var_1.GetMainCamera(var_1_0)
	local var_1_2 = var_1.GetComponent

	typeof = var_1_10004
	Camera = var_1_10006
	arg_1_0._camera = var_1_2(var_1_1, var_1_10004(var_1_10006))
	arg_1_0._cameraTF = arg_1_0._camera.transform
	GameObject = var_1

	local var_1_3 = var_1.Find("UICamera")
	local var_1_4 = var_1.GetComponent

	typeof = var_4
	Camera = var_1_10006
	arg_1_0._uiCamera = var_1_4(var_1_3, var_4(var_1_10006))
	pg = var_1
	arg_1_0._cameraFixMgr = var_1.CameraFixMgr.GetInstance()

	return
end

function var_0_4.ActiveMainCamera(arg_2_0)
	CameraMgr = var_1_10001

	local var_2_0 = var_1_10001.instance

	var_1.SetActiveMainCamera(var_2_0, arg_2_0)

	return
end

function var_0_4.Initialize(arg_3_0)
	local var_3_0 = arg_3_0._cameraTF

	var_3_0.localPosition = var_0_3.CAMERA_INIT_POS
	CameraMgr = var_3_0

	local var_3_1 = var_3_0.instance

	var_1.SetCameraOrthographicSize(var_3_1, arg_3_0._camera, 20)
	var_0_1.UpdateCameraPositionArgs()
	arg_3_0:setArrowPoint()

	arg_3_0._boundFix = var_0.Battle.BattleCameraBoundFixDecorate.New()
	arg_3_0._followPilot = var_0.Battle.BattleCameraFollowPilot.New()
	arg_3_0._focusCharacter = var_0.Battle.BattleCameraFocusChar.New()
	arg_3_0._fromTo = var_0.Battle.BattleCameraTween.New()
	arg_3_0._gesture = var_0.Battle.BattleCameraFollowGesture.New()

	arg_3_0:active()
	arg_3_0:SwitchCameraPos()

	arg_3_0._shakeEnabled = true

	local var_3_2 = var_0.Battle.BattleState.GetInstance()

	arg_3_0._uiMediator = var_1.GetMediatorByName(var_3_2, var_0.Battle.BattleUIMediator.__name)

	return
end

function var_0_4.Clear(arg_4_0)
	arg_4_0.ActiveMainCamera(false)

	LeanTween = var_1

	local var_4_0 = var_1.cancel

	go = var_3

	var_4_0(var_3(arg_4_0._camera))
	arg_4_0:Deactive()
	arg_4_0:StopShake()

	local var_4_1 = arg_4_0._boundFix

	var_1.Dispose(var_4_1)

	local var_4_2 = arg_4_0._followPilot

	var_1.Dispose(var_4_2)

	local var_4_3 = arg_4_0._focusCharacter

	var_1.Dispose(var_4_3)

	local var_4_4 = arg_4_0._fromTo

	var_1.Dispose(var_4_4)

	local var_4_5 = arg_4_0._gesture

	var_1.Dispose(var_4_5)

	local var_4_6 = arg_4_0._cameraTF

	Vector3 = var_1_10002
	var_4_6.localPosition = var_1_10002(0, 62, -10)
	CameraMgr = var_4_6

	local var_4_7 = var_4_6.instance

	var_1.SetCameraOrthographicSize(var_4_7, arg_4_0._camera, 20)

	arg_4_0._uiMediator = nil

	return
end

function var_0_4.SetMapData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_0._boundFix
	local var_5_1, var_5_2, var_5_3, var_5_4 = var_5.SetMapData(var_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)

	pg = var_9

	local var_5_5 = var_9.CameraFixMgr.GetInstance().actualWidth
	local var_5_6 = arg_5_0._followPilot
	local var_5_7 = var_10.SetGoldenRation
	local var_5_8 = arg_5_0._camera
	local var_5_9 = var_13.ScreenToWorldPoint

	Vector3 = var_1_10016

	var_5_7(var_5_6, var_5_9(var_5_8, var_1_10016(var_5_5 * var_0_3.CAMERA_GOLDEN_RATE, 0, 0)).x - arg_5_0._cameraTF.position.x)

	return var_5_1, var_5_2, var_5_3, var_5_4
end

function var_0_4.SetFocusFleet(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._followPilot

	var_2.SetFleetVO(var_6_0, arg_6_1)

	local var_6_1 = arg_6_0._cameraTF
	local var_6_2 = arg_6_0._boundFix
	local var_6_3 = var_3.GetCameraPos
	local var_6_4 = arg_6_0._followPilot

	var_6_1.position = var_6_3(var_6_2, var_6.GetCameraPos(var_6_4))

	var_0_1.UpdateCameraPositionArgs()

	return
end

function var_0_4.SetCameraSilder(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._gesture

	var_2.SetGestureComponent(var_7_0, arg_7_1)

	return
end

function var_0_4.SwitchCameraPos(arg_8_0, arg_8_1)
	if arg_8_1 == "TWEEN_TO_CHARACTER" then
		function arg_8_0._currentCameraPos()
			local var_9_0 = arg_8_0._fromTo

			return var_0.GetCameraPos(var_9_0)
		end
	elseif arg_8_1 == "FOLLOW_GESTURE" then
		function arg_8_0._currentCameraPos()
			local var_10_0 = arg_8_0._boundFix
			local var_10_1 = var_0.GetCameraPos
			local var_10_2 = arg_8_0._gesture

			return var_10_1(var_10_0, var_3.GetCameraPos(var_10_2, arg_8_0._cameraTF.position))
		end
	else
		function arg_8_0._currentCameraPos()
			local var_11_0 = arg_8_0._boundFix
			local var_11_1 = var_0.GetCameraPos
			local var_11_2 = arg_8_0._followPilot

			return var_11_1(var_11_0, var_3.GetCameraPos(var_11_2))
		end
	end

	return
end

function var_0_4.GetS2WPoint(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._camera

	return var_2.ScreenToWorldPoint(var_12_0, arg_12_1)
end

function var_0_4.setArrowPoint(arg_13_0)
	local var_13_0 = 1
	local var_13_1 = arg_13_0._uiCamera
	local var_13_2 = var_2.ScreenToWorldPoint(var_13_1, arg_13_0._cameraFixMgr.leftBottomVector)

	Vector3 = var_1_10003

	local var_13_3 = var_13_2 + var_1_10003(var_13_0, var_13_0, 0)
	local var_13_4 = arg_13_0._uiCamera
	local var_13_5 = var_3.ScreenToWorldPoint(var_13_4, arg_13_0._cameraFixMgr.rightTopVector)

	Vector3 = var_13_1
	arg_13_0._arrowCenterPos = (var_13_3 + (var_13_5 - var_13_1(var_13_0, var_13_0, 0))) * 0.5
	arg_13_0._arrowRightHorizon = var_3.x + 4
	arg_13_0._arrowTopHorizon = var_3.y + 4
	arg_13_0._arrowBottomHorizon = var_13_3.y - 4
	arg_13_0._arrowLeftHorizon = var_13_3.x - 3.75

	local var_13_6 = arg_13_0._uiCamera
	local var_13_7 = var_4.ScreenToWorldPoint(var_13_6, arg_13_0._cameraFixMgr.notchAdaptLBVector)

	Vector3 = var_13_4
	arg_13_0._arrowLeftBottomPos_notch = var_13_7 + var_13_4(var_13_0, var_13_0, 0)

	local var_13_8 = arg_13_0._uiCamera
	local var_13_9 = var_4.ScreenToWorldPoint(var_13_8, arg_13_0._cameraFixMgr.notchAdaptRTVector)

	Vector3 = var_5
	arg_13_0._arrowRightTopPos_notch = var_13_9 - var_5(var_13_0, var_13_0, 0)
	arg_13_0._arrowFieldHalfWidth_notch = arg_13_0._arrowRightTopPos_notch.x - arg_13_0._arrowCenterPos.x

	return
end

function var_0_4.Update(arg_14_0)
	local var_14_0 = arg_14_0:GetCameraPoint()

	if arg_14_0._cameraTF.position.x ~= var_14_0.x or var_2.z ~= var_14_0 then
		arg_14_0._cameraTF.position = var_14_0

		var_0_1.UpdateCameraPositionArgs()
	end

	if arg_14_0._shakeInfo and arg_14_0._shakeEnabled then
		arg_14_0:DoShake()
	end

	return
end

function var_0_4.StartShake(arg_15_0, arg_15_1)
	if arg_15_0._shakeInfo and (arg_15_0._shakeInfo._priority > arg_15_1.priority or arg_15_1.priority == 0) then
		return
	end

	arg_15_0._shakeInfo = {}
	arg_15_0._shakeInfo._elapsed = 0

	local var_15_0 = arg_15_0._shakeInfo
	local var_15_1

	if not arg_15_1.time then
		var_15_1 = 0
	end

	var_15_0._duration = var_15_1
	arg_15_0._shakeInfo._count = 0

	local var_15_2 = arg_15_0._shakeInfo
	local var_15_3

	if not arg_15_1.loop then
		var_15_3 = 1
	end

	var_15_2._loop = var_15_3
	arg_15_0._shakeInfo._direction = 1

	local var_15_4 = arg_15_0._shakeInfo
	local var_15_5

	if not arg_15_1.vibration_H then
		var_15_5 = 0
	end

	var_15_4._vibrationH = var_15_5

	local var_15_6 = arg_15_0._shakeInfo
	local var_15_7

	if not arg_15_1.friction_const_H then
		var_15_7 = 0
	end

	var_15_6._fricConstH = var_15_7

	local var_15_8 = arg_15_0._shakeInfo
	local var_15_9

	if not arg_15_1.friction_coefficient_H then
		var_15_9 = 1
	end

	var_15_8._fricCoefH = var_15_9

	local var_15_10 = arg_15_0._shakeInfo
	local var_15_11

	if not arg_15_1.vibration_V then
		var_15_11 = 0
	end

	var_15_10._vibrationV = var_15_11

	local var_15_12 = arg_15_0._shakeInfo
	local var_15_13

	if not arg_15_1.friction_const_V then
		var_15_13 = 0
	end

	var_15_12._fricConstV = var_15_13

	local var_15_14 = arg_15_0._shakeInfo
	local var_15_15

	if not arg_15_1.friction_coefficient_V then
		var_15_15 = 1
	end

	var_15_14._fricCoefV = var_15_15

	local var_15_16 = arg_15_0._shakeInfo

	Vector3 = var_15_15
	var_15_16._diff = var_15_15.zero
	arg_15_0._shakeInfo._bounce = arg_15_1.bounce

	if arg_15_0._shakeInfo._bounce then
		arg_15_0._shakeInfo._duration = arg_15_0._shakeInfo._duration * 0.5
	end

	arg_15_0._shakeInfo._priority = arg_15_1.priority

	return
end

function var_0_4.StopShake(arg_16_0)
	arg_16_0._shakeInfo = nil

	return
end

function var_0_4.DoShake(arg_17_0)
	arg_17_0._shakeInfo._count = arg_17_0._shakeInfo._count + 1

	local var_17_0 = arg_17_0._shakeInfo
	local var_17_1 = arg_17_0._shakeInfo._elapsed

	Time = var_1_10003
	var_17_0._elapsed = var_17_1 + var_1_10003.deltaTime

	local var_17_2 = arg_17_0._shakeInfo._vibrationH

	math = var_2

	local var_17_3 = var_17_2 * (var_2.random() * 0.5 + 0.5) * arg_17_0._shakeInfo._count
	local var_17_4 = arg_17_0._shakeInfo._vibrationV

	math = var_3

	local var_17_5 = var_17_4 * (var_3.random() * 0.5 + 0.5) * arg_17_0._shakeInfo._count

	Vector3 = var_3

	local var_17_6 = var_3(var_17_3, var_17_5, 0)
	local var_17_7 = var_3.Mul(var_17_6, arg_17_0._shakeInfo._direction)

	LuaHelper = var_1_10004

	var_1_10004.UpdateTFLocalPos(arg_17_0._cameraTF, var_17_7 - arg_17_0._shakeInfo._diff)

	if arg_17_0._shakeInfo._count >= arg_17_0._shakeInfo._loop then
		arg_17_0._shakeInfo._vibrationH = arg_17_0._shakeInfo._vibrationH * arg_17_0._shakeInfo._fricCoefH + arg_17_0._shakeInfo._fricConstH
		arg_17_0._shakeInfo._vibrationV = arg_17_0._shakeInfo._vibrationV * arg_17_0._shakeInfo._fricCoefV + arg_17_0._shakeInfo._fricConstV
		arg_17_0._shakeInfo._direction = -arg_17_0._shakeInfo._direction
		arg_17_0._shakeInfo._count = 0
	end

	if arg_17_0._shakeInfo._elapsed > arg_17_0._shakeInfo._duration then
		if arg_17_0._shakeInfo._bounce then
			var_0_4.bounceReverse(arg_17_0._shakeInfo)

			arg_17_0._shakeInfo._elapsed = 0
			arg_17_0._shakeInfo._bounce = false
		else
			arg_17_0:StopShake()
		end
	else
		arg_17_0._shakeInfo._diff = var_17_7
	end

	return
end

function var_0_4.bounceReverse(arg_18_0)
	if arg_18_0._fricCoefH ~= 0 then
		arg_18_0._fricCoefH = 1 / arg_18_0._fricCoefH
	end

	if arg_18_0._fricCoefV ~= 0 then
		arg_18_0._fricCoefV = 1 / arg_18_0._fricCoefV
	end

	arg_18_0._fricConstH = arg_18_0._fricConstH * -1
	arg_18_0._fricConstV = arg_18_0._fricConstV * -1

	return
end

function var_0_4.PauseShake(arg_19_0)
	arg_19_0._shakeEnabled = false

	return
end

function var_0_4.ResumeShake(arg_20_0)
	arg_20_0._shakeEnabled = true

	return
end

function var_0_4.active(arg_21_0)
	UpdateBeat = var_1_10001

	var_1_10001:Add(arg_21_0.Update, arg_21_0)

	return
end

function var_0_4.Deactive(arg_22_0)
	UpdateBeat = var_1_10001

	var_1_10001:Remove(arg_22_0.Update, arg_22_0)

	return
end

function var_0_4.CutInPainting(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:DispatchEvent(var_0.Event.New(var_0_2.SHOW_PAINTING, {
		caster = arg_23_1,
		speed = arg_23_2
	}))

	return
end

function var_0_4.BulletTime(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = {
		key = arg_24_1,
		speed = arg_24_2,
		exemptUnit = arg_24_3
	}

	arg_24_0:DispatchEvent(var_0.Event.New(var_0_2.BULLET_TIME, var_24_0))

	local var_24_1 = var_0.Battle.BattleState.GetInstance()

	var_5.ScaleTimer(var_24_1, arg_24_2)

	if arg_24_0._uiMediator then
		local var_24_2 = 1 / (arg_24_2 or 1)
		local var_24_3 = arg_24_0._uiMediator

		var_7.ScaleUISpeed(var_24_3, var_24_2)

		local var_24_4 = arg_24_0._uiMediator

		if var_7.GetAppearFX(var_24_4) ~= nil then
			local var_24_5 = arg_24_0._uiMediator
			local var_24_6 = var_7.GetAppearFX(var_24_5)
			local var_24_7 = var_7.GetComponent

			typeof = var_10
			Animator = var_1_10012
			var_24_7(var_24_6, var_10(var_1_10012)).speed = var_24_2
		end
	end

	return
end

function var_0_4.ZoomCamara(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	arg_25_3 = arg_25_3 or 1.6
	arg_25_2 = arg_25_2 or var_0_3.CAMERA_SIZE

	if not arg_25_1 then
		CameraMgr = var_1_10005
		var_1_10007 = var_1_10005.instance
		arg_25_1 = var_1_10005.GetCameraOrthographicSize(var_1_10007, arg_25_0._camera)
	end

	LeanTween = var_1_10005

	local var_25_0 = var_1_10005.value

	go = var_1_10007

	local var_25_1 = var_25_0(var_1_10007(arg_25_0._camera), arg_25_1, arg_25_2, arg_25_3)
	local var_25_2 = var_5.setOnUpdate

	System = var_8

	local var_25_3 = var_25_2(var_25_1, var_8.Action_float(function(arg_26_0)
		CameraMgr = var_2_10001

		local var_26_0 = var_2_10001.instance

		var_1.SetCameraOrthographicSize(var_26_0, arg_25_0._camera, arg_26_0)

		return
	end))

	if arg_25_4 then
		local var_25_4 = var_25_3
		local var_25_5 = var_25_3.setEase

		LeanTweenType = var_9

		var_25_5(var_25_4, var_9.easeOutExpo)
	end

	return
end

function var_0_4.FocusCharacter(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	arg_27_0:StopShake()

	delay = var_6

	local var_27_0

	var_27_0 = var_6 or 0

	local var_27_1 = delay
	local var_27_2 = {
		unit = arg_27_1,
		duration = arg_27_2,
		extraBulletTime = arg_27_3,
		skill = arg_27_4 or false
	}

	LeanTween = var_7

	local var_27_3 = var_7.cancel

	go = var_1_10009

	var_27_3(var_1_10009(arg_27_0._camera))

	local var_27_4 = arg_27_0._cameraTF.position

	if arg_27_1 ~= nil then
		local var_27_5 = arg_27_0._focusCharacter

		var_8.SetUnit(var_27_5, arg_27_1)

		local var_27_6 = arg_27_0._focusCharacter
		local var_27_7 = var_8.GetCameraPos(var_27_6)

		if arg_27_5 == nil then
			arg_27_5 = true
		end

		local var_27_8 = arg_27_0._fromTo
		local var_27_9 = var_9.SetFromTo
		local var_27_10 = arg_27_0._camera
		local var_27_11 = var_27_4
		local var_27_12 = var_27_7
		local var_27_13 = arg_27_2

		delay = var_1_10016

		var_27_9(var_27_8, var_27_10, var_27_11, var_27_12, var_27_13, var_1_10016, arg_27_5)
		arg_27_0:SwitchCameraPos(var_0_4.TWEEN_TO_CHARACTER)
	else
		local var_27_14 = arg_27_0._boundFix
		local var_27_15 = var_8.GetCameraPos
		local var_27_16 = arg_27_0._followPilot
		local var_27_17 = var_27_15(var_27_14, var_11.GetCameraPos(var_27_16))

		local function var_27_18()
			local var_28_0 = arg_27_0

			var_0.SwitchCameraPos(var_28_0)

			return
		end

		if arg_27_5 == nil then
			arg_27_5 = false
		end

		local var_27_19 = arg_27_0._fromTo
		local var_27_20 = var_10.SetFromTo
		local var_27_21 = arg_27_0._camera
		local var_27_22 = var_27_4
		local var_27_23 = var_27_17
		local var_27_24 = arg_27_2

		delay = var_1_10017

		var_27_20(var_27_19, var_27_21, var_27_22, var_27_23, var_27_24, var_1_10017, arg_27_5, var_27_18)
		arg_27_0:SwitchCameraPos(var_0_4.TWEEN_TO_CHARACTER)
	end

	arg_27_0:DispatchEvent(var_0.Event.New(var_0_2.CAMERA_FOCUS, var_27_2))

	return
end

function var_0_4.ResetFocus(arg_29_0)
	local var_29_0 = arg_29_0

	arg_29_0.StopShake(var_29_0)

	LeanTween = var_1

	local var_29_1 = var_1.cancel

	go = var_29_0

	var_29_1(var_29_0(arg_29_0._camera))

	LeanTween = var_29_1

	local var_29_2 = var_29_1.cancel

	go = var_3

	var_29_2(var_3(arg_29_0._uiCamera))

	local var_29_3 = arg_29_0._boundFix
	local var_29_4 = var_1.GetCameraPos
	local var_29_5 = arg_29_0._followPilot
	local var_29_6 = var_29_4(var_29_3, var_4.GetCameraPos(var_29_5))

	LeanTween = var_1_10002

	local var_29_7 = var_1_10002.move

	go = var_4

	local var_29_8 = var_29_7(var_4(arg_29_0._camera), var_29_6, var_0_3.CAM_RESET_DURATION)
	local var_29_9 = var_2.setOnUpdate

	System = var_5

	var_29_9(var_29_8, var_5.Action_float(function(arg_30_0)
		var_0_1.UpdateCameraPositionArgs()

		return
	end))
	arg_29_0:DispatchEvent(var_0.Event.New(var_0_2.CAMERA_FOCUS_RESET, {}))

	return
end

function var_0_4.GetCharacterArrowBarPosition(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0._arrowLeftBottomPos_notch
	local var_31_1 = arg_31_0._arrowRightTopPos_notch
	local var_31_2 = arg_31_0._arrowCenterPos

	if arg_31_1.x >= arg_31_0._arrowLeftHorizon and arg_31_1.x < arg_31_0._arrowRightHorizon and arg_31_1.y >= arg_31_0._arrowBottomHorizon and arg_31_1.y <= arg_31_0._arrowTopHorizon then
		return nil
	else
		local var_31_3 = arg_31_1.y - var_31_2.y
		local var_31_4
		local var_31_5
		local var_31_6
		local var_31_7

		if arg_31_1.x > var_31_2.x then
			var_31_6 = var_31_1.x
			var_31_7 = arg_31_1.x - var_31_2.x
		else
			var_31_6 = var_31_0.x
			var_31_7 = var_31_2.x - arg_31_1.x
		end

		local var_31_8 = var_31_3 / var_31_7 * arg_31_0._arrowFieldHalfWidth_notch

		if var_31_1.y < var_31_8 then
			var_31_8 = var_31_1.y
			var_31_6 = var_31_7 / var_31_3 * (var_31_8 - var_31_2.y)
		elseif var_31_8 < var_31_0.y then
			var_31_8 = var_31_0.y
			var_31_6 = var_31_7 / var_31_3 * (var_31_8 - var_31_2.y)
		end

		if arg_31_2 then
			arg_31_2:Set(var_31_6, var_31_8, 10)

			return arg_31_2
		else
			Vector3 = var_11

			return var_11(var_31_6, var_31_8, 10)
		end
	end

	return
end

function var_0_4.GetCameraPoint(arg_32_0)
	return arg_32_0._currentCameraPos()
end

function var_0_4.GetArrowCenterPos(arg_33_0)
	return arg_33_0._arrowCenterPos
end

function var_0_4.GetCamera(arg_34_0)
	return arg_34_0._camera
end

function var_0_4.Add2Camera(arg_35_0, arg_35_1, arg_35_2)
	arg_35_2 = arg_35_2 or 0
	tf = var_1_10003

	local var_35_0 = var_1_10003(arg_35_1)

	arg_35_1.SetParent(var_35_0, arg_35_0._cameraTF)

	pg = var_3

	var_3.ViewUtils.SetSortingOrder(arg_35_1, arg_35_2)

	return arg_35_0._cameraTF.localScale
end

function var_0_4.PauseCameraTween(arg_36_0)
	LeanTween = var_1_10001

	local var_36_0 = var_1_10001.pause

	go = var_1_10003

	var_36_0(var_1_10003(arg_36_0._camera))

	LeanTween = var_36_0

	local var_36_1 = var_36_0.pause

	go = var_3

	var_36_1(var_3(arg_36_0._uiCamera))

	return
end

function var_0_4.ResumeCameraTween(arg_37_0)
	LeanTween = var_1_10001

	local var_37_0 = var_1_10001.resume

	go = var_1_10003

	var_37_0(var_1_10003(arg_37_0._camera))

	LeanTween = var_37_0

	local var_37_1 = var_37_0.resume

	go = var_3

	var_37_1(var_3(arg_37_0._uiCamera))

	return
end

return
