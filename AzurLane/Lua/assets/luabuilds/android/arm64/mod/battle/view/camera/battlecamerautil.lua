ys = ys or {}

local var_0_0 = ys.Battle.BattleVariable
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleConfig
local var_0_3 = singletonClass("BattleCameraUtil")

ys.Battle.BattleCameraUtil = var_0_3
var_0_3.__name = "BattleCameraUtil"
var_0_3.FOCUS_PILOT = "FOCUS_PILOT"
var_0_3.TWEEN_TO_CHARACTER = "TWEEN_TO_CHARACTER"
var_0_3.FOLLOW_GESTURE = "FOLLOW_GESTURE"

function var_0_3.Ctor(arg_1_0)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._camera = pg.UIMgr.GetInstance():GetMainCamera():GetComponent(typeof(Camera))
	arg_1_0._cameraTF = arg_1_0._camera.transform
	arg_1_0._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
	arg_1_0._cameraFixMgr = pg.CameraFixMgr.GetInstance()

	return
end

function var_0_3.ActiveMainCamera(arg_2_0)
	CameraMgr.instance:SetActiveMainCamera(arg_2_0)

	return
end

function var_0_3.Initialize(arg_3_0)
	arg_3_0._cameraTF.localPosition = var_0_2.CAMERA_INIT_POS

	CameraMgr.instance:SetCameraOrthographicSize(arg_3_0._camera, 20)
	var_0_0.UpdateCameraPositionArgs()
	arg_3_0:setArrowPoint()

	arg_3_0._boundFix = var_0.Battle.BattleCameraBoundFixDecorate.New()
	arg_3_0._followPilot = var_0.Battle.BattleCameraFollowPilot.New()
	arg_3_0._focusCharacter = var_0.Battle.BattleCameraFocusChar.New()
	arg_3_0._fromTo = var_0.Battle.BattleCameraTween.New()
	arg_3_0._gesture = var_0.Battle.BattleCameraFollowGesture.New()

	arg_3_0:active()
	arg_3_0:SwitchCameraPos()

	arg_3_0._shakeEnabled = true
	arg_3_0._uiMediator = var_0.Battle.BattleState.GetInstance():GetMediatorByName(var_0.Battle.BattleUIMediator.__name)

	return
end

function var_0_3.Clear(arg_4_0)
	arg_4_0.ActiveMainCamera(false)
	LeanTween.cancel(go(arg_4_0._camera))
	arg_4_0:Deactive()
	arg_4_0:StopShake()
	arg_4_0._boundFix:Dispose()
	arg_4_0._followPilot:Dispose()
	arg_4_0._focusCharacter:Dispose()
	arg_4_0._fromTo:Dispose()
	arg_4_0._gesture:Dispose()

	arg_4_0._cameraTF.localPosition = Vector3(0, 62, -10)

	CameraMgr.instance:SetCameraOrthographicSize(arg_4_0._camera, 20)

	arg_4_0._uiMediator = nil

	return
end

function var_0_3.SetMapData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0, var_5_1, var_5_2, var_5_3 = arg_5_0._boundFix:SetMapData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)

	arg_5_0._followPilot:SetGoldenRation(arg_5_0._camera:ScreenToWorldPoint(Vector3(pg.CameraFixMgr.GetInstance().actualWidth * var_0_2.CAMERA_GOLDEN_RATE, 0, 0)).x - arg_5_0._cameraTF.position.x)

	return var_5_0, var_5_1, var_5_2, var_5_3
end

function var_0_3.SetFocusFleet(arg_6_0, arg_6_1)
	arg_6_0._followPilot:SetFleetVO(arg_6_1)

	arg_6_0._cameraTF.position = arg_6_0._boundFix:GetCameraPos(arg_6_0._followPilot:GetCameraPos())

	var_0_0.UpdateCameraPositionArgs()

	return
end

function var_0_3.SetCameraSilder(arg_7_0, arg_7_1)
	arg_7_0._gesture:SetGestureComponent(arg_7_1)

	return
end

function var_0_3.SwitchCameraPos(arg_8_0, arg_8_1)
	arg_8_0._currentCameraPos = arg_8_1 == "TWEEN_TO_CHARACTER" and function()
		return arg_8_0._fromTo:GetCameraPos()
	end or arg_8_1 == "FOLLOW_GESTURE" and function()
		return arg_8_0._boundFix:GetCameraPos(arg_8_0._gesture:GetCameraPos(arg_8_0._cameraTF.position))
	end or function()
		return arg_8_0._boundFix:GetCameraPos(arg_8_0._followPilot:GetCameraPos())
	end

	return
end

function var_0_3.GetS2WPoint(arg_12_0, arg_12_1)
	return arg_12_0._camera:ScreenToWorldPoint(arg_12_1)
end

function var_0_3.setArrowPoint(arg_13_0)
	local var_13_0 = arg_13_0._uiCamera:ScreenToWorldPoint(arg_13_0._cameraFixMgr.leftBottomVector) + Vector3(1, 1, 0)
	local var_13_1 = arg_13_0._uiCamera:ScreenToWorldPoint(arg_13_0._cameraFixMgr.rightTopVector) - Vector3(1, 1, 0)

	arg_13_0._arrowCenterPos = (var_13_0 + var_13_1) * 0.5
	arg_13_0._arrowRightHorizon = var_13_1.x + 4
	arg_13_0._arrowTopHorizon = var_13_1.y + 4
	arg_13_0._arrowBottomHorizon = var_13_0.y - 4
	arg_13_0._arrowLeftHorizon = var_13_0.x - 3.75
	arg_13_0._arrowLeftBottomPos_notch = arg_13_0._uiCamera:ScreenToWorldPoint(arg_13_0._cameraFixMgr.notchAdaptLBVector) + Vector3(1, 1, 0)
	arg_13_0._arrowRightTopPos_notch = arg_13_0._uiCamera:ScreenToWorldPoint(arg_13_0._cameraFixMgr.notchAdaptRTVector) - Vector3(1, 1, 0)
	arg_13_0._arrowFieldHalfWidth_notch = arg_13_0._arrowRightTopPos_notch.x - arg_13_0._arrowCenterPos.x

	return
end

function var_0_3.Update(arg_14_0)
	local var_14_0 = arg_14_0:GetCameraPoint()

	if arg_14_0._cameraTF.position.x ~= var_14_0.x or arg_14_0._cameraTF.position.z ~= var_14_0 then
		arg_14_0._cameraTF.position = var_14_0

		var_0_0.UpdateCameraPositionArgs()
	end

	if arg_14_0._shakeInfo and arg_14_0._shakeEnabled then
		arg_14_0:DoShake()
	end

	return
end

function var_0_3.StartShake(arg_15_0, arg_15_1)
	if arg_15_0._shakeInfo and (arg_15_0._shakeInfo._priority > arg_15_1.priority or arg_15_1.priority == 0) then
		return
	end

	arg_15_0._shakeInfo = {}
	arg_15_0._shakeInfo._elapsed = 0
	arg_15_0._shakeInfo._duration = arg_15_1.time or 0
	arg_15_0._shakeInfo._count = 0
	arg_15_0._shakeInfo._loop = arg_15_1.loop or 1
	arg_15_0._shakeInfo._direction = 1
	arg_15_0._shakeInfo._vibrationH = arg_15_1.vibration_H or 0
	arg_15_0._shakeInfo._fricConstH = arg_15_1.friction_const_H or 0
	arg_15_0._shakeInfo._fricCoefH = arg_15_1.friction_coefficient_H or 1
	arg_15_0._shakeInfo._vibrationV = arg_15_1.vibration_V or 0
	arg_15_0._shakeInfo._fricConstV = arg_15_1.friction_const_V or 0
	arg_15_0._shakeInfo._fricCoefV = arg_15_1.friction_coefficient_V or 1
	arg_15_0._shakeInfo._diff = Vector3.zero
	arg_15_0._shakeInfo._bounce = arg_15_1.bounce

	if arg_15_0._shakeInfo._bounce then
		arg_15_0._shakeInfo._duration = arg_15_0._shakeInfo._duration * 0.5
	end

	arg_15_0._shakeInfo._priority = arg_15_1.priority

	return
end

function var_0_3.StopShake(arg_16_0)
	arg_16_0._shakeInfo = nil

	return
end

function var_0_3.DoShake(arg_17_0)
	arg_17_0._shakeInfo._count = arg_17_0._shakeInfo._count + 1
	arg_17_0._shakeInfo._elapsed = arg_17_0._shakeInfo._elapsed + Time.deltaTime

	local var_17_0 = Vector3(arg_17_0._shakeInfo._vibrationH * (math.random() * 0.5 + 0.5) * arg_17_0._shakeInfo._count, arg_17_0._shakeInfo._vibrationV * (math.random() * 0.5 + 0.5) * arg_17_0._shakeInfo._count, 0):Mul(arg_17_0._shakeInfo._direction)

	LuaHelper.UpdateTFLocalPos(arg_17_0._cameraTF, var_17_0 - arg_17_0._shakeInfo._diff)

	if arg_17_0._shakeInfo._count >= arg_17_0._shakeInfo._loop then
		arg_17_0._shakeInfo._vibrationH = arg_17_0._shakeInfo._vibrationH * arg_17_0._shakeInfo._fricCoefH + arg_17_0._shakeInfo._fricConstH
		arg_17_0._shakeInfo._vibrationV = arg_17_0._shakeInfo._vibrationV * arg_17_0._shakeInfo._fricCoefV + arg_17_0._shakeInfo._fricConstV
		arg_17_0._shakeInfo._direction = -arg_17_0._shakeInfo._direction
		arg_17_0._shakeInfo._count = 0
	end

	if arg_17_0._shakeInfo._elapsed > arg_17_0._shakeInfo._duration then
		if arg_17_0._shakeInfo._bounce then
			var_0_3.bounceReverse(arg_17_0._shakeInfo)

			arg_17_0._shakeInfo._elapsed = 0
			arg_17_0._shakeInfo._bounce = false
		else
			arg_17_0:StopShake()
		end
	else
		arg_17_0._shakeInfo._diff = var_17_0
	end

	return
end

function var_0_3.bounceReverse(arg_18_0)
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

function var_0_3.PauseShake(arg_19_0)
	arg_19_0._shakeEnabled = false

	return
end

function var_0_3.ResumeShake(arg_20_0)
	arg_20_0._shakeEnabled = true

	return
end

function var_0_3.active(arg_21_0)
	UpdateBeat:Add(arg_21_0.Update, arg_21_0)

	return
end

function var_0_3.Deactive(arg_22_0)
	UpdateBeat:Remove(arg_22_0.Update, arg_22_0)

	return
end

function var_0_3.CutInPainting(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:DispatchEvent(var_0.Event.New(var_0_1.SHOW_PAINTING, {
		caster = arg_23_1,
		speed = arg_23_2
	}))

	return
end

function var_0_3.BulletTime(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0:DispatchEvent(var_0.Event.New(var_0_1.BULLET_TIME, {
		key = arg_24_1,
		speed = arg_24_2,
		exemptUnit = arg_24_3
	}))
	var_0.Battle.BattleState.GetInstance():ScaleTimer(arg_24_2)

	if arg_24_0._uiMediator then
		arg_24_0._uiMediator:ScaleUISpeed(1 / (arg_24_2 or 1))

		if arg_24_0._uiMediator:GetAppearFX() ~= nil then
			arg_24_0._uiMediator:GetAppearFX():GetComponent(typeof(Animator)).speed = 1 / (arg_24_2 or 1)
		end
	end

	return
end

function var_0_3.ZoomCamara(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	arg_25_3 = arg_25_3 or 1.6
	arg_25_2 = arg_25_2 or var_0_2.CAMERA_SIZE
	arg_25_1 = arg_25_1 or CameraMgr.instance:GetCameraOrthographicSize(arg_25_0._camera)

	local var_25_0 = LeanTween.value(go(arg_25_0._camera), arg_25_1, arg_25_2, arg_25_3):setOnUpdate(System.Action_float(function(arg_26_0)
		CameraMgr.instance:SetCameraOrthographicSize(arg_25_0._camera, arg_26_0)

		return
	end))

	if arg_25_4 then
		var_25_0:setEase(LeanTweenType.easeOutExpo)
	end

	return
end

function var_0_3.FocusCharacter(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	arg_27_0:StopShake()

	delay = delay or 0

	LeanTween.cancel(go(arg_27_0._camera))

	if arg_27_1 ~= nil then
		arg_27_0._focusCharacter:SetUnit(arg_27_1)

		if arg_27_5 == nil then
			arg_27_5 = true
		end

		arg_27_0._fromTo:SetFromTo(arg_27_0._camera, arg_27_0._cameraTF.position, arg_27_0._focusCharacter:GetCameraPos(), arg_27_2, delay, arg_27_5)
		arg_27_0:SwitchCameraPos(var_0_3.TWEEN_TO_CHARACTER)
	else
		local var_27_1 = arg_27_0._boundFix:GetCameraPos(arg_27_0._followPilot:GetCameraPos())

		if arg_27_5 == nil then
			arg_27_5 = false
		end

		arg_27_0._fromTo:SetFromTo(arg_27_0._camera, arg_27_0._cameraTF.position, var_27_1, arg_27_2, delay, arg_27_5, function()
			arg_27_0:SwitchCameraPos()

			return
		end)
		arg_27_0:SwitchCameraPos(var_0_3.TWEEN_TO_CHARACTER)
	end

	arg_27_0:DispatchEvent(var_0.Event.New(var_0_1.CAMERA_FOCUS, var_27_0))

	return
end

function var_0_3.ResetFocus(arg_29_0)
	arg_29_0:StopShake()
	LeanTween.cancel(go(arg_29_0._camera))
	LeanTween.cancel(go(arg_29_0._uiCamera))
	LeanTween.move(go(arg_29_0._camera), arg_29_0._boundFix:GetCameraPos(arg_29_0._followPilot:GetCameraPos()), var_0_2.CAM_RESET_DURATION):setOnUpdate(System.Action_float(function(arg_30_0)
		var_0_0.UpdateCameraPositionArgs()

		return
	end))
	arg_29_0:DispatchEvent(var_0.Event.New(var_0_1.CAMERA_FOCUS_RESET, {}))

	return
end

function var_0_3.GetCharacterArrowBarPosition(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0._arrowRightTopPos_notch
	local var_31_1 = arg_31_0._arrowCenterPos

	if arg_31_1.x >= arg_31_0._arrowLeftHorizon and arg_31_1.x < arg_31_0._arrowRightHorizon and arg_31_1.y >= arg_31_0._arrowBottomHorizon and arg_31_1.y <= arg_31_0._arrowTopHorizon then
		return nil
	else
		local var_31_2 = arg_31_1.y - var_31_1.y
		local var_31_5
		local var_31_6

		if arg_31_1.x > var_31_1.x then
			var_31_5 = var_31_0.x
			var_31_6 = arg_31_1.x - var_31_1.x
		else
			var_31_5 = arg_31_0._arrowLeftBottomPos_notch.x
			var_31_6 = var_31_1.x - arg_31_1.x
		end

		local var_31_7 = var_31_2 / var_31_6 * arg_31_0._arrowFieldHalfWidth_notch

		if var_31_2 / var_31_6 * arg_31_0._arrowFieldHalfWidth_notch > var_31_0.y then
			var_31_7 = var_31_0.y
			var_31_5 = var_31_6 / var_31_2 * (var_31_0.y - var_31_1.y)
		elseif var_31_7 < arg_31_0._arrowLeftBottomPos_notch.y then
			var_31_7 = arg_31_0._arrowLeftBottomPos_notch.y
			var_31_5 = var_31_6 / var_31_2 * (arg_31_0._arrowLeftBottomPos_notch.y - var_31_1.y)
		end

		if arg_31_2 then
			arg_31_2:Set(var_31_5, var_31_7, 10)

			return arg_31_2
		else
			return Vector3(var_31_5, var_31_7, 10)
		end
	end

	return
end

function var_0_3.GetCameraPoint(arg_32_0)
	return arg_32_0._currentCameraPos()
end

function var_0_3.GetArrowCenterPos(arg_33_0)
	return arg_33_0._arrowCenterPos
end

function var_0_3.GetCamera(arg_34_0)
	return arg_34_0._camera
end

function var_0_3.Add2Camera(arg_35_0, arg_35_1, arg_35_2)
	arg_35_2 = arg_35_2 or 0
	arg_35_1 = tf(arg_35_1)

	arg_35_1:SetParent(arg_35_0._cameraTF)
	pg.ViewUtils.SetSortingOrder(arg_35_1, arg_35_2)

	return arg_35_0._cameraTF.localScale
end

function var_0_3.PauseCameraTween(arg_36_0)
	LeanTween.pause(go(arg_36_0._camera))
	LeanTween.pause(go(arg_36_0._uiCamera))

	return
end

function var_0_3.ResumeCameraTween(arg_37_0)
	LeanTween.resume(go(arg_37_0._camera))
	LeanTween.resume(go(arg_37_0._uiCamera))

	return
end

return
