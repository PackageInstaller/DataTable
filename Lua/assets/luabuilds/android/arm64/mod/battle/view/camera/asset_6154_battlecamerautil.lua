ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleVariable
local var_0_2 = ys.Battle.BattleEvent
local var_0_3 = ys.Battle.BattleConfig
local var_0_4 = singletonClass("BattleCameraUtil")

ys.Battle.BattleCameraUtil = var_0_4
var_0_4.__name = "BattleCameraUtil"
var_0_4.FOCUS_PILOT = "FOCUS_PILOT"
var_0_4.TWEEN_TO_CHARACTER = "TWEEN_TO_CHARACTER"
var_0_4.FOLLOW_GESTURE = "FOLLOW_GESTURE"

function var_0_4:Ctor()
	var_0_0.EventDispatcher.AttachEventDispatcher(self)

	self._camera = pg.UIMgr.GetInstance():GetMainCamera():GetComponent(typeof(Camera))
	self._cameraTF = self._camera.transform
	self._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
	self._cameraFixMgr = pg.CameraFixMgr.GetInstance()

	return
end

function var_0_4.ActiveMainCamera(arg_2_0)
	CameraMgr.instance:SetActiveMainCamera(arg_2_0)

	return
end

function var_0_4:Initialize()
	self._cameraTF.localPosition = var_0_3.CAMERA_INIT_POS

	CameraMgr.instance:SetCameraOrthographicSize(self._camera, 20)
	var_0_1.UpdateCameraPositionArgs()
	self:setArrowPoint()

	self._boundFix = var_0_0.Battle.BattleCameraBoundFixDecorate.New()
	self._followPilot = var_0_0.Battle.BattleCameraFollowPilot.New()
	self._focusCharacter = var_0_0.Battle.BattleCameraFocusChar.New()
	self._fromTo = var_0_0.Battle.BattleCameraTween.New()
	self._gesture = var_0_0.Battle.BattleCameraFollowGesture.New()

	self:active()
	self:SwitchCameraPos()

	self._shakeEnabled = true
	self._uiMediator = var_0_0.Battle.BattleState.GetInstance():GetMediatorByName(var_0_0.Battle.BattleUIMediator.__name)

	return
end

function var_0_4:Clear()
	self.ActiveMainCamera(false)
	LeanTween.cancel(go(self._camera))
	self:Deactive()
	self:StopShake()
	self._boundFix:Dispose()
	self._followPilot:Dispose()
	self._focusCharacter:Dispose()
	self._fromTo:Dispose()
	self._gesture:Dispose()

	self._cameraTF.localPosition = Vector3(0, 62, -10)

	CameraMgr.instance:SetCameraOrthographicSize(self._camera, 20)

	self._uiMediator = nil

	return
end

function var_0_4:SetMapData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0, var_5_1, var_5_2, var_5_3 = self._boundFix:SetMapData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)

	self._followPilot:SetGoldenRation(self._camera:ScreenToWorldPoint(Vector3(pg.CameraFixMgr.GetInstance().actualWidth * var_0_3.CAMERA_GOLDEN_RATE, 0, 0)).x - self._cameraTF.position.x)

	return var_5_0, var_5_1, var_5_2, var_5_3
end

function var_0_4:SetFocusFleet(arg_6_1)
	self._followPilot:SetFleetVO(arg_6_1)

	self._cameraTF.position = self._boundFix:GetCameraPos(self._followPilot:GetCameraPos())

	var_0_1.UpdateCameraPositionArgs()

	return
end

function var_0_4:SetCameraSilder(arg_7_1)
	self._gesture:SetGestureComponent(arg_7_1)

	return
end

function var_0_4.SwitchCameraPos(arg_8_0, arg_8_1)
	arg_8_0._currentCameraPos = arg_8_1 == "TWEEN_TO_CHARACTER" and function()
		return arg_8_0._fromTo:GetCameraPos()
	end or arg_8_1 == "FOLLOW_GESTURE" and function()
		return arg_8_0._boundFix:GetCameraPos(arg_8_0._gesture:GetCameraPos(arg_8_0._cameraTF.position))
	end or function()
		return arg_8_0._boundFix:GetCameraPos(arg_8_0._followPilot:GetCameraPos())
	end

	return
end

function var_0_4:GetS2WPoint(arg_12_1)
	return self._camera:ScreenToWorldPoint(arg_12_1)
end

function var_0_4:setArrowPoint()
	local var_13_0 = self._uiCamera:ScreenToWorldPoint(self._cameraFixMgr.leftBottomVector) + Vector3(1, 1, 0)
	local var_13_1 = self._uiCamera:ScreenToWorldPoint(self._cameraFixMgr.rightTopVector) - Vector3(1, 1, 0)

	self._arrowCenterPos = (var_13_0 + var_13_1) * 0.5
	self._arrowRightHorizon = var_13_1.x + 4
	self._arrowTopHorizon = var_13_1.y + 4
	self._arrowBottomHorizon = var_13_0.y - 4
	self._arrowLeftHorizon = var_13_0.x - 3.75
	self._arrowLeftBottomPos_notch = self._uiCamera:ScreenToWorldPoint(self._cameraFixMgr.notchAdaptLBVector) + Vector3(1, 1, 0)
	self._arrowRightTopPos_notch = self._uiCamera:ScreenToWorldPoint(self._cameraFixMgr.notchAdaptRTVector) - Vector3(1, 1, 0)
	self._arrowFieldHalfWidth_notch = self._arrowRightTopPos_notch.x - self._arrowCenterPos.x

	return
end

function var_0_4:Update()
	local var_14_0 = self:GetCameraPoint()

	if self._cameraTF.position.x ~= var_14_0.x or self._cameraTF.position.z ~= var_14_0 then
		self._cameraTF.position = var_14_0

		var_0_1.UpdateCameraPositionArgs()
	end

	if self._shakeInfo and self._shakeEnabled then
		self:DoShake()
	end

	return
end

function var_0_4:StartShake(arg_15_1)
	if self._shakeInfo and (self._shakeInfo._priority > arg_15_1.priority or arg_15_1.priority == 0) then
		return
	end

	self._shakeInfo = {}
	self._shakeInfo._elapsed = 0
	self._shakeInfo._duration = arg_15_1.time or 0
	self._shakeInfo._count = 0
	self._shakeInfo._loop = arg_15_1.loop or 1
	self._shakeInfo._direction = 1
	self._shakeInfo._vibrationH = arg_15_1.vibration_H or 0
	self._shakeInfo._fricConstH = arg_15_1.friction_const_H or 0
	self._shakeInfo._fricCoefH = arg_15_1.friction_coefficient_H or 1
	self._shakeInfo._vibrationV = arg_15_1.vibration_V or 0
	self._shakeInfo._fricConstV = arg_15_1.friction_const_V or 0
	self._shakeInfo._fricCoefV = arg_15_1.friction_coefficient_V or 1
	self._shakeInfo._diff = Vector3.zero
	self._shakeInfo._bounce = arg_15_1.bounce

	if self._shakeInfo._bounce then
		self._shakeInfo._duration = self._shakeInfo._duration * 0.5
	end

	self._shakeInfo._priority = arg_15_1.priority

	return
end

function var_0_4.StopShake(arg_16_0)
	arg_16_0._shakeInfo = nil

	return
end

function var_0_4:DoShake()
	self._shakeInfo._count = self._shakeInfo._count + 1
	self._shakeInfo._elapsed = self._shakeInfo._elapsed + Time.deltaTime

	local var_17_0 = Vector3(self._shakeInfo._vibrationH * (math.random() * 0.5 + 0.5) * self._shakeInfo._count, self._shakeInfo._vibrationV * (math.random() * 0.5 + 0.5) * self._shakeInfo._count, 0):Mul(self._shakeInfo._direction)

	LuaHelper.UpdateTFLocalPos(self._cameraTF, var_17_0 - self._shakeInfo._diff)

	if self._shakeInfo._count >= self._shakeInfo._loop then
		self._shakeInfo._vibrationH = self._shakeInfo._vibrationH * self._shakeInfo._fricCoefH + self._shakeInfo._fricConstH
		self._shakeInfo._vibrationV = self._shakeInfo._vibrationV * self._shakeInfo._fricCoefV + self._shakeInfo._fricConstV
		self._shakeInfo._direction = -self._shakeInfo._direction
		self._shakeInfo._count = 0
	end

	if self._shakeInfo._elapsed > self._shakeInfo._duration then
		if self._shakeInfo._bounce then
			var_0_4.bounceReverse(self._shakeInfo)

			self._shakeInfo._elapsed = 0
			self._shakeInfo._bounce = false
		else
			self:StopShake()
		end
	else
		self._shakeInfo._diff = var_17_0
	end

	return
end

function var_0_4:bounceReverse()
	if self._fricCoefH ~= 0 then
		self._fricCoefH = 1 / self._fricCoefH
	end

	if self._fricCoefV ~= 0 then
		self._fricCoefV = 1 / self._fricCoefV
	end

	self._fricConstH = self._fricConstH * -1
	self._fricConstV = self._fricConstV * -1

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

function var_0_4:active()
	UpdateBeat:Add(self.Update, self)

	return
end

function var_0_4:Deactive()
	UpdateBeat:Remove(self.Update, self)

	return
end

function var_0_4:CutInPainting(arg_23_1, arg_23_2)
	self:DispatchEvent(var_0_0.Event.New(var_0_2.SHOW_PAINTING, {
		caster = arg_23_1,
		speed = arg_23_2
	}))

	return
end

function var_0_4:BulletTime(arg_24_1, arg_24_2, arg_24_3)
	self:DispatchEvent(var_0_0.Event.New(var_0_2.BULLET_TIME, {
		key = arg_24_1,
		speed = arg_24_2,
		exemptUnit = arg_24_3
	}))
	var_0_0.Battle.BattleState.GetInstance():ScaleTimer(arg_24_2)

	if self._uiMediator then
		self._uiMediator:ScaleUISpeed(1 / (arg_24_2 or 1))

		if self._uiMediator:GetAppearFX() ~= nil then
			self._uiMediator:GetAppearFX():GetComponent(typeof(Animator)).speed = 1 / (arg_24_2 or 1)
		end
	end

	return
end

function var_0_4:ZoomCamara(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	arg_25_3 = arg_25_3 or 1.6
	arg_25_2 = arg_25_2 or var_0_3.CAMERA_SIZE
	arg_25_1 = arg_25_1 or CameraMgr.instance:GetCameraOrthographicSize(self._camera)

	if arg_25_4 then
		LeanTween.value(go(self._camera), arg_25_1, arg_25_2, arg_25_3):setOnUpdate(System.Action_float(function(arg_26_0)
			CameraMgr.instance:SetCameraOrthographicSize(self._camera, arg_26_0)

			return
		end)):setEase(LeanTweenType.easeOutExpo)
	end

	return
end

function var_0_4:FocusCharacter(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	self:StopShake()

	delay = delay or 0

	local var_27_0 = {
		unit = arg_27_1,
		duration = arg_27_2,
		extraBulletTime = arg_27_3,
		skill = arg_27_4 or false
	}

	LeanTween.cancel(go(self._camera))

	if arg_27_1 ~= nil then
		self._focusCharacter:SetUnit(arg_27_1)

		if arg_27_5 == nil then
			arg_27_5 = true
		end

		self._fromTo:SetFromTo(self._camera, self._cameraTF.position, self._focusCharacter:GetCameraPos(), arg_27_2, delay, arg_27_5)
		self:SwitchCameraPos(var_0_4.TWEEN_TO_CHARACTER)
	else
		if arg_27_5 == nil then
			arg_27_5 = false
		end

		self._fromTo:SetFromTo(self._camera, self._cameraTF.position, self._boundFix:GetCameraPos(self._followPilot:GetCameraPos()), arg_27_2, delay, arg_27_5, function()
			self:SwitchCameraPos()

			return
		end)
		self:SwitchCameraPos(var_0_4.TWEEN_TO_CHARACTER)
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_2.CAMERA_FOCUS, var_27_0))

	return
end

function var_0_4:ResetFocus()
	self:StopShake()
	LeanTween.cancel(go(self._camera))
	LeanTween.cancel(go(self._uiCamera))
	LeanTween.move(go(self._camera), self._boundFix:GetCameraPos(self._followPilot:GetCameraPos()), var_0_3.CAM_RESET_DURATION):setOnUpdate(System.Action_float(function(arg_30_0)
		var_0_1.UpdateCameraPositionArgs()

		return
	end))
	self:DispatchEvent(var_0_0.Event.New(var_0_2.CAMERA_FOCUS_RESET, {}))

	return
end

function var_0_4:GetCharacterArrowBarPosition(arg_31_1, arg_31_2)
	local var_31_0 = self._arrowRightTopPos_notch
	local var_31_1 = self._arrowCenterPos

	if arg_31_1.x >= self._arrowLeftHorizon and arg_31_1.x < self._arrowRightHorizon and arg_31_1.y >= self._arrowBottomHorizon and arg_31_1.y <= self._arrowTopHorizon then
		return nil
	else
		local var_31_2 = arg_31_1.y - var_31_1.y
		local var_31_5
		local var_31_6

		if arg_31_1.x > var_31_1.x then
			var_31_5 = var_31_0.x
			var_31_6 = arg_31_1.x - var_31_1.x
		else
			var_31_5 = self._arrowLeftBottomPos_notch.x
			var_31_6 = var_31_1.x - arg_31_1.x
		end

		local var_31_7 = var_31_2 / var_31_6 * self._arrowFieldHalfWidth_notch

		if var_31_2 / var_31_6 * self._arrowFieldHalfWidth_notch > var_31_0.y then
			var_31_7 = var_31_0.y
			var_31_5 = var_31_6 / var_31_2 * (var_31_0.y - var_31_1.y)
		elseif var_31_7 < self._arrowLeftBottomPos_notch.y then
			var_31_7 = self._arrowLeftBottomPos_notch.y
			var_31_5 = var_31_6 / var_31_2 * (self._arrowLeftBottomPos_notch.y - var_31_1.y)
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

function var_0_4:GetCameraPoint()
	return self._currentCameraPos()
end

function var_0_4:GetArrowCenterPos()
	return self._arrowCenterPos
end

function var_0_4:GetCamera()
	return self._camera
end

function var_0_4:Add2Camera(arg_35_1, arg_35_2)
	arg_35_2 = arg_35_2 or 0
	arg_35_1 = tf(arg_35_1)

	arg_35_1:SetParent(self._cameraTF)
	pg.ViewUtils.SetSortingOrder(arg_35_1, arg_35_2)

	return self._cameraTF.localScale
end

function var_0_4:PauseCameraTween()
	LeanTween.pause(go(self._camera))
	LeanTween.pause(go(self._uiCamera))

	return
end

function var_0_4:ResumeCameraTween()
	LeanTween.resume(go(self._camera))
	LeanTween.resume(go(self._uiCamera))

	return
end

return
