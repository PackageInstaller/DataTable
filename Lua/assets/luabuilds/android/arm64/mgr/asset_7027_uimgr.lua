pg = pg or {}

local var_0_0 = singletonClass("UIMgr")

pg.UIMgr = var_0_0

local var_0_1 = pg

var_0_0._loadPanel = nil
var_0_0.CameraUI = 1
var_0_0.CameraLevel = 2
var_0_0.CameraOverlay = 3
var_0_0.OptimizedBlur = 1
var_0_0.PartialBlur = 2

local function var_0_2(arg_1_0)
	if arg_1_0 == nil then
		return
	end

	arg_1_0.downsample = 2
	arg_1_0.blurSize = 1
	arg_1_0.blurIteration = 2

	return
end

local function var_0_3(arg_2_0)
	if arg_2_0 == nil then
		return
	end

	arg_2_0.downsample = 2
	arg_2_0.blurSize = 1
	arg_2_0.blurIteration = 4

	return
end

local function var_0_4(arg_3_0)
	if arg_3_0 == nil then
		return
	end

	arg_3_0.downsample = 2
	arg_3_0.blurSize = 1
	arg_3_0.blurIteration = 1

	return
end

local function var_0_5(arg_4_0)
	if arg_4_0 == nil then
		return
	end

	arg_4_0.downsample = 2
	arg_4_0.blurSize = 1
	arg_4_0.blurIteration = 1

	return
end

function var_0_0:Init(arg_5_1)
	print("initializing ui manager...")

	self.mainCamera = GameObject.Find("MainCamera")

	setActive(self.mainCamera, false)

	self.mainCameraComp = self.mainCamera:GetComponent("Camera")
	self.uiCamera = tf(GameObject.Find("UICamera"))
	self.uiCameraComp = self.uiCamera:GetComponent("Camera")
	self.uiCameraComp.allowMSAA = false
	self.levelCamera = tf(GameObject.Find("LevelCamera"))
	self.levelCameraComp = self.levelCamera:GetComponent("Camera")
	self.levelCameraComp.allowMSAA = false
	self.overlayCamera = tf(GameObject.Find("OverlayCamera"))
	self.overlayCameraComp = self.overlayCamera:GetComponent("Camera")
	self.overlayCameraComp.allowMSAA = false
	self.uiCameraComp = self.uiCamera:GetComponent("Camera")
	self.UICanvas = self.uiCamera:Find("Canvas")
	self.UIMain = self.uiCamera:Find("Canvas/UIMain")
	self.LevelMain = self.levelCamera:Find("Canvas/UIMain")
	self.OverlayMain = self.overlayCamera:Find("Overlay/UIMain")
	self.OverlayToast = self.overlayCamera:Find("Overlay/UIOverlay")
	self.OverlayEffect = self.overlayCamera:Find("Overlay/UIEffect")
	self._normalUIMain = nil
	self._cameraBlurPartial = self.uiCamera:GetComponent("UIPartialBlur")
	self._levelCameraPartial = self.levelCamera:GetComponent("UIPartialBlur")
	self.cameraBlurs = {
		[var_0_0.CameraUI] = {
			self.uiCamera:GetComponent("BlurOptimized"),
			self._cameraBlurPartial
		},
		[var_0_0.CameraLevel] = {
			self.levelCamera:GetComponent("BlurOptimized"),
			self._levelCameraPartial
		},
		[var_0_0.CameraOverlay] = {
			(self.overlayCamera:GetComponent("BlurOptimized"))
		}
	}

	local var_5_0 = DevicePerformanceUtil.GetDeviceLevel()

	for iter_5_0, iter_5_1 in ipairs(self.cameraBlurs) do
		if var_5_0 == DevicePerformanceLevel.Low then
			var_0_4(iter_5_1[var_0_0.OptimizedBlur])
			var_0_5(iter_5_1[var_0_0.PartialBlur])
		else
			var_0_2(iter_5_1[var_0_0.OptimizedBlur])
			var_0_3(iter_5_1[var_0_0.PartialBlur])
		end
	end

	self.defaultMaterial = Material.New(Shader.Find("UI/Default"))
	self.partialBlurMaterial = Material.New(Shader.Find("UI/PartialBlur"))
	self._debugPanel = DebugPanel.New()

	setActive(self.uiCamera, false)
	seriesAsync({
		function(arg_6_0)
			setActive(self.uiCamera, true)

			self._loadPanel = LoadingPanel.New(arg_6_0)

			return
		end
	}, arg_5_1)

	return
end

function var_0_0:Loading(arg_7_1)
	self._loadPanel:appendInfo(arg_7_1)

	return
end

function var_0_0:LoadingOn(arg_8_1)
	self._loadPanel:on(arg_8_1)

	return
end

function var_0_0:displayLoadingBG(arg_9_1)
	if tobool(self.showBG) == arg_9_1 then
		return
	end

	self._loadPanel:displayBG(arg_9_1)

	self.showBG = arg_9_1

	if self.showBG then
		var_0_1.UIMgr.GetInstance():LoadingOn()
	else
		var_0_1.UIMgr.GetInstance():LoadingOff()
	end

	return
end

function var_0_0:LoadingOff()
	self._loadPanel:off()

	return
end

function var_0_0:OnLoading()
	return self._loadPanel:onLoading()
end

function var_0_0:LoadingRetainCount()
	return self._loadPanel:getRetainCount()
end

function var_0_0:AddDebugButton(arg_13_1, arg_13_2)
	self._debugPanel:addCustomBtn(arg_13_1, arg_13_2)

	return
end

function var_0_0:AddWorldTestButton(arg_14_1, arg_14_2)
	self._debugPanel:addCustomBtn(arg_14_1, function()
		self._debugPanel:hidePanel()
		arg_14_2()

		return
	end)

	return
end

var_0_0._maxbianjie = 50
var_0_0._maxbianjieInv = 0.02
var_0_0._maxbianjieSqr = 2500
var_0_0._followRange = 0
var_0_0._stick = nil
var_0_0._areaImg = nil
var_0_0._stickImg = nil
var_0_0._stickCom = nil
var_0_0._normalColor = Color(255, 255, 255, 1)
var_0_0._darkColor = Color(255, 255, 255, 0.5)
var_0_0._firstPos = Vector3.zero

function var_0_0:AttachStickOb(arg_16_1)
	self.hrz = 0
	self.vtc = 0
	self.fingerId = -1

	local var_16_0 = arg_16_1:Find("Area")

	self._stick = var_16_0:Find("Stick")
	self._areaImg = var_16_0:GetComponent(typeof(Image))
	self._stickImg = self._stick:GetComponent(typeof(Image))
	self._stickCom = arg_16_1:GetComponent(typeof(StickController))
	self._stickCom.StickBorderRate = 1

	self._stickCom:SetStickFunc(function(arg_17_0, arg_17_1)
		self:UpdateStick(arg_17_0, arg_17_1)

		return
	end)

	self._firstPos = var_16_0.localPosition
	self.vtc = 0
	self._stickTailPS = self._stick:Find("tailGizmos")

	self:SetActive(true)

	return
end

function var_0_0.SetActive(arg_18_0, arg_18_1)
	arg_18_0._stickActive = arg_18_1

	return
end

function var_0_0:Marching()
	local var_19_0 = ys.Battle.BattleConfig

	LeanTween.value(go(self._stick), 0, 0.625, 1.8):setOnUpdate(System.Action_float(function(arg_20_0)
		self.hrz = var_19_0.START_SPEED_CONST_B * (arg_20_0 - var_19_0.START_SPEED_CONST_A) * (arg_20_0 - var_19_0.START_SPEED_CONST_A)

		return
	end)):setOnComplete(System.Action(function()
		self.hrz = 0

		return
	end))

	return
end

function var_0_0:UpdateStick(arg_22_1, arg_22_2)
	if not self._stickActive then
		return
	end

	if self._stickTailPS then
		if arg_22_2 == -1 then
			if arg_22_2 ~= self.fingerId then
				setActive(self._stickTailPS, false)
			end
		elseif arg_22_2 >= 0 and arg_22_2 ~= self.fingerId then
			setActive(self._stickTailPS, true)
		end
	end

	if arg_22_2 == -2 then
		self:SetOutput(arg_22_1.x, arg_22_1.y, -2)

		return
	elseif arg_22_2 == -1 then
		self:SetOutput(0, 0, arg_22_2)

		return
	end

	local var_22_0 = arg_22_1

	var_22_0.z = 0

	local var_22_1 = var_22_0:SqrMagnitude()

	if var_22_1 > self._maxbianjieSqr then
		var_22_0 = var_22_0 / math.sqrt(var_22_1)

		if arg_22_1 - var_22_0 * self._maxbianjie ~= self._firstPos then
			-- block empty
		end

		self._stick.localPosition = var_22_0 * self._maxbianjie

		self:SetOutput(var_22_0.x, var_22_0.y, arg_22_2)
	else
		self._stick.localPosition = arg_22_1

		self:SetOutput(var_22_0.x * self._maxbianjieInv, var_22_0.y * self._maxbianjieInv, arg_22_2)
	end

	return
end

function var_0_0:SetOutput(arg_23_1, arg_23_2, arg_23_3)
	self.hrz = arg_23_1
	self.vtc = arg_23_2

	local var_23_0 = (arg_23_3 >= 0 and 1 or 0) - (self.fingerId >= 0 and 1 or 0)

	if (arg_23_3 >= 0 and 1 or 0) - (self.fingerId >= 0 and 1 or 0) ~= 0 and self._areaImg and self._stickImg then
		if var_23_0 > 0 then
			self._areaImg.color = var_0_0._normalColor or var_0_0._darkColor
		end

		if var_23_0 > 0 then
			self._stickImg.color = var_0_0._normalColor or var_0_0._darkColor
		end
	end

	if arg_23_3 < 0 then
		self._stick.localPosition = Vector3.zero
	end

	self.fingerId = arg_23_3

	return
end

function var_0_0:ClearStick()
	self._stick.localPosition = Vector3.zero

	self._stickCom:ClearStickFunc()

	self._stick = nil
	self._areaImg = nil
	self._stickImg = nil
	self._stickCom = nil

	return
end

function var_0_0.OverlayPanel(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2 = arg_25_2 or {}
	arg_25_2.type = LayerWeightConst.UI_TYPE_SUB

	var_0_1.LayerWeightMgr.GetInstance():Add2Overlay(arg_25_1, arg_25_2)

	return
end

function var_0_0.BlurPanel(arg_26_0, arg_26_1, arg_26_2)
	arg_26_2 = arg_26_2 or {}
	arg_26_2.type = LayerWeightConst.UI_TYPE_SUB
	arg_26_2.globalBlur = true

	var_0_1.LayerWeightMgr.GetInstance():Add2Overlay(arg_26_1, arg_26_2)

	return
end

function var_0_0:UnOverlayPanel(arg_27_1, arg_27_2)
	var_0_1.LayerWeightMgr.GetInstance():DelFromOverlay(arg_27_1, arg_27_2 or self.UIMain)

	return
end

function var_0_0:PartialBlurTfs(arg_28_1)
	self:UpdatePBList(arg_28_1)

	if self.levelCameraComp.enabled then
		self:UpdatePBEnable(true, self.cameraBlurs[var_0_0.CameraLevel])
		self:UpdatePBEnable(false, self.cameraBlurs[var_0_0.CameraUI])
	else
		self:UpdatePBEnable(false, self.cameraBlurs[var_0_0.CameraLevel])
		self:UpdatePBEnable(true, self.cameraBlurs[var_0_0.CameraUI])
	end

	return
end

function var_0_0:ShutdownPartialBlur()
	self:UpdatePBList({})
	self:UpdatePBEnable(false, self.cameraBlurs[var_0_0.CameraLevel])
	self:UpdatePBEnable(false, self.cameraBlurs[var_0_0.CameraUI])

	return
end

local var_0_6 = {}

function var_0_0:UpdatePBList(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(var_0_6) do
		if not IsNil(iter_30_0) then
			iter_30_0.material = iter_30_1
		end

		var_0_6[iter_30_0] = nil
	end

	var_0_6 = {}

	for iter_30_2, iter_30_3 in ipairs(arg_30_1) do
		local var_30_0 = iter_30_3:GetComponent(typeof(Image))

		assert(var_30_0, "mask should be an image.")

		var_0_6[var_30_0] = var_30_0.material
		var_30_0.material = self.partialBlurMaterial
	end

	return
end

function var_0_0.UpdatePBEnable(arg_31_0, arg_31_1, arg_31_2)
	arg_31_2[var_0_0.PartialBlur].enabled = arg_31_1

	return
end

local var_0_7

function var_0_0:TempOverlayPanelPB(arg_32_1, arg_32_2)
	self:OverlayPanel(arg_32_1, setmetatable({}, {
		__index = function(arg_33_0, arg_33_1)
			if arg_33_1 == "pbList" then
				return nil
			end

			return arg_32_2[arg_33_1]
		end
	}))

	var_0_7 = {
		arg_32_2.baseCamera:GetComponent("BlurOptimized"),
		arg_32_2.baseCamera:GetComponent("UIPartialBlur")
	}

	if DevicePerformanceUtil.GetDeviceLevel() == DevicePerformanceLevel.Low then
		var_0_4(var_0_7[var_0_0.OptimizedBlur])
		var_0_5(var_0_7[var_0_0.PartialBlur])
	else
		var_0_2(var_0_7[var_0_0.OptimizedBlur])
		var_0_3(var_0_7[var_0_0.PartialBlur])
	end

	var_0_7[var_0_0.PartialBlur].maskCam = self.overlayCamera:GetComponent("Camera")

	self:UpdateOtherPBList(arg_32_2.pbList)
	self:UpdatePBEnable(true, var_0_7)

	return
end

function var_0_0:TempUnOverlayPanelPB(arg_34_1, arg_34_2)
	self:UpdateOtherPBList({})
	self:UpdatePBEnable(false, var_0_7)

	var_0_7 = nil

	self:UnOverlayPanel(arg_34_1, arg_34_2)

	return
end

local var_0_8 = {}

function var_0_0:UpdateOtherPBList(arg_35_1)
	for iter_35_0, iter_35_1 in pairs(var_0_8) do
		iter_35_0.material = iter_35_1
	end

	var_0_8 = {}

	for iter_35_2, iter_35_3 in ipairs(arg_35_1 or {}) do
		local var_35_0 = iter_35_3:GetComponent(typeof(Image))

		assert(var_35_0, "mask should be an image.")

		var_0_8[var_35_0] = var_35_0.material
		var_35_0.material = self.partialBlurMaterial
	end

	return
end

function var_0_0:BlurCamera(arg_36_1, arg_36_2, arg_36_3)
	if self.camLockStatus then
		return
	end

	local var_36_0 = self.cameraBlurs[arg_36_1][var_0_0.OptimizedBlur]

	if not arg_36_2 and var_36_0.enabled and var_36_0.staticBlur then
		var_36_0.enabled = false
	end

	var_36_0.enabled = true
	var_36_0.staticBlur = tobool(arg_36_2)

	return
end

function var_0_0:UnblurCamera(arg_37_1, arg_37_2)
	if self.camLockStatus then
		return
	end

	self.cameraBlurs[arg_37_1][var_0_0.OptimizedBlur].enabled = false

	return
end

function var_0_0.SetCameraBlurLock(arg_38_0, arg_38_1)
	arg_38_0.camLockStatus = arg_38_1

	return
end

function var_0_0:SetMainCamBlurTexture(arg_39_1)
	local var_39_0 = self.mainCamera:GetComponent(typeof(Camera))
	local var_39_1 = ReflectionHelp.RefCallStaticMethod(typeof("UnityEngine.RenderTexture"), "GetTemporary", {
		typeof("System.Int32"),
		typeof("System.Int32"),
		typeof("System.Int32")
	}, {
		Screen.width,
		Screen.height,
		0
	})

	var_39_0.targetTexture = var_39_1

	var_39_0:Render()

	local var_39_2 = var_0_1.ShaderMgr.GetInstance():BlurTexture(var_39_1)

	var_39_0.targetTexture = nil

	ReflectionHelp.RefCallStaticMethod(typeof("UnityEngine.RenderTexture"), "ReleaseTemporary", {
		typeof("UnityEngine.RenderTexture")
	}, {
		var_39_1
	})

	arg_39_1.uvRect = var_39_0.rect
	arg_39_1.texture = var_39_2

	return var_39_2
end

function var_0_0:GetMainCamera()
	return self.mainCamera
end

return
