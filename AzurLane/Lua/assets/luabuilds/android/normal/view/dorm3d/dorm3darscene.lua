class = var_0_10000

local var_0_0 = "Dorm3dARScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = "ARScene2|common/ar"

var_0_1.AR_FAIL_CODE = {
	[0] = "CheckingAvailability",
	"NeedsInstall",
	"Installing",
	-1,
	"pc editor",
	None = "Unsupported"
}
var_0_1.AR_PASS_CODE = {
	5,
	6,
	7
}

function var_0_1.getUIName(arg_1_0)
	return "Dorm3DARUI"
end

function var_0_1.forceGC(arg_2_0)
	return true
end

function var_0_1.loadingQueue(arg_3_0)
	return function(arg_4_0)
		pg = var_2_10001

		local var_4_0 = var_2_10001.SceneAnimMgr.GetInstance()

		var_1.Dorm3DSceneChange(var_4_0, function(arg_5_0)
			return arg_4_0(arg_5_0)
		end)

		return
	end
end

function var_0_1.Ctor(arg_6_0, ...)
	var_0_1.super.Ctor(arg_6_0, ...)

	AutoLoader = var_1
	arg_6_0.loader = var_1.New()

	return
end

function var_0_1.preload(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	ApartmentProxy = var_1_10003

	local var_7_0 = var_1_10002(var_1_10003)

	arg_7_0.room = var_2.getRoom(var_7_0, arg_7_0.contextData.roomId)
	unpack = var_2
	string = var_7_0

	local var_7_1, var_7_2 = var_2(var_7_0.split(var_0_2, "|"))

	seriesAsync = var_4

	var_4({
		function(arg_8_0)
			SceneOpMgr = var_2_10001

			local var_8_0 = var_2_10001.Inst
			local var_8_1 = var_1.LoadSceneAsync

			string = var_2_10003

			local var_8_2 = var_2_10003.lower("dorm3d/scenesres/scenes/" .. var_7_2 .. "/" .. var_7_1 .. "_scene")
			local var_8_3 = var_7_1

			LoadSceneMode = var_5

			var_8_1(var_8_0, var_8_2, var_8_3, var_5.Additive, function(arg_9_0, arg_9_1)
				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_7_0

			var_1.LoadCharacter(var_10_0, {
				arg_7_0.contextData.groupId
			}, arg_10_0)

			return
		end,
		function(arg_11_0)
			GameObject = var_2_10001

			local var_11_0 = var_2_10001.Find("FakeAR/Main Camera")

			GameObject = var_2

			local var_11_1 = var_2.Find("AR/XR Origin/Camera Offset/Main Camera")

			if var_11_0 then
				originalPrint = var_3

				var_3("Fix Fake AR Camera Data")

				HotfixHelper = var_3

				var_3.FixARCameraData(var_11_0)
			end

			if var_11_1 then
				originalPrint = var_3

				var_3("Fix True AR Camera Data")

				HotfixHelper = var_3

				var_3.FixARCameraData(var_11_1)
			end

			arg_11_0()

			return
		end
	}, arg_7_1)

	return
end

function var_0_1.LoadCharacter(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.hxMatDict = {}
	arg_12_0.ladyDict = {}
	arg_12_0.skinDict = {}

	local var_12_0 = {}

	ipairs = var_1_10004

	for iter_12_0, iter_12_1 in var_1_10004(arg_12_1) do
		local var_12_1 = arg_12_0
		local var_12_2 = arg_12_0.ladyDict

		var_12_2[iter_12_1] = var_12_1
		getProxy = var_12_2
		ApartmentProxy = var_1_10011
		var_1_10011 = var_12_2(var_1_10011)

		local var_12_3 = var_10.getApartment(var_1_10011, iter_12_1)

		var_1_10011 = var_10.getConfig(var_12_3, "asset_name")

		local var_12_4 = var_10
		local var_12_5 = var_10.GetSkinModelID
		local var_12_6 = arg_12_0.room
		local var_12_7 = var_12_5(var_12_4, var_14.getConfig(var_12_6, "tag"))

		pg = var_12_4

		local var_12_8 = var_12_4.dorm3d_resource[var_12_7].model_id

		assert = var_14

		var_14(var_12_8)

		ipairs = var_14

		for iter_12_2, iter_12_3 in var_14({
			"common",
			var_12_8
		}) do
			string = var_1_10019
			var_1_10019 = var_1_10019.format("dorm3d/character/%s/res/%s", var_1_10011, iter_12_3)
			checkABExist = var_20

			if var_20(var_1_10019) then
				table = var_20

				var_20.insert(var_12_0, function(arg_13_0)
					local var_13_0 = arg_12_0.loader

					var_1.LoadBundle(var_13_0, var_1_10019, function(arg_14_0)
						ipairs = var_3_10001

						for iter_14_0, iter_14_1 in var_3_10001(arg_14_0:GetAllAssetNames()) do
							string = var_3_10006

							local var_14_0, var_14_1

							var_3_10006, var_14_0, var_14_1 = var_3_10006.find(iter_14_1, "material_hx[/\\](.*).mat")

							if var_3_10006 then
								arg_12_0.hxMatDict[var_14_1] = {
									arg_14_0,
									iter_14_1
								}
							end
						end

						arg_13_0()

						return
					end)

					return
				end)
			end
		end

		var_12_1.skinId = var_12_7
		var_12_1.skinIdList = {
			var_12_7
		}
		table = var_14

		var_14.insert(var_12_0, function(arg_15_0)
			string = var_2_10001

			local var_15_0 = var_2_10001.format("dorm3d/character/%s/prefabs/%s", var_1_10011, var_12_8)
			local var_15_1 = arg_12_0.loader

			var_2.GetPrefab(var_15_1, var_15_0, "", function(arg_16_0)
				local var_16_0 = var_12_1

				var_16_0.ladyGameObject = arg_16_0
				setActive = var_16_0

				var_16_0(arg_16_0.transform, false)

				arg_12_0.skinDict[var_12_7] = {
					ladyGameObject = arg_16_0
				}

				arg_15_0()

				return
			end)

			return
		end)
	end

	parallelAsync = var_4

	var_4(var_12_0, arg_12_2)

	return
end

function var_0_1.InitCharacter(arg_17_0, arg_17_1)
	arg_17_0.lady = arg_17_0.ladyGameObject.transform

	local var_17_0 = arg_17_0.lady

	var_2.SetParent(var_17_0, arg_17_0.mainCameraTF)

	local var_17_1 = arg_17_0.lady

	var_2.SetParent(var_17_1, nil)

	setActive = var_2

	var_2(arg_17_0.lady, true)

	local var_17_2 = arg_17_0.lady
	local var_17_3 = var_2.GetComponent

	typeof = var_4
	Animator = var_1_10005
	arg_17_0.ladyAnimator = var_17_3(var_17_2, var_4(var_1_10005))

	local var_17_4 = arg_17_0.ladyAnimator

	arg_17_0.ladyAnimBaseLayerIndex = var_2.GetLayerIndex(var_17_4, "Base Layer")

	local var_17_5 = arg_17_0.ladyAnimator

	arg_17_0.ladyAnimFaceLayerIndex = var_2.GetLayerIndex(var_17_5, "Face")
	arg_17_0.ladyBoneMaps = {}

	local var_17_6 = arg_17_0.lady
	local var_17_7 = var_2.GetComponentsInChildren

	typeof = var_4
	Transform = var_1_10005

	local var_17_8 = var_17_7(var_17_6, var_4(var_1_10005), true)

	table = var_17_6

	var_17_6.IpairsCArray(var_17_8, function(arg_18_0, arg_18_1)
		if arg_18_1.name == "BodyCollider" then
			arg_17_0.ladyCollider = arg_18_1
		elseif arg_18_1.name == "Interest" then
			arg_17_0.ladyInterestRoot = arg_18_1
		elseif arg_18_1.name == "Head Center" then
			arg_17_0.ladyHeadCenter = arg_18_1
		end

		return
	end)
	arg_17_0:HXCharacter(arg_17_0.lady)

	local var_17_9 = arg_17_0.ladyAnimator
	local var_17_10 = var_3.GetComponent(var_17_9, "DftAniEvent")

	var_3.SetCommonEvent(var_17_10, function(arg_19_0)
		if arg_17_0.nowState then
			var_2_10002 = arg_19_0.animatorStateInfo

			if var_1.IsName(var_2_10002, arg_17_0.nowState) then
				existCall = var_1

				var_1(arg_17_0.stateCallback)

				return
			end
		end

		local var_19_0 = arg_19_0.animatorStateInfo

		pairs = var_2_10002

		for iter_19_0, iter_19_1 in var_2_10002(arg_17_0.animCallbacks) do
			if var_19_0:IsName(iter_19_0) then
				warning = var_7

				var_7("Active", iter_19_0)

				table = var_7

				local var_19_1 = var_7.removebykey(arg_17_0.animCallbacks, iter_19_0)

				existCall = var_8

				var_8(var_19_1)

				return
			end
		end

		if arg_19_0.stringParameter ~= "" then
			local var_19_2 = arg_17_0

			var_2.OnAnimationEvent(var_19_2, arg_19_0)
		end

		return
	end)

	arg_17_0.animEventCallbacks = {}
	arg_17_0.animCallbacks = {}

	return
end

function var_0_1.HXCharacter(arg_20_0, arg_20_1)
	HXSet = var_1_10002

	if not var_1_10002.isHx() then
		return
	end

	Dorm3dHxHelper = var_2

	var_2.ShowHolyLight({
		arg_20_1
	}, arg_20_0.holyLightRoot)

	Dorm3dHxHelper = var_2

	if var_2.ReplaceCharacterParts(arg_20_1) then
		return
	end

	local var_20_0 = arg_20_1
	local var_20_1 = arg_20_1.GetComponentsInChildren

	typeof = var_4
	SkinnedMeshRenderer = var_1_10005

	local var_20_2 = var_20_1(var_20_0, var_4(var_1_10005))

	table = var_20_0

	var_20_0.IpairsCArray(var_20_2, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_1.sharedMaterials
		local var_21_1 = false

		table = var_2_10004

		var_2_10004.IpairsCArray(var_21_0, function(arg_22_0, arg_22_1)
			local var_22_0 = arg_22_1.name

			if not arg_20_0.hxMatDict[var_22_0] then
				return
			end

			var_21_1 = true
			unpack = var_3

			local var_22_1, var_22_2 = var_3(arg_20_0.hxMatDict[var_22_0])
			local var_22_3 = var_22_1
			local var_22_4 = var_22_1.LoadAssetSync
			local var_22_5 = var_22_2

			typeof = var_3_10008
			Material = var_3_10009

			local var_22_6

			var_22_6[arg_22_0], var_22_6 = var_22_4(var_22_3, var_22_5, var_3_10008(var_3_10009), false, false), var_21_0
			warning = var_22_6

			var_22_6("Replace HX Material", arg_20_0.hxMatDict[var_22_0][2])

			return
		end)

		if var_21_1 then
			arg_21_1.sharedMaterials = var_21_0
		end

		return
	end)

	return
end

function var_0_1.OnAnimationEvent(arg_23_0, arg_23_1)
	if arg_23_1.animatorClipInfo.weight < 0.5 then
		return
	end

	local var_23_0 = arg_23_1.stringParameter

	table = var_1_10005

	local var_23_1 = var_1_10005.removebykey(arg_23_0.animEventCallbacks, var_23_0)

	existCall = var_6

	var_6(var_23_1)

	return
end

function var_0_1.init(arg_24_0)
	arg_24_0:findUI()
	arg_24_0:addListener()

	return
end

function var_0_1.PlaySingleAction(arg_25_0, arg_25_1, arg_25_2)
	string = var_1_10003

	local var_25_0 = var_1_10003.find(arg_25_1, "^Face_")

	tobool = var_4

	if var_4(var_25_0) then
		arg_25_0:PlayFaceAnim(arg_25_1, arg_25_2)

		return
	end

	local var_25_1

	if not arg_25_0.animNameMap then
		var_25_1 = {}
	end

	arg_25_0.animNameMap = var_25_1
	arg_25_0.animNameMap[arg_25_0.ladyAnimator.StringToHash(arg_25_1)] = arg_25_1

	local var_25_2 = {}
	local var_25_3 = arg_25_0.ladyAnimator
	local var_25_4 = var_6.GetCurrentAnimatorStateInfo(var_25_3, arg_25_0.ladyAnimBaseLayerIndex)

	if not var_6.IsName(var_25_4, arg_25_1) then
		table = var_6

		var_6.insert(var_25_2, function(arg_26_0)
			arg_25_0.nowState = arg_25_1
			arg_25_0.stateCallback = arg_26_0

			local var_26_0 = arg_25_0.ladyAnimator

			var_1.CrossFadeInFixedTime(var_26_0, arg_25_1, 0.25, arg_25_0.ladyAnimBaseLayerIndex)

			return
		end)

		table = var_6

		var_6.insert(var_25_2, function(arg_27_0)
			arg_25_0.nowState = nil
			arg_25_0.stateCallback = nil

			arg_27_0()

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_25_2, arg_25_2)

	return
end

function var_0_1.SwitchAnim(arg_28_0, arg_28_1, arg_28_2)
	string = var_1_10003

	local var_28_0 = var_1_10003.find(arg_28_1, "^Face_")

	tobool = var_4

	if var_4(var_28_0) then
		arg_28_0:PlayFaceAnim(arg_28_1, arg_28_2)

		return
	end

	local var_28_1

	if not arg_28_0.animNameMap then
		var_28_1 = {}
	end

	arg_28_0.animNameMap = var_28_1
	arg_28_0.animNameMap[arg_28_0.ladyAnimator.StringToHash(arg_28_1)] = arg_28_1

	local var_28_2 = {}

	table = var_6

	var_6.insert(var_28_2, function(arg_29_0)
		arg_28_0.nowState = arg_28_1
		arg_28_0.stateCallback = arg_29_0

		local var_29_0 = arg_28_0.ladyAnimator

		var_1.PlayInFixedTime(var_29_0, arg_28_1, arg_28_0.ladyAnimBaseLayerIndex)

		return
	end)

	table = var_6

	var_6.insert(var_28_2, function(arg_30_0)
		arg_28_0.nowState = nil
		arg_28_0.stateCallback = nil

		arg_30_0()

		return
	end)

	seriesAsync = var_6

	var_6(var_28_2, arg_28_2)

	return
end

function var_0_1.PlayFaceAnim(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.ladyAnimator

	var_3.CrossFadeInFixedTime(var_31_0, arg_31_1, 0.2, arg_31_0.ladyAnimFaceLayerIndex)

	existCall = var_3

	var_3(arg_31_2)

	return
end

function var_0_1.SetARUIActive(arg_32_0, arg_32_1)
	setActive = var_1_10002

	var_1_10002(arg_32_0.backBtn, arg_32_1)

	setActive = var_1_10002

	var_1_10002(arg_32_0.menuListTF, arg_32_1)

	setActive = var_1_10002

	var_1_10002(arg_32_0.tipTextTF, arg_32_1)

	return
end

function var_0_1.SetARUIActiveWhenInit(arg_33_0, arg_33_1)
	setActive = var_1_10002

	var_1_10002(arg_33_0.resetBtn, false)

	return
end

function var_0_1.ResetCharPos(arg_34_0)
	if arg_34_0.ARCheck then
		local var_34_0 = arg_34_0.lady

		Vector3 = var_1_10002
		var_34_0.localPosition = var_1_10002.zero

		local var_34_1 = arg_34_0.lady

		Vector3 = var_1_10002
		var_34_1.localRotation = var_1_10002(0, 180, 0)
	else
		local var_34_2 = arg_34_0.lady

		Vector3 = var_1_10002
		var_34_2.localPosition = var_1_10002(0, 0, 2)

		local var_34_3 = arg_34_0.lady

		Vector3 = var_2
		var_34_3.localRotation = var_2(0, 180, 0)
	end

	return
end

function var_0_1.didEnter(arg_35_0)
	local var_35_0 = arg_35_0
	local var_35_1 = arg_35_0.emit

	Dorm3dARMediator = var_1_10003

	var_35_1(var_35_0, var_1_10003.IN_ITAR_PHOTO)

	return
end

function var_0_1.SetARLite(arg_36_0, arg_36_1)
	arg_36_0.ARState = arg_36_1
	table = var_1_10002
	arg_36_0.ARCheck = var_1_10002.contains(var_0_1.AR_PASS_CODE, arg_36_1)
	GraphApiHelper = var_2

	if var_2.IsUsingVulkan() then
		arg_36_0.ARCheck = false
		warning = var_2

		var_2("ar not allow on vulkan.")
	end

	return
end

function var_0_1.InitARPlane(arg_37_0)
	arg_37_0._initState = true

	if arg_37_0.lady then
		setActive = var_1

		var_1(arg_37_0.lady, false)
	end

	arg_37_0:SetARUIActiveWhenInit(false)

	GameObject = var_1

	local var_37_0 = var_1.Find("AR")

	SetActive = var_2

	var_2(var_37_0, arg_37_0.ARCheck)

	GameObject = var_2

	local var_37_1 = var_2.Find("FakeAR")

	SetActive = var_3

	var_3(var_37_1, not arg_37_0.ARCheck)

	local var_37_2, var_37_3

	if arg_37_0.ARCheck then
		originalPrint = var_37_3

		var_37_3("AR CHECK SUCCESS, INIT AR")

		var_37_2 = arg_37_0.aiHelperSC

		var_37_3.Init(var_37_2)

		var_37_2 = arg_37_0
		var_37_3 = arg_37_0.emit
		Dorm3dARMediator = var_5

		var_37_3(var_37_2, var_5.INIT_AR_PLANE)
	else
		originalPrint = var_37_3

		var_37_3("AR CHECK FAIL")

		var_37_2 = arg_37_0

		arg_37_0.InitARFinish(var_37_2)

		var_37_2 = arg_37_0

		arg_37_0.EnabledDrag(var_37_2)
	end

	PLATFORM = var_37_3
	PLATFORM_WINDOWSEDITOR = var_37_2

	if var_37_3 == var_37_2 then
		arg_37_0:InitARFinish()
	end

	return
end

function var_0_1.Reset(arg_38_0)
	arg_38_0._initState = true

	if arg_38_0.lady then
		setActive = var_1

		var_1(arg_38_0.lady, false)
	end

	arg_38_0:SetARUIActiveWhenInit(false)

	if arg_38_0.ARCheck then
		local var_38_0 = arg_38_0.aiHelperSC

		var_1.ResetAll(var_38_0)
	end

	return
end

function var_0_1.InitARFinish(arg_39_0)
	setActive = var_1_10001

	var_1_10001(arg_39_0.tipsLabel, false)

	local var_39_0 = arg_39_0
	local var_39_1 = arg_39_0.emit

	Dorm3dARMediator = var_3

	var_39_1(var_39_0, var_3.AR_INIT_FINISH)
	arg_39_0:InitCharacter(arg_39_0.contextData.groupId)

	if arg_39_0.ARCheck then
		GameObject = var_1

		local var_39_2 = var_1.Find("Tpl(Clone)").transform
		local var_39_3 = arg_39_0.lady

		var_2.SetParent(var_39_3, var_39_2)
	else
		local var_39_4 = arg_39_0.lady

		var_1.SetParent(var_39_4, arg_39_0.tpl)
	end

	arg_39_0:ResetCharPos()
	arg_39_0:SetARUIActiveWhenInit(true)

	arg_39_0._initState = false

	return
end

function var_0_1.willExit(arg_40_0)
	local var_40_0 = arg_40_0.loader

	var_1.Clear(var_40_0)

	if arg_40_0.ARCheck then
		local var_40_1 = arg_40_0.aiHelperSC

		var_1.ResetAll(var_40_1)

		local var_40_2 = arg_40_0.aiHelperSC

		var_1.Destroy(var_40_2)
	end

	GameObject = var_1

	if var_1.Find("Tpl(Clone)") then
		Destroy = var_2

		var_2(var_1)
	end

	unpack = var_2
	string = var_1_10003

	local var_40_3, var_40_4 = var_2(var_1_10003.split(var_0_2, "|"))

	SceneOpMgr = var_4

	local var_40_5 = var_4.Inst
	local var_40_6 = var_4.UnloadSceneAsync

	string = var_1_10006

	var_40_6(var_40_5, var_1_10006.lower("dorm3d/scenesres/scenes/" .. var_40_4 .. "/" .. var_40_3 .. "_scene"), var_40_3)

	if arg_40_0.luHandle then
		LateUpdateBeat = var_4

		var_4:RemoveListener(arg_40_0.luHandle)
	end

	return
end

function var_0_1.findUI(arg_41_0)
	local var_41_0 = arg_41_0._tf

	arg_41_0.backBtn = var_1.Find(var_41_0, "BackBtn")

	local var_41_1 = arg_41_0._tf

	arg_41_0.menuListTF = var_1.Find(var_41_1, "MenuList")

	local var_41_2 = arg_41_0.menuListTF

	arg_41_0.initARBtn = var_1.Find(var_41_2, "InitARBtn")

	local var_41_3 = arg_41_0.menuListTF

	arg_41_0.resetBtn = var_1.Find(var_41_3, "ResetBtn")

	local var_41_4 = arg_41_0._tf

	arg_41_0.tipTextTF = var_1.Find(var_41_4, "TipText")

	local var_41_5 = arg_41_0.tipTextTF

	arg_41_0.tipsLabel = var_1.Find(var_41_5, "tipsText")

	local var_41_6 = arg_41_0.tipTextTF

	arg_41_0.tipsText = var_1.Find(var_41_6, "tipsText/text")
	setActive = var_1

	var_1(arg_41_0.tipsLabel, false)

	GameObject = var_1
	arg_41_0.fakeARCanvas = var_1.Find("FakeAR/Main Camera/ARCanvas").transform
	setSizeDelta = var_1

	local var_41_7 = arg_41_0.fakeARCanvas

	Vector2 = var_3
	Screen = var_1_10004

	local var_41_8 = var_1_10004.width

	Screen = var_1_10005

	var_1(var_41_7, var_3(var_41_8, var_1_10005.height))

	GameObject = var_1

	local var_41_9 = var_1.Find("FakeAR/Main Camera")

	arg_41_0.fakeARCamera = var_1.GetComponent(var_41_9, "Camera")

	local var_41_10 = arg_41_0._tf

	arg_41_0.drag = var_1.Find(var_41_10, "drag")
	GameObject = var_1

	local var_41_11 = var_1.Find("ARScriptHandle")

	GetComponent = var_2
	arg_41_0.aiHelperSC = var_2(var_41_11, "ARHelper")

	local var_41_12 = arg_41_0.aiHelperSC

	GameObject = var_3
	var_41_12.tplPrefab = var_3.Find("Tpl")
	GameObject = var_41_12
	arg_41_0.tpl = var_41_12.Find("Tpl").transform

	local var_41_13 = arg_41_0._tf

	arg_41_0.holyLightRoot = var_2.Find(var_41_13, "HolyLightRoot")

	return
end

function var_0_1.addListener(arg_42_0)
	onButton = var_1_10001

	local var_42_0 = arg_42_0
	local var_42_1 = arg_42_0.backBtn

	local function var_42_2()
		local var_43_0 = arg_42_0

		var_0.closeView(var_43_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_42_0, var_42_1, var_42_2, var_1_10005)

	onButton = var_1_10001

	local var_42_3 = arg_42_0
	local var_42_4 = arg_42_0.resetBtn

	local function var_42_5()
		local var_44_0 = arg_42_0

		var_0.Reset(var_44_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_42_3, var_42_4, var_42_5, var_1_10005)

	function arg_42_0.aiHelperSC.planeCountCB(arg_45_0, arg_45_1)
		if not (arg_45_0 > 0) then
			setActive = var_2_10003

			var_2_10003(arg_42_0.tipsLabel, true)

			setText = var_2_10003

			local var_45_0 = arg_42_0.tipsText

			i18n = var_5

			var_2_10003(var_45_0, var_5("AR_plane_check"))
		elseif not arg_45_1 then
			setActive = var_2_10003

			var_2_10003(arg_42_0.tipsLabel, true)

			setText = var_2_10003

			local var_45_1 = arg_42_0.tipsText

			i18n = var_5

			var_2_10003(var_45_1, var_5("AR_plane_long_press_to_summon"))
		elseif arg_42_0._initState then
			local var_45_2 = arg_42_0

			var_3.InitARFinish(var_45_2)
		end

		return
	end

	function arg_42_0.aiHelperSC.distanceCB(arg_46_0)
		if arg_46_0 < 0.3 then
			local var_46_0 = arg_42_0

			var_46_0.distanceFlag = true
			setActive = var_46_0

			var_46_0(arg_42_0.lady, false)

			setActive = var_46_0

			var_46_0(arg_42_0.tipsLabel, true)

			setText = var_46_0

			local var_46_1 = arg_42_0.tipsText

			i18n = var_3

			var_46_0(var_46_1, var_3("AR_plane_distance_near"))
		elseif arg_42_0.distanceFlag then
			setActive = var_1

			var_1(arg_42_0.tipsLabel, false)

			setActive = var_1

			var_1(arg_42_0.lady, true)

			arg_42_0.distanceFlag = false
		end

		return
	end

	function arg_42_0.aiHelperSC.insPrefabFailCB()
		warning = var_2_10000

		var_2_10000("距离过近，呼出角色失败")

		pg = var_2_10000

		local var_47_0 = var_2_10000.TipsMgr.GetInstance()
		local var_47_1 = var_0.ShowTips

		i18n = var_2_10002

		var_47_1(var_47_0, var_2_10002("AR_plane_summon_fail_by_near"))

		return
	end

	function arg_42_0.aiHelperSC.insPrefabSuccCB()
		setActive = var_2_10000

		var_2_10000(arg_42_0.tipsLabel, false)

		pg = var_2_10000

		local var_48_0 = var_2_10000.TipsMgr.GetInstance()
		local var_48_1 = var_0.ShowTips

		i18n = var_2

		var_48_1(var_48_0, var_2("AR_plane_summon_success"))

		local var_48_2 = arg_42_0.aiHelperSC

		var_0.StopPlaneCheck(var_48_2)

		return
	end

	return
end

function var_0_1.EnabledDrag(arg_49_0)
	local var_49_0 = arg_49_0.lady

	Vector3 = var_1_10002
	var_49_0.localScale = var_1_10002(5, 5, 5)
	LuaHelper = var_49_0

	local var_49_1 = var_49_0.GetWorldCorners
	local var_49_2 = arg_49_0._tf
	local var_49_3 = var_49_1(var_2.GetComponent(var_49_2, "RectTransform"))[2].x - var_1[0].x
	local var_49_4 = var_1[2].y - var_1[0].y

	pg = var_4
	arg_49_0.widthRate = var_49_3 / var_4.CameraFixMgr.GetInstance().actualWidth
	pg = var_4
	arg_49_0.heightRate = var_49_4 / var_4.CameraFixMgr.GetInstance().actualHeight
	arg_49_0.halfWidth = var_49_3 / 2
	arg_49_0.halfHeight = var_49_4 / 2
	arg_49_0.isEnableDrag = true

	local var_49_5 = arg_49_0.drag.gameObject

	GetOrAddComponent = var_5

	local var_49_6 = var_49_5

	typeof = var_1_10007
	Button = var_1_10008

	var_5(var_49_6, var_1_10007(var_1_10008))

	GetOrAddComponent = var_5

	local var_49_7 = arg_49_0._tf

	typeof = var_7
	PinchZoom = var_1_10008
	arg_49_0.zoom = var_5(var_49_7, var_7(var_1_10008))

	local var_49_8 = arg_49_0.zoom

	var_49_8.enabled = true
	GetOrAddComponent = var_49_8

	local var_49_9 = var_49_5

	typeof = var_7
	EventTriggerListener = var_1_10008

	local var_49_10 = var_49_8(var_49_9, var_7(var_1_10008))

	Vector3 = var_49_9

	local var_49_11 = var_49_9(0, 0, 0)

	var_49_10:AddBeginDragFunc(function(arg_50_0, arg_50_1)
		Application = var_2_10002

		if var_2_10002.isEditor then
			Input = var_2

			if var_2.GetMouseButton(2) then
				return
			end
		end

		if arg_49_0.zoom.processing then
			return
		end

		setButtonEnabled = var_2

		var_2(var_49_5, false)

		Input = var_2

		if var_2.touchCount > 1 then
			return
		end

		local var_50_0 = var_0_1.Screen2Local(var_49_5.transform.parent, arg_50_1.position)

		var_49_11 = arg_49_0.drag.localPosition - var_50_0

		return
	end)
	var_49_10:AddDragFunc(function(arg_51_0, arg_51_1)
		Application = var_2_10002

		if var_2_10002.isEditor then
			Input = var_2

			if var_2.GetMouseButton(2) then
				return
			end
		end

		if arg_49_0.zoom.processing then
			return
		end

		Input = var_2

		if var_2.touchCount > 1 then
			return
		end

		local var_51_0 = var_0_1.Screen2Local(var_49_5.transform.parent, arg_51_1.position)
		local var_51_1 = arg_49_0.drag

		Vector3 = var_4
		var_51_1.localPosition = var_4(var_51_0.x, var_51_0.y, 0) + var_49_11

		local var_51_2 = arg_49_0.tpl
		local var_51_3 = arg_49_0

		var_51_2.localPosition = var_4.GetUI2Char(var_51_3, arg_51_1.position)

		return
	end)
	var_49_10:AddDragEndFunc(function()
		setButtonEnabled = var_2_10000

		var_2_10000(var_49_5, true)

		return
	end)

	var_49_10.enabled = true
	Input = var_7
	var_7.multiTouchEnabled = true
	arg_49_0.fakeARCamera.orthographicSize = 8

	local var_49_12 = arg_49_0.fakeARCamera

	var_49_12.orthographic = true
	LateUpdateBeat = var_49_12
	arg_49_0.luHandle = var_49_12:CreateListener(function()
		if arg_49_0.zoom.processing then
			local var_53_0 = arg_49_0.drag.localScale.x
			local var_53_1 = arg_49_0.tpl

			Vector3 = var_2_10002
			var_53_1.localScale = var_2_10002(var_53_0, var_53_0, var_53_0)
		end

		return
	end, arg_49_0)
	LateUpdateBeat = var_7

	var_7:AddListener(arg_49_0.luHandle)

	return
end

function var_0_1.GetUI2Char(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0.widthRate * arg_54_1.x - arg_54_0.halfWidth
	local var_54_1 = arg_54_0.heightRate * arg_54_1.y - arg_54_0.halfHeight

	Vector3 = var_4

	return var_4(var_54_0, var_54_1, 2)
end

function var_0_1.Screen2Local(arg_55_0, arg_55_1)
	GameObject = var_1_10002

	local var_55_0 = var_1_10002.Find("UICamera")
	local var_55_1 = var_2.GetComponent(var_55_0, "Camera")
	local var_55_2 = arg_55_0
	local var_55_3 = arg_55_0.GetComponent(var_55_2, "RectTransform")

	LuaHelper = var_55_2

	local var_55_4 = var_55_2.ScreenToLocal(var_55_3, arg_55_1, var_55_1)

	Vector3 = var_5

	return var_5(var_55_4.x, var_55_4.y, 0)
end

return var_0_1
