pg = pg or {}
pg.CameraFixMgr = singletonClass("CameraFixMgr", import("view.base.BaseEventLogic"))

local var_0_0 = pg.CameraFixMgr

pg.CameraFixMgr.ASPECT_RATIO_UPDATE = "aspect_ratio_update"

function pg.CameraFixMgr:Init(arg_1_1)
	self.targetRatio = 1.7777777777777777

	self:AddListener()
	self:Adapt()
	arg_1_1()

	return
end

function pg.CameraFixMgr:AddListener()
	self:Clear()

	function self.adaptCall(arg_3_0)
		self:AfterCall(arg_3_0)

		return
	end

	CameraMgr.instance:AddListener(self.adaptCall)

	return
end

function pg.CameraFixMgr.Adapt(arg_4_0)
	CameraMgr.instance:Adapt()

	return
end

function pg.CameraFixMgr:AfterCall(arg_5_1)
	self.targetRatio = arg_5_1
	self.currentWidth = Screen.width
	self.currentHeight = Screen.height

	local var_5_0 = self.currentWidth / self.currentHeight

	if self.currentWidth / self.currentHeight < self.targetRatio then
		self.actualWidth = self.currentWidth
		self.actualHeight = self.currentWidth / self.targetRatio
		self.leftBottomVector = Vector3(0, (self.currentHeight - self.actualHeight) * 0.5, 0)
		self.rightTopVector = Vector3(self.currentWidth, self.currentHeight - (self.currentHeight - self.actualHeight) * 0.5, 0)
	else
		self.actualWidth = self.currentHeight * self.targetRatio
		self.actualHeight = self.currentHeight
		self.leftBottomVector = Vector3((self.currentWidth - self.actualWidth) * 0.5, 0, 0)
		self.rightTopVector = Vector3(self.currentWidth - (self.currentWidth - self.actualWidth) * 0.5, self.currentHeight, 0)
	end

	local var_5_1 = NotchAdapt.CheckNotchRatio

	if var_5_0 > ADAPT_NOTICE and var_5_1 < self.targetRatio then
		self.notchAdaptWidth = self.currentHeight * var_5_1
		self.notchAdaptHeight = self.currentHeight
		self.notchAdaptLBVector = Vector3((self.currentWidth - self.notchAdaptWidth) * 0.5, 0, 0)
		self.notchAdaptRTVector = Vector3(self.currentWidth - (self.currentWidth - self.notchAdaptWidth) * 0.5, self.currentHeight, 0)
	else
		self.notchAdaptWidth = self.actualWidth
		self.notchAdaptHeight = self.actualHeight
		self.notchAdaptLBVector = self.leftBottomVector
		self.notchAdaptRTVector = self.rightTopVector
	end

	self:FixOverlayPadding(var_5_0)
	self:emit(var_0_0.ASPECT_RATIO_UPDATE, self.targetRatio)

	return
end

function pg.CameraFixMgr:GetBattleUIRatio()
	return self.targetRatio
end

function pg.CameraFixMgr:GetCurrentWidth()
	return self.currentWidth
end

function pg.CameraFixMgr:GetCurrentHeight()
	return self.currentHeight
end

function pg.CameraFixMgr.SetForceRatio(arg_9_0, arg_9_1)
	if not arg_9_1 then
		CameraMgr.instance:SetForceRatio(-1)
	else
		CameraMgr.instance:SetForceRatio(arg_9_1)
	end

	return
end

function pg.CameraFixMgr:BlockCameraRatioControll(arg_10_1)
	if arg_10_1 then
		local var_10_0 = System.Array.CreateInstance(typeof("System.Single"), 2)

		var_10_0[0] = 0
		var_10_0[1] = 100

		ReflectionHelp.RefSetField(CameraMgr.instance:GetType(), "AspectRatioRange", CameraMgr.instance, var_10_0)
	else
		local var_10_1 = System.Array.CreateInstance(typeof("System.Single"), 2)

		var_10_1[0] = 1.3333333333333333
		var_10_1[1] = 2.3333333333333335

		ReflectionHelp.RefSetField(CameraMgr.instance:GetType(), "AspectRatioRange", CameraMgr.instance, var_10_1)
	end

	self:Adapt()

	return
end

function pg.CameraFixMgr:Clear()
	if self.adaptCall then
		CameraMgr.instance:RemoveListener(self.adaptCall)

		self.adaptCall = nil
	end

	return
end

function pg.CameraFixMgr:Dispose()
	self:Clear()

	return
end

local var_0_1 = 1920
local var_0_2 = 1080

local function var_0_3(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0 and not IsNil(arg_13_0)
	local var_13_1 = var_0_1
	local var_13_2 = var_0_2

	if var_13_0 then
		var_13_1 = arg_13_0.referenceResolution.x
		var_13_2 = arg_13_0.referenceResolution.y
	end

	if var_13_1 <= 0 or var_13_2 <= 0 then
		var_13_1 = var_0_1
		var_13_2 = var_0_2
	end

	local var_13_3 = arg_13_1 / var_13_1

	if var_13_0 and arg_13_0.screenMatchMode == CanvasScaler.ScreenMatchMode.MatchWidthOrHeight then
		local var_13_4 = math.log(var_13_3) / math.log(2)

		return math.pow(2, var_13_4 + (math.log(arg_13_2 / var_13_2) / math.log(2) - var_13_4) * arg_13_0.matchWidthOrHeight)
	elseif var_13_0 and arg_13_0.screenMatchMode == CanvasScaler.ScreenMatchMode.Shrink then
		return math.max(var_13_3, arg_13_2 / var_13_2)
	else
		return math.min(var_13_3, arg_13_2 / var_13_2)
	end

	return
end

function pg.CameraFixMgr:FixOverlayPadding(arg_14_1)
	if not self.paddingCanvas or IsNil(self.paddingCanvas) then
		local var_14_0 = GameObject.Find("/OverlayCamera/Adpter")

		if not var_14_0 or IsNil(var_14_0) then
			return
		end

		self.paddingCanvas = rtf(var_14_0)
		self.paddingCanvasScaler = var_14_0:GetComponent(typeof(CanvasScaler))
		self.paddingTop = self.paddingCanvas:Find("top")
		self.paddingBottom = self.paddingCanvas:Find("bottom")
		self.paddingLeft = self.paddingCanvas:Find("left")
		self.paddingRight = self.paddingCanvas:Find("right")
	end

	if IsNil(self.paddingTop) or IsNil(self.paddingBottom) or IsNil(self.paddingLeft) or IsNil(self.paddingRight) then
		return
	end

	local var_14_1 = var_0_3(self.paddingCanvasScaler, self.currentWidth, self.currentHeight)

	if var_14_1 <= 0 then
		return
	end

	local var_14_2 = self.currentWidth / var_14_1
	local var_14_3 = self.currentHeight / var_14_1
	local var_14_4
	local var_14_5

	if arg_14_1 < self.targetRatio then
		var_14_4 = var_14_2
		var_14_5 = var_14_2 / self.targetRatio
	else
		var_14_5 = var_14_3
		var_14_4 = var_14_3 * self.targetRatio
	end

	local var_14_6 = math.max((var_14_2 - var_14_4) * 0.5, 0)
	local var_14_7 = math.max((var_14_3 - var_14_5) * 0.5, 0)

	self.paddingLeft.sizeDelta = Vector2(var_14_6, self.paddingLeft.sizeDelta.y)
	self.paddingRight.sizeDelta = Vector2(var_14_6, self.paddingRight.sizeDelta.y)
	self.paddingTop.sizeDelta = Vector2(self.paddingTop.sizeDelta.x, var_14_7)
	self.paddingBottom.sizeDelta = Vector2(self.paddingBottom.sizeDelta.x, var_14_7)

	return
end

return
