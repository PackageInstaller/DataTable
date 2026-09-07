local Dorm3dRoomTemplateScene = class("Dorm3dRoomTemplateScene", import("view.dorm3d.Core.Dorm3dBaseScene"))

Dorm3dRoomTemplateScene.CAMERA = {
	GIFT = 8,
	PHOTO_FREE = 11,
	FURNITURE_WATCH = 7,
	PHOTO = 10,
	AIM2 = 2,
	TALK = 4,
	POV = 12,
	IK_WATCH = 13,
	CUSTOM = 15,
	ROLE2 = 9,
	ROLE = 3,
	SKIN = 14,
	AIM = 1
}
Dorm3dRoomTemplateScene.CAMERA_MAX_OPERATION = {
	RIGHT = "right",
	DOWN = "donw",
	ZOOMIN = "zoom_in",
	ZOOMOUT = "zoom_out",
	UP = "up",
	LEFT = "left"
}
Dorm3dRoomTemplateScene.ANIM = {
	IDLE = "Idle"
}
Dorm3dRoomTemplateScene.PLAY_EXPRESSION = "Dorm3dRoomTemplateScene.PLAY_EXPRESSION"
Dorm3dRoomTemplateScene.MOVE_PLAYER_TO_FURNITURE = "Dorm3dRoomTemplateScene.MOVE_PLAYER_TO_FURNITURE"
Dorm3dRoomTemplateScene.SHOW_BLOCK = "Dorm3dRoomTemplateScene.SHOW_BLOCK"
Dorm3dRoomTemplateScene.HIDE_BLOCK = "Dorm3dRoomTemplateScene.HIDE_BLOCK"
Dorm3dRoomTemplateScene.ON_ROLEWATCH_CAMERA_MAX = "Dorm3dRoomTemplateScene.ON_ROLEWATCH_CAMERA_MAX"
Dorm3dRoomTemplateScene.ON_STICK_MOVE = "Dorm3dRoomTemplateScene.ON_STICK_MOVE"
Dorm3dRoomTemplateScene.ENABLE_SCENEBLOCK = "Dorm3dRoomTemplateScene.ENABLE_SCENEBLOCK"
Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_BEGIN = "Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_BEGIN"
Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE = "Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE"
Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_END = "Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_END"
Dorm3dRoomTemplateScene.ON_POV_STICK_VIEW = "Dorm3dRoomTemplateScene.ON_POV_STICK_VIEW"
Dorm3dRoomTemplateScene.ON_ENTER_SECTOR = "Dorm3dRoomTemplateScene.ON_ENTER_SECTOR"
Dorm3dRoomTemplateScene.ON_CHANGE_DISTANCE = "Dorm3dRoomTemplateScene.ON_CHANGE_DISTANCE"
Dorm3dRoomTemplateScene.CLICK_CHARACTER = "Dorm3dRoomTemplateScene.CLICK_CHARACTER"
Dorm3dRoomTemplateScene.CLICK_CONTACT = "Dorm3dRoomTemplateScene.CLICK_CONTACT"
Dorm3dRoomTemplateScene.DISTANCE_TRIGGER = "Dorm3dRoomTemplateScene.DISTANCE_TRIGGER"
Dorm3dRoomTemplateScene.WALK_DISTANCE_TRIGGER = "Dorm3dRoomTemplateScene.WALK_DISTANCE_TRIGGER"
Dorm3dRoomTemplateScene.CHANGE_WATCH = "Dorm3dRoomTemplateScene.CHANGE_WATCH"
Dorm3dRoomTemplateScene.PHOTO_CALL = "Dorm3dRoomTemplateScene.PHOTO_CALL"
Dorm3dRoomTemplateScene.SHIFT_ZONE_SAFE = "Dorm3dRoomTemplateScene.SHIFT_ZONE_SAFE"
Dorm3dRoomTemplateScene.TIMELINE_END = "Dorm3dRoomTemplateScene.TIMELINE_END"
Dorm3dRoomTemplateScene.TRIGGER_TIMELINE_PLAYER_EVENT = "Dorm3dRoomTemplateScene.TRIGGER_TIMELINE_PLAYER_EVENT"
Dorm3dRoomTemplateScene.POV_CLOSE_DISTANCE = 1.5
Dorm3dRoomTemplateScene.POV_PENDING_CLOSE_DISTANCE = 2

function Dorm3dRoomTemplateScene:getUIName()
	return nil
end

function Dorm3dRoomTemplateScene:forceGC()
	return true
end

function Dorm3dRoomTemplateScene:loadingQueue()
	return function(arg_4_0)
		pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_5_0)
			return arg_4_0(arg_5_0)
		end)

		return
	end
end

function Dorm3dRoomTemplateScene:getBGM()
	if pg.dorm3d_rooms[self.contextData.roomId].room_bgm and pg.dorm3d_rooms[self.contextData.roomId].room_bgm ~= "" then
		return pg.dorm3d_rooms[self.contextData.roomId].room_bgm
	else
		return Dorm3dRoomTemplateScene.super.getBGM(self)
	end

	return
end

function Dorm3dRoomTemplateScene:Ctor(...)
	Dorm3dRoomTemplateScene.super.Ctor(self, ...)

	self.loader = AutoLoader.New()
	self.scene = self

	return
end

function Dorm3dRoomTemplateScene:SetRoom(arg_8_1)
	self.room = arg_8_1

	return
end

function Dorm3dRoomTemplateScene:preload(arg_9_1)
	tolua.loadassembly("MagicaClothV2")
	tolua.loadassembly("ParadoxNotion")
	tolua.loadassembly("Yongshi.BLRP.Runtime")

	for iter_9_0, iter_9_1 in pairs({
		_MonoManager = "ParadoxNotion.Services.MonoManager"
	}) do
		if not GameObject.Find(iter_9_0) then
			GetOrAddComponent(GameObject.New(iter_9_0), typeof(iter_9_1))
		end
	end

	self.room = getProxy(ApartmentProxy):getRoom(self.contextData.roomId)

	local var_9_0 = {}

	table.insert(var_9_0, function(arg_10_0)
		self.dormSceneMgr = Dorm3dSceneMgr.New(self.room:getConfig("scene_info"), arg_10_0)

		return
	end)
	table.insert(var_9_0, function(arg_11_0)
		self:LoadCharacter(self.contextData.groupIds, arg_11_0)

		return
	end)
	seriesAsync(var_9_0, arg_9_1)

	return
end

function Dorm3dRoomTemplateScene:init()
	self:BindEvent()
	self:InitData()
	self:initScene()
	self:initNodeCanvas()

	if self.room:isPersonalRoom() then
		local var_12_0 = getProxy(ApartmentProxy):getApartment(self.contextData.groupIds[1]):GetCurSkinId()

		setActive(self.ladyDict[self.contextData.groupIds[1]].ladyGameObject, false)

		self.ladyDict[self.contextData.groupIds[1]].skinId = var_12_0
		self.ladyDict[self.contextData.groupIds[1]].ladyGameObject = self.skinDict[var_12_0].ladyGameObject

		setActive(self.ladyDict[self.contextData.groupIds[1]].ladyGameObject, true)
	end

	for iter_12_0, iter_12_1 in pairs(self.ladyDict) do
		self:InitCharacter(iter_12_1, iter_12_0)
	end

	if not self.room:isPersonalRoom() then
		local var_12_1 = underscore.detect(self.contextData.groupIds, function(arg_13_0)
			return self.contextData.ladyZone[arg_13_0] == self.contextData.inFurnitureName
		end) or self.contextData.groupIds[1]

		if var_12_1 then
			self:SyncInterestTransform(self.ladyDict[var_12_1])
		end

		if SlideExtraSystem.IsOpen(self.room) and self.contextData.inFurnitureName == SlideConst.SLIDE_ZONE then
			self:SyncInterestTransformByTf(self:GetFurnitureByName(self.contextData.inFurnitureName):Find("StayPoint"))
		end
	end

	self.retainCount = 0
	self.sceneBlockLayer = self._tf:Find("SceneBlock")

	setActive(self.sceneBlockLayer, false)

	self.blockLayer = self._tf:Find("Block")

	setActive(self.blockLayer, false)

	self.blackLayer = self._tf:Find("BlackScreen")

	setActive(self.blackLayer, false)

	self.holyLightRoot = self._tf:Find("HolyLightRoot")

	self:InitHolyLight()
	self:ChangePlayerPosition()

	self.cacheSceneDic = {}
	self.sceneGroupDic = {}
	self.lastSceneRootDict = {}

	pg.ClickEffectMgr.GetInstance():SetClickEffect("DORM3D")

	return
end

function Dorm3dRoomTemplateScene:BindEvent()
	self:bind(Dorm3dRoomTemplateScene.PLAY_EXPRESSION, function(arg_15_0, arg_15_1)
		self:PlayExpression(arg_15_1)

		return
	end)
	self:bind(Dorm3dRoomTemplateScene.SHOW_BLOCK, function()
		self.retainCount = self.retainCount + 1

		setActive(self.blockLayer, true)

		return
	end)
	self:bind(Dorm3dRoomTemplateScene.HIDE_BLOCK, function()
		self.retainCount = math.max(self.retainCount - 1, 0)

		if self.retainCount > 0 then
			return
		end

		setActive(self.blockLayer, false)

		return
	end)
	self:bind(Dorm3dRoomTemplateScene.ENABLE_SCENEBLOCK, function(arg_18_0, arg_18_1)
		setActive(self.sceneBlockLayer, arg_18_1)

		return
	end)
	self:bind(Dorm3dRoomTemplateScene.ON_STICK_MOVE, function(arg_19_0, arg_19_1)
		self:OnStickMove(arg_19_1)

		return
	end)
	self:bind(Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_BEGIN, function(arg_20_0, arg_20_1)
		if self.pinchMode then
			return
		end

		self.moveStickOrigin = arg_20_1.position
		self.moveStickPosition = self.moveStickOrigin
		self.moveStickDraging = true

		return
	end)

	local function var_14_0()
		self.moveStickOrigin = nil
		self.moveStickPosition = nil
		self.moveStickDraging = nil

		if isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]) then
			self:emit(Dorm3dPhotoMediator.CAMERA_STICK_MOVE, Vector2.zero)
		end

		return
	end

	self:bind(Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_END, function(arg_22_0, arg_22_1)
		var_14_0()

		return
	end)
	self:bind(Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE, function(arg_23_0, arg_23_1)
		if self.pinchMode then
			var_14_0()

			return
		end

		if not self.moveStickDraging then
			return
		end

		self.moveStickPosition = self.moveStickPosition + arg_23_1

		if isActive(self.povLayer:Find("Guide")) then
			setActive(self.povLayer:Find("Guide"), false)
		end

		return
	end)

	local var_14_1 = 32.4 / Screen.height

	self:bind(Dorm3dRoomTemplateScene.ON_POV_STICK_VIEW, function(arg_24_0, arg_24_1)
		if self.pinchMode then
			return
		end

		arg_24_1 = arg_24_1 * var_14_1

		local function var_24_0(arg_25_0, arg_25_1, arg_25_2)
			arg_25_0[arg_25_1].m_InputAxisValue = arg_25_2
			arg_25_0[arg_25_1] = arg_25_0[arg_25_1]

			return
		end

		if isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV]) then
			var_24_0(self.compPovAim, "m_HorizontalAxis", arg_24_1.x)
			var_24_0(self.compPovAim, "m_VerticalAxis", arg_24_1.y)
		elseif isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]) then
			local var_24_1 = self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]:Find("PhotoFree Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)):GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim)

			var_24_0(var_24_1, "m_HorizontalAxis", arg_24_1.x)
			var_24_0(var_24_1, "m_VerticalAxis", arg_24_1.y)
		end

		return
	end)

	local var_14_2 = {
		HideSceneItem = true,
		SetExtraAnimSpeed = true,
		EnableHeadIK = true,
		ResetCharacterExtraItem = true,
		PlayEnterExtraItem = true,
		ResetTempHideSceneItems = true,
		HideCharacterBylayer = true,
		RevertCharacterBylayer = true
	}

	self:bind(Dorm3dRoomTemplateScene.PHOTO_CALL, function(arg_26_0, arg_26_1, ...)
		if var_14_2[arg_26_1] then
			self[arg_26_1](self, self:GetCurrentLadyEnv(), ...)
		else
			self[arg_26_1](self, ...)
		end

		return
	end)
	self:bind(Dorm3dRoomTemplateScene.SHIFT_ZONE_SAFE, function(arg_27_0, arg_27_1)
		self:ShiftZoneSafe(arg_27_1)

		return
	end)
	self:bind(Dorm3dRoomTemplateScene.TRIGGER_TIMELINE_PLAYER_EVENT, function(arg_28_0, arg_28_1)
		if not self.nowTimelinePlayer then
			warning("nowTimelinePlayer is nil, can't trigger event", arg_28_1)

			return
		end

		self.nowTimelinePlayer:TriggerEvent(arg_28_1)

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:initScene()
	local var_29_0, var_29_1 = unpack(string.split(self.dormSceneMgr.sceneInfo, "|"))

	self:ResetSceneStructure((SceneManager.GetSceneByName(var_29_0 .. "_base")))

	self.mainCameraTF = GameObject.Find("BackYardMainCamera").transform
	self.camBrain = self.mainCameraTF:GetComponent(typeof(Cinemachine.CinemachineBrain))
	self.camBrainEvenetHandler = self.mainCameraTF:GetComponent(typeof(CameraBrainEventsHandler))
	self.raycastCamera = self.mainCameraTF:Find("CameraForRaycast"):GetComponent(typeof(Camera))
	self.sceneRaycaster = self.raycastCamera:GetComponent(typeof(UnityEngine.EventSystems.PhysicsRaycaster))
	self.player = GameObject.Find("Player").transform
	self.playerEye = self.player:Find("Eye")
	self.playerFoot = self.player:Find("Foot")

	setActive(self.playerFoot, false)

	self.playerController = self.player:GetComponent(typeof(UnityEngine.CharacterController))
	self.attachedPoints = {}

	eachChild(self.furnitures, function(arg_30_0)
		table.insert(self.attachedPoints, 1, arg_30_0)

		return
	end)

	self.modelRoot = GameObject.Find("scene_root").transform
	self.slotRoot = GameObject.Find("FurnitureSlots").transform

	setActive(self.slotRoot, true)
	self:InitSlots()
	tolua.loadassembly("Cinemachine")

	local var_29_2 = GameObject.Find("CM Cameras").transform

	eachChild(var_29_2, function(arg_31_0)
		setActive(arg_31_0, false)

		return
	end)

	self.camBrain.enabled = false
	self.camBrain.enabled = true
	self.cameraAim = var_29_2:Find("Aim Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	self.cameraAim2 = var_29_2:Find("Aim2 Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	self.cameraFree = nil
	self.cameraFurnitureWatch = nil
	self.cameraRole = var_29_2:Find("Role Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	self.cameraRole2 = var_29_2:Find("Role2 Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	self.cameraGift = var_29_2:Find("Gift Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	local var_29_3 = {
		self.cameraAim,
		self.cameraAim2,
		self.cameraRole,
		[Dorm3dRoomTemplateScene.CAMERA.TALK] = var_29_2:Find("Talk Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)),
		[Dorm3dRoomTemplateScene.CAMERA.GIFT] = self.cameraGift,
		[Dorm3dRoomTemplateScene.CAMERA.ROLE2] = self.cameraRole2
	}

	var_29_3[Dorm3dRoomTemplateScene.CAMERA.PHOTO] = var_29_2:Find("Photo Camera"):GetComponent(typeof(Cinemachine.CinemachineFreeLook))
	var_29_3[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE] = var_29_2:Find("PhotoFree Controller")
	var_29_3[Dorm3dRoomTemplateScene.CAMERA.POV] = var_29_2:Find("FP Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	if self.room:isPersonalRoom() then
		var_29_3[Dorm3dRoomTemplateScene.CAMERA.SKIN] = var_29_2:Find("Skin Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)) or nil
	end

	self.cameras = var_29_3

	setActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]:Find("PhotoFree Camera"), true)

	self.compPovAim = self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV]:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim)
	self.cameraRoot = var_29_2
	self.POVOriginalFOV = self:GetPOVFOV()
	self.restrictedBox = GameObject.Find("RestrictedArea").transform

	setActive(self.restrictedBox, false)

	local var_29_5 = self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]:GetComponent(typeof(CharacterController)).radius

	self.isMultiFloor = self.restrictedBox.childCount > 2

	local var_29_6 = "Floor"
	local var_29_7 = "Celling"

	if self.isMultiFloor then
		self.restrictedHeightRange = {}

		for iter_29_0 = 0, math.floor(self.restrictedBox.childCount / 2) - 1 do
			table.insert(self.restrictedHeightRange, {
				self.restrictedBox:Find(iter_29_0 == 0 and var_29_6 or var_29_6 .. "_" .. iter_29_0).position.y + var_29_5,
				self.restrictedBox:Find(iter_29_0 == 0 and var_29_7 or var_29_7 .. "_" .. iter_29_0).position.y - var_29_5
			})
		end
	else
		self.restrictedHeightRange = {
			self.restrictedBox:Find(var_29_6).position.y + var_29_5,
			self.restrictedBox:Find(var_29_7).position.y - var_29_5
		}
	end

	self.ladyInterest = GameObject.Find("InterestProxy").transform
	self.daynightCtrlComp = GameObject.Find("[MainBlock]").transform:GetComponent("DayNightCtrl")

	self:SwitchDayNight(self.contextData.timeIndex)

	self.tfCutIn = getSceneRootTFDic(SceneManager.GetSceneByName(var_29_0 .. "_base")).CutIn

	if self.tfCutIn then
		local var_29_8 = {}

		var_29_8.lady = self.tfCutIn:Find("lady"):GetChild(0)
		var_29_8.player = self.tfCutIn:Find("player"):GetChild(0)
		self.modelCutIn = var_29_8

		setActive(self.tfCutIn, false)
	end

	return
end

function Dorm3dRoomTemplateScene:SwitchDayNight(arg_32_1, arg_32_2)
	if arg_32_2 and not IsNil(arg_32_2) then
		arg_32_2:SwitcherToIndex(arg_32_1 - 1)
	elseif not IsNil(self.daynightCtrlComp) then
		self.daynightCtrlComp:SwitcherToIndex(arg_32_1 - 1)
	end

	self:InitLightSettings()

	return
end

function Dorm3dRoomTemplateScene:InitLightSettings()
	self.globalVolume = GameObject.Find("GlobalVolume")

	self:RegisterGlobalVolume()

	self.characterLight = GameObject.Find("CharacterLight")

	self:RecordCharacterLight()
	table.IpairsCArray(GameObject.Find("[Lighting]").transform:GetComponentsInChildren(typeof(Light), true), function(arg_34_0, arg_34_1)
		arg_34_1.shadows = UnityEngine.LightShadows.None

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:ResetSceneStructure(arg_35_1)
	table.IpairsCArray(arg_35_1:GetRootGameObjects(), function(arg_36_0, arg_36_1)
		if arg_36_1.name == "Furnitures" then
			self.furnitures = tf(arg_36_1)

			eachChild(self.furnitures, function(arg_37_0)
				if arg_37_0:Find("FreeLook Camera") then
					setActive(arg_37_0:Find("FreeLook Camera"), false)
				end

				if arg_37_0:Find("FreeLook Camera") then
					setActive(arg_37_0:Find("RoleWatch Camera"), false)
				end

				if arg_37_0:Find("IKCamera") then
					setActive(arg_37_0:Find("IKCamera"), false)
				end

				local var_37_0 = arg_37_0:GetComponent(typeof(UnityEngine.Collider))

				if not var_37_0 then
					return
				end

				var_37_0.enabled = false

				return
			end)
		end

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:InitSlots()
	local var_38_0 = self.modelRoot:GetComponentsInChildren(typeof(Transform), true):ToTable()

	self.slotDict = {}

	_.each(self.room:GetSlots(), function(arg_39_0)
		local var_39_0 = arg_39_0:GetFurnitureName()
		local var_39_1 = arg_39_0:GetConfigID()
		local var_39_2 = self.slotRoot:Find(tostring(var_39_1))

		if not var_39_2 then
			errorMsg("Not Find Slot: " .. var_39_1)

			return
		end

		local var_39_3 = {
			trans = var_39_2,
			sceneHides = {}
		}
		local var_39_4 = var_39_2:Find("Selector")

		if var_39_4 then
			GetOrAddComponent(var_39_4, typeof(EventTriggerListener)):AddPointClickFunc(function(arg_40_0, arg_40_1)
				self:emit(Dorm3dRoomMediator.ON_CLICK_FURNITURE_SLOT, var_39_1)

				return
			end)
			setActive(var_39_4, false)
		end

		local var_39_5

		for iter_39_0, iter_39_1 in ipairs(var_38_0) do
			if iter_39_1.name == var_39_0 then
				var_39_5 = iter_39_1

				break
			end
		end

		if var_39_5 then
			var_39_3.model = var_39_5
		end

		self.slotDict[var_39_1] = var_39_3

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:SetContactStateDic(arg_41_1)
	self.contactStateDic = arg_41_1
	self.hideContactStateDic = {}
	self.contactInRangeDic = {}
	self.transRangeDic = {
		list = {}
	}
	self.transformFilter = self.transformFilter or BLHX.Rendering.TransformFilter.New()

	for iter_41_0, iter_41_1 in pairs(self.contactStateDic) do
		self.hideContactStateDic[iter_41_0] = math.min(iter_41_1, ApartmentRoom.ITEM_UNLOCK)
		self.contactInRangeDic[iter_41_0] = false
		self.transRangeDic[iter_41_0] = {
			#self.transRangeDic.list + 1,
			#pg.dorm3d_collection_template[iter_41_0].vfx_prefab
		}

		table.insertto(self.transRangeDic.list, underscore.map(pg.dorm3d_collection_template[iter_41_0].vfx_prefab, function(arg_42_0)
			return self.modelRoot:Find(arg_42_0)
		end))
	end

	self.transformFilter:Init(self.mainCameraTF, self.transRangeDic.list, 2, 60)
	self:ActiveContact()

	return
end

function Dorm3dRoomTemplateScene:TempHideContact(arg_43_1)
	self.hideConcatFlag = arg_43_1

	self:ActiveContact()

	return
end

function Dorm3dRoomTemplateScene:ActiveContact()
	for iter_44_0, iter_44_1 in pairs(self.contactInRangeDic) do
		self:UpdateContactDisplay(iter_44_0, (self.contactInRangeDic[iter_44_0] and not self.hideConcatFlag or nil) and (self.contactStateDic[iter_44_0] or self.hideContactStateDic[iter_44_0]))
	end

	return
end

function Dorm3dRoomTemplateScene:UpdateContactDisplay(arg_45_1, arg_45_2)
	for iter_45_0, iter_45_1 in ipairs(pg.dorm3d_collection_template[arg_45_1].vfx_prefab) do
		local var_45_0 = self.modelRoot:Find(iter_45_1)

		if self:IsModeInHidePending(iter_45_1) then
			-- block empty
		elseif not self.modelRoot:Find(iter_45_1) then
			warning(arg_45_1, iter_45_1)
		else
			setActive(var_45_0, arg_45_2 == ApartmentRoom.ITEM_FIRST)
		end
	end

	for iter_45_2, iter_45_3 in ipairs(pg.dorm3d_collection_template[arg_45_1].model) do
		if self:IsModeInHidePending(iter_45_3) then
			-- block empty
		elseif not self.modelRoot:Find(iter_45_3) then
			warning(arg_45_1, iter_45_3)
		else
			local var_45_1 = self.modelRoot:Find(iter_45_3)

			if self:CheckSceneItemActive(var_45_1) then
				local var_45_2 = GetComponent(var_45_1, typeof(EventTriggerListener))

				if arg_45_2 == ApartmentRoom.ITEM_FIRST then
					var_45_2 = var_45_2 or GetOrAddComponent(var_45_1, typeof(EventTriggerListener))

					var_45_2:AddPointClickFunc(function(arg_46_0, arg_46_1)
						self:emit(Dorm3dRoomTemplateScene.CLICK_CONTACT, arg_45_1)

						return
					end)

					var_45_2.enabled = true
				elseif var_45_2 then
					var_45_2.enabled = false
				end

				setActive(var_45_1, arg_45_2 > ApartmentRoom.ITEM_LOCK)
			end
		end
	end

	return
end

function Dorm3dRoomTemplateScene:SetFloatEnable(arg_47_1)
	self.enableFloatUpdate = arg_47_1

	if arg_47_1 then
		self:UpdateFloatPosition()
	end

	return
end

function Dorm3dRoomTemplateScene:UpdateFloatPosition()
	setLocalPosition(self.rtFloatPage:Find("lady"), (self:GetLocalPosition(self:GetScreenPosition(self:GetCurrentLadyEnv().ladyHeadCenter.position + Vector3(0, 0.2, 0)), self.rtFloatPage)))

	return
end

function Dorm3dRoomTemplateScene:LoadCharacter(arg_49_1, arg_49_2)
	self.hxMatDict = {}
	self.ladyDict = {}
	self.skinDict = {}

	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		table.insert(var_49_0, function(arg_50_0)
			self:LoadSingleCharacter(iter_49_1, arg_50_0)

			return
		end)
	end

	parallelAsync(var_49_0, arg_49_2)

	return
end

function Dorm3dRoomTemplateScene:LoadCharacterAdditionally(arg_51_1, arg_51_2)
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in ipairs(arg_51_1) do
		table.insert(var_51_0, function(arg_52_0)
			self:LoadSingleCharacter(iter_51_1, function()
				self:InitCharacter(self.ladyDict[iter_51_1], iter_51_1)
				arg_52_0()

				return
			end)

			return
		end)
	end

	parallelAsync(var_51_0, arg_51_2)

	return
end

function Dorm3dRoomTemplateScene:LoadSingleCharacter(arg_54_1, arg_54_2)
	local var_54_0 = {}
	local var_54_1 = LadyEnv.New(self)

	self.ladyDict[arg_54_1] = var_54_1

	local var_54_2 = getProxy(ApartmentProxy)
	local var_54_3 = var_54_2:getApartment(arg_54_1)
	local var_54_4 = var_54_3:getConfig("asset_name")
	local var_54_5 = var_54_3:GetSkinModelID(self.room:getConfig("tag"))
	local var_54_6 = Dorm3dSkin.New({
		configId = var_54_2
	}):GetModelName()

	assert(var_54_6)

	for iter_54_0, iter_54_1 in ipairs({
		"common",
		var_54_6
	}) do
		local var_54_7 = string.format("dorm3d/character/%s/res/%s", var_54_4, iter_54_1)

		if checkABExist(var_54_7) then
			table.insert(var_54_0, function(arg_55_0)
				self.loader:LoadBundle(var_54_7, function(arg_56_0)
					for iter_56_0, iter_56_1 in ipairs(arg_56_0:GetAllAssetNames()) do
						local var_56_0, var_56_1, var_56_2 = string.find(string.lower(iter_56_1), "material_hx[/\\](.*).mat")

						if var_56_0 then
							self.hxMatDict[var_56_2 .. " (Instance)"] = {
								arg_56_0,
								iter_56_1
							}
							self.hxMatDict[var_56_2] = {
								arg_56_0,
								iter_56_1
							}
						end
					end

					arg_55_0()

					return
				end)

				return
			end)
		end
	end

	var_54_1.skinId = var_54_5
	var_54_1.skinIdList = {
		var_54_5
	}

	table.insert(var_54_0, function(arg_57_0)
		self.loader:GetPrefab(string.format("dorm3d/character/%s/prefabs/%s", var_54_4, var_54_6), "", function(arg_58_0)
			var_54_1.ladyGameObject = arg_58_0
			self.skinDict[var_54_5] = {
				ladyGameObject = arg_58_0
			}

			arg_57_0()

			return
		end)

		return
	end)

	if self.room:isPersonalRoom() then
		for iter_54_2, iter_54_3 in ipairs(var_54_3:GetAllModelIds()) do
			if not table.contains(var_54_1.skinIdList, iter_54_3) then
				local var_54_8 = Dorm3dSkin.New({
					configId = iter_54_3
				})

				if not var_54_8:IsShow() then
					if iter_54_3 == 199033 then
						local var_54_10 = string.format("dorm3d/character/%s/prefabs/%s", var_54_4, (var_54_8:GetModelName()))

						if checkABExist(var_54_10) then
							table.insert(var_54_1.skinIdList, iter_54_3)
							table.insert(var_54_0, function(arg_59_0)
								self.loader:GetPrefab(var_54_10, "", function(arg_60_0)
									self.skinDict[iter_54_3] = {
										ladyGameObject = arg_60_0
									}
									GetComponent(arg_60_0, "GraphOwner").enabled = false

									setActive(arg_60_0, false)
									arg_59_0()

									return
								end)

								return
							end)
						end
					end
				end
			end
		end
	end

	if self.contextData.pendingDic[arg_54_1] then
		local var_54_11 = pg.dorm3d_welcome[self.contextData.pendingDic[arg_54_1]]

		if pg.dorm3d_welcome[self.contextData.pendingDic[arg_54_1]].item_prefab ~= "" then
			table.insert(var_54_0, function(arg_61_0)
				self.loader:GetPrefab(string.lower("dorm3d/furniture/item/" .. var_54_11.item_prefab), "", function(arg_62_0)
					var_54_1.tfPendintItem = arg_62_0.transform

					setActive(arg_62_0, false)
					arg_61_0()

					return
				end)

				return
			end)
		end
	end

	parallelAsync(var_54_0, arg_54_2)

	return
end

function Dorm3dRoomTemplateScene:HXCharacter(arg_63_1)
	if not HXSet.isHx() then
		return
	end

	if Dorm3dHxHelper.ReplaceCharacterParts(arg_63_1) then
		return
	end

	table.IpairsCArray(arg_63_1:GetComponentsInChildren(typeof(SkinnedMeshRenderer), true), function(arg_64_0, arg_64_1)
		local var_64_0 = arg_64_1.sharedMaterials
		local var_64_1 = false

		table.IpairsCArray(arg_64_1.sharedMaterials, function(arg_65_0, arg_65_1)
			if arg_65_1 == nil then
				return
			end

			local var_65_0 = arg_65_1.name

			if not self.hxMatDict[arg_65_1.name] then
				return
			end

			var_64_1 = true

			local var_65_1, var_65_2 = unpack(self.hxMatDict[var_65_0])

			var_64_0[arg_65_0] = var_65_1:LoadAssetSync(var_65_2, typeof(Material), false, false)

			warning("Replace HX Material", self.hxMatDict[var_65_0][2])

			return
		end)

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:InitHolyLight()
	local var_66_0 = {}

	for iter_66_0, iter_66_1 in pairs(self.ladyDict) do
		table.insert(var_66_0, iter_66_1.lady)
	end

	Dorm3dHxHelper.ShowHolyLight(var_66_0, self.holyLightRoot, true)

	return
end

function Dorm3dRoomTemplateScene:InitCharacter(arg_67_1, arg_67_2)
	arg_67_1:InitCharacter(arg_67_2)
	Dorm3dHxHelper.HideCharacterPart(arg_67_1.lady)
	self:HXCharacter(arg_67_1.lady)
	arg_67_1:SetZone(self.contextData.ladyZone[arg_67_2])
	self:ChangeCharacterPosition(arg_67_1)

	return
end

function Dorm3dRoomTemplateScene:SetCameraLady(arg_68_1)
	self.cameraAim2.LookAt = arg_68_1.ladyInterestRoot
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.TALK].Follow = arg_68_1.ladyInterestRoot
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.TALK].LookAt = arg_68_1.ladyInterestRoot
	self.cameraGift.Follow = self.ladyInterest
	self.cameraGift.LookAt = self.ladyInterest
	self.cameraRole2.LookAt = arg_68_1.ladyInterestRoot
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].Follow = self.ladyInterest
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].LookAt = self.ladyInterest

	return
end

function Dorm3dRoomTemplateScene:initNodeCanvas()
	local var_69_0 = pg.NodeCanvasMgr.GetInstance()

	var_69_0:Active()
	var_69_0:RegisterFunc("DistanceTrigger", function(arg_70_0)
		self:emit(Dorm3dRoomTemplateScene.DISTANCE_TRIGGER, arg_70_0, self.ladyDict[arg_70_0].dis)

		return
	end)
	var_69_0:RegisterFunc("ShortWaitAction", function(arg_71_0)
		self:DoShortWait(arg_71_0)

		return
	end)
	var_69_0:RegisterFunc("WatchShortWaitAction", function(arg_72_0)
		self:DoShortWait(arg_72_0)

		return
	end)
	var_69_0:RegisterFunc("WalkDistanceTrigger", function(arg_73_0)
		self:emit(Dorm3dRoomTemplateScene.WALK_DISTANCE_TRIGGER, arg_73_0, self.ladyDict[arg_73_0].dis)

		return
	end)
	var_69_0:RegisterFunc("ChangeWatch", function(arg_74_0)
		self:emit(Dorm3dRoomTemplateScene.CHANGE_WATCH, arg_74_0)

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:SetAllBlackbloardValue(arg_75_1, arg_75_2)
	self[arg_75_1] = arg_75_2

	for iter_75_0, iter_75_1 in pairs(self.ladyDict) do
		self:SetBlackboardValue(iter_75_1, arg_75_1, arg_75_2)
	end

	return
end

function Dorm3dRoomTemplateScene:SetBlackboardValue(arg_76_1, arg_76_2, arg_76_3)
	arg_76_1:SetBlackboardValue(arg_76_2, arg_76_3)

	return
end

function Dorm3dRoomTemplateScene:GetBlackboardValue(arg_77_1, arg_77_2)
	return arg_77_1:GetBlackboardValue(arg_77_2)
end

function Dorm3dRoomTemplateScene:didEnter()
	local var_78_0 = -21.6 / Screen.height

	self.joystickDelta = Vector2.zero
	self.joystickTimer = FrameTimer.New(function()
		local function var_79_0(arg_80_0, arg_80_1, arg_80_2)
			arg_80_0[arg_80_1].m_InputAxisValue = arg_80_2
			arg_80_0[arg_80_1] = arg_80_0[arg_80_1]

			return
		end

		if self.surroudCamera and not self.pinchMode then
			var_79_0(self.surroudCamera, "m_XAxis", (self.joystickDelta * var_78_0).x)
			var_79_0(self.surroudCamera, "m_YAxis", (self.joystickDelta * var_78_0).y)
		elseif self.furniturePOV and self.cameras[Dorm3dRoomTemplateScene.CAMERA.FURNITURE_WATCH] and isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.FURNITURE_WATCH]) then
			var_79_0(self.furniturePOV, "m_HorizontalAxis", (self.joystickDelta * var_78_0).x)
			var_79_0(self.furniturePOV, "m_VerticalAxis", (self.joystickDelta * var_78_0).y)
		end

		self.joystickDelta = Vector2.zero

		return
	end, 1, -1)

	self.joystickTimer:Start()

	local var_78_1 = 1.75

	self.moveStickTimer = FrameTimer.New(function()
		if not self.moveStickDraging then
			return
		end

		local var_81_0 = (self.moveStickPosition - self.moveStickOrigin):ClampMagnitude(200)

		self.moveStickPosition = self.moveStickOrigin + var_81_0

		local var_81_1 = self.mainCameraTF:TransformDirection((Vector3.New((var_81_0 / 200).x, 0, (var_81_0 / 200).y)))

		var_81_1.y = 0

		local var_81_2 = var_81_1:Normalize()

		var_81_2:Mul(var_78_1)

		if isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV]) then
			self.playerController:SimpleMove(var_81_2)

			self.tweenFOV = true
		elseif isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]) then
			self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]:GetComponent(typeof(UnityEngine.CharacterController)):Move(var_81_2 * Time.deltaTime)
			self:emit(Dorm3dPhotoMediator.CAMERA_STICK_MOVE, (var_81_0 / 200):Normalize())
			onNextTick(function()
				local var_82_0 = self:GetRestritedHeightRange()

				self:emit(Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED, (math.InverseLerp(var_82_0[1], var_82_0[2], self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE].position.y)))

				return
			end)
		end

		return
	end, 1, -1)

	self.moveStickTimer:Start()

	self.pinchMode = false
	self.pinchSize = 0
	self.pinchValue = 1
	self.pinchNodeOrder = 1

	GlobalClickEventMgr.Inst:AddBeginPinchFunc(function(arg_83_0, arg_83_1)
		if self.surroudCamera and isActive(self.surroudCamera) then
			self.pinchMode = true
			self.pinchSize = (arg_83_0 - arg_83_1):Magnitude()
			self.pinchNodeOrder = arg_83_1.x < arg_83_0.x and -1 or 1

			return
		end

		if isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV]) then
			if (arg_83_0 - arg_83_1):Magnitude() < Screen.height * 0.5 then
				self.pinchMode = true
				self.pinchSize = (arg_83_0 - arg_83_1):Magnitude()
				self.pinchNodeOrder = arg_83_1.x < arg_83_0.x and -1 or 1
			end

			return
		end

		return
	end)

	local var_78_3 = ((IsUnityEditor or nil) and 0.1) * 1080 / Screen.height

	GlobalClickEventMgr.Inst:AddPinchFunc(function(arg_84_0, arg_84_1)
		if not self.pinchMode then
			return
		end

		local var_84_0 = (arg_84_0 - arg_84_1):Magnitude()

		if isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV]) then
			self.pinchValue = math.clamp(self.pinchValue + (self.pinchSize - var_84_0) * var_78_3 * (self.pinchNodeOrder * (arg_84_1.x < arg_84_0.x and -1 or 1)), 0.5, 1)
			self.pinchSize = var_84_0

			self:SetPOVFOV(self.POVOriginalFOV * self.pinchValue)

			self.tweenFOV = nil

			return
		end

		if isActive(self.surroudCamera) and self.surroudCamera == self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO] then
			self:SetPinchValue(math.clamp(self.pinchValue + (self.pinchSize - var_84_0) * var_78_3 * (self.pinchNodeOrder * (arg_84_1.x < arg_84_0.x and -1 or 1)), 0.5, 1))

			self.pinchSize = var_84_0

			return
		end

		return
	end)
	GlobalClickEventMgr.Inst:AddEndPinchFunc(function()
		self.pinchMode = false
		self.pinchSize = 0

		return
	end)

	self.cameraBlendCallbacks = {}
	self.activeCMCamera = nil

	function self.camBrainEvenetHandler.OnBlendStarted(arg_86_0)
		if self.activeCMCamera then
			self:OnCameraBlendFinished(self.activeCMCamera)
		end

		self.activeCMCamera = self.camBrain.ActiveVirtualCamera

		return
	end

	function self.camBrainEvenetHandler.OnBlendFinished(arg_87_0)
		self.activeCMCamera = nil

		self:OnCameraBlendFinished(arg_87_0)

		return
	end

	self.expressionDict = {}

	self:OverlayPanel(self.blockLayer)
	self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV])

	local var_78_4
	local var_78_5
	local var_78_6 = self.resumeCallback

	function self.resumeCallback()
		var_78_5 = true

		if var_78_4 then
			existCall(var_78_6)
		end

		return
	end

	self:RefreshSlots(nil, function()
		var_78_4 = true
		self.doneFirstSlotFresh = true

		if var_78_5 then
			existCall(var_78_6)
		end

		return
	end)

	self.updateHandler = UpdateBeat:CreateListener(function()
		xpcall(function()
			self:Update()

			return
		end, function(...)
			errorMsg(debug.traceback(...))

			return
		end)

		return
	end)

	UpdateBeat:AddListener(self.updateHandler)
	self:InitExtraSystem()

	return
end

function Dorm3dRoomTemplateScene:InitData()
	if not self.contextData.ladyZone then
		self.contextData.ladyZone = {}

		local var_93_0
		local var_93_1 = self.room:getConfig("default_zone")

		for iter_93_0, iter_93_1 in ipairs(var_93_1) do
			self.contextData.ladyZone[iter_93_1[1]] = iter_93_1[2]

			if table.contains(self.contextData.groupIds, iter_93_1[1]) then
				var_93_0 = var_93_0 or self.contextData.ladyZone[iter_93_1[1]]
			end
		end

		self.contextData.inFurnitureName = var_93_0 or var_93_1[1][2]
	end

	self.zoneDatas = _.select(self.room:GetZones(), function(arg_94_0)
		return not arg_94_0:IsGlobal()
	end)
	self.activeLady = {}

	return
end

function Dorm3dRoomTemplateScene:Update()
	self.raycastCamera.fieldOfView = self.mainCameraTF:GetComponent(typeof(Camera)).fieldOfView

	if self.tweenFOV then
		self.pinchValue = Mathf.Lerp(self.pinchValue, 1, (Damp(1, 1, Time.deltaTime)))

		self:SetPOVFOV(self.POVOriginalFOV * self.pinchValue)

		if self.pinchValue > 0.99 then
			self.tweenFOV = nil
		end
	end

	if isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV]) then
		self:TriggerLadyDistance()
	end

	if self.contactInRangeDic then
		local var_95_0 = self.transformFilter:Execute():ToTable()

		for iter_95_0, iter_95_1 in pairs(self.contactInRangeDic) do
			local var_95_2 = underscore(var_95_0):chain():slice(unpack(self.transRangeDic[iter_95_0])):any(function(arg_96_0)
				return arg_96_0
			end):value()

			if tobool(iter_95_1) ~= var_95_2 then
				self.contactInRangeDic[iter_95_0] = var_95_2

				self:UpdateContactDisplay(iter_95_0, (var_95_2 and not self.hideConcatFlag or nil) and (self.contactStateDic[iter_95_0] or self.hideContactStateDic[iter_95_0]))
			end
		end
	end

	if self.enableFloatUpdate then
		self:UpdateFloatPosition()
	end

	self:CheckInSector()

	if self.systemManager then
		self.systemManager:Update(Time.deltaTime)
	end

	return
end

function Dorm3dRoomTemplateScene:CheckInSector()
	if not isActive(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV]) then
		return
	end

	local var_97_0 = self.mainCameraTF.position

	for iter_97_0, iter_97_1 in pairs(self.ladyDict) do
		if iter_97_1.lady then
			local var_97_1 = tobool(self.activeLady[iter_97_0])

			if var_97_1 ~= tobool(Dorm3dRoomTemplateScene.IsPointInSector({
				Radius = 2,
				Angle = 120,
				Position = iter_97_1.lady.position,
				Rotation = iter_97_1.lady.rotation
			}, var_97_0)) then
				self.activeLady[iter_97_0] = not var_97_1

				self:emit(Dorm3dRoomTemplateScene.ON_ENTER_SECTOR, iter_97_0)
			end
		end
	end

	return
end

function Dorm3dRoomTemplateScene:TriggerLadyDistance()
	for iter_98_0, iter_98_1 in pairs(self.ladyDict) do
		if iter_98_1.lady then
			iter_98_1.dis = (iter_98_1.lady.position - self.player.position).magnitude

			if self:GetBlackboardValue(iter_98_1, "inPending") then
				if (Dorm3dRoomTemplateScene.POV_PENDING_CLOSE_DISTANCE or Dorm3dRoomTemplateScene.POV_CLOSE_DISTANCE) > iter_98_1.dis ~= self:GetBlackboardValue(iter_98_1, "inDistance") then
					self:SetBlackboardValue(iter_98_1, "inDistance", iter_98_1.dis < Dorm3dRoomTemplateScene.POV_CLOSE_DISTANCE)
					self:emit(Dorm3dRoomTemplateScene.ON_CHANGE_DISTANCE, iter_98_0, iter_98_1.dis < Dorm3dRoomTemplateScene.POV_CLOSE_DISTANCE)
				end
			end
		end
	end

	return
end

function Dorm3dRoomTemplateScene:OnStickMove(arg_99_1)
	self.joystickDelta = arg_99_1

	return
end

function Dorm3dRoomTemplateScene:SetPinchValue(arg_100_1)
	self.pinchValue = arg_100_1

	self:SetCameraObrits()

	return
end

function Dorm3dRoomTemplateScene:GetPOVFOV()
	return ReflectionHelp.RefGetField(typeof("Cinemachine.LensSettings"), "FieldOfView", self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV].m_Lens)
end

function Dorm3dRoomTemplateScene:SetPOVFOV(arg_102_1)
	ReflectionHelp.RefSetField(typeof("Cinemachine.LensSettings"), "FieldOfView", self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV].m_Lens, arg_102_1)

	self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV].m_Lens = self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV].m_Lens

	return
end

function Dorm3dRoomTemplateScene:RefreshSlots(arg_103_1, arg_103_2)
	arg_103_1 = arg_103_1 or self.room

	local var_103_0 = arg_103_1:GetSlots()
	local var_103_1 = arg_103_1:GetFurnitures()

	self:emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
	table.ParallelIpairsAsync(var_103_0, function(arg_104_0, arg_104_1, arg_104_2)
		local var_104_0 = arg_104_1:GetConfigID()

		if not self.slotDict[var_104_0] then
			return arg_104_2()
		end

		local var_104_1 = _.detect(var_103_1, function(arg_105_0)
			return arg_105_0:GetSlotID() == var_104_0
		end)
		local var_104_2 = var_104_1 and var_104_1:GetModel() or false
		local var_104_3 = self.slotDict[var_104_0].model

		self.slotDict[var_104_0].displayModelName = var_104_2
		self.slotDict[var_104_0].furnitureId = var_104_1 and var_104_1:GetConfigID()

		local function var_104_4(arg_106_0)
			table.Foreach(self.slotDict[var_104_0].sceneHides or {}, function(arg_107_0, arg_107_1)
				setActive(arg_107_1.trans, arg_107_1.visible)

				return
			end)

			self.slotDict[var_104_0].sceneHides = {}

			if var_104_3 then
				setActive(var_104_3, var_104_2 == "")
			end

			if arg_106_0 then
				local var_106_1 = arg_106_0:getConfig("scene_hides")

				if #var_106_1 > 0 then
					table.Ipairs(var_106_1, function(arg_108_0, arg_108_1)
						local var_108_0 = self.modelRoot:Find(arg_108_1)

						assert(var_108_0, string.format("dorm3d_furniture_template:%d scene_hides missing scene item :%s", arg_106_0:GetConfigID(), arg_108_1))
						table.insert(self.slotDict[var_104_0].sceneHides, {
							name = arg_108_1,
							trans = var_108_0,
							visible = isActive(var_108_0)
						})
						setActive(var_108_0, false)

						return
					end)
				end
			end

			return
		end

		if var_104_2 == false or var_104_2 == "" then
			self.loader:ClearRequest("slot_" .. var_104_0)
			var_104_4()
			arg_104_2()

			return
		end

		local var_104_5 = self.slotDict[var_104_0].trans

		if self.loader:GetLoadingRP("slot_" .. var_104_0) then
			self:emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)
		end

		self.loader:GetPrefabBYStopLoading("dorm3d/furniture/prefabs/" .. var_104_2, "", function(arg_109_0)
			assert(arg_109_0)
			setParent(arg_109_0, var_104_5)
			var_104_4(var_104_1)
			arg_104_2()

			return
		end, "slot_" .. var_104_0)

		return
	end, function()
		self:emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)
		existCall(arg_103_2)
		warning("RefreshSlots", "Done")
		self:emit(Dorm3dRoomMediator.REFRESH_FURNITURE_AND_SLOTS_DONE)

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:RefreshSlotsEmpty(arg_111_1)
	local var_111_0 = Clone(self.room)

	var_111_0.furnitures = {}

	self:RefreshSlots(var_111_0, arg_111_1)

	return
end

function Dorm3dRoomTemplateScene:CheckSceneItemActiveByPath(arg_112_1)
	return self:CheckSceneItemActive((self:GetSceneItem(arg_112_1)))
end

function Dorm3dRoomTemplateScene:CheckSceneItemActive(arg_113_1)
	local var_113_0 = true
	local var_113_1

	table.Checkout(self.slotDict, function(arg_114_0, arg_114_1)
		if underscore.detect(arg_114_1.sceneHides, function(arg_115_0)
			return arg_115_0.trans == arg_113_1
		end) then
			var_113_0 = false
			var_113_1 = arg_114_1.furnitureId

			return false
		end

		return
	end)

	return true, nil
end

function Dorm3dRoomTemplateScene:ChangeCharacterPosition(arg_116_1)
	self:ResetCharPoint(arg_116_1, arg_116_1.ladyActiveZone)
	self:SyncInterestTransform(arg_116_1)

	return
end

function Dorm3dRoomTemplateScene:SyncCurrentInterestTransform()
	self:SyncInterestTransform((self:GetCurrentLadyEnv()))

	return
end

function Dorm3dRoomTemplateScene:SyncInterestTransform(arg_118_1)
	self.ladyInterest.position = arg_118_1.ladyInterestRoot.position
	self.ladyInterest.rotation = arg_118_1.ladyInterestRoot.rotation

	return
end

function Dorm3dRoomTemplateScene:SyncInterestTransformByTf(arg_119_1)
	self.ladyInterest.position = arg_119_1.position
	self.ladyInterest.rotation = arg_119_1.rotation

	return
end

function Dorm3dRoomTemplateScene:ChangePlayerPosition(arg_120_1)
	arg_120_1 = arg_120_1 or self.contextData.inFurnitureName
	self.player.position = self.furnitures:Find(arg_120_1):Find("PlayerPoint").position
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV].transform.position = self.playerEye.position

	local var_120_0 = Quaternion.LookRotation(self.ladyInterest.position - self.playerEye.position).eulerAngles

	self.compPovAim.m_HorizontalAxis.Value = self:GetNearestAngle(var_120_0.y, self.compPovAim.m_HorizontalAxis.m_MinValue, self.compPovAim.m_HorizontalAxis.m_MaxValue)
	self.compPovAim.m_HorizontalAxis = self.compPovAim.m_HorizontalAxis
	self.compPovAim.m_VerticalAxis.Value = var_120_0.x
	self.compPovAim.m_VerticalAxis = self.compPovAim.m_VerticalAxis

	return
end

function Dorm3dRoomTemplateScene:GetAttachedFurnitureName()
	return self.contextData.inFurnitureName
end

function Dorm3dRoomTemplateScene:GetFurnitureByName(arg_122_1)
	return underscore.detect(self.attachedPoints, function(arg_123_0)
		return arg_123_0.name == arg_122_1
	end)
end

function Dorm3dRoomTemplateScene:GetSlotByID(arg_124_1)
	return self.displaySlots[arg_124_1] and self.displaySlots[arg_124_1].trans
end

function Dorm3dRoomTemplateScene:GetScreenPosition(arg_125_1, arg_125_2)
	arg_125_2 = arg_125_2 or self.raycastCamera

	local var_125_0 = arg_125_2:WorldToScreenPoint(arg_125_1)

	if var_125_0.z < 0 then
		var_125_0.x = var_125_0.x + (var_125_0.x < 0 and -1 or 1) * Screen.width
		var_125_0.y = var_125_0.y + (var_125_0.y < 0 and -1 or 1) * Screen.height
		var_125_0.z = -var_125_0.z
	end

	return var_125_0
end

function Dorm3dRoomTemplateScene:GetLocalPosition(arg_126_1, arg_126_2)
	return LuaHelper.ScreenToLocal(arg_126_2, arg_126_1, pg.UIMgr.GetInstance().uiCameraComp)
end

function Dorm3dRoomTemplateScene:GetModelRoot()
	return self.modelRoot
end

function Dorm3dRoomTemplateScene:ShiftZoneSafe(arg_128_1)
	local var_128_0 = {}

	if self.room:isPersonalRoom() and not self:GetBlackboardValue(self:GetCurrentLadyEnv(), "inPending") then
		table.insert(var_128_0, function(arg_129_0)
			self:OutOfLazy(self.apartment:GetConfigID(), arg_129_0)

			return
		end)
	end

	table.insert(var_128_0, function(arg_130_0)
		self:ShiftZone(arg_128_1, arg_130_0)

		return
	end)
	seriesAsync(var_128_0, function()
		self:CheckQueue()

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:ShiftZone(arg_132_1, arg_132_2)
	local var_132_0 = self:GetFurnitureByName(arg_132_1)

	if not var_132_0 then
		errorMsg(arg_132_1 .. " Not Find")
		existCall(arg_132_2)

		return
	end

	seriesAsync({
		function(arg_133_0)
			self:emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
			self:ShowBlackScreen(true, arg_133_0)

			return
		end,
		function(arg_134_0)
			if self.shiftLady or self.room:isPersonalRoom() then
				local var_134_0 = self.shiftLady or self.apartment:GetConfigID()

				self.shiftLady = nil
				self.contextData.ladyZone[var_134_0] = var_132_0.name

				local var_134_1 = self.ladyDict[var_134_0]

				self.ladyDict[var_134_0]:SetZone(self.contextData.ladyZone[var_134_0])

				if self:GetBlackboardValue(self.ladyDict[var_134_0], "inPending") then
					self:SetOutPending(self.ladyDict[var_134_0])
					self:SwitchAnim(self.ladyDict[var_134_0], Dorm3dRoomTemplateScene.ANIM.IDLE)
					onNextTick(function()
						self:ChangeCharacterPosition(var_134_1)
						arg_134_0()

						return
					end)
				else
					self:ChangeCharacterPosition(self.ladyDict[var_134_0])
					arg_134_0()
				end
			else
				arg_134_0()
			end

			return
		end,
		function(arg_136_0)
			self.contextData.inFurnitureName = var_132_0.name

			if SlideExtraSystem.IsOpen(self.room) and self.contextData.inFurnitureName == SlideConst.SLIDE_ZONE then
				self:SyncInterestTransformByTf(var_132_0.transform:Find("StayPoint"))
			elseif not self.apartment then
				for iter_136_0, iter_136_1 in pairs(self.ladyDict) do
					if iter_136_1.ladyBaseZone == self.contextData.inFurnitureName then
						self:SyncInterestTransform(iter_136_1)

						break
					end
				end
			end

			self:ChangePlayerPosition()
			self:TriggerLadyDistance()
			self:CheckInSector()
			arg_136_0()

			return
		end,
		function(arg_137_0)
			self:UpdateZoneList()
			self:ShowBlackScreen(false, arg_137_0)

			return
		end,
		function(arg_138_0)
			self:emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)
			arg_138_0()

			return
		end
	}, arg_132_2)

	return
end

function Dorm3dRoomTemplateScene:ActiveCamera(arg_139_1)
	table.Foreach(self.cameras, function(arg_140_0, arg_140_1)
		setActive(arg_140_1, arg_140_1 == arg_139_1)

		return
	end)

	if isActive(arg_139_1) then
		self:OnCameraBlendFinished(arg_139_1)
	end

	return
end

function Dorm3dRoomTemplateScene:ActiveCameraByName(arg_141_1)
	local var_141_0 = self.cameraRoot:Find(arg_141_1)

	assert(var_141_0, "ActiveCameraByName: " .. arg_141_1 .. " not found")
	table.Foreach(self.cameras, function(arg_142_0, arg_142_1)
		setActive(arg_142_1, false)

		return
	end)
	setActive(var_141_0, true)

	self.cameras[Dorm3dRoomTemplateScene.CAMERA.CUSTOM] = var_141_0:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	return
end

function Dorm3dRoomTemplateScene:ShowBlackScreen(arg_143_1, arg_143_2)
	local var_143_0 = self.blackSceneInfo or {
		color = "#000000",
		time = 0.3,
		delay = arg_143_1 and 0 or 0.3
	}

	setImageColor(self.blackLayer, Color.NewHex(var_143_0.color))
	setActive(self.blackLayer, true)
	setCanvasGroupAlpha(self.blackLayer, arg_143_1 and 0 or 1)
	self:managedTween(LeanTween.alphaCanvas, function()
		if not arg_143_1 then
			setActive(self.blackLayer, false)
		end

		existCall(arg_143_2)

		return
	end, GetComponent(self.blackLayer, typeof(CanvasGroup)), arg_143_1 and 1 or 0, var_143_0.time):setDelay(var_143_0.delay)

	return
end

function Dorm3dRoomTemplateScene:RegisterOrbits(arg_145_1)
	self = self.scene
	self.orbits = {
		original = arg_145_1.m_Orbits
	}
	self.orbits.current = _.range(3):map(function(arg_146_0)
		return Cinemachine.CinemachineFreeLook.Orbit.New(self.orbits.original[arg_146_0 - 1].m_Height, self.orbits.original[arg_146_0 - 1].m_Radius)
	end)
	self.surroudCamera = arg_145_1

	return
end

function Dorm3dRoomTemplateScene:SetCameraObrits()
	self = self.scene

	if not self.surroudCamera then
		return
	end

	local var_147_0 = self.orbits.original[1]

	for iter_147_0 = 0, #self.orbits.current - 1 do
		self.orbits.current[iter_147_0 + 1].m_Height = math.lerp(var_147_0.m_Height, self.orbits.original[iter_147_0].m_Height, self.pinchValue)
		self.orbits.current[iter_147_0 + 1].m_Radius = self.orbits.original[iter_147_0].m_Radius * self.pinchValue
	end

	self.surroudCamera.m_Orbits = self.orbits.current

	return
end

function Dorm3dRoomTemplateScene:RevertCameraOrbit()
	self = self.scene

	if not self.surroudCamera then
		return
	end

	for iter_148_0 = 0, #self.orbits.current - 1 do
		self.orbits.current[iter_148_0 + 1].m_Height = self.orbits.original[iter_148_0].m_Height
		self.orbits.current[iter_148_0 + 1].m_Radius = self.orbits.original[iter_148_0].m_Radius
	end

	self.surroudCamera.m_Orbits = self.orbits.current
	self.surroudCamera = nil

	return
end

function Dorm3dRoomTemplateScene:ActiveStateCamera(arg_149_1, arg_149_2)
	local var_149_0 = {
		base = function(arg_150_0)
			self:RegisterCameraBlendFinished(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV], arg_150_0)
			self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV])

			return
		end,
		watch = function(arg_151_0)
			assert(self.apartment)
			self:SyncInterestTransform(self:GetCurrentLadyEnv())
			self:SetCameraLady(self:GetCurrentLadyEnv())
			self:RegisterCameraBlendFinished(self.cameras[Dorm3dRoomTemplateScene.CAMERA.ROLE], arg_151_0)
			self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.ROLE])

			return
		end,
		walk = function(arg_152_0)
			self:RegisterCameraBlendFinished(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV], arg_152_0)
			self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV])

			return
		end,
		ik = function(arg_153_0)
			arg_153_0()

			return
		end,
		gift = function(arg_154_0)
			assert(self.apartment)
			self:SetCameraLady(self:GetCurrentLadyEnv())
			self:RegisterCameraBlendFinished(self.cameras[Dorm3dRoomTemplateScene.CAMERA.GIFT], arg_154_0)
			self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.GIFT])

			return
		end,
		standby = function(arg_155_0)
			assert(self.apartment)
			self:SetCameraLady(self:GetCurrentLadyEnv())

			self.cameras[Dorm3dRoomTemplateScene.CAMERA.ROLE2].transform.position = self.cameraRole.transform.position

			self:RegisterCameraBlendFinished(self.cameras[Dorm3dRoomTemplateScene.CAMERA.ROLE2], arg_155_0)
			self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.ROLE2])

			return
		end,
		talk = function(arg_156_0)
			assert(self.apartment)
			self:SetCameraLady(self:GetCurrentLadyEnv())
			self:SyncInterestTransform(self:GetCurrentLadyEnv())
			self:RegisterCameraBlendFinished(self.cameras[Dorm3dRoomTemplateScene.CAMERA.TALK], arg_156_0)
			self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.TALK])

			return
		end
	}
	local var_149_1 = {}

	table.insert(var_149_1, function(arg_157_0)
		switch(arg_149_1, var_149_0, arg_157_0, arg_157_0)

		return
	end)
	seriesAsync(var_149_1, arg_149_2)

	return
end

function Dorm3dRoomTemplateScene:GetSceneItem(arg_158_1)
	local var_158_0

	if string.find(arg_158_1, "FurnitureSlots/") == 1 then
		arg_158_1 = string.gsub(arg_158_1, "^FurnitureSlots/", "", 1)
		var_158_0 = self.slotRoot:Find(arg_158_1)
	else
		var_158_0 = self.modelRoot:Find(arg_158_1)
	end

	if not var_158_0 then
		warning(string.format("Missing scene item path: %s", arg_158_1))
	end

	return var_158_0
end

function Dorm3dRoomTemplateScene:SetSceneAnimSpeed(arg_159_1, arg_159_2)
	table.Ipairs(arg_159_1 or {}, function(arg_160_0, arg_160_1)
		if self.sceneAnimatorDict[arg_160_1] then
			self.sceneAnimatorDict[arg_160_1].animator.speed = arg_159_2
		end

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:SetExtraAnimSpeed(arg_161_1, arg_161_2, arg_161_3)
	table.Ipairs(arg_161_2 or {}, function(arg_162_0, arg_162_1)
		if arg_161_1.extraItems[arg_162_1[1]] then
			arg_161_1.extraItems[arg_162_1[1]].trans:GetComponent(typeof(Animator)).speed = arg_161_3
		end

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:PlayEnterSceneAnim(arg_163_1, arg_163_2, arg_163_3)
	arg_163_3 = arg_163_3 or 1

	local var_163_0 = {}

	if arg_163_1 and #arg_163_1 > 0 then
		table.Ipairs(arg_163_1, function(arg_164_0, arg_164_1)
			self:PlaySceneItemAnim(arg_164_1[1], arg_164_1[2], arg_163_2)
			self:SetSceneAnimSpeed({
				arg_164_1[1]
			}, arg_163_3)
			table.insert(var_163_0, arg_164_1[1])

			return
		end)
	end

	self:ResetSceneItemAnimators(var_163_0)

	return
end

function Dorm3dRoomTemplateScene:PlayEnterExtraItem(arg_165_1, arg_165_2, arg_165_3)
	arg_165_3 = arg_165_3 or 1

	local var_165_0 = {}

	if arg_165_2 and #arg_165_2 > 0 then
		table.Ipairs(arg_165_2, function(arg_166_0, arg_166_1)
			self:LoadCharacterExtraItem(arg_165_1, arg_166_1[1], arg_166_1[2], arg_166_1[3] and Vector3.New(unpack(arg_166_1[3])), arg_166_1[4] and Quaternion.Euler(unpack(arg_166_1[4])), (#arg_166_1 > 4 or nil) and (arg_166_1[5] or nil), arg_165_3)
			table.insert(var_165_0, arg_166_1[1])

			return
		end)
	end

	self:ResetCharacterExtraItem(arg_165_1, var_165_0)

	return
end

function Dorm3dRoomTemplateScene:HideSceneItem(arg_167_1, arg_167_2)
	if arg_167_2 and #arg_167_2 > 0 then
		if arg_167_1.tempHideSceneItems and #arg_167_1.tempHideSceneItems > 0 then
			self:ResetTempHideSceneItems(arg_167_1, arg_167_2)
		end

		arg_167_1.tempHideSceneItems = {}

		table.Ipairs(arg_167_2, function(arg_168_0, arg_168_1)
			setActive(self:GetSceneItem(arg_168_1), false)
			table.insert(arg_167_1.tempHideSceneItems, arg_168_1)

			return
		end)
	end

	return
end

function Dorm3dRoomTemplateScene:ResetTempHideSceneItems(arg_169_1, arg_169_2)
	arg_169_2 = arg_169_2 or {}

	if arg_169_1.tempHideSceneItems and #arg_169_1.tempHideSceneItems > 0 then
		table.Ipairs(arg_169_1.tempHideSceneItems, function(arg_170_0, arg_170_1)
			if table.contains(arg_169_2, arg_170_1) then
				return
			end

			setActive(self:GetSceneItem(arg_170_1), true)

			return
		end)

		arg_169_1.tempHideSceneItems = nil
	end

	return
end

function Dorm3dRoomTemplateScene:EnableCurrentHeadIK(arg_171_1)
	self:EnableHeadIK(self:GetCurrentLadyEnv(), arg_171_1)

	return
end

function Dorm3dRoomTemplateScene:EnableHeadIK(arg_172_1, arg_172_2)
	arg_172_1.ladyHeadIKComp.enableIk = arg_172_2

	return
end

function Dorm3dRoomTemplateScene:SettingHeadAimIK(arg_173_1, arg_173_2, arg_173_3)
	local var_173_0

	if arg_173_2[1] == 0 then
		self:EnableHeadIK(arg_173_1, false)

		return
	elseif arg_173_2[1] == 1 then
		self:EnableHeadIK(arg_173_1, true)

		var_173_0 = self.mainCameraTF:Find("AimTarget")
	elseif arg_173_2[1] == 2 then
		self:EnableHeadIK(arg_173_1, true)
		table.IpairsCArray(arg_173_1.lady:GetComponentsInChildren(typeof(Transform), true), function(arg_174_0, arg_174_1)
			if arg_174_1.name ~= arg_173_2[2] then
				return
			end

			var_173_0 = arg_174_1

			return
		end)
	end

	arg_173_1.ladyHeadIKComp.AimTarget = var_173_0

	if not arg_173_3 and arg_173_2[3] then
		arg_173_1.ladyHeadIKComp.BodyWeight = arg_173_2[3]
	end

	if not arg_173_3 and arg_173_2[4] then
		arg_173_1.ladyHeadIKComp.HeadWeight = arg_173_2[4]
	end

	return
end

function Dorm3dRoomTemplateScene:ResetHeadAimIK(arg_175_1)
	self:EnableHeadIK(arg_175_1, true)

	arg_175_1.ladyHeadIKComp.AimTarget = self.mainCameraTF:Find("AimTarget")
	arg_175_1.ladyHeadIKComp.HeadWeight = arg_175_1.ladyHeadIKData.HeadWeight
	arg_175_1.ladyHeadIKComp.BodyWeight = arg_175_1.ladyHeadIKData.BodyWeight

	return
end

function Dorm3dRoomTemplateScene:SetIKTimelineStatus(arg_176_1, arg_176_2, arg_176_3, arg_176_4, arg_176_5)
	self:emit(RoomIKSystem.SET_IK_TIMELINE_STATUS, arg_176_1, arg_176_2, arg_176_3, arg_176_4, arg_176_5)

	return
end

function Dorm3dRoomTemplateScene:ExitIKTimelineStatus(arg_177_1, arg_177_2)
	self:emit(RoomIKSystem.EXIT_IK_TIMELINE_STATUS, arg_177_1, arg_177_2)

	return
end

function Dorm3dRoomTemplateScene:HideCharacter(arg_178_1)
	for iter_178_0, iter_178_1 in pairs(self.ladyDict) do
		if iter_178_0 ~= arg_178_1 then
			self:HideCharacterBylayer(iter_178_1)
		end
	end

	return
end

function Dorm3dRoomTemplateScene:RevertCharacter(arg_179_1)
	for iter_179_0, iter_179_1 in pairs(self.ladyDict) do
		if iter_179_0 ~= arg_179_1 then
			self:RevertCharacterBylayer(iter_179_1)
		end
	end

	return
end

function Dorm3dRoomTemplateScene:HideCharacterBylayer(arg_180_1)
	local var_180_0 = arg_180_1.lady:Find("all")

	for iter_180_0 = 0, var_180_0.childCount - 1 do
		local var_180_1 = var_180_0:GetChild(iter_180_0)

		if var_180_1.name ~= "Bip001" then
			pg.ViewUtils.SetLayer(var_180_1, Layer.UIHidden)
		end
	end

	if arg_180_1.tfPendintItem then
		pg.ViewUtils.SetLayer(arg_180_1.tfPendintItem, Layer.UIHidden)
	end

	if arg_180_1.ladyWatchFloat then
		pg.ViewUtils.SetLayer(arg_180_1.ladyWatchFloat, Layer.UIHidden)
	end

	Dorm3dHxHelper.SetModelHolyLightActive(arg_180_1.lady, self.holyLightRoot, false)

	return
end

function Dorm3dRoomTemplateScene:RevertCharacterBylayer(arg_181_1)
	local var_181_0 = arg_181_1.lady:Find("all")

	for iter_181_0 = 0, var_181_0.childCount - 1 do
		local var_181_1 = var_181_0:GetChild(iter_181_0)

		if var_181_1.name ~= "Bip001" then
			pg.ViewUtils.SetLayer(var_181_1, Layer.Character3D)
		end
	end

	if arg_181_1.tfPendintItem then
		pg.ViewUtils.SetLayer(arg_181_1.tfPendintItem, Layer.Default)
	end

	if arg_181_1.ladyWatchFloat then
		pg.ViewUtils.SetLayer(arg_181_1.ladyWatchFloat, Layer.Default)
	end

	Dorm3dHxHelper.SetModelHolyLightActive(arg_181_1.lady, self.holyLightRoot, true)

	return
end

function Dorm3dRoomTemplateScene:EnterFurnitureWatchMode()
	self:SetAllBlackbloardValue("inLockLayer", true)
	self:EnableJoystick(true)
	self:HideCharacter()

	return
end

function Dorm3dRoomTemplateScene:ExitFurnitureWatchMode(arg_183_1)
	self:HideFurnitureSlots()

	local var_183_0 = self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV]

	seriesAsync({
		function(arg_184_0)
			self.furniturePOV = nil

			self:EnableJoystick(false)
			self:emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
			self:ShowBlackScreen(true, arg_184_0)

			return
		end,
		function(arg_185_0)
			existCall(arg_183_1)
			self:RevertCharacter()
			self:SetAllBlackbloardValue("inLockLayer", false)
			self:RegisterCameraBlendFinished(var_183_0, arg_185_0)
			self:ActiveCamera(var_183_0)

			return
		end,
		function(arg_186_0)
			self:ShowBlackScreen(false, arg_186_0)

			return
		end
	}, function()
		self:emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)

		return
	end)
	self:RefreshSlots()

	return
end

function Dorm3dRoomTemplateScene:SwitchFurnitureZone(arg_188_1)
	local var_188_0 = self:GetFurnitureByName(arg_188_1:GetWatchCameraName()):Find("FurnitureWatch Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	if self.cameraFurnitureWatch and self.cameraFurnitureWatch ~= var_188_0 then
		self:UnRegisterCameraBlendFinished(self.cameraFurnitureWatch)
		setActive(self.cameraFurnitureWatch, false)
	end

	self.cameraFurnitureWatch = var_188_0
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.FURNITURE_WATCH] = self.cameraFurnitureWatch
	self.furniturePOV = self.cameraFurnitureWatch:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim)

	self:RegisterCameraBlendFinished(self.cameraFurnitureWatch, function()
		self:emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)

		return
	end)
	self:emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
	self:ActiveCamera(self.cameraFurnitureWatch)

	return
end

function Dorm3dRoomTemplateScene:HideFurnitureSlots()
	if self.displaySlots then
		self:UpdateDisplaySlots({})
		table.Foreach(self.displaySlots, function(arg_191_0, arg_191_1)
			if IsNil(arg_191_1.trans:Find("Selector")) then
				return
			end

			setActive(arg_191_1.trans:Find("Selector"), false)

			return
		end)

		self.displaySlots = nil
	end

	return
end

function Dorm3dRoomTemplateScene:DisplayFurnitureSlots(arg_192_1)
	self:HideFurnitureSlots()

	self.displaySlots = {}

	_.each(arg_192_1, function(arg_193_0)
		self.displaySlots[arg_193_0] = self.slotDict[arg_193_0]

		if not self.displaySlots[arg_193_0] then
			errorMsg("Slot " .. arg_193_0 .. " Not Binding Scene Object")

			return
		end

		if self.displaySlots[arg_193_0].trans:Find("Selector") then
			setActive(self.displaySlots[arg_193_0].trans:Find("Selector"), true)
		end

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:UpdateDisplaySlots(arg_194_1)
	table.Foreach(self.displaySlots, function(arg_195_0, arg_195_1)
		if not IsNil(arg_195_1.trans:Find("Selector")) then
			setActive(arg_195_1.trans:Find("Selector/Normal"), arg_194_1[arg_195_0] == 0)
			setActive(arg_195_1.trans:Find("Selector/Active"), arg_194_1[arg_195_0] == 1)
			setActive(arg_195_1.trans:Find("Selector/Ban"), arg_194_1[arg_195_0] == 2)
		end

		local var_195_0 = self.slotDict[arg_195_0].model

		if self.slotDict[arg_195_0].displayModelName and self.slotDict[arg_195_0].displayModelName ~= "" then
			var_195_0 = arg_195_1.trans:GetChild(arg_195_1.trans.childCount - 1)
		end

		local function var_195_1(arg_196_0, arg_196_1)
			table.IpairsCArray(arg_196_0:GetComponentsInChildren(typeof(Renderer), true), function(arg_197_0, arg_197_1)
				if arg_197_1.material and arg_197_1.material:HasProperty("_FinalTint") then
					arg_197_1.material:SetColor("_FinalTint", arg_196_1)
				end

				return
			end)

			return
		end

		if var_195_0 then
			if arg_194_1[arg_195_0] == 1 then
				var_195_1(var_195_0, Color.NewHex("3F83AE73"))
			else
				var_195_1(var_195_0, Color.New(0, 0, 0, 0))
			end
		end

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:EnterPhotoMode(arg_198_1, arg_198_2)
	self:SetAllBlackbloardValue("inLockLayer", true)
	self:emit(Dorm3dRoomTemplateScene.ENABLE_SCENEBLOCK, true)
	seriesAsync({
		function(arg_199_0)
			self:TempHideUI(true, arg_199_0)

			return
		end,
		function(arg_200_0)
			self:ShowBlackScreen(true, arg_200_0)

			return
		end,
		function(arg_201_0)
			local var_201_0 = self.apartment:GetConfigID()

			self:SwitchAnim(self.ladyDict[var_201_0], arg_198_2)
			self.ladyDict[var_201_0].ladyAnimator:Update(0)
			self:ResetCharPoint(self.ladyDict[var_201_0], arg_198_1:GetWatchCameraName())
			self:SyncInterestTransform(self.ladyDict[var_201_0])
			setActive(self.ladyDict[var_201_0].ladySafeCollider, true)
			self:HideCharacter(var_201_0)

			self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_XAxis.Value = 180
			self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_XAxis = self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_XAxis
			self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_YAxis.Value = 0.7
			self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_YAxis = self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_YAxis
			self.pinchValue = 1

			self:RegisterOrbits(self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO])
			self:SetCameraObrits()
			setActive(self.restrictedBox, true)
			self:RegisterCameraBlendFinished(self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO], arg_201_0)
			self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO])

			return
		end,
		function(arg_202_0)
			self:ShowBlackScreen(false, arg_202_0)

			return
		end
	}, function()
		self:EnableJoystick(true)

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:ExitPhotoMode()
	self:emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
	self:EnableJoystick(false)
	seriesAsync({
		function(arg_205_0)
			self:ShowBlackScreen(true, arg_205_0)

			return
		end,
		function(arg_206_0)
			self:RevertCameraOrbit()

			local var_206_0 = self:GetCurrentLadyEnv()

			self:SwitchAnim(var_206_0, Dorm3dRoomTemplateScene.ANIM.IDLE)
			setActive(var_206_0.ladySafeCollider, false)
			onNextTick(function()
				self:ChangeCharacterPosition(var_206_0)

				return
			end)

			if self.contextData.photoFreeMode then
				self:EnablePOVLayer(false)

				self.contextData.photoFreeMode = nil
			end

			setActive(self.restrictedBox, false)
			self:RegisterCameraBlendFinished(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV], arg_206_0)
			self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.POV])

			return
		end,
		function(arg_208_0)
			self:RevertCharacter(self.apartment:GetConfigID())
			self:ShowBlackScreen(false, arg_208_0)

			return
		end
	}, function()
		self:RefreshSlots()
		self:SetAllBlackbloardValue("inLockLayer", false)
		self:emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)
		self:emit(Dorm3dRoomTemplateScene.ENABLE_SCENEBLOCK, false)
		self:TempHideUI(false)

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:SwitchCameraZone(arg_210_1, arg_210_2, arg_210_3)
	self:emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
	seriesAsync({
		function(arg_211_0)
			self:ShowBlackScreen(true, arg_211_0)

			return
		end,
		function(arg_212_0)
			local var_212_0 = self:GetCurrentLadyEnv()

			self:SwitchAnim(var_212_0, arg_210_2)
			onNextTick(function()
				self:ResetCharPoint(var_212_0, arg_210_1:GetWatchCameraName())
				self:SyncInterestTransform(var_212_0)

				if self.contextData.photoFreeMode then
					self.camBrain.enabled = false

					self:SwitchPhotoCamera()

					self.camBrain.enabled = true

					onDelayTick(function()
						self.camBrain.enabled = false

						self:SwitchPhotoCamera()

						self.camBrain.enabled = true

						return
					end, 0.1)
				end

				arg_212_0()

				return
			end)

			return
		end,
		function(arg_215_0)
			self:ShowBlackScreen(false, arg_215_0)

			return
		end
	}, function()
		self:emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)
		existCall(arg_210_3)

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:SwitchPhotoCamera()
	if not self.contextData.photoFreeMode then
		self:EnableJoystick(false)
		self:EnablePOVLayer(true)

		local var_217_0 = self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]:Find("PhotoFree Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)):GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim)
		local var_217_1 = self.mainCameraTF.rotation:ToEulerAngles()

		var_217_0.m_HorizontalAxis.Value = var_217_1.y
		var_217_0.m_HorizontalAxis = var_217_0.m_HorizontalAxis
		var_217_0.m_VerticalAxis.Value = self:GetNearestAngle(var_217_1.x, var_217_0.m_VerticalAxis.m_MinValue, var_217_0.m_VerticalAxis.m_MaxValue)
		var_217_0.m_VerticalAxis = var_217_0.m_VerticalAxis

		local var_217_2 = self:GetRestritedHeightRange()

		self.mainCameraTF.position.y = math.clamp(self.mainCameraTF.position.y, var_217_2[1], var_217_2[2])
		self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE].transform.position = self.mainCameraTF.position

		self:emit(Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED, (math.InverseLerp(var_217_2[1], var_217_2[2], self.mainCameraTF.position.y)))
		self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE])
	else
		self:EnableJoystick(true)
		self:EnablePOVLayer(false)
		self:ActiveCamera(self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO])
	end

	self.contextData.photoFreeMode = not self.contextData.photoFreeMode

	return
end

function Dorm3dRoomTemplateScene:SetPhotoCameraHeight(arg_218_1)
	local var_218_0 = self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]
	local var_218_1 = self:GetRestritedHeightRange()

	self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE]:GetComponent(typeof(UnityEngine.CharacterController)):Move(Vector3.New(0, math.lerp(var_218_1[1], var_218_1[2], arg_218_1) - self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO_FREE].position.y, 0))
	onNextTick(function()
		local var_219_0 = self:GetRestritedHeightRange()

		self:emit(Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED, (math.InverseLerp(var_219_0[1], var_219_0[2], var_218_0.position.y)))

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:ResetPhotoCameraPosition()
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_XAxis.Value = 180
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_XAxis = self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_XAxis
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_YAxis.Value = 0.7
	self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_YAxis = self.cameras[Dorm3dRoomTemplateScene.CAMERA.PHOTO].m_YAxis

	return
end

function Dorm3dRoomTemplateScene:ResetCurrentCharPoint(arg_221_1)
	self:ResetCharPoint(self:GetCurrentLadyEnv(), arg_221_1)

	return
end

function Dorm3dRoomTemplateScene:ResetCharPoint(arg_222_1, arg_222_2)
	local var_222_0 = self.furnitures:Find(arg_222_2 .. "/StayPoint")

	arg_222_1.lady.position = var_222_0.position
	arg_222_1.lady.rotation = var_222_0.rotation

	return
end

function Dorm3dRoomTemplateScene:GetNearestAngle(arg_223_1, arg_223_2, arg_223_3)
	if arg_223_3 < arg_223_2 then
		arg_223_3 = arg_223_3 + 360
	end

	if arg_223_2 <= arg_223_1 and arg_223_1 <= arg_223_3 then
		return arg_223_1
	end

	arg_223_1 = (arg_223_2 + arg_223_3) / 2 - Mathf.DeltaAngle(arg_223_1, (arg_223_2 + arg_223_3) / 2)
	arg_223_1 = math.clamp(arg_223_1, arg_223_2, arg_223_3)

	return arg_223_1
end

function Dorm3dRoomTemplateScene:PlayTimeline(arg_224_1, arg_224_2)
	local var_224_0 = {}

	if self.waitForTimeline then
		table.insert(var_224_0, function(arg_225_0)
			self.waitForTimeline = nil

			self.waitForTimeline()
			arg_225_0()

			return
		end)
	end

	table.insert(var_224_0, function(arg_226_0)
		self:LoadTimelineScene(arg_224_1.name, false, nil, arg_226_0)

		return
	end)

	if arg_224_1.scene and arg_224_1.sceneRoot then
		table.insert(var_224_0, function(arg_227_0)
			self:ChangeArtScene(arg_224_1.scene .. "|" .. arg_224_1.sceneRoot, arg_227_0)

			return
		end)
	end

	table.insert(var_224_0, function(arg_228_0)
		local var_228_0 = Dorm3dHxHelper.GetTimelineMainCharacter()

		Dorm3dHxHelper.ShowHolyLight({
			var_228_0
		}, self.holyLightRoot)

		local var_228_1 = GameObject.Find("[actor]").transform

		table.IpairsCArray(var_228_1:GetComponentsInChildren(typeof(Animator), true), function(arg_229_0, arg_229_1)
			GetOrAddComponent(arg_229_1.transform, typeof(DftAniEvent))

			return
		end)

		var_228_0 = var_228_0 or var_228_1:GetComponentInChildren(typeof("BLHXCharacterPropertiesController")).transform

		local var_228_2

		eachChild(GameObject.Find("[camera]").transform, function(arg_230_0)
			if arg_230_0.tag == "MainCamera" then
				var_228_2 = arg_230_0
			end

			return
		end)
		assert(var_228_2, "Missing MainCamera")

		self.nowTimelinePlayer = TimelinePlayer.New(GameObject.Find("[sequence]").transform)

		TimelineSupport.InitSubtitle(self.nowTimelinePlayer.comDirector, self.apartment:GetCallName())
		self.nowTimelinePlayer:Register(arg_224_1.time, function(arg_231_0, arg_231_1, arg_231_2)
			switch(arg_231_1.stringParameter, {
				TimelinePause = function()
					arg_231_0:SetSpeed(0)

					return
				end,
				TimelineResume = function()
					arg_231_0:SetSpeed(1)

					return
				end,
				TimelinePlayOnTime = function()
					if arg_231_1.intParameter == 0 or arg_231_1.intParameter == arg_231_2.selectIndex then
						arg_231_0:SetTime(arg_231_1.floatParameter)
					end

					return
				end,
				TimelineSelectStart = function()
					arg_231_2.selectIndex = nil

					if arg_224_1.options then
						local var_235_0 = arg_224_1.options[arg_231_1.intParameter]

						self:DoTimelineOption(arg_224_1.options[arg_231_1.intParameter], function(arg_236_0)
							arg_231_2.selectIndex = arg_236_0
							arg_231_2.optionIndex = var_235_0[arg_236_0].flag

							arg_231_0:Play()

							return
						end)
					end

					return
				end,
				TimelineTouchStart = function()
					arg_231_2.selectIndex = nil

					if arg_224_1.touchs then
						local var_237_0 = arg_224_1.touchs[arg_231_1.intParameter]

						self:DoTimelineTouch(arg_224_1.touchs[arg_231_1.intParameter], function(arg_238_0)
							arg_231_2.selectIndex = arg_238_0
							arg_231_2.optionIndex = var_237_0[arg_238_0].flag

							return
						end)
					end

					return
				end,
				TimelineSelectLoop = function()
					if not arg_231_2.selectIndex then
						arg_231_0:RawSetTime(arg_231_1.floatParameter)
					end

					return
				end,
				TimelineSelect = function()
					arg_231_2.selectIndex = arg_231_1.intParameter

					return
				end,
				TimelineAccompanyJump = function()
					if self.canTriggerAccompanyPerformance then
						self.canTriggerAccompanyPerformance = false

						arg_231_0:SetTime(arg_224_1.accompanys[arg_231_1.intParameter][math.random(#arg_224_1.accompanys[arg_231_1.intParameter])])
					end

					return
				end,
				TimelineIKStart = function()
					arg_231_2.selectIndex = nil

					local var_242_0 = self:GetCurrentLadyEnv()

					if var_242_0:CheckIkTimelineStatus(arg_231_1.intParameter) then
						self:emit(RoomIKSystem.SET_IK_TIMELINE_STATUS, var_242_0, var_228_0.gameObject, arg_231_1.intParameter, var_228_2)
					end

					return
				end,
				TimelineEnd = function()
					arg_231_2.finish = true

					arg_231_0:SetSpeed(0)

					return
				end,
				TimelineAimIKStart = function()
					arg_231_2.selectIndex = nil

					self:emit(AimIKSystem.ENTER_TIMELINE_AIMIK_STATUS, arg_231_1.intParameter)

					return
				end
			}, function()
				warning("other event trigger:" .. arg_231_1.stringParameter)

				return
			end)

			if arg_231_2.finish then
				self.timelineMark = arg_231_2
				self.timelineFinishCall = nil

				pg.m02:sendNotification(Dorm3dRoomTemplateScene.TIMELINE_END)

				local var_231_0 = self:GetCurrentLadyEnv()

				if var_231_0.ikTimelineMode then
					self:emit(RoomIKSystem.EXIT_IK_TIMELINE_STATUS, var_231_0)
				end

				arg_228_0()
			end

			return
		end)

		function self.timelineFinishCall()
			self.nowTimelinePlayer:TriggerEvent({
				stringParameter = "TimelineEnd"
			})

			return
		end

		self:HideCharacter()
		setActive(self.mainCameraTF, false)
		setActive(var_228_2, true)
		eachChild(self.rtTimelineScreen, function(arg_247_0)
			setActive(arg_247_0, false)

			return
		end)
		setActive(self.rtTimelineScreen, true)
		setActive(self.rtTimelineScreen:Find("btn_skip"), self.inReplayTalk)
		self.nowTimelinePlayer:Start()

		return
	end)
	table.insert(var_224_0, function(arg_248_0)
		self:ShowBlackScreen(true, function()
			self.nowTimelinePlayer:Stop()
			self.nowTimelinePlayer:Dispose()

			self.nowTimelinePlayer = nil

			self:UnloadTimelineScene(arg_224_1.name, false, arg_248_0)

			return
		end)

		return
	end)

	local var_224_1 = self.dormSceneMgr.artSceneInfo

	table.insert(var_224_0, function(arg_250_0)
		self:RevertArtScene(var_224_1, arg_250_0)

		return
	end)
	seriesAsync(var_224_0, function()
		setActive(self.rtTimelineScreen, false)
		self:RevertCharacter()
		setActive(self.mainCameraTF, true)
		self:InitHolyLight()

		self.timelineMark = nil

		existCall(arg_224_2, self.timelineMark, function(arg_252_0)
			self:ShowBlackScreen(false, arg_252_0)

			return
		end)

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:GetCurrentLadyEnv()
	if not self.apartment then
		return nil
	end

	return self.ladyDict[self.apartment:GetConfigID()]
end

function Dorm3dRoomTemplateScene:PlayCurrentSingleAction(...)
	return self:PlaySingleAction(self:GetCurrentLadyEnv(), ...)
end

function Dorm3dRoomTemplateScene:PlaySingleAction(arg_255_1, arg_255_2, arg_255_3, arg_255_4)
	arg_255_1:PlaySingleAction(arg_255_2, arg_255_3, arg_255_4)

	return
end

function Dorm3dRoomTemplateScene:SwitchCurrentAnim(...)
	return self:SwitchAnim(self:GetCurrentLadyEnv(), ...)
end

function Dorm3dRoomTemplateScene:SwitchAnim(arg_257_1, arg_257_2, arg_257_3)
	arg_257_1:SwitchAnim(arg_257_2, arg_257_3)

	return
end

function Dorm3dRoomTemplateScene:PlayFaceAnim(arg_258_1, arg_258_2, arg_258_3)
	arg_258_1:PlayFaceAnim(arg_258_2, arg_258_3)

	return
end

function Dorm3dRoomTemplateScene:RegisterAnimCallback(arg_259_1, arg_259_2)
	self:GetCurrentLadyEnv().animCallbacks[arg_259_1] = arg_259_2

	return
end

function Dorm3dRoomTemplateScene:SetCharacterAnimSpeed(arg_260_1)
	local var_260_0 = self:GetCurrentLadyEnv()

	var_260_0.ladyAnimator.speed = arg_260_1
	var_260_0.ladyHeadIKComp.blinkSpeed = var_260_0.ladyHeadIKData.blinkSpeed * arg_260_1
	var_260_0.ladyHeadIKComp.DampTime = arg_260_1 > 0 and var_260_0.ladyHeadIKData.DampTime / arg_260_1 or var_260_0.ladyHeadIKData.DampTime * math.huge

	return
end

function Dorm3dRoomTemplateScene:OnAnimationEvent(arg_261_1)
	if arg_261_1.animatorClipInfo.weight < 0.5 then
		return
	end

	existCall((table.removebykey(self.animEventCallbacks, arg_261_1.stringParameter)))

	return
end

function Dorm3dRoomTemplateScene:RegisterAnimEventCallback(arg_262_1, arg_262_2)
	self.animEventCallbacks[arg_262_1] = arg_262_2

	return
end

function Dorm3dRoomTemplateScene:PlaySceneItemAnim(arg_263_1, arg_263_2, arg_263_3)
	self.sceneAnimatorDict = self.sceneAnimatorDict or {}

	if not self.sceneAnimatorDict[arg_263_1] then
		local var_263_0 = self:GetSceneItem(pg.dorm3d_scene_animator[arg_263_1].item_name)

		assert(var_263_0, "Missing Scene Animator in pg.dorm3d_scene_animator: " .. arg_263_1 .. " " .. pg.dorm3d_scene_animator[arg_263_1].item_name)

		if not var_263_0 then
			return
		end

		local var_263_1 = var_263_0:GetComponent(typeof(Animator))

		if not var_263_1 then
			return
		end

		self.sceneAnimatorDict[arg_263_1] = {
			trans = var_263_0,
			animator = var_263_1
		}
	end

	if not arg_263_3 then
		if self.sceneAnimatorDict[arg_263_1].animator:GetCurrentAnimatorStateInfo(0):IsName(arg_263_2) then
			return
		end
	end

	self.sceneAnimatorDict[arg_263_1].animator:PlayInFixedTime(arg_263_2)

	return
end

function Dorm3dRoomTemplateScene:ResetSceneItemAnimators(arg_264_1)
	if not self.sceneAnimatorDict then
		return
	end

	table.Foreach(self.sceneAnimatorDict, function(arg_265_0, arg_265_1)
		if arg_264_1 and table.contains(arg_264_1, arg_265_0) then
			return
		end

		setActive(arg_265_1.trans, false)
		setActive(arg_265_1.trans, true)

		self.sceneAnimatorDict[arg_265_0] = nil

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:LoadCharacterExtraItem(arg_266_1, arg_266_2, arg_266_3, arg_266_4, arg_266_5, arg_266_6, arg_266_7)
	local function var_266_0(arg_267_0)
		if arg_266_6 then
			local var_267_0 = arg_267_0:GetComponent(typeof(Animator))

			if var_267_0 then
				var_267_0:Play(arg_266_6)

				var_267_0.speed = arg_266_7
			end
		end

		return
	end

	arg_266_1.extraItems = arg_266_1.extraItems or {}

	if arg_266_1.extraItems[arg_266_2] then
		var_266_0(arg_266_1.extraItems[arg_266_2].trans)

		return
	end

	local var_266_1

	if arg_266_3 == "" then
		var_266_1 = arg_266_1.lady
	elseif arg_266_3 == "scene_root" then
		var_266_1 = self.modelRoot
	else
		table.IpairsCArray(arg_266_1.lady:GetComponentsInChildren(typeof(Transform), true), function(arg_268_0, arg_268_1)
			if arg_268_1.name == arg_266_3 then
				var_266_1 = arg_268_1
			end

			return
		end)
	end

	if not var_266_1 then
		return
	end

	self.loader:GetPrefab(string.lower("dorm3d/" .. arg_266_2), "", function(arg_269_0)
		setParent(arg_269_0, var_266_1)

		if arg_266_4 then
			setLocalPosition(arg_269_0, arg_266_4)
		end

		if arg_266_5 then
			setLocalRotation(arg_269_0, arg_266_5)
		end

		var_266_0(arg_269_0)

		arg_266_1.extraItems[arg_266_2] = {
			trans = arg_269_0.transform,
			handler = var_266_1
		}

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:ResetCharacterExtraItem(arg_270_1, arg_270_2)
	if not arg_270_1.extraItems then
		return
	end

	table.Foreach(arg_270_1.extraItems, function(arg_271_0, arg_271_1)
		if arg_270_2 and table.contains(arg_270_2, arg_271_0) then
			return
		end

		self.loader:ReturnPrefab(arg_271_1.trans.gameObject)

		arg_270_1.extraItems[arg_271_0] = nil

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:RegisterCameraBlendFinished(arg_272_1, arg_272_2)
	self.cameraBlendCallbacks[arg_272_1] = arg_272_2

	return
end

function Dorm3dRoomTemplateScene:UnRegisterCameraBlendFinished(arg_273_1)
	self.cameraBlendCallbacks[arg_273_1] = nil

	return
end

function Dorm3dRoomTemplateScene:OnCameraBlendFinished(arg_274_1)
	if not arg_274_1 then
		return
	end

	existCall((table.removebykey(self.cameraBlendCallbacks, arg_274_1)))

	return
end

function Dorm3dRoomTemplateScene:PlayHeartFX(arg_275_1)
	setActive(self.ladyDict[arg_275_1].effectHeart, false)
	setActive(self.ladyDict[arg_275_1].effectHeart, true)
	pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_joyful")

	return
end

function Dorm3dRoomTemplateScene:PlayExpression(arg_276_1)
	local var_276_0 = arg_276_1.name

	if self.expressionDict[arg_276_1.name] then
		self.expressionDict[arg_276_1.name].timer:Reset(nil, 5)
		self.expressionDict[arg_276_1.name].timer:Start()

		if self.expressionDict[arg_276_1.name].instance then
			setActive(self.expressionDict[arg_276_1.name].instance, false)
			setActive(self.expressionDict[arg_276_1.name].instance, true)
		end

		return
	end

	local var_276_1 = {
		name = arg_276_1.name,
		timer = Timer.New(function()
			self:RemoveExpression(var_276_0)

			return
		end, 5, 1, true)
	}

	self.expressionDict[arg_276_1.name] = var_276_1

	self.loader:GetPrefab("dorm3D/effect/prefab/expression/" .. arg_276_1.name, arg_276_1.name, function(arg_278_0)
		var_276_1.instance = arg_278_0

		onNextTick(function()
			setParent(arg_278_0, self:GetCurrentLadyEnv().ladyHeadCenter)

			return
		end)
		setLocalPosition(arg_278_0, Vector3(0, 0, -0.2))
		setActive(arg_278_0, false)
		setActive(arg_278_0, true)

		return
	end, var_276_1)

	return
end

function Dorm3dRoomTemplateScene:RemoveExpression(arg_280_1)
	if not self.expressionDict[arg_280_1] then
		return
	end

	self.loader:ClearRequest(self.expressionDict[arg_280_1])

	if self.expressionDict[arg_280_1].instance then
		self.loader:ReturnPrefab(self.expressionDict[arg_280_1].instance)
	end

	self.expressionDict[arg_280_1] = nil

	return
end

function Dorm3dRoomTemplateScene:ShowOrHideCanWatchMark(arg_281_1, arg_281_2)
	setActive(arg_281_1.ladyWatchFloat, arg_281_2)

	return
end

function Dorm3dRoomTemplateScene:RegisterGlobalVolume()
	local var_282_0 = GraphicsInterface.Instance.GetOrAddVolumeComponent(self.globalVolume, typeof(BLHX.Rendering.CustomDepthOfField))
	local var_282_1 = GraphicsInterface.Instance.GetOrAddVolumeComponent(self.globalVolume, typeof(UnityEngine.Rendering.Universal.ColorAdjustments))

	self.originalCameraSettings = {
		depthOfField = {
			enabled = var_282_0.enabled.value,
			focusDistance = {
				length = 2,
				min = var_282_0.gaussianStart.min,
				value = var_282_0.gaussianStart.value
			},
			blurRadius = {
				min = var_282_0.blurRadius.min,
				max = var_282_0.blurRadius.max,
				value = var_282_0.blurRadius.value
			}
		},
		postExposure = {
			value = var_282_1.postExposure.value
		},
		contrast = {
			min = var_282_1.contrast.min,
			max = var_282_1.contrast.max,
			value = var_282_1.contrast.value
		},
		saturate = {
			min = var_282_1.saturation.min,
			max = var_282_1.saturation.max,
			value = var_282_1.saturation.value
		}
	}
	self.originalCameraSettings.depthOfField.enabled = true

	local var_282_2 = self.globalVolume:GetComponent(typeof(UnityEngine.Rendering.Volume))

	self.originalVolume = {
		profile = var_282_2.sharedProfile,
		weight = var_282_2.weight
	}

	return
end

function Dorm3dRoomTemplateScene:SettingCamera(arg_283_1)
	self.activeCameraSettings = arg_283_1

	local var_283_0 = GraphicsInterface.Instance.GetOrAddVolumeComponent(self.globalVolume, typeof(BLHX.Rendering.CustomDepthOfField))
	local var_283_1 = GraphicsInterface.Instance.GetOrAddVolumeComponent(self.globalVolume, typeof(UnityEngine.Rendering.Universal.ColorAdjustments))

	var_283_0.enabled:Override(arg_283_1.depthOfField.enabled)
	var_283_0.gaussianStart:Override(arg_283_1.depthOfField.focusDistance.value)
	var_283_0.gaussianEnd:Override(arg_283_1.depthOfField.focusDistance.value + arg_283_1.depthOfField.focusDistance.length)
	var_283_0.blurRadius:Override(arg_283_1.depthOfField.blurRadius.value)
	var_283_1.postExposure:Override(arg_283_1.postExposure.value)
	var_283_1.contrast:Override(arg_283_1.contrast.value)
	var_283_1.saturation:Override(arg_283_1.saturate.value)

	return
end

function Dorm3dRoomTemplateScene:GetCameraSettings()
	return self.originalCameraSettings
end

function Dorm3dRoomTemplateScene:RevertCameraSettings()
	self:SettingCamera(self.originalCameraSettings)

	self.activeCameraSettings = nil

	return
end

function Dorm3dRoomTemplateScene:SetVolumeProfile(arg_286_1, arg_286_2)
	if self.cameraVolume then
		self:RevertVolumeProfile()
	end

	self.loader:GetPrefab("dorm3d/effect/volume/" .. arg_286_1, "", function(arg_287_0)
		self.cameraVolume = arg_287_0

		return
	end)

	return
end

function Dorm3dRoomTemplateScene:RevertVolumeProfile()
	if self.cameraVolume then
		self.loader:ReturnPrefab(self.cameraVolume)

		self.cameraVolume = nil
	end

	return
end

function Dorm3dRoomTemplateScene:RecordCharacterLight()
	tolua.loadassembly("Yongshi.BLRP.Runtime.AOT")

	local var_289_0 = self.characterLight:GetComponent(typeof("BLHX.Rendering.CharacterLight"))

	self.originalCharacterColor = {
		color = ReflectionHelp.RefGetProperty(typeof("BLHX.Rendering.CharacterLight"), "characterLightColor", var_289_0),
		intensity = ReflectionHelp.RefGetProperty(typeof("BLHX.Rendering.CharacterLight"), "characterLightIntensity", var_289_0)
	}

	return
end

function Dorm3dRoomTemplateScene:SetCharacterLight(arg_290_1, arg_290_2, arg_290_3)
	local var_290_0 = self.characterLight:GetComponent(typeof(Light))
	local var_290_1 = self.characterLight:GetComponent(typeof("BLHX.Rendering.CharacterLight"))

	ReflectionHelp.RefSetProperty(typeof("BLHX.Rendering.CharacterLight"), "characterLightColor", var_290_1, (Color.Lerp(self.originalCharacterColor.color, arg_290_1, arg_290_3)))
	ReflectionHelp.RefSetProperty(typeof("BLHX.Rendering.CharacterLight"), "characterLightIntensity", var_290_1, (math.lerp(self.originalCharacterColor.intensity, arg_290_2, arg_290_3)))

	return
end

function Dorm3dRoomTemplateScene:RevertCharacterLight()
	self:SetCharacterLight(self.originalCharacterColor.color, self.originalCharacterColor.intensity, 1)

	return
end

function Dorm3dRoomTemplateScene:onBackPressed()
	if self.exited or self.retainCount > 0 then
		-- block empty
	else
		self:closeView()
	end

	return
end

function Dorm3dRoomTemplateScene:LoadTimelineScene(arg_293_1, arg_293_2, arg_293_3, arg_293_4)
	self.dormSceneMgr:LoadTimelineScene({
		name = arg_293_1,
		assetRootName = self.apartment:getConfig("asset_name"),
		isCache = arg_293_2,
		waitForTimeline = arg_293_3,
		loadSceneFunc = function(arg_294_0, arg_294_1)
			local var_294_0 = Dorm3dHxHelper.GetTimelineMainCharacter()

			Dorm3dHxHelper.HideCharacterPart(var_294_0, nil, true)
			self:HXCharacter(var_294_0)

			return
		end
	}, arg_293_4)

	return
end

function Dorm3dRoomTemplateScene:UnloadTimelineScene(arg_295_1, arg_295_2, arg_295_3)
	self.dormSceneMgr:UnloadTimelineScene(arg_295_1, arg_295_2, arg_295_3)

	return
end

function Dorm3dRoomTemplateScene:ChangeArtScene(arg_296_1, arg_296_2)
	local var_296_0 = {}

	table.insert(var_296_0, function(arg_297_0)
		self.dormSceneMgr:ChangeArtScene(arg_296_1, arg_297_0)

		return
	end)
	table.insert(var_296_0, function(arg_298_0)
		setActive(self.slotRoot, false)
		arg_298_0()

		return
	end)
	warning(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>", arg_296_1, self.dormSceneMgr.sceneInfo, Dorm3dSceneMgr.IsSameSceneInfo(arg_296_1, self.dormSceneMgr.sceneInfo))

	if Dorm3dSceneMgr.IsSameSceneInfo(arg_296_1, self.dormSceneMgr.sceneInfo) then
		table.insert(var_296_0, function(arg_299_0)
			self:SwitchDayNight(1)
			self:TempHideContact(true)
			arg_299_0()

			return
		end)
	end

	seriesAsync(var_296_0, arg_296_2)

	return
end

function Dorm3dRoomTemplateScene:RevertArtScene(arg_300_1, arg_300_2)
	local var_300_0 = {}

	table.insert(var_300_0, function(arg_301_0)
		self.dormSceneMgr:ChangeArtScene(arg_300_1, arg_301_0)

		return
	end)
	table.insert(var_300_0, function(arg_302_0)
		setActive(self.slotRoot, true)
		arg_302_0()

		return
	end)
	table.insert(var_300_0, function(arg_303_0)
		self:SwitchDayNight(self.contextData.timeIndex)
		onNextTick(function()
			self:RefreshSlots()
			self:TempHideContact(false)
			arg_303_0()

			return
		end)

		return
	end)
	seriesAsync(var_300_0, arg_300_2)

	return
end

function Dorm3dRoomTemplateScene:ChangeSubScene(arg_305_1, arg_305_2)
	local var_305_0 = {}

	table.insert(var_305_0, function(arg_306_0)
		self.dormSceneMgr:ChangeSubScene(arg_305_1, arg_306_0)

		return
	end)

	local var_305_1 = self:GetCurrentLadyEnv()

	table.insert(var_305_0, function(arg_307_0)
		if Dorm3dSceneMgr.IsSameSceneInfo(arg_305_1, self.dormSceneMgr.sceneInfo) then
			var_305_1.ladyActiveZone = var_305_1.walkBornPoint or var_305_1.ladyBaseZone
		elseif not var_305_1.walkBornPoint then
			var_305_1.ladyActiveZone = "Default"
		end

		arg_307_0()

		return
	end)

	if not Dorm3dSceneMgr.IsSameSceneInfo(arg_305_1, self.dormSceneMgr.subSceneInfo) then
		table.insert(var_305_0, function(arg_308_0)
			local var_308_0, var_308_1 = Dorm3dSceneMgr.ParseInfo(arg_305_1)

			self:ResetSceneStructure(SceneManager.GetSceneByName(var_308_0 .. "_base"))

			if Dorm3dSceneMgr.IsSameSceneInfo(arg_305_1, self.dormSceneMgr.sceneInfo) then
				self:RefreshSlots()
			else
				self:SwitchAnim(var_305_1, Dorm3dRoomTemplateScene.ANIM.IDLE)
			end

			if not Dorm3dSceneMgr.IsSameSceneInfo(self.dormSceneMgr.subSceneInfo, self.dormSceneMgr.sceneInfo) then
				self:RefreshSlotsEmpty()
			end

			arg_308_0()

			return
		end)
	end

	table.insert(var_305_0, function(arg_309_0)
		onNextTick(function()
			self:ChangeCharacterPosition(var_305_1)
			self:ChangePlayerPosition(var_305_1.ladyActiveZone)
			self:TriggerLadyDistance()
			self:CheckInSector()
			arg_309_0()

			return
		end)

		return
	end)
	seriesAsync(var_305_0, arg_305_2)

	return
end

function Dorm3dRoomTemplateScene:IsPointInSector(arg_311_1)
	local var_311_0 = arg_311_1 - self.Position

	if (arg_311_1 - self.Position).y > self.Radius then
		return false
	end

	var_311_0.y = 0

	if var_311_0.magnitude > self.Radius then
		return false
	end

	return Vector3.Angle(self.Rotation * Vector3.forward, var_311_0) <= self.Angle / 2
end

function Dorm3dRoomTemplateScene:GetRestritedHeightRange()
	if not self.isMultiFloor then
		return self.restrictedHeightRange
	else
		for iter_312_0 = #self.restrictedHeightRange, 1, -1 do
			if self.mainCameraTF.position.y >= self.restrictedHeightRange[iter_312_0][1] then
				return self.restrictedHeightRange[iter_312_0]
			end
		end

		return self.restrictedHeightRange[1]
	end

	return
end

function Dorm3dRoomTemplateScene:willExit()
	Dorm3dRoomTemplateScene.super.willExit(self)
	self.joystickTimer:Stop()
	self.moveStickTimer:Stop()
	UpdateBeat:RemoveListener(self.updateHandler)

	if self.moveTimer then
		self.moveTimer:Stop()

		self.moveTimer = nil
	end

	if self.moveWaitTimer then
		self.moveWaitTimer:Stop()

		self.moveWaitTimer = nil
	end

	GlobalClickEventMgr.Inst:RemoveBeginPinchFunc()
	GlobalClickEventMgr.Inst:RemovePinchFunc()
	GlobalClickEventMgr.Inst:RemoveEndPinchFunc()

	if not IsNil(self.furnitures) then
		eachChild(self.furnitures, function(arg_314_0)
			local var_314_0 = GetComponent(arg_314_0, typeof(EventTriggerListener))

			if not var_314_0 then
				return
			end

			var_314_0:ClearEvents()

			return
		end)
	end

	pg.IKMgr.GetInstance():ResetActiveIKs()

	for iter_313_0, iter_313_1 in pairs(self.ladyDict) do
		GetComponent(iter_313_1.lady, typeof(EventTriggerListener)):ClearEvents()
	end

	self.camBrainEvenetHandler.OnBlendStarted = nil
	self.camBrainEvenetHandler.OnBlendFinished = nil

	self:UnOverlayPanel(self.blockLayer, self._tf)
	table.Foreach(self.expressionDict, function(arg_315_0)
		self:RemoveExpression(arg_315_0)

		return
	end)
	self.loader:Clear()
	pg.ClickEffectMgr.GetInstance():SetClickEffect("NORMAL")
	pg.NodeCanvasMgr.GetInstance():Clear()
	self.dormSceneMgr:Dispose()

	self.dormSceneMgr = nil

	ReflectionHelp.RefSetProperty(typeof("UnityEngine.LightmapSettings"), "lightmaps", nil, nil)

	if self.transformFilter then
		self.transformFilter:Dispose()
	end

	return
end

return Dorm3dRoomTemplateScene
