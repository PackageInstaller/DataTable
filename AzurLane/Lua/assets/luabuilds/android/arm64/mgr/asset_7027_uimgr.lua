pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
singletonClass = pg

local var_0_1 = var_0("UIMgr")

pg = var_0_10001
var_0_10001.UIMgr = var_0_1
pg = var_0_10001
var_0_1._loadPanel = nil
var_0_1.CameraUI = 1
var_0_1.CameraLevel = 2
var_0_1.CameraOverlay = 3
var_0_1.OptimizedBlur = 1
var_0_1.PartialBlur = 2

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

function var_0_1.Init(arg_5_0, arg_5_1)
	print = var_1_10002

	var_1_10002("initializing ui manager...")

	GameObject = var_1_10002
	arg_5_0.mainCamera = var_1_10002.Find("MainCamera")
	setActive = var_2

	var_2(arg_5_0.mainCamera, false)

	local var_5_0 = arg_5_0.mainCamera

	arg_5_0.mainCameraComp = var_2.GetComponent(var_5_0, "Camera")
	tf = var_2
	GameObject = var_5_0
	arg_5_0.uiCamera = var_2(var_5_0.Find("UICamera"))

	local var_5_1 = arg_5_0.uiCamera

	arg_5_0.uiCameraComp = var_2.GetComponent(var_5_1, "Camera")

	local var_5_2 = arg_5_0.uiCameraComp

	var_5_2.allowMSAA = false
	tf = var_5_2
	GameObject = var_5_1
	arg_5_0.levelCamera = var_5_2(var_5_1.Find("LevelCamera"))

	local var_5_3 = arg_5_0.levelCamera

	arg_5_0.levelCameraComp = var_2.GetComponent(var_5_3, "Camera")

	local var_5_4 = arg_5_0.levelCameraComp

	var_5_4.allowMSAA = false
	tf = var_5_4
	GameObject = var_5_3
	arg_5_0.overlayCamera = var_5_4(var_5_3.Find("OverlayCamera"))

	local var_5_5 = arg_5_0.overlayCamera

	arg_5_0.overlayCameraComp = var_2.GetComponent(var_5_5, "Camera")
	arg_5_0.overlayCameraComp.allowMSAA = false

	local var_5_6 = arg_5_0.uiCamera

	arg_5_0.uiCameraComp = var_2.GetComponent(var_5_6, "Camera")

	local var_5_7 = arg_5_0.uiCamera

	arg_5_0.UICanvas = var_2.Find(var_5_7, "Canvas")

	local var_5_8 = arg_5_0.uiCamera

	arg_5_0.UIMain = var_2.Find(var_5_8, "Canvas/UIMain")

	local var_5_9 = arg_5_0.levelCamera

	arg_5_0.LevelMain = var_2.Find(var_5_9, "Canvas/UIMain")

	local var_5_10 = arg_5_0.overlayCamera

	arg_5_0.OverlayMain = var_2.Find(var_5_10, "Overlay/UIMain")

	local var_5_11 = arg_5_0.overlayCamera

	arg_5_0.OverlayToast = var_2.Find(var_5_11, "Overlay/UIOverlay")

	local var_5_12 = arg_5_0.overlayCamera

	arg_5_0.OverlayEffect = var_2.Find(var_5_12, "Overlay/UIEffect")
	arg_5_0._normalUIMain = nil

	local var_5_13 = arg_5_0.uiCamera

	arg_5_0._cameraBlurPartial = var_2.GetComponent(var_5_13, "UIPartialBlur")

	local var_5_14 = arg_5_0.levelCamera

	arg_5_0._levelCameraPartial = var_2.GetComponent(var_5_14, "UIPartialBlur")

	local var_5_15 = {}
	local var_5_16 = var_0_1.CameraUI
	local var_5_17 = {}
	local var_5_18 = arg_5_0.uiCamera

	var_5_17[1] = var_5.GetComponent(var_5_18, "BlurOptimized")
	var_5_17[2] = arg_5_0._cameraBlurPartial
	var_5_15[var_5_16] = var_5_17

	local var_5_19 = var_0_1.CameraLevel
	local var_5_20 = {}
	local var_5_21 = arg_5_0.levelCamera

	var_5_20[1] = var_5.GetComponent(var_5_21, "BlurOptimized")
	var_5_20[2] = arg_5_0._levelCameraPartial
	var_5_15[var_5_19] = var_5_20

	local var_5_22 = var_0_1.CameraOverlay
	local var_5_23 = {}
	local var_5_24 = arg_5_0.overlayCamera

	var_5_23[1] = var_5.GetComponent(var_5_24, "BlurOptimized")
	var_5_15[var_5_22] = var_5_23
	arg_5_0.cameraBlurs = var_5_15
	DevicePerformanceUtil = var_5_15

	local var_5_25 = var_5_15.GetDeviceLevel()

	ipairs = var_5_22

	for iter_5_0, iter_5_1 in var_5_22(arg_5_0.cameraBlurs) do
		DevicePerformanceLevel = var_8

		if var_5_25 == var_8.Low then
			var_0_4(iter_5_1[var_0_1.OptimizedBlur])
			var_0_5(iter_5_1[var_0_1.PartialBlur])
		else
			var_0_2(iter_5_1[var_0_1.OptimizedBlur])
			var_0_3(iter_5_1[var_0_1.PartialBlur])
		end
	end

	Material = var_3

	local var_5_26 = var_3.New

	Shader = var_5
	arg_5_0.defaultMaterial = var_5_26(var_5.Find("UI/Default"))
	Material = var_3

	local var_5_27 = var_3.New

	Shader = var_5
	arg_5_0.partialBlurMaterial = var_5_27(var_5.Find("UI/PartialBlur"))
	DebugPanel = var_3
	arg_5_0._debugPanel = var_3.New()
	setActive = var_3

	var_3(arg_5_0.uiCamera, false)

	seriesAsync = var_3

	var_3({
		function(arg_6_0)
			setActive = var_2_10001

			var_2_10001(arg_5_0.uiCamera, true)

			local var_6_0 = arg_5_0

			LoadingPanel = var_2_10002
			var_6_0._loadPanel = var_2_10002.New(arg_6_0)

			return
		end
	}, arg_5_1)

	return
end

function var_0_1.Loading(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._loadPanel

	var_2.appendInfo(var_7_0, arg_7_1)

	return
end

function var_0_1.LoadingOn(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._loadPanel

	var_2.on(var_8_0, arg_8_1)

	return
end

function var_0_1.displayLoadingBG(arg_9_0, arg_9_1)
	tobool = var_1_10002

	if var_1_10002(arg_9_0.showBG) == arg_9_1 then
		return
	end

	local var_9_0 = arg_9_0._loadPanel

	var_2.displayBG(var_9_0, arg_9_1)

	arg_9_0.showBG = arg_9_1

	if arg_9_0.showBG then
		local var_9_1 = var_0_10001.UIMgr.GetInstance()

		var_2.LoadingOn(var_9_1)
	else
		local var_9_2 = var_0_10001.UIMgr.GetInstance()

		var_2.LoadingOff(var_9_2)
	end

	return
end

function var_0_1.LoadingOff(arg_10_0)
	local var_10_0 = arg_10_0._loadPanel

	var_1.off(var_10_0)

	return
end

function var_0_1.OnLoading(arg_11_0)
	local var_11_0 = arg_11_0._loadPanel

	return var_1.onLoading(var_11_0)
end

function var_0_1.LoadingRetainCount(arg_12_0)
	local var_12_0 = arg_12_0._loadPanel

	return var_1.getRetainCount(var_12_0)
end

function var_0_1.AddDebugButton(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._debugPanel

	var_3.addCustomBtn(var_13_0, arg_13_1, arg_13_2)

	return
end

function var_0_1.AddWorldTestButton(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._debugPanel

	var_3.addCustomBtn(var_14_0, arg_14_1, function()
		local var_15_0 = arg_14_0._debugPanel

		var_0.hidePanel(var_15_0)
		arg_14_2()

		return
	end)

	return
end

var_0_1._maxbianjie = 50
var_0_1._maxbianjieInv = 0.02
var_0_1._maxbianjieSqr = 2500
var_0_1._followRange = 0
var_0_1._stick = nil
var_0_1._areaImg = nil
var_0_1._stickImg = nil
var_0_1._stickCom = nil
Color = var_6
var_0_1._normalColor = var_6(255, 255, 255, 1)
Color = var_6
var_0_1._darkColor = var_6(255, 255, 255, 0.5)
Vector3 = var_6
var_0_1._firstPos = var_6.zero

function var_0_1.AttachStickOb(arg_16_0, arg_16_1)
	arg_16_0.hrz = 0
	arg_16_0.vtc = 0
	arg_16_0.fingerId = -1

	local var_16_0 = arg_16_1:Find("Area")

	arg_16_0._stick = var_2.Find(var_16_0, "Stick")

	local var_16_1 = var_2
	local var_16_2 = var_2.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_16_0._areaImg = var_16_2(var_16_1, var_6(var_1_10008))

	local var_16_3 = arg_16_0._stick
	local var_16_4 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_16_0._stickImg = var_16_4(var_16_3, var_6(var_1_10008))

	local var_16_5 = arg_16_1
	local var_16_6 = arg_16_1.GetComponent

	typeof = var_6
	StickController = var_1_10008
	arg_16_0._stickCom = var_16_6(var_16_5, var_6(var_1_10008))
	arg_16_0._stickCom.StickBorderRate = 1

	local var_16_7 = arg_16_0._stickCom

	var_3.SetStickFunc(var_16_7, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_16_0

		var_2.UpdateStick(var_17_0, arg_17_0, arg_17_1)

		return
	end)

	arg_16_0._firstPos = var_2.localPosition
	arg_16_0.vtc = 0

	local var_16_8 = arg_16_0._stick

	arg_16_0._stickTailPS = var_3.Find(var_16_8, "tailGizmos")

	arg_16_0:SetActive(true)

	return
end

function var_0_1.SetActive(arg_18_0, arg_18_1)
	arg_18_0._stickActive = arg_18_1

	return
end

function var_0_1.Marching(arg_19_0)
	ys = var_1_10001

	local var_19_0 = var_1_10001.Battle.BattleConfig

	LeanTween = var_1_10002

	local var_19_1 = var_1_10002.value

	go = var_1_10004

	local var_19_2 = var_19_1(var_1_10004(arg_19_0._stick), 0, 0.625, 1.8)
	local var_19_3 = var_2.setOnUpdate

	System = var_5

	local var_19_4 = var_19_3(var_19_2, var_5.Action_float(function(arg_20_0)
		arg_19_0.hrz = var_19_0.START_SPEED_CONST_B * (arg_20_0 - var_19_0.START_SPEED_CONST_A) * (arg_20_0 - var_19_0.START_SPEED_CONST_A)

		return
	end))
	local var_19_5 = var_2.setOnComplete

	System = var_5

	var_19_5(var_19_4, var_5.Action(function()
		arg_19_0.hrz = 0

		return
	end))

	return
end

function var_0_1.UpdateStick(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_0._stickActive then
		return
	end

	if arg_22_0._stickTailPS then
		if arg_22_2 == -1 then
			if arg_22_2 ~= arg_22_0.fingerId then
				setActive = var_3

				var_3(arg_22_0._stickTailPS, false)
			end
		elseif arg_22_2 >= 0 and arg_22_2 ~= arg_22_0.fingerId then
			setActive = var_3

			var_3(arg_22_0._stickTailPS, true)
		end
	end

	if arg_22_2 == -2 then
		arg_22_0:SetOutput(arg_22_1.x, arg_22_1.y, -2)

		return
	elseif arg_22_2 == -1 then
		arg_22_0:SetOutput(0, 0, arg_22_2)

		return
	end

	local var_22_0 = arg_22_1

	var_22_0.z = 0

	local var_22_1 = var_22_0:SqrMagnitude()

	if arg_22_0._maxbianjieSqr < var_22_1 then
		math = var_5

		if arg_22_1 - var_22_0 / var_5.sqrt(var_22_1) * arg_22_0._maxbianjie ~= arg_22_0._firstPos then
			local var_22_2 = arg_22_0._firstPos
		end

		arg_22_0._stick.localPosition = var_5

		arg_22_0:SetOutput(var_22_0.x, var_22_0.y, arg_22_2)
	else
		arg_22_0._stick.localPosition = arg_22_1

		arg_22_0:SetOutput(var_22_0.x * arg_22_0._maxbianjieInv, var_22_0.y * arg_22_0._maxbianjieInv, arg_22_2)
	end

	return
end

function var_0_1.SetOutput(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0.hrz = arg_23_1
	arg_23_0.vtc = arg_23_2

	local var_23_0 = arg_23_3 >= 0 and 1 or 0
	local var_23_1 = arg_23_0.fingerId
	local var_23_3

	if var_23_0 - (0 <= var_23_1 and 1 or 0) ~= 0 and arg_23_0._areaImg and arg_23_0._stickImg then
		local var_23_2 = arg_23_0._areaImg

		if not (0 < var_4) or not var_0_1._normalColor then
			var_23_3 = var_0_1._darkColor
		end

		var_23_2.color = var_23_3

		local var_23_4 = arg_23_0._stickImg

		if not (0 < var_4) or not var_0_1._normalColor then
			var_23_3 = var_0_1._darkColor
		end

		var_23_4.color = var_23_3
	end

	if arg_23_3 < 0 then
		local var_23_5 = arg_23_0._stick

		Vector3 = var_23_3
		var_23_5.localPosition = var_23_3.zero
	end

	arg_23_0.fingerId = arg_23_3

	return
end

function var_0_1.ClearStick(arg_24_0)
	local var_24_0 = arg_24_0._stick

	Vector3 = var_1_10002
	var_24_0.localPosition = var_1_10002.zero

	local var_24_1 = arg_24_0._stickCom

	var_1.ClearStickFunc(var_24_1)

	arg_24_0._stick = nil
	arg_24_0._areaImg = nil
	arg_24_0._stickImg = nil
	arg_24_0._stickCom = nil

	return
end

function var_0_1.OverlayPanel(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2 = arg_25_2 or {}
	LayerWeightConst = var_1_10003
	arg_25_2.type = var_1_10003.UI_TYPE_SUB

	local var_25_0 = var_0_10001.LayerWeightMgr.GetInstance()

	var_3.Add2Overlay(var_25_0, arg_25_1, arg_25_2)

	return
end

function var_0_1.BlurPanel(arg_26_0, arg_26_1, arg_26_2)
	arg_26_2 = arg_26_2 or {}
	LayerWeightConst = var_1_10003
	arg_26_2.type = var_1_10003.UI_TYPE_SUB
	arg_26_2.globalBlur = true

	local var_26_0 = var_0_10001.LayerWeightMgr.GetInstance()

	var_3.Add2Overlay(var_26_0, arg_26_1, arg_26_2)

	return
end

function var_0_1.UnOverlayPanel(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = var_0_10001.LayerWeightMgr.GetInstance()

	var_3.DelFromOverlay(var_27_0, arg_27_1, arg_27_2 or arg_27_0.UIMain)

	return
end

function var_0_1.PartialBlurTfs(arg_28_0, arg_28_1)
	arg_28_0:UpdatePBList(arg_28_1)

	if arg_28_0.levelCameraComp.enabled then
		arg_28_0:UpdatePBEnable(true, arg_28_0.cameraBlurs[var_0_1.CameraLevel])
		arg_28_0:UpdatePBEnable(false, arg_28_0.cameraBlurs[var_0_1.CameraUI])
	else
		arg_28_0:UpdatePBEnable(false, arg_28_0.cameraBlurs[var_0_1.CameraLevel])
		arg_28_0:UpdatePBEnable(true, arg_28_0.cameraBlurs[var_0_1.CameraUI])
	end

	return
end

function var_0_1.ShutdownPartialBlur(arg_29_0)
	arg_29_0:UpdatePBList({})
	arg_29_0:UpdatePBEnable(false, arg_29_0.cameraBlurs[var_0_1.CameraLevel])
	arg_29_0:UpdatePBEnable(false, arg_29_0.cameraBlurs[var_0_1.CameraUI])

	return
end

local var_0_6 = {}

function var_0_1.UpdatePBList(arg_30_0, arg_30_1)
	pairs = var_1_10002

	for iter_30_0, iter_30_1 in var_1_10002(var_0_6) do
		IsNil = var_1_10007

		if not var_1_10007(iter_30_0) then
			iter_30_0.material = iter_30_1
		end

		var_1_10007 = var_0_6
		var_1_10007[iter_30_0] = nil
	end

	var_0_6 = {}
	ipairs = var_2

	for iter_30_2, iter_30_3 in var_2(arg_30_1) do
		local var_30_0 = iter_30_3
		local var_30_1 = iter_30_3.GetComponent

		typeof = var_1_10010
		Image = var_1_10012

		local var_30_2 = var_30_1(var_30_0, var_1_10010(var_1_10012))

		assert = var_1_10008

		var_1_10008(var_30_2, "mask should be an image.")

		var_1_10008 = var_0_6
		var_1_10008[var_30_2] = var_30_2.material
		var_30_2.material = arg_30_0.partialBlurMaterial
	end

	return
end

function var_0_1.UpdatePBEnable(arg_31_0, arg_31_1, arg_31_2)
	arg_31_2[var_0_1.PartialBlur].enabled = arg_31_1

	return
end

local var_0_7

function var_0_1.TempOverlayPanelPB(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.OverlayPanel
	local var_32_2 = arg_32_1

	setmetatable = var_1_10007

	var_32_1(var_32_0, var_32_2, var_1_10007({}, {
		__index = function(arg_33_0, arg_33_1)
			if arg_33_1 == "pbList" then
				return nil
			end

			return arg_32_2[arg_33_1]
		end
	}))

	local var_32_3 = arg_32_2.baseCamera

	var_0_7 = {
		var_32_3:GetComponent("BlurOptimized"),
		var_32_3:GetComponent("UIPartialBlur")
	}
	DevicePerformanceUtil = var_4

	local var_32_4 = var_4.GetDeviceLevel()

	DevicePerformanceLevel = var_5

	if var_32_4 == var_5.Low then
		var_0_4(var_0_7[var_0_1.OptimizedBlur])
		var_0_5(var_0_7[var_0_1.PartialBlur])
	else
		var_0_2(var_0_7[var_0_1.OptimizedBlur])
		var_0_3(var_0_7[var_0_1.PartialBlur])
	end

	local var_32_5 = var_0_7[var_0_1.PartialBlur]
	local var_32_6 = arg_32_0.overlayCamera

	var_32_5.maskCam = var_6.GetComponent(var_32_6, "Camera")

	arg_32_0:UpdateOtherPBList(arg_32_2.pbList)
	arg_32_0:UpdatePBEnable(true, var_0_7)

	return
end

function var_0_1.TempUnOverlayPanelPB(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0:UpdateOtherPBList({})
	arg_34_0:UpdatePBEnable(false, var_0_7)

	var_0_7 = nil

	arg_34_0:UnOverlayPanel(arg_34_1, arg_34_2)

	return
end

local var_0_8 = {}

function var_0_1.UpdateOtherPBList(arg_35_0, arg_35_1)
	pairs = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10002(var_0_8) do
		iter_35_0.material = iter_35_1
	end

	var_0_8 = {}
	ipairs = var_2

	for iter_35_2, iter_35_3 in var_2(arg_35_1 or {}) do
		local var_35_0 = iter_35_3
		local var_35_1 = iter_35_3.GetComponent

		typeof = var_1_10010
		Image = var_1_10012

		local var_35_2 = var_35_1(var_35_0, var_1_10010(var_1_10012))

		assert = var_1_10008

		var_1_10008(var_35_2, "mask should be an image.")

		var_1_10008 = var_0_8
		var_1_10008[var_35_2] = var_35_2.material
		var_35_2.material = arg_35_0.partialBlurMaterial
	end

	return
end

function var_0_1.BlurCamera(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_0.camLockStatus then
		return
	end

	local var_36_0 = arg_36_0.cameraBlurs[arg_36_1][var_0_1.OptimizedBlur]

	if not arg_36_2 and var_36_0.enabled and var_36_0.staticBlur then
		var_36_0.enabled = false
	end

	var_36_0.enabled = true
	tobool = var_5
	var_36_0.staticBlur = var_5(arg_36_2)

	return
end

function var_0_1.UnblurCamera(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0.camLockStatus then
		return
	end

	arg_37_0.cameraBlurs[arg_37_1][var_0_1.OptimizedBlur].enabled = false

	return
end

function var_0_1.SetCameraBlurLock(arg_38_0, arg_38_1)
	arg_38_0.camLockStatus = arg_38_1

	return
end

function var_0_1.SetMainCamBlurTexture(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.mainCamera
	local var_39_1 = var_2.GetComponent

	typeof = var_1_10005
	Camera = var_1_10007

	local var_39_2 = var_39_1(var_39_0, var_1_10005(var_1_10007))

	ReflectionHelp = var_1_10003

	local var_39_3 = var_1_10003.RefCallStaticMethod

	typeof = var_5

	local var_39_4 = var_5("UnityEngine.RenderTexture")
	local var_39_5 = "GetTemporary"
	local var_39_6 = {}

	typeof = var_1_10008
	var_39_6[1] = var_1_10008("System.Int32")
	typeof = var_8
	var_39_6[2] = var_8("System.Int32")
	typeof = var_8
	var_39_6[3] = var_8("System.Int32")

	local var_39_7 = {
		nil,
		nil,
		0
	}

	Screen = var_1_10009
	var_39_7[1] = var_1_10009.width
	Screen = var_9
	var_39_7[2] = var_9.height
	var_39_2.targetTexture = var_39_3(var_39_4, var_39_5, var_39_6, var_39_7)

	var_39_2:Render()

	local var_39_8 = var_0_10001.ShaderMgr.GetInstance()
	local var_39_9 = var_4.BlurTexture(var_39_8, var_3)

	var_39_2.targetTexture = nil
	ReflectionHelp = var_5

	local var_39_10 = var_5.RefCallStaticMethod

	typeof = var_7

	local var_39_11 = var_7("UnityEngine.RenderTexture")
	local var_39_12 = "ReleaseTemporary"
	local var_39_13 = {}

	typeof = var_10
	var_39_13[1] = var_10("UnityEngine.RenderTexture")

	var_39_10(var_39_11, var_39_12, var_39_13, {
		var_3
	})

	arg_39_1.uvRect = var_39_2.rect
	arg_39_1.texture = var_39_9

	return var_39_9
end

function var_0_1.GetMainCamera(arg_40_0)
	return arg_40_0.mainCamera
end

return
