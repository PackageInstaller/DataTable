local Dorm3dARScene = class("Dorm3dARScene", import("view.base.BaseUI"))
local var_0_1 = "ARScene2|common/ar"

Dorm3dARScene.AR_FAIL_CODE = {
	[0] = "CheckingAvailability",
	"NeedsInstall",
	"Installing",
	-1,
	"pc editor",
	None = "Unsupported"
}
Dorm3dARScene.AR_PASS_CODE = {
	5,
	6,
	7
}

function Dorm3dARScene:getUIName()
	return "Dorm3DARUI"
end

function Dorm3dARScene:forceGC()
	return true
end

function Dorm3dARScene:loadingQueue()
	return function(arg_4_0)
		pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_5_0)
			return arg_4_0(arg_5_0)
		end)

		return
	end
end

function Dorm3dARScene:Ctor(...)
	Dorm3dARScene.super.Ctor(self, ...)

	self.loader = AutoLoader.New()

	return
end

function Dorm3dARScene:preload(arg_7_1)
	self.room = getProxy(ApartmentProxy):getRoom(self.contextData.roomId)

	local var_7_0, var_7_1 = unpack(string.split(var_0_1, "|"))

	seriesAsync({
		function(arg_8_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_7_1 .. "/" .. var_7_0 .. "_scene"), var_7_0, LoadSceneMode.Additive, function(arg_9_0, arg_9_1)
				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			self:LoadCharacter({
				self.contextData.groupId
			}, arg_10_0)

			return
		end,
		function(arg_11_0)
			local var_11_0 = GameObject.Find("FakeAR/Main Camera")
			local var_11_1 = GameObject.Find("AR/XR Origin/Camera Offset/Main Camera")

			if var_11_0 then
				originalPrint("Fix Fake AR Camera Data")
				HotfixHelper.FixARCameraData(var_11_0)
			end

			if var_11_1 then
				originalPrint("Fix True AR Camera Data")
				HotfixHelper.FixARCameraData(var_11_1)
			end

			arg_11_0()

			return
		end
	}, arg_7_1)

	return
end

function Dorm3dARScene:LoadCharacter(arg_12_1, arg_12_2)
	self.hxMatDict = {}
	self.ladyDict = {}
	self.skinDict = {}

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_1 = self

		self.ladyDict[iter_12_1] = self

		local var_12_2 = getProxy(ApartmentProxy)
		local var_12_3 = var_12_2:getApartment(iter_12_1)
		local var_12_4 = var_12_3:getConfig("asset_name")
		local var_12_5 = var_12_3:GetSkinModelID(self.room:getConfig("tag"))
		local var_12_6 = pg.dorm3d_resource[var_12_2].model_id

		assert(pg.dorm3d_resource[var_12_2].model_id)

		for iter_12_2, iter_12_3 in ipairs({
			"common",
			pg.dorm3d_resource[var_12_2].model_id
		}) do
			local var_12_7 = string.format("dorm3d/character/%s/res/%s", var_12_4, iter_12_3)

			if checkABExist(var_12_7) then
				table.insert(var_12_0, function(arg_13_0)
					self.loader:LoadBundle(var_12_7, function(arg_14_0)
						for iter_14_0, iter_14_1 in ipairs(arg_14_0:GetAllAssetNames()) do
							local var_14_0, var_14_1, var_14_2 = string.find(iter_14_1, "material_hx[/\\](.*).mat")

							if var_14_0 then
								self.hxMatDict[var_14_2] = {
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

		self.skinId = var_12_5
		self.skinIdList = {
			var_12_5
		}

		table.insert(var_12_0, function(arg_15_0)
			self.loader:GetPrefab(string.format("dorm3d/character/%s/prefabs/%s", var_12_4, var_12_6), "", function(arg_16_0)
				var_12_1.ladyGameObject = arg_16_0

				setActive(arg_16_0.transform, false)

				self.skinDict[var_12_5] = {
					ladyGameObject = arg_16_0
				}

				arg_15_0()

				return
			end)

			return
		end)
	end

	parallelAsync(var_12_0, arg_12_2)

	return
end

function Dorm3dARScene:InitCharacter(arg_17_1)
	self.lady = self.ladyGameObject.transform

	self.lady:SetParent(self.mainCameraTF)
	self.lady:SetParent(nil)
	setActive(self.lady, true)

	self.ladyAnimator = self.lady:GetComponent(typeof(Animator))
	self.ladyAnimBaseLayerIndex = self.ladyAnimator:GetLayerIndex("Base Layer")
	self.ladyAnimFaceLayerIndex = self.ladyAnimator:GetLayerIndex("Face")
	self.ladyBoneMaps = {}

	table.IpairsCArray(self.lady:GetComponentsInChildren(typeof(Transform), true), function(arg_18_0, arg_18_1)
		if arg_18_1.name == "BodyCollider" then
			self.ladyCollider = arg_18_1
		elseif arg_18_1.name == "Interest" then
			self.ladyInterestRoot = arg_18_1
		elseif arg_18_1.name == "Head Center" then
			self.ladyHeadCenter = arg_18_1
		end

		return
	end)
	self:HXCharacter(self.lady)
	self.ladyAnimator:GetComponent("DftAniEvent"):SetCommonEvent(function(arg_19_0)
		if self.nowState and arg_19_0.animatorStateInfo:IsName(self.nowState) then
			existCall(self.stateCallback)

			return
		end

		local var_19_0 = arg_19_0.animatorStateInfo

		for iter_19_0, iter_19_1 in pairs(self.animCallbacks) do
			if var_19_0:IsName(iter_19_0) then
				warning("Active", iter_19_0)
				existCall((table.removebykey(self.animCallbacks, iter_19_0)))

				return
			end
		end

		if arg_19_0.stringParameter ~= "" then
			self:OnAnimationEvent(arg_19_0)
		end

		return
	end)

	self.animEventCallbacks = {}
	self.animCallbacks = {}

	return
end

function Dorm3dARScene:HXCharacter(arg_20_1)
	if not HXSet.isHx() then
		return
	end

	Dorm3dHxHelper.ShowHolyLight({
		arg_20_1
	}, self.holyLightRoot)

	if Dorm3dHxHelper.ReplaceCharacterParts(arg_20_1) then
		return
	end

	table.IpairsCArray(arg_20_1:GetComponentsInChildren(typeof(SkinnedMeshRenderer)), function(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_1.sharedMaterials
		local var_21_1 = false

		table.IpairsCArray(arg_21_1.sharedMaterials, function(arg_22_0, arg_22_1)
			if not self.hxMatDict[arg_22_1.name] then
				return
			end

			var_21_1 = true

			local var_22_0, var_22_1 = unpack(self.hxMatDict[arg_22_1.name])

			var_21_0[arg_22_0] = var_22_0:LoadAssetSync(var_22_1, typeof(Material), false, false)

			warning("Replace HX Material", self.hxMatDict[arg_22_1.name][2])

			return
		end)

		return
	end)

	return
end

function Dorm3dARScene:OnAnimationEvent(arg_23_1)
	if arg_23_1.animatorClipInfo.weight < 0.5 then
		return
	end

	existCall((table.removebykey(self.animEventCallbacks, arg_23_1.stringParameter)))

	return
end

function Dorm3dARScene:init()
	self:findUI()
	self:addListener()

	return
end

function Dorm3dARScene:PlaySingleAction(arg_25_1, arg_25_2)
	if tobool((string.find(arg_25_1, "^Face_"))) then
		self:PlayFaceAnim(arg_25_1, arg_25_2)

		return
	end

	self.animNameMap = self.animNameMap or {}
	self.animNameMap[self.ladyAnimator.StringToHash(arg_25_1)] = arg_25_1

	local var_25_0 = {}

	if not self.ladyAnimator:GetCurrentAnimatorStateInfo(self.ladyAnimBaseLayerIndex):IsName(arg_25_1) then
		table.insert(var_25_0, function(arg_26_0)
			self.nowState = arg_25_1
			self.stateCallback = arg_26_0

			self.ladyAnimator:CrossFadeInFixedTime(arg_25_1, 0.25, self.ladyAnimBaseLayerIndex)

			return
		end)
		table.insert(var_25_0, function(arg_27_0)
			self.nowState = nil
			self.stateCallback = nil

			arg_27_0()

			return
		end)
	end

	seriesAsync(var_25_0, arg_25_2)

	return
end

function Dorm3dARScene:SwitchAnim(arg_28_1, arg_28_2)
	if tobool((string.find(arg_28_1, "^Face_"))) then
		self:PlayFaceAnim(arg_28_1, arg_28_2)

		return
	end

	self.animNameMap = self.animNameMap or {}
	self.animNameMap[self.ladyAnimator.StringToHash(arg_28_1)] = arg_28_1

	local var_28_0 = {}

	table.insert(var_28_0, function(arg_29_0)
		self.nowState = arg_28_1
		self.stateCallback = arg_29_0

		self.ladyAnimator:PlayInFixedTime(arg_28_1, self.ladyAnimBaseLayerIndex)

		return
	end)
	table.insert(var_28_0, function(arg_30_0)
		self.nowState = nil
		self.stateCallback = nil

		arg_30_0()

		return
	end)
	seriesAsync(var_28_0, arg_28_2)

	return
end

function Dorm3dARScene:PlayFaceAnim(arg_31_1, arg_31_2)
	self.ladyAnimator:CrossFadeInFixedTime(arg_31_1, 0.2, self.ladyAnimFaceLayerIndex)
	existCall(arg_31_2)

	return
end

function Dorm3dARScene:SetARUIActive(arg_32_1)
	setActive(self.backBtn, arg_32_1)
	setActive(self.menuListTF, arg_32_1)
	setActive(self.tipTextTF, arg_32_1)

	return
end

function Dorm3dARScene:SetARUIActiveWhenInit(arg_33_1)
	setActive(self.resetBtn, false)

	return
end

function Dorm3dARScene:ResetCharPos()
	if self.ARCheck then
		self.lady.localPosition = Vector3.zero
		self.lady.localRotation = Vector3(0, 180, 0)
	else
		self.lady.localPosition = Vector3(0, 0, 2)
		self.lady.localRotation = Vector3(0, 180, 0)
	end

	return
end

function Dorm3dARScene:didEnter()
	self:emit(Dorm3dARMediator.IN_ITAR_PHOTO)

	return
end

function Dorm3dARScene:SetARLite(arg_36_1)
	self.ARState = arg_36_1
	self.ARCheck = table.contains(Dorm3dARScene.AR_PASS_CODE, arg_36_1)

	if GraphApiHelper.IsUsingVulkan() then
		self.ARCheck = false

		warning("ar not allow on vulkan.")
	end

	return
end

function Dorm3dARScene:InitARPlane()
	self._initState = true

	if self.lady then
		setActive(self.lady, false)
	end

	self:SetARUIActiveWhenInit(false)
	SetActive(GameObject.Find("AR"), self.ARCheck)
	SetActive(GameObject.Find("FakeAR"), not self.ARCheck)

	if self.ARCheck then
		originalPrint("AR CHECK SUCCESS, INIT AR")
		self.aiHelperSC:Init()
		self:emit(Dorm3dARMediator.INIT_AR_PLANE)
	else
		originalPrint("AR CHECK FAIL")
		self:InitARFinish()
		self:EnabledDrag()
	end

	if PLATFORM == PLATFORM_WINDOWSEDITOR then
		self:InitARFinish()
	end

	return
end

function Dorm3dARScene:Reset()
	self._initState = true

	if self.lady then
		setActive(self.lady, false)
	end

	self:SetARUIActiveWhenInit(false)

	if self.ARCheck then
		self.aiHelperSC:ResetAll()
	end

	return
end

function Dorm3dARScene:InitARFinish()
	setActive(self.tipsLabel, false)
	self:emit(Dorm3dARMediator.AR_INIT_FINISH)
	self:InitCharacter(self.contextData.groupId)

	if self.ARCheck then
		self.lady:SetParent(GameObject.Find("Tpl(Clone)").transform)
	else
		self.lady:SetParent(self.tpl)
	end

	self:ResetCharPos()
	self:SetARUIActiveWhenInit(true)

	self._initState = false

	return
end

function Dorm3dARScene:willExit()
	self.loader:Clear()

	if self.ARCheck then
		self.aiHelperSC:ResetAll()
		self.aiHelperSC:Destroy()
	end

	local var_40_0 = GameObject.Find("Tpl(Clone)")

	if var_40_0 then
		Destroy(var_40_0)
	end

	local var_40_1, var_40_2 = unpack(string.split(var_0_1, "|"))

	SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_40_2 .. "/" .. var_40_1 .. "_scene"), var_40_1)

	if self.luHandle then
		LateUpdateBeat:RemoveListener(self.luHandle)
	end

	return
end

function Dorm3dARScene:findUI()
	self.backBtn = self._tf:Find("BackBtn")
	self.menuListTF = self._tf:Find("MenuList")
	self.initARBtn = self.menuListTF:Find("InitARBtn")
	self.resetBtn = self.menuListTF:Find("ResetBtn")
	self.tipTextTF = self._tf:Find("TipText")
	self.tipsLabel = self.tipTextTF:Find("tipsText")
	self.tipsText = self.tipTextTF:Find("tipsText/text")

	setActive(self.tipsLabel, false)

	self.fakeARCanvas = GameObject.Find("FakeAR/Main Camera/ARCanvas").transform

	setSizeDelta(self.fakeARCanvas, Vector2(Screen.width, Screen.height))

	self.fakeARCamera = GameObject.Find("FakeAR/Main Camera"):GetComponent("Camera")
	self.drag = self._tf:Find("drag")
	self.aiHelperSC = GetComponent(GameObject.Find("ARScriptHandle"), "ARHelper")
	self.aiHelperSC.tplPrefab = GameObject.Find("Tpl")
	self.tpl = GameObject.Find("Tpl").transform
	self.holyLightRoot = self._tf:Find("HolyLightRoot")

	return
end

function Dorm3dARScene:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.resetBtn, function()
		self:Reset()

		return
	end, SFX_PANEL)

	function self.aiHelperSC.planeCountCB(arg_45_0, arg_45_1)
		if arg_45_0 <= 0 then
			setActive(self.tipsLabel, true)
			setText(self.tipsText, i18n("AR_plane_check"))
		elseif not arg_45_1 then
			setActive(self.tipsLabel, true)
			setText(self.tipsText, i18n("AR_plane_long_press_to_summon"))
		elseif self._initState then
			self:InitARFinish()
		end

		return
	end

	function self.aiHelperSC.distanceCB(arg_46_0)
		if arg_46_0 < 0.3 then
			self.distanceFlag = true

			setActive(self.lady, false)
			setActive(self.tipsLabel, true)
			setText(self.tipsText, i18n("AR_plane_distance_near"))
		elseif self.distanceFlag then
			setActive(self.tipsLabel, false)
			setActive(self.lady, true)

			self.distanceFlag = false
		end

		return
	end

	function self.aiHelperSC.insPrefabFailCB()
		warning("距离过近，呼出角色失败")
		pg.TipsMgr.GetInstance():ShowTips(i18n("AR_plane_summon_fail_by_near"))

		return
	end

	function self.aiHelperSC.insPrefabSuccCB()
		setActive(self.tipsLabel, false)
		pg.TipsMgr.GetInstance():ShowTips(i18n("AR_plane_summon_success"))
		self.aiHelperSC:StopPlaneCheck()

		return
	end

	return
end

function Dorm3dARScene:EnabledDrag()
	self.lady.localScale = Vector3(5, 5, 5)

	local var_49_0 = LuaHelper.GetWorldCorners(self._tf:GetComponent("RectTransform"))

	self.widthRate = (var_49_0[2].x - var_49_0[0].x) / pg.CameraFixMgr.GetInstance().actualWidth
	self.heightRate = (var_49_0[2].y - var_49_0[0].y) / pg.CameraFixMgr.GetInstance().actualHeight
	self.halfWidth = (var_49_0[2].x - var_49_0[0].x) / 2
	self.halfHeight = (var_49_0[2].y - var_49_0[0].y) / 2
	self.isEnableDrag = true

	local var_49_1 = self.drag.gameObject

	GetOrAddComponent(self.drag.gameObject, typeof(Button))

	self.zoom = GetOrAddComponent(self._tf, typeof(PinchZoom))
	self.zoom.enabled = true

	local var_49_2 = GetOrAddComponent(self.drag.gameObject, typeof(EventTriggerListener))
	local var_49_3 = Vector3(0, 0, 0)

	var_49_2:AddBeginDragFunc(function(arg_50_0, arg_50_1)
		if Application.isEditor and Input.GetMouseButton(2) then
			return
		end

		if self.zoom.processing then
			return
		end

		setButtonEnabled(var_49_1, false)

		if Input.touchCount > 1 then
			return
		end

		var_49_3 = self.drag.localPosition - Dorm3dARScene.Screen2Local(var_49_1.transform.parent, arg_50_1.position)

		return
	end)
	var_49_2:AddDragFunc(function(arg_51_0, arg_51_1)
		if Application.isEditor and Input.GetMouseButton(2) then
			return
		end

		if self.zoom.processing then
			return
		end

		if Input.touchCount > 1 then
			return
		end

		local var_51_0 = Dorm3dARScene.Screen2Local(var_49_1.transform.parent, arg_51_1.position)

		self.drag.localPosition = Vector3(var_51_0.x, var_51_0.y, 0) + var_49_3
		self.tpl.localPosition = self:GetUI2Char(arg_51_1.position)

		return
	end)
	var_49_2:AddDragEndFunc(function()
		setButtonEnabled(var_49_1, true)

		return
	end)

	var_49_2.enabled = true
	Input.multiTouchEnabled = true
	self.fakeARCamera.orthographicSize = 8
	self.fakeARCamera.orthographic = true
	self.luHandle = LateUpdateBeat:CreateListener(function()
		if self.zoom.processing then
			self.tpl.localScale = Vector3(self.drag.localScale.x, self.drag.localScale.x, self.drag.localScale.x)
		end

		return
	end, self)

	LateUpdateBeat:AddListener(self.luHandle)

	return
end

function Dorm3dARScene:GetUI2Char(arg_54_1)
	return Vector3(self.widthRate * arg_54_1.x - self.halfWidth, self.heightRate * arg_54_1.y - self.halfHeight, 2)
end

function Dorm3dARScene:Screen2Local(arg_55_1)
	local var_55_0 = GameObject.Find("UICamera")

	return Vector3(var_55_0.x, LuaHelper.ScreenToLocal(self:GetComponent("RectTransform"), arg_55_1, (var_55_0:GetComponent("Camera"))).y, 0)
end

return Dorm3dARScene
