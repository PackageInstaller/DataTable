local var_0_0 = class("Dorm3dRoomTemplateScene", import("view.dorm3d.Core.Dorm3dBaseScene"))

var_0_0.CAMERA = {
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
var_0_0.CAMERA_MAX_OPERATION = {
	RIGHT = "right",
	DOWN = "donw",
	ZOOMIN = "zoom_in",
	ZOOMOUT = "zoom_out",
	UP = "up",
	LEFT = "left"
}
var_0_0.ANIM = {
	IDLE = "Idle"
}
var_0_0.PLAY_EXPRESSION = "Dorm3dRoomTemplateScene.PLAY_EXPRESSION"
var_0_0.MOVE_PLAYER_TO_FURNITURE = "Dorm3dRoomTemplateScene.MOVE_PLAYER_TO_FURNITURE"
var_0_0.SHOW_BLOCK = "Dorm3dRoomTemplateScene.SHOW_BLOCK"
var_0_0.HIDE_BLOCK = "Dorm3dRoomTemplateScene.HIDE_BLOCK"
var_0_0.ON_ROLEWATCH_CAMERA_MAX = "Dorm3dRoomTemplateScene.ON_ROLEWATCH_CAMERA_MAX"
var_0_0.ON_STICK_MOVE = "Dorm3dRoomTemplateScene.ON_STICK_MOVE"
var_0_0.ENABLE_SCENEBLOCK = "Dorm3dRoomTemplateScene.ENABLE_SCENEBLOCK"
var_0_0.ON_POV_STICK_MOVE_BEGIN = "Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_BEGIN"
var_0_0.ON_POV_STICK_MOVE = "Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE"
var_0_0.ON_POV_STICK_MOVE_END = "Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_END"
var_0_0.ON_POV_STICK_VIEW = "Dorm3dRoomTemplateScene.ON_POV_STICK_VIEW"
var_0_0.ON_ENTER_SECTOR = "Dorm3dRoomTemplateScene.ON_ENTER_SECTOR"
var_0_0.ON_CHANGE_DISTANCE = "Dorm3dRoomTemplateScene.ON_CHANGE_DISTANCE"
var_0_0.CLICK_CHARACTER = "Dorm3dRoomTemplateScene.CLICK_CHARACTER"
var_0_0.CLICK_CONTACT = "Dorm3dRoomTemplateScene.CLICK_CONTACT"
var_0_0.DISTANCE_TRIGGER = "Dorm3dRoomTemplateScene.DISTANCE_TRIGGER"
var_0_0.WALK_DISTANCE_TRIGGER = "Dorm3dRoomTemplateScene.WALK_DISTANCE_TRIGGER"
var_0_0.CHANGE_WATCH = "Dorm3dRoomTemplateScene.CHANGE_WATCH"
var_0_0.PHOTO_CALL = "Dorm3dRoomTemplateScene.PHOTO_CALL"
var_0_0.SHIFT_ZONE_SAFE = "Dorm3dRoomTemplateScene.SHIFT_ZONE_SAFE"
var_0_0.TIMELINE_END = "Dorm3dRoomTemplateScene.TIMELINE_END"
var_0_0.TRIGGER_TIMELINE_PLAYER_EVENT = "Dorm3dRoomTemplateScene.TRIGGER_TIMELINE_PLAYER_EVENT"
var_0_0.POV_CLOSE_DISTANCE = 1.5
var_0_0.POV_PENDING_CLOSE_DISTANCE = 2

function var_0_0.getUIName(arg_1_0)
	return nil
end

function var_0_0.forceGC(arg_2_0)
	return true
end

function var_0_0.loadingQueue(arg_3_0)
	return function(arg_4_0)
		pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_5_0)
			return arg_4_0(arg_5_0)
		end)

		return
	end
end

function var_0_0.getBGM(arg_6_0)
	if pg.dorm3d_rooms[arg_6_0.contextData.roomId].room_bgm and pg.dorm3d_rooms[arg_6_0.contextData.roomId].room_bgm ~= "" then
		return pg.dorm3d_rooms[arg_6_0.contextData.roomId].room_bgm
	else
		return var_0_0.super.getBGM(arg_6_0)
	end

	return
end

function var_0_0.Ctor(arg_7_0, ...)
	var_0_0.super.Ctor(arg_7_0, ...)

	arg_7_0.loader = AutoLoader.New()
	arg_7_0.scene = arg_7_0

	return
end

function var_0_0.SetRoom(arg_8_0, arg_8_1)
	arg_8_0.room = arg_8_1

	return
end

function var_0_0.preload(arg_9_0, arg_9_1)
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

	arg_9_0.room = getProxy(ApartmentProxy):getRoom(arg_9_0.contextData.roomId)

	table.insert({}, function(arg_10_0)
		arg_9_0.dormSceneMgr = Dorm3dSceneMgr.New(arg_9_0.room:getConfig("scene_info"), arg_10_0)

		return
	end)
	table.insert({}, function(arg_11_0)
		arg_9_0:LoadCharacter(arg_9_0.contextData.groupIds, arg_11_0)

		return
	end)
	seriesAsync({}, arg_9_1)

	return
end

function var_0_0.init(arg_12_0)
	arg_12_0:BindEvent()
	arg_12_0:InitData()
	arg_12_0:initScene()
	arg_12_0:initNodeCanvas()

	if arg_12_0.room:isPersonalRoom() then
		local var_12_0 = getProxy(ApartmentProxy):getApartment(arg_12_0.contextData.groupIds[1]):GetCurSkinId()

		setActive(arg_12_0.ladyDict[arg_12_0.contextData.groupIds[1]].ladyGameObject, false)

		arg_12_0.ladyDict[arg_12_0.contextData.groupIds[1]].skinId = var_12_0
		arg_12_0.ladyDict[arg_12_0.contextData.groupIds[1]].ladyGameObject = arg_12_0.skinDict[var_12_0].ladyGameObject

		setActive(arg_12_0.ladyDict[arg_12_0.contextData.groupIds[1]].ladyGameObject, true)
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.ladyDict) do
		arg_12_0:InitCharacter(iter_12_1, iter_12_0)
	end

	if not arg_12_0.room:isPersonalRoom() then
		local var_12_1 = underscore.detect(arg_12_0.contextData.groupIds, function(arg_13_0)
			return arg_12_0.contextData.ladyZone[arg_13_0] == arg_12_0.contextData.inFurnitureName
		end) or arg_12_0.contextData.groupIds[1]

		if var_12_1 then
			arg_12_0:SyncInterestTransform(arg_12_0.ladyDict[var_12_1])
		end

		if SlideExtraSystem.IsOpen(arg_12_0.room) and arg_12_0.contextData.inFurnitureName == SlideConst.SLIDE_ZONE then
			arg_12_0:SyncInterestTransformByTf(arg_12_0:GetFurnitureByName(arg_12_0.contextData.inFurnitureName):Find("StayPoint"))
		end
	end

	arg_12_0.retainCount = 0
	arg_12_0.sceneBlockLayer = arg_12_0._tf:Find("SceneBlock")

	setActive(arg_12_0.sceneBlockLayer, false)

	arg_12_0.blockLayer = arg_12_0._tf:Find("Block")

	setActive(arg_12_0.blockLayer, false)

	arg_12_0.blackLayer = arg_12_0._tf:Find("BlackScreen")

	setActive(arg_12_0.blackLayer, false)

	arg_12_0.holyLightRoot = arg_12_0._tf:Find("HolyLightRoot")

	arg_12_0:InitHolyLight()
	arg_12_0:ChangePlayerPosition()

	arg_12_0.cacheSceneDic = {}
	arg_12_0.sceneGroupDic = {}
	arg_12_0.lastSceneRootDict = {}

	pg.ClickEffectMgr.GetInstance():SetClickEffect("DORM3D")

	return
end

function var_0_0.BindEvent(arg_14_0)
	arg_14_0:bind(var_0_0.PLAY_EXPRESSION, function(arg_15_0, arg_15_1)
		arg_14_0:PlayExpression(arg_15_1)

		return
	end)
	arg_14_0:bind(var_0_0.SHOW_BLOCK, function()
		arg_14_0.retainCount = arg_14_0.retainCount + 1

		setActive(arg_14_0.blockLayer, true)

		return
	end)
	arg_14_0:bind(var_0_0.HIDE_BLOCK, function()
		arg_14_0.retainCount = math.max(arg_14_0.retainCount - 1, 0)

		if arg_14_0.retainCount > 0 then
			return
		end

		setActive(arg_14_0.blockLayer, false)

		return
	end)
	arg_14_0:bind(var_0_0.ENABLE_SCENEBLOCK, function(arg_18_0, arg_18_1)
		setActive(arg_14_0.sceneBlockLayer, arg_18_1)

		return
	end)
	arg_14_0:bind(var_0_0.ON_STICK_MOVE, function(arg_19_0, arg_19_1)
		arg_14_0:OnStickMove(arg_19_1)

		return
	end)
	arg_14_0:bind(var_0_0.ON_POV_STICK_MOVE_BEGIN, function(arg_20_0, arg_20_1)
		if arg_14_0.pinchMode then
			return
		end

		arg_14_0.moveStickOrigin = arg_20_1.position
		arg_14_0.moveStickPosition = arg_14_0.moveStickOrigin
		arg_14_0.moveStickDraging = true

		return
	end)

	local function var_14_0()
		arg_14_0.moveStickOrigin = nil
		arg_14_0.moveStickPosition = nil
		arg_14_0.moveStickDraging = nil

		if isActive(arg_14_0.cameras[var_0_0.CAMERA.PHOTO_FREE]) then
			arg_14_0:emit(Dorm3dPhotoMediator.CAMERA_STICK_MOVE, Vector2.zero)
		end

		return
	end

	arg_14_0:bind(var_0_0.ON_POV_STICK_MOVE_END, function(arg_22_0, arg_22_1)
		var_14_0()

		return
	end)
	arg_14_0:bind(var_0_0.ON_POV_STICK_MOVE, function(arg_23_0, arg_23_1)
		if arg_14_0.pinchMode then
			var_14_0()

			return
		end

		if not arg_14_0.moveStickDraging then
			return
		end

		arg_14_0.moveStickPosition = arg_14_0.moveStickPosition + arg_23_1

		if isActive(arg_14_0.povLayer:Find("Guide")) then
			setActive(arg_14_0.povLayer:Find("Guide"), false)
		end

		return
	end)

	local var_14_1 = 32.4 / Screen.height

	arg_14_0:bind(var_0_0.ON_POV_STICK_VIEW, function(arg_24_0, arg_24_1)
		if arg_14_0.pinchMode then
			return
		end

		arg_24_1 = arg_24_1 * var_14_1

		if isActive(arg_14_0.cameras[var_0_0.CAMERA.POV]) then
			(function(arg_25_0, arg_25_1, arg_25_2)
				arg_25_0[arg_25_1].m_InputAxisValue = arg_25_2
				arg_25_0[arg_25_1] = arg_25_0[arg_25_1]

				return
			end)(arg_14_0.compPovAim, "m_HorizontalAxis", arg_24_1.x)
			;(function(arg_25_0, arg_25_1, arg_25_2)
				arg_25_0[arg_25_1].m_InputAxisValue = arg_25_2
				arg_25_0[arg_25_1] = arg_25_0[arg_25_1]

				return
			end)(arg_14_0.compPovAim, "m_VerticalAxis", arg_24_1.y)
		elseif isActive(arg_14_0.cameras[var_0_0.CAMERA.PHOTO_FREE]) then
			local var_24_0 = arg_14_0.cameras[var_0_0.CAMERA.PHOTO_FREE]:Find("PhotoFree Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)):GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim)

			;(function(arg_25_0, arg_25_1, arg_25_2)
				arg_25_0[arg_25_1].m_InputAxisValue = arg_25_2
				arg_25_0[arg_25_1] = arg_25_0[arg_25_1]

				return
			end)(var_24_0, "m_HorizontalAxis", arg_24_1.x)
			;(function(arg_25_0, arg_25_1, arg_25_2)
				arg_25_0[arg_25_1].m_InputAxisValue = arg_25_2
				arg_25_0[arg_25_1] = arg_25_0[arg_25_1]

				return
			end)(var_24_0, "m_VerticalAxis", arg_24_1.y)
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

	arg_14_0:bind(var_0_0.PHOTO_CALL, function(arg_26_0, arg_26_1, ...)
		if var_14_2[arg_26_1] then
			arg_14_0[arg_26_1](arg_14_0, arg_14_0:GetCurrentLadyEnv(), ...)
		else
			arg_14_0[arg_26_1](arg_14_0, ...)
		end

		return
	end)
	arg_14_0:bind(var_0_0.SHIFT_ZONE_SAFE, function(arg_27_0, arg_27_1)
		arg_14_0:ShiftZoneSafe(arg_27_1)

		return
	end)
	arg_14_0:bind(var_0_0.TRIGGER_TIMELINE_PLAYER_EVENT, function(arg_28_0, arg_28_1)
		if not arg_14_0.nowTimelinePlayer then
			warning("nowTimelinePlayer is nil, can't trigger event", arg_28_1)

			return
		end

		arg_14_0.nowTimelinePlayer:TriggerEvent(arg_28_1)

		return
	end)

	return
end

function var_0_0.initScene(arg_29_0)
	local var_29_0, var_29_1 = unpack(string.split(arg_29_0.dormSceneMgr.sceneInfo, "|"))

	arg_29_0:ResetSceneStructure((SceneManager.GetSceneByName(var_29_0 .. "_base")))

	arg_29_0.mainCameraTF = GameObject.Find("BackYardMainCamera").transform
	arg_29_0.camBrain = arg_29_0.mainCameraTF:GetComponent(typeof(Cinemachine.CinemachineBrain))
	arg_29_0.camBrainEvenetHandler = arg_29_0.mainCameraTF:GetComponent(typeof(CameraBrainEventsHandler))
	arg_29_0.raycastCamera = arg_29_0.mainCameraTF:Find("CameraForRaycast"):GetComponent(typeof(Camera))
	arg_29_0.sceneRaycaster = arg_29_0.raycastCamera:GetComponent(typeof(UnityEngine.EventSystems.PhysicsRaycaster))
	arg_29_0.player = GameObject.Find("Player").transform
	arg_29_0.playerEye = arg_29_0.player:Find("Eye")
	arg_29_0.playerFoot = arg_29_0.player:Find("Foot")

	setActive(arg_29_0.playerFoot, false)

	arg_29_0.playerController = arg_29_0.player:GetComponent(typeof(UnityEngine.CharacterController))
	arg_29_0.attachedPoints = {}

	eachChild(arg_29_0.furnitures, function(arg_30_0)
		table.insert(arg_29_0.attachedPoints, 1, arg_30_0)

		return
	end)

	arg_29_0.modelRoot = GameObject.Find("scene_root").transform
	arg_29_0.slotRoot = GameObject.Find("FurnitureSlots").transform

	setActive(arg_29_0.slotRoot, true)
	arg_29_0:InitSlots()
	tolua.loadassembly("Cinemachine")

	local var_29_2 = GameObject.Find("CM Cameras").transform

	eachChild(var_29_2, function(arg_31_0)
		setActive(arg_31_0, false)

		return
	end)

	arg_29_0.camBrain.enabled = false
	arg_29_0.camBrain.enabled = true
	arg_29_0.cameraAim = var_29_2:Find("Aim Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	arg_29_0.cameraAim2 = var_29_2:Find("Aim2 Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	arg_29_0.cameraFree = nil
	arg_29_0.cameraFurnitureWatch = nil
	arg_29_0.cameraRole = var_29_2:Find("Role Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	arg_29_0.cameraRole2 = var_29_2:Find("Role2 Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	arg_29_0.cameraGift = var_29_2:Find("Gift Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	local var_29_3 = {
		arg_29_0.cameraAim,
		arg_29_0.cameraAim2,
		arg_29_0.cameraRole,
		[var_0_0.CAMERA.TALK] = var_29_2:Find("Talk Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)),
		[var_0_0.CAMERA.GIFT] = arg_29_0.cameraGift,
		[var_0_0.CAMERA.ROLE2] = arg_29_0.cameraRole2
	}

	var_29_3[var_0_0.CAMERA.PHOTO] = var_29_2:Find("Photo Camera"):GetComponent(typeof(Cinemachine.CinemachineFreeLook))
	var_29_3[var_0_0.CAMERA.PHOTO_FREE] = var_29_2:Find("PhotoFree Controller")
	var_29_3[var_0_0.CAMERA.POV] = var_29_2:Find("FP Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	local var_29_4 = var_0_0.CAMERA.SKIN

	if arg_29_0.room:isPersonalRoom() then
		var_29_3[var_29_4] = var_29_2:Find("Skin Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)) or nil
		arg_29_0.cameras = var_29_3

		setActive(arg_29_0.cameras[var_0_0.CAMERA.PHOTO_FREE]:Find("PhotoFree Camera"), true)

		arg_29_0.compPovAim = arg_29_0.cameras[var_0_0.CAMERA.POV]:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim)
		arg_29_0.cameraRoot = var_29_2
		arg_29_0.POVOriginalFOV = arg_29_0:GetPOVFOV()
		arg_29_0.restrictedBox = GameObject.Find("RestrictedArea").transform

		setActive(arg_29_0.restrictedBox, false)

		local var_29_5 = arg_29_0.cameras[var_0_0.CAMERA.PHOTO_FREE]:GetComponent(typeof(CharacterController)).radius

		arg_29_0.isMultiFloor = arg_29_0.restrictedBox.childCount > 2

		local var_29_6 = "Floor"
		local var_29_7 = "Celling"

		if arg_29_0.isMultiFloor then
			arg_29_0.restrictedHeightRange = {}

			for iter_29_0 = 0, math.floor(arg_29_0.restrictedBox.childCount / 2) - 1 do
				table.insert(arg_29_0.restrictedHeightRange, {
					arg_29_0.restrictedBox:Find(iter_29_0 == 0 and var_29_6 or var_29_6 .. "_" .. iter_29_0).position.y + var_29_5,
					arg_29_0.restrictedBox:Find(iter_29_0 == 0 and var_29_7 or var_29_7 .. "_" .. iter_29_0).position.y - var_29_5
				})
			end
		else
			arg_29_0.restrictedHeightRange = {
				arg_29_0.restrictedBox:Find(var_29_6).position.y + var_29_5,
				arg_29_0.restrictedBox:Find(var_29_7).position.y - var_29_5
			}
		end

		arg_29_0.ladyInterest = GameObject.Find("InterestProxy").transform
		arg_29_0.daynightCtrlComp = GameObject.Find("[MainBlock]").transform:GetComponent("DayNightCtrl")

		arg_29_0:SwitchDayNight(arg_29_0.contextData.timeIndex)

		arg_29_0.tfCutIn = getSceneRootTFDic(SceneManager.GetSceneByName(var_29_0 .. "_base")).CutIn

		if arg_29_0.tfCutIn then
			({}).lady = arg_29_0.tfCutIn:Find("lady"):GetChild(0)
			;({}).player = arg_29_0.tfCutIn:Find("player"):GetChild(0)
			arg_29_0.modelCutIn = {}

			setActive(arg_29_0.tfCutIn, false)
		end

		return
	end
end

function var_0_0.SwitchDayNight(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_2 and not IsNil(arg_32_2) then
		arg_32_2:SwitcherToIndex(arg_32_1 - 1)
	elseif not IsNil(arg_32_0.daynightCtrlComp) then
		arg_32_0.daynightCtrlComp:SwitcherToIndex(arg_32_1 - 1)
	end

	arg_32_0:InitLightSettings()

	return
end

function var_0_0.InitLightSettings(arg_33_0)
	arg_33_0.globalVolume = GameObject.Find("GlobalVolume")

	arg_33_0:RegisterGlobalVolume()

	arg_33_0.characterLight = GameObject.Find("CharacterLight")

	arg_33_0:RecordCharacterLight()
	table.IpairsCArray(GameObject.Find("[Lighting]").transform:GetComponentsInChildren(typeof(Light), true), function(arg_34_0, arg_34_1)
		arg_34_1.shadows = UnityEngine.LightShadows.None

		return
	end)

	return
end

function var_0_0.ResetSceneStructure(arg_35_0, arg_35_1)
	table.IpairsCArray(arg_35_1:GetRootGameObjects(), function(arg_36_0, arg_36_1)
		if arg_36_1.name == "Furnitures" then
			arg_35_0.furnitures = tf(arg_36_1)

			eachChild(arg_35_0.furnitures, function(arg_37_0)
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

function var_0_0.InitSlots(arg_38_0)
	local var_38_0 = arg_38_0.modelRoot:GetComponentsInChildren(typeof(Transform), true):ToTable()

	arg_38_0.slotDict = {}

	_.each(arg_38_0.room:GetSlots(), function(arg_39_0)
		local var_39_0 = arg_39_0:GetFurnitureName()
		local var_39_1 = arg_39_0:GetConfigID()
		local var_39_2 = arg_38_0.slotRoot:Find(tostring(var_39_1))

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
				arg_38_0:emit(Dorm3dRoomMediator.ON_CLICK_FURNITURE_SLOT, var_39_1)

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

		arg_38_0.slotDict[var_39_1] = var_39_3

		return
	end)

	return
end

function var_0_0.SetContactStateDic(arg_41_0, arg_41_1)
	arg_41_0.contactStateDic = arg_41_1
	arg_41_0.hideContactStateDic = {}
	arg_41_0.contactInRangeDic = {}
	arg_41_0.transRangeDic = {
		list = {}
	}
	arg_41_0.transformFilter = arg_41_0.transformFilter or BLHX.Rendering.TransformFilter.New()

	for iter_41_0, iter_41_1 in pairs(arg_41_0.contactStateDic) do
		arg_41_0.hideContactStateDic[iter_41_0] = math.min(iter_41_1, ApartmentRoom.ITEM_UNLOCK)
		arg_41_0.contactInRangeDic[iter_41_0] = false
		arg_41_0.transRangeDic[iter_41_0] = {
			#arg_41_0.transRangeDic.list + 1,
			#pg.dorm3d_collection_template[iter_41_0].vfx_prefab
		}

		table.insertto(arg_41_0.transRangeDic.list, underscore.map(pg.dorm3d_collection_template[iter_41_0].vfx_prefab, function(arg_42_0)
			return arg_41_0.modelRoot:Find(arg_42_0)
		end))
	end

	arg_41_0.transformFilter:Init(arg_41_0.mainCameraTF, arg_41_0.transRangeDic.list, 2, 60)
	arg_41_0:ActiveContact()

	return
end

function var_0_0.TempHideContact(arg_43_0, arg_43_1)
	arg_43_0.hideConcatFlag = arg_43_1

	arg_43_0:ActiveContact()

	return
end

function var_0_0.ActiveContact(arg_44_0)
	for iter_44_0, iter_44_1 in pairs(arg_44_0.contactInRangeDic) do
		local var_44_0 = arg_44_0
		local var_44_2 = iter_44_0

		if arg_44_0.contactInRangeDic[iter_44_0] and not arg_44_0.hideConcatFlag then
			local var_44_3 = arg_44_0.contactStateDic[iter_44_0] or arg_44_0.hideContactStateDic[iter_44_0]

			var_44_1(var_44_0, var_44_2, var_44_3)
		end
	end

	return
end

function var_0_0.UpdateContactDisplay(arg_45_0, arg_45_1, arg_45_2)
	for iter_45_0, iter_45_1 in ipairs(pg.dorm3d_collection_template[arg_45_1].vfx_prefab) do
		local var_45_0 = arg_45_0.modelRoot:Find(iter_45_1)

		if arg_45_0:IsModeInHidePending(iter_45_1) then
			-- block empty
		elseif not arg_45_0.modelRoot:Find(iter_45_1) then
			warning(arg_45_1, iter_45_1)
		else
			setActive(var_45_0, arg_45_2 == ApartmentRoom.ITEM_FIRST)
		end
	end

	for iter_45_2, iter_45_3 in ipairs(pg.dorm3d_collection_template[arg_45_1].model) do
		if arg_45_0:IsModeInHidePending(iter_45_3) then
			-- block empty
		elseif not arg_45_0.modelRoot:Find(iter_45_3) then
			warning(arg_45_1, iter_45_3)
		else
			local var_45_1 = arg_45_0.modelRoot:Find(iter_45_3)

			if arg_45_0:CheckSceneItemActive(var_45_1) then
				local var_45_2 = GetComponent(var_45_1, typeof(EventTriggerListener))

				if arg_45_2 == ApartmentRoom.ITEM_FIRST then
					var_45_2 = var_45_2 or GetOrAddComponent(var_45_1, typeof(EventTriggerListener))

					var_45_2:AddPointClickFunc(function(arg_46_0, arg_46_1)
						arg_45_0:emit(var_0_0.CLICK_CONTACT, arg_45_1)

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

function var_0_0.SetFloatEnable(arg_47_0, arg_47_1)
	arg_47_0.enableFloatUpdate = arg_47_1

	if arg_47_1 then
		arg_47_0:UpdateFloatPosition()
	end

	return
end

function var_0_0.UpdateFloatPosition(arg_48_0)
	setLocalPosition(arg_48_0.rtFloatPage:Find("lady"), (arg_48_0:GetLocalPosition(arg_48_0:GetScreenPosition(arg_48_0:GetCurrentLadyEnv().ladyHeadCenter.position + Vector3(0, 0.2, 0)), arg_48_0.rtFloatPage)))

	return
end

function var_0_0.LoadCharacter(arg_49_0, arg_49_1, arg_49_2)
	arg_49_0.hxMatDict = {}
	arg_49_0.ladyDict = {}
	arg_49_0.skinDict = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		table.insert({}, function(arg_50_0)
			arg_49_0:LoadSingleCharacter(iter_49_1, arg_50_0)

			return
		end)
	end

	parallelAsync({}, arg_49_2)

	return
end

function var_0_0.LoadCharacterAdditionally(arg_51_0, arg_51_1, arg_51_2)
	for iter_51_0, iter_51_1 in ipairs(arg_51_1) do
		table.insert({}, function(arg_52_0)
			arg_51_0:LoadSingleCharacter(iter_51_1, function()
				arg_51_0:InitCharacter(arg_51_0.ladyDict[iter_51_1], iter_51_1)
				arg_52_0()

				return
			end)

			return
		end)
	end

	parallelAsync({}, arg_51_2)

	return
end

function var_0_0.LoadSingleCharacter(arg_54_0, arg_54_1, arg_54_2)
	local var_54_9000
	local var_54_0 = LadyEnv.New(arg_54_0)

	arg_54_0.ladyDict[arg_54_1] = var_54_0

	local var_54_1 = getProxy(ApartmentProxy)
	local var_54_2 = var_54_1.getApartment(var_54_9000, arg_54_1)
	local var_54_3 = var_54_2:getConfig("asset_name")
	local var_54_4 = var_54_2:GetSkinModelID(arg_54_0.room:getConfig("tag"))
	local var_54_5 = Dorm3dSkin.New({
		configId = var_54_1
	}):GetModelName()

	assert(var_54_5)

	for iter_54_0, iter_54_1 in ipairs({
		"common",
		var_54_5
	}) do
		if checkABExist((string.format("dorm3d/character/%s/res/%s", var_54_3, iter_54_1))) then
			table.insert({}, function(arg_55_0)
				arg_54_0.loader:LoadBundle(var_0, function(arg_56_0)
					for iter_56_0, iter_56_1 in ipairs(arg_56_0:GetAllAssetNames()) do
						local var_56_0, var_56_1, var_56_2 = string.find(string.lower(iter_56_1), "material_hx[/\\](.*).mat")

						if var_56_0 then
							arg_54_0.hxMatDict[var_56_2 .. " (Instance)"] = {
								arg_56_0,
								iter_56_1
							}
							arg_54_0.hxMatDict[var_56_2] = {
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

	var_54_0.skinId = var_54_4
	var_54_0.skinIdList = {
		var_54_4
	}

	table.insert({}, function(arg_57_0)
		arg_54_0.loader:GetPrefab(string.format("dorm3d/character/%s/prefabs/%s", var_54_3, var_54_5), "", function(arg_58_0)
			var_54_0.ladyGameObject = arg_58_0
			arg_54_0.skinDict[var_54_4] = {
				ladyGameObject = arg_58_0
			}

			arg_57_0()

			return
		end)

		return
	end)

	if arg_54_0.room:isPersonalRoom() then
		for iter_54_2, iter_54_3 in ipairs(var_54_2:GetAllModelIds()) do
			if not table.contains(var_54_0.skinIdList, iter_54_3) then
				local var_54_6 = Dorm3dSkin.New({
					configId = iter_54_3
				})

				if not var_54_6:IsShow() then
					if iter_54_3 == 199033 then
						if checkABExist((string.format("dorm3d/character/%s/prefabs/%s", var_54_3, (var_54_6:GetModelName())))) then
							table.insert(var_54_0.skinIdList, iter_54_3)
							table.insert({}, function(arg_59_0)
								arg_54_0.loader:GetPrefab(var_0, "", function(arg_60_0)
									arg_54_0.skinDict[iter_54_3] = {
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

	if arg_54_0.contextData.pendingDic[arg_54_1] then
		if pg.dorm3d_welcome[arg_54_0.contextData.pendingDic[arg_54_1]].item_prefab ~= "" then
			table.insert({}, function(arg_61_0)
				arg_54_0.loader:GetPrefab(string.lower("dorm3d/furniture/item/" .. var_0.item_prefab), "", function(arg_62_0)
					var_54_0.tfPendintItem = arg_62_0.transform

					setActive(arg_62_0, false)
					arg_61_0()

					return
				end)

				return
			end)
		end
	end

	parallelAsync({}, arg_54_2)

	return
end

function var_0_0.HXCharacter(arg_63_0, arg_63_1)
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

			if not arg_63_0.hxMatDict[arg_65_1.name] then
				return
			end

			var_64_1 = true

			local var_65_1, var_65_2 = unpack(arg_63_0.hxMatDict[var_65_0])

			var_64_0[arg_65_0] = var_65_1:LoadAssetSync(var_65_2, typeof(Material), false, false)

			warning("Replace HX Material", arg_63_0.hxMatDict[var_65_0][2])

			return
		end)

		if false then
			arg_64_1.sharedMaterials = arg_64_1.sharedMaterials

			GraphicsInterface.Instance:UpdateCharacterMaterialLst(go(arg_63_1))
		end

		return
	end)

	return
end

function var_0_0.InitHolyLight(arg_66_0)
	for iter_66_0, iter_66_1 in pairs(arg_66_0.ladyDict) do
		table.insert({}, iter_66_1.lady)
	end

	Dorm3dHxHelper.ShowHolyLight({}, arg_66_0.holyLightRoot, true)

	return
end

function var_0_0.InitCharacter(arg_67_0, arg_67_1, arg_67_2)
	arg_67_1:InitCharacter(arg_67_2)
	Dorm3dHxHelper.HideCharacterPart(arg_67_1.lady)
	arg_67_0:HXCharacter(arg_67_1.lady)
	arg_67_1:SetZone(arg_67_0.contextData.ladyZone[arg_67_2])
	arg_67_0:ChangeCharacterPosition(arg_67_1)

	return
end

function var_0_0.SetCameraLady(arg_68_0, arg_68_1)
	arg_68_0.cameraAim2.LookAt = arg_68_1.ladyInterestRoot
	arg_68_0.cameras[var_0_0.CAMERA.TALK].Follow = arg_68_1.ladyInterestRoot
	arg_68_0.cameras[var_0_0.CAMERA.TALK].LookAt = arg_68_1.ladyInterestRoot
	arg_68_0.cameraGift.Follow = arg_68_0.ladyInterest
	arg_68_0.cameraGift.LookAt = arg_68_0.ladyInterest
	arg_68_0.cameraRole2.LookAt = arg_68_1.ladyInterestRoot
	arg_68_0.cameras[var_0_0.CAMERA.PHOTO].Follow = arg_68_0.ladyInterest
	arg_68_0.cameras[var_0_0.CAMERA.PHOTO].LookAt = arg_68_0.ladyInterest

	return
end

function var_0_0.initNodeCanvas(arg_69_0)
	local var_69_0 = pg.NodeCanvasMgr.GetInstance()

	var_69_0:Active()
	var_69_0:RegisterFunc("DistanceTrigger", function(arg_70_0)
		arg_69_0:emit(var_0_0.DISTANCE_TRIGGER, arg_70_0, arg_69_0.ladyDict[arg_70_0].dis)

		return
	end)
	var_69_0:RegisterFunc("ShortWaitAction", function(arg_71_0)
		arg_69_0:DoShortWait(arg_71_0)

		return
	end)
	var_69_0:RegisterFunc("WatchShortWaitAction", function(arg_72_0)
		arg_69_0:DoShortWait(arg_72_0)

		return
	end)
	var_69_0:RegisterFunc("WalkDistanceTrigger", function(arg_73_0)
		arg_69_0:emit(var_0_0.WALK_DISTANCE_TRIGGER, arg_73_0, arg_69_0.ladyDict[arg_73_0].dis)

		return
	end)
	var_69_0:RegisterFunc("ChangeWatch", function(arg_74_0)
		arg_69_0:emit(var_0_0.CHANGE_WATCH, arg_74_0)

		return
	end)

	return
end

function var_0_0.SetAllBlackbloardValue(arg_75_0, arg_75_1, arg_75_2)
	arg_75_0[arg_75_1] = arg_75_2

	for iter_75_0, iter_75_1 in pairs(arg_75_0.ladyDict) do
		arg_75_0:SetBlackboardValue(iter_75_1, arg_75_1, arg_75_2)
	end

	return
end

function var_0_0.SetBlackboardValue(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	arg_76_1:SetBlackboardValue(arg_76_2, arg_76_3)

	return
end

function var_0_0.GetBlackboardValue(arg_77_0, arg_77_1, arg_77_2)
	return arg_77_1:GetBlackboardValue(arg_77_2)
end

function var_0_0.didEnter(arg_78_0)
	local var_78_0 = -21.6 / Screen.height

	arg_78_0.joystickDelta = Vector2.zero
	arg_78_0.joystickTimer = FrameTimer.New(function()
		if arg_78_0.surroudCamera and not arg_78_0.pinchMode then
			(function(arg_80_0, arg_80_1, arg_80_2)
				arg_80_0[arg_80_1].m_InputAxisValue = arg_80_2
				arg_80_0[arg_80_1] = arg_80_0[arg_80_1]

				return
			end)(arg_78_0.surroudCamera, "m_XAxis", (arg_78_0.joystickDelta * var_78_0).x)
			;(function(arg_80_0, arg_80_1, arg_80_2)
				arg_80_0[arg_80_1].m_InputAxisValue = arg_80_2
				arg_80_0[arg_80_1] = arg_80_0[arg_80_1]

				return
			end)(arg_78_0.surroudCamera, "m_YAxis", (arg_78_0.joystickDelta * var_78_0).y)
		elseif arg_78_0.furniturePOV and arg_78_0.cameras[var_0_0.CAMERA.FURNITURE_WATCH] and isActive(arg_78_0.cameras[var_0_0.CAMERA.FURNITURE_WATCH]) then
			(function(arg_80_0, arg_80_1, arg_80_2)
				arg_80_0[arg_80_1].m_InputAxisValue = arg_80_2
				arg_80_0[arg_80_1] = arg_80_0[arg_80_1]

				return
			end)(arg_78_0.furniturePOV, "m_HorizontalAxis", (arg_78_0.joystickDelta * var_78_0).x)
			;(function(arg_80_0, arg_80_1, arg_80_2)
				arg_80_0[arg_80_1].m_InputAxisValue = arg_80_2
				arg_80_0[arg_80_1] = arg_80_0[arg_80_1]

				return
			end)(arg_78_0.furniturePOV, "m_VerticalAxis", (arg_78_0.joystickDelta * var_78_0).y)
		end

		arg_78_0.joystickDelta = Vector2.zero

		return
	end, 1, -1)

	arg_78_0.joystickTimer:Start()

	local var_78_1 = 1.75

	arg_78_0.moveStickTimer = FrameTimer.New(function()
		if not arg_78_0.moveStickDraging then
			return
		end

		local var_81_0 = (arg_78_0.moveStickPosition - arg_78_0.moveStickOrigin):ClampMagnitude(200)

		arg_78_0.moveStickPosition = arg_78_0.moveStickOrigin + var_81_0

		local var_81_1 = arg_78_0.mainCameraTF:TransformDirection((Vector3.New((var_81_0 / 200).x, 0, (var_81_0 / 200).y)))

		var_81_1.y = 0

		local var_81_2 = var_81_1:Normalize()

		var_81_2:Mul(var_78_1)

		if isActive(arg_78_0.cameras[var_0_0.CAMERA.POV]) then
			arg_78_0.playerController:SimpleMove(var_81_2)

			arg_78_0.tweenFOV = true
		elseif isActive(arg_78_0.cameras[var_0_0.CAMERA.PHOTO_FREE]) then
			arg_78_0.cameras[var_0_0.CAMERA.PHOTO_FREE]:GetComponent(typeof(UnityEngine.CharacterController)):Move(var_81_2 * Time.deltaTime)
			arg_78_0:emit(Dorm3dPhotoMediator.CAMERA_STICK_MOVE, (var_81_0 / 200):Normalize())
			onNextTick(function()
				local var_82_0 = arg_78_0:GetRestritedHeightRange()

				arg_78_0:emit(Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED, (math.InverseLerp(var_82_0[1], var_82_0[2], arg_78_0.cameras[var_0_0.CAMERA.PHOTO_FREE].position.y)))

				return
			end)
		end

		return
	end, 1, -1)

	arg_78_0.moveStickTimer:Start()

	arg_78_0.pinchMode = false
	arg_78_0.pinchSize = 0
	arg_78_0.pinchValue = 1
	arg_78_0.pinchNodeOrder = 1

	GlobalClickEventMgr.Inst:AddBeginPinchFunc(function(arg_83_0, arg_83_1)
		if arg_78_0.surroudCamera and isActive(arg_78_0.surroudCamera) then
			arg_78_0.pinchMode = true
			arg_78_0.pinchSize = (arg_83_0 - arg_83_1):Magnitude()
			arg_78_0.pinchNodeOrder = arg_83_1.x < arg_83_0.x and -1 or 1

			return
		end

		if isActive(arg_78_0.cameras[var_0_0.CAMERA.POV]) then
			if (arg_83_0 - arg_83_1):Magnitude() < Screen.height * 0.5 then
				arg_78_0.pinchMode = true
				arg_78_0.pinchSize = (arg_83_0 - arg_83_1):Magnitude()
				arg_78_0.pinchNodeOrder = arg_83_1.x < arg_83_0.x and -1 or 1
			end

			return
		end

		return
	end)

	local var_78_2 = 0.01

	if IsUnityEditor then
		var_78_2 = 0.1
	end

	local var_78_3 = var_78_2 * 1080 / Screen.height

	GlobalClickEventMgr.Inst:AddPinchFunc(function(arg_84_0, arg_84_1)
		if not arg_78_0.pinchMode then
			return
		end

		local var_84_0 = (arg_84_0 - arg_84_1):Magnitude()

		if isActive(arg_78_0.cameras[var_0_0.CAMERA.POV]) then
			arg_78_0.pinchValue = math.clamp(arg_78_0.pinchValue + (arg_78_0.pinchSize - var_84_0) * var_78_3 * (arg_78_0.pinchNodeOrder * (arg_84_1.x < arg_84_0.x and -1 or 1)), 0.5, 1)
			arg_78_0.pinchSize = var_84_0

			arg_78_0:SetPOVFOV(arg_78_0.POVOriginalFOV * arg_78_0.pinchValue)

			arg_78_0.tweenFOV = nil

			return
		end

		if isActive(arg_78_0.surroudCamera) and arg_78_0.surroudCamera == arg_78_0.cameras[var_0_0.CAMERA.PHOTO] then
			arg_78_0:SetPinchValue(math.clamp(arg_78_0.pinchValue + (arg_78_0.pinchSize - var_84_0) * var_78_3 * (arg_78_0.pinchNodeOrder * (arg_84_1.x < arg_84_0.x and -1 or 1)), 0.5, 1))

			arg_78_0.pinchSize = var_84_0

			return
		end

		return
	end)
	GlobalClickEventMgr.Inst:AddEndPinchFunc(function()
		arg_78_0.pinchMode = false
		arg_78_0.pinchSize = 0

		return
	end)

	arg_78_0.cameraBlendCallbacks = {}
	arg_78_0.activeCMCamera = nil

	function arg_78_0.camBrainEvenetHandler.OnBlendStarted(arg_86_0)
		if arg_78_0.activeCMCamera then
			arg_78_0:OnCameraBlendFinished(arg_78_0.activeCMCamera)
		end

		arg_78_0.activeCMCamera = arg_78_0.camBrain.ActiveVirtualCamera

		return
	end

	function arg_78_0.camBrainEvenetHandler.OnBlendFinished(arg_87_0)
		arg_78_0.activeCMCamera = nil

		arg_78_0:OnCameraBlendFinished(arg_87_0)

		return
	end

	arg_78_0.expressionDict = {}

	arg_78_0:OverlayPanel(arg_78_0.blockLayer)
	arg_78_0:ActiveCamera(arg_78_0.cameras[var_0_0.CAMERA.POV])

	local var_78_4
	local var_78_5
	local var_78_6 = arg_78_0.resumeCallback

	function arg_78_0.resumeCallback()
		var_78_5 = true

		if var_78_4 then
			existCall(var_78_6)
		end

		return
	end

	arg_78_0:RefreshSlots(nil, function()
		var_78_4 = true
		arg_78_0.doneFirstSlotFresh = true

		if var_78_5 then
			existCall(var_78_6)
		end

		return
	end)

	arg_78_0.updateHandler = UpdateBeat:CreateListener(function()
		xpcall(function()
			arg_78_0:Update()

			return
		end, function(...)
			errorMsg(debug.traceback(...))

			return
		end)

		return
	end)

	UpdateBeat:AddListener(arg_78_0.updateHandler)
	arg_78_0:InitExtraSystem()

	return
end

function var_0_0.InitData(arg_93_0)
	if not arg_93_0.contextData.ladyZone then
		arg_93_0.contextData.ladyZone = {}

		local var_93_0
		local var_93_1 = arg_93_0.room:getConfig("default_zone")

		for iter_93_0, iter_93_1 in ipairs(var_93_1) do
			arg_93_0.contextData.ladyZone[iter_93_1[1]] = iter_93_1[2]

			if table.contains(arg_93_0.contextData.groupIds, iter_93_1[1]) then
				var_93_0 = var_93_0 or arg_93_0.contextData.ladyZone[iter_93_1[1]]
			end
		end

		arg_93_0.contextData.inFurnitureName = var_93_0 or var_93_1[1][2]
	end

	arg_93_0.zoneDatas = _.select(arg_93_0.room:GetZones(), function(arg_94_0)
		return not arg_94_0:IsGlobal()
	end)
	arg_93_0.activeLady = {}

	return
end

function var_0_0.Update(arg_95_0)
	arg_95_0.raycastCamera.fieldOfView = arg_95_0.mainCameraTF:GetComponent(typeof(Camera)).fieldOfView

	if arg_95_0.tweenFOV then
		arg_95_0.pinchValue = Mathf.Lerp(arg_95_0.pinchValue, 1, (Damp(1, 1, Time.deltaTime)))

		arg_95_0:SetPOVFOV(arg_95_0.POVOriginalFOV * arg_95_0.pinchValue)

		if arg_95_0.pinchValue > 0.99 then
			arg_95_0.tweenFOV = nil
		end
	end

	if isActive(arg_95_0.cameras[var_0_0.CAMERA.POV]) then
		arg_95_0:TriggerLadyDistance()
	end

	if arg_95_0.contactInRangeDic then
		local var_95_0 = arg_95_0.transformFilter:Execute():ToTable()

		for iter_95_0, iter_95_1 in pairs(arg_95_0.contactInRangeDic) do
			local var_95_2 = underscore(var_95_0):chain():slice(unpack(arg_95_0.transRangeDic[iter_95_0])):any(function(arg_96_0)
				return arg_96_0
			end):value()

			if tobool(iter_95_1) ~= var_95_2 then
				arg_95_0.contactInRangeDic[iter_95_0] = var_95_2

				local var_95_3 = arg_95_0
				local var_95_5 = iter_95_0

				if var_95_2 and not arg_95_0.hideConcatFlag then
					local var_95_6 = arg_95_0.contactStateDic[iter_95_0] or arg_95_0.hideContactStateDic[iter_95_0]

					var_95_4(var_95_3, var_95_5, var_95_6)
				end
			end
		end
	end

	if arg_95_0.enableFloatUpdate then
		arg_95_0:UpdateFloatPosition()
	end

	arg_95_0:CheckInSector()

	if arg_95_0.systemManager then
		arg_95_0.systemManager:Update(Time.deltaTime)
	end

	return
end

function var_0_0.CheckInSector(arg_97_0)
	if not isActive(arg_97_0.cameras[var_0_0.CAMERA.POV]) then
		return
	end

	for iter_97_0, iter_97_1 in pairs(arg_97_0.ladyDict) do
		if iter_97_1.lady then
			local var_97_1 = tobool(arg_97_0.activeLady[iter_97_0])

			if var_97_1 ~= tobool(var_0_0.IsPointInSector({
				Radius = 2,
				Angle = 120,
				Position = iter_97_1.lady.position,
				Rotation = iter_97_1.lady.rotation
			}, var_97_0)) then
				arg_97_0.activeLady[iter_97_0] = not var_97_1

				arg_97_0:emit(var_0_0.ON_ENTER_SECTOR, iter_97_0)
			end
		end
	end

	return
end

function var_0_0.TriggerLadyDistance(arg_98_0)
	for iter_98_0, iter_98_1 in pairs(arg_98_0.ladyDict) do
		if iter_98_1.lady then
			iter_98_1.dis = (iter_98_1.lady.position - arg_98_0.player.position).magnitude

			if arg_98_0:GetBlackboardValue(iter_98_1, "inPending") then
				local var_98_0 = var_0_0.POV_PENDING_CLOSE_DISTANCE or var_0_0.POV_CLOSE_DISTANCE

				if var_98_0 > iter_98_1.dis ~= arg_98_0:GetBlackboardValue(iter_98_1, "inDistance") then
					arg_98_0:SetBlackboardValue(iter_98_1, "inDistance", iter_98_1.dis < var_0_0.POV_CLOSE_DISTANCE)
					arg_98_0:emit(var_0_0.ON_CHANGE_DISTANCE, iter_98_0, iter_98_1.dis < var_0_0.POV_CLOSE_DISTANCE)
				end
			end
		end
	end

	return
end

function var_0_0.OnStickMove(arg_99_0, arg_99_1)
	arg_99_0.joystickDelta = arg_99_1

	return
end

function var_0_0.SetPinchValue(arg_100_0, arg_100_1)
	arg_100_0.pinchValue = arg_100_1

	arg_100_0:SetCameraObrits()

	return
end

function var_0_0.GetPOVFOV(arg_101_0)
	return ReflectionHelp.RefGetField(typeof("Cinemachine.LensSettings"), "FieldOfView", arg_101_0.cameras[var_0_0.CAMERA.POV].m_Lens)
end

function var_0_0.SetPOVFOV(arg_102_0, arg_102_1)
	ReflectionHelp.RefSetField(typeof("Cinemachine.LensSettings"), "FieldOfView", arg_102_0.cameras[var_0_0.CAMERA.POV].m_Lens, arg_102_1)

	arg_102_0.cameras[var_0_0.CAMERA.POV].m_Lens = arg_102_0.cameras[var_0_0.CAMERA.POV].m_Lens

	return
end

function var_0_0.RefreshSlots(arg_103_0, arg_103_1, arg_103_2)
	arg_103_1 = arg_103_1 or arg_103_0.room

	local var_103_0 = arg_103_1:GetSlots()
	local var_103_1 = arg_103_1:GetFurnitures()

	arg_103_0:emit(var_0_0.SHOW_BLOCK)
	table.ParallelIpairsAsync(var_103_0, function(arg_104_0, arg_104_1, arg_104_2)
		local var_104_0 = arg_104_1:GetConfigID()

		if not arg_103_0.slotDict[var_104_0] then
			return arg_104_2()
		end

		local var_104_1 = _.detect(var_103_1, function(arg_105_0)
			return arg_105_0:GetSlotID() == var_104_0
		end)
		local var_104_2 = var_104_1 and var_104_1:GetModel() or false
		local var_104_3 = arg_103_0.slotDict[var_104_0].model

		arg_103_0.slotDict[var_104_0].displayModelName = var_104_2
		arg_103_0.slotDict[var_104_0].furnitureId = var_104_1 and var_104_1:GetConfigID()

		local function var_104_4(arg_106_0)
			local var_106_0 = arg_103_0.slotDict[var_104_0].sceneHides or {}

			table.Foreach(var_106_0, function(arg_107_0, arg_107_1)
				setActive(arg_107_1.trans, arg_107_1.visible)

				return
			end)

			arg_103_0.slotDict[var_104_0].sceneHides = {}

			if var_104_3 then
				setActive(var_104_3, var_104_2 == "")
			end

			if arg_106_0 then
				local var_106_1 = arg_106_0:getConfig("scene_hides")

				if #var_106_1 > 0 then
					table.Ipairs(var_106_1, function(arg_108_0, arg_108_1)
						local var_108_0 = arg_103_0.modelRoot:Find(arg_108_1)

						assert(var_108_0, string.format("dorm3d_furniture_template:%d scene_hides missing scene item :%s", arg_106_0:GetConfigID(), arg_108_1))
						table.insert(arg_103_0.slotDict[var_104_0].sceneHides, {
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
			arg_103_0.loader:ClearRequest("slot_" .. var_104_0)
			;(function(arg_106_0)
				local var_106_0 = arg_103_0.slotDict[var_104_0].sceneHides or {}

				table.Foreach(var_106_0, function(arg_107_0, arg_107_1)
					setActive(arg_107_1.trans, arg_107_1.visible)

					return
				end)

				arg_103_0.slotDict[var_104_0].sceneHides = {}

				if var_104_3 then
					setActive(var_104_3, var_104_2 == "")
				end

				if arg_106_0 then
					local var_106_1 = arg_106_0:getConfig("scene_hides")

					if #var_106_1 > 0 then
						table.Ipairs(var_106_1, function(arg_108_0, arg_108_1)
							local var_108_0 = arg_103_0.modelRoot:Find(arg_108_1)

							assert(var_108_0, string.format("dorm3d_furniture_template:%d scene_hides missing scene item :%s", arg_106_0:GetConfigID(), arg_108_1))
							table.insert(arg_103_0.slotDict[var_104_0].sceneHides, {
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
			end)()
			arg_104_2()

			return
		end

		local var_104_5 = arg_103_0.slotDict[var_104_0].trans

		if arg_103_0.loader:GetLoadingRP("slot_" .. var_104_0) then
			arg_103_0:emit(var_0_0.HIDE_BLOCK)
		end

		arg_103_0.loader:GetPrefabBYStopLoading("dorm3d/furniture/prefabs/" .. var_104_2, "", function(arg_109_0)
			assert(arg_109_0)
			setParent(arg_109_0, var_104_5)
			var_104_4(var_104_1)
			arg_104_2()

			return
		end, "slot_" .. var_104_0)

		return
	end, function()
		arg_103_0:emit(var_0_0.HIDE_BLOCK)
		existCall(arg_103_2)
		warning("RefreshSlots", "Done")
		arg_103_0:emit(Dorm3dRoomMediator.REFRESH_FURNITURE_AND_SLOTS_DONE)

		return
	end)

	return
end

function var_0_0.RefreshSlotsEmpty(arg_111_0, arg_111_1)
	local var_111_0 = Clone(arg_111_0.room)

	var_111_0.furnitures = {}

	arg_111_0:RefreshSlots(var_111_0, arg_111_1)

	return
end

function var_0_0.CheckSceneItemActiveByPath(arg_112_0, arg_112_1)
	return arg_112_0:CheckSceneItemActive((arg_112_0:GetSceneItem(arg_112_1)))
end

function var_0_0.CheckSceneItemActive(arg_113_0, arg_113_1)
	local var_113_0 = true
	local var_113_1

	table.Checkout(arg_113_0.slotDict, function(arg_114_0, arg_114_1)
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

function var_0_0.ChangeCharacterPosition(arg_116_0, arg_116_1)
	arg_116_0:ResetCharPoint(arg_116_1, arg_116_1.ladyActiveZone)
	arg_116_0:SyncInterestTransform(arg_116_1)

	return
end

function var_0_0.SyncCurrentInterestTransform(arg_117_0)
	arg_117_0:SyncInterestTransform((arg_117_0:GetCurrentLadyEnv()))

	return
end

function var_0_0.SyncInterestTransform(arg_118_0, arg_118_1)
	arg_118_0.ladyInterest.position = arg_118_1.ladyInterestRoot.position
	arg_118_0.ladyInterest.rotation = arg_118_1.ladyInterestRoot.rotation

	return
end

function var_0_0.SyncInterestTransformByTf(arg_119_0, arg_119_1)
	arg_119_0.ladyInterest.position = arg_119_1.position
	arg_119_0.ladyInterest.rotation = arg_119_1.rotation

	return
end

function var_0_0.ChangePlayerPosition(arg_120_0, arg_120_1)
	arg_120_1 = arg_120_1 or arg_120_0.contextData.inFurnitureName

	local var_120_0 = arg_120_0.furnitures:Find(arg_120_1)

	arg_120_0.player.position = var_120_0:Find("PlayerPoint").position
	arg_120_0.cameras[var_0_0.CAMERA.POV].transform.position = arg_120_0.playerEye.position

	local var_120_1 = Quaternion.LookRotation(arg_120_0.ladyInterest.position - arg_120_0.playerEye.position).eulerAngles

	arg_120_0.compPovAim.m_HorizontalAxis.Value = arg_120_0:GetNearestAngle(var_120_1.y, arg_120_0.compPovAim.m_HorizontalAxis.m_MinValue, arg_120_0.compPovAim.m_HorizontalAxis.m_MaxValue)
	arg_120_0.compPovAim.m_HorizontalAxis = arg_120_0.compPovAim.m_HorizontalAxis
	arg_120_0.compPovAim.m_VerticalAxis.Value = var_120_1.x
	arg_120_0.compPovAim.m_VerticalAxis = arg_120_0.compPovAim.m_VerticalAxis

	return
end

function var_0_0.GetAttachedFurnitureName(arg_121_0)
	return arg_121_0.contextData.inFurnitureName
end

function var_0_0.GetFurnitureByName(arg_122_0, arg_122_1)
	return underscore.detect(arg_122_0.attachedPoints, function(arg_123_0)
		return arg_123_0.name == arg_122_1
	end)
end

function var_0_0.GetSlotByID(arg_124_0, arg_124_1)
	return arg_124_0.displaySlots[arg_124_1] and arg_124_0.displaySlots[arg_124_1].trans
end

function var_0_0.GetScreenPosition(arg_125_0, arg_125_1, arg_125_2)
	arg_125_2 = arg_125_2 or arg_125_0.raycastCamera

	local var_125_0 = arg_125_2:WorldToScreenPoint(arg_125_1)

	if var_125_0.z < 0 then
		var_125_0.x = var_125_0.x + (var_125_0.x < 0 and -1 or 1) * Screen.width
		var_125_0.y = var_125_0.y + (var_125_0.y < 0 and -1 or 1) * Screen.height
		var_125_0.z = -var_125_0.z
	end

	return var_125_0
end

function var_0_0.GetLocalPosition(arg_126_0, arg_126_1, arg_126_2)
	return LuaHelper.ScreenToLocal(arg_126_2, arg_126_1, pg.UIMgr.GetInstance().uiCameraComp)
end

function var_0_0.GetModelRoot(arg_127_0)
	return arg_127_0.modelRoot
end

function var_0_0.ShiftZoneSafe(arg_128_0, arg_128_1)
	if arg_128_0.room:isPersonalRoom() and not arg_128_0:GetBlackboardValue(arg_128_0:GetCurrentLadyEnv(), "inPending") then
		table.insert({}, function(arg_129_0)
			arg_128_0:OutOfLazy(arg_128_0.apartment:GetConfigID(), arg_129_0)

			return
		end)
	end

	table.insert({}, function(arg_130_0)
		arg_128_0:ShiftZone(arg_128_1, arg_130_0)

		return
	end)
	seriesAsync({}, function()
		arg_128_0:CheckQueue()

		return
	end)

	return
end

function var_0_0.ShiftZone(arg_132_0, arg_132_1, arg_132_2)
	if not arg_132_0:GetFurnitureByName(arg_132_1) then
		errorMsg(arg_132_1 .. " Not Find")
		existCall(arg_132_2)

		return
	end

	seriesAsync({
		function(arg_133_0)
			arg_132_0:emit(var_0_0.SHOW_BLOCK)
			arg_132_0:ShowBlackScreen(true, arg_133_0)

			return
		end,
		function(arg_134_0)
			if arg_132_0.shiftLady or arg_132_0.room:isPersonalRoom() then
				local var_134_0 = arg_132_0.shiftLady or arg_132_0.apartment:GetConfigID()

				arg_132_0.shiftLady = nil
				arg_132_0.contextData.ladyZone[var_134_0] = var_0.name

				local var_134_1 = arg_132_0.ladyDict[var_134_0]

				arg_132_0.ladyDict[var_134_0]:SetZone(arg_132_0.contextData.ladyZone[var_134_0])

				if arg_132_0:GetBlackboardValue(arg_132_0.ladyDict[var_134_0], "inPending") then
					arg_132_0:SetOutPending(arg_132_0.ladyDict[var_134_0])
					arg_132_0:SwitchAnim(arg_132_0.ladyDict[var_134_0], var_0_0.ANIM.IDLE)
					onNextTick(function()
						arg_132_0:ChangeCharacterPosition(var_134_1)
						arg_134_0()

						return
					end)
				else
					arg_132_0:ChangeCharacterPosition(arg_132_0.ladyDict[var_134_0])
					arg_134_0()
				end
			else
				arg_134_0()
			end

			return
		end,
		function(arg_136_0)
			arg_132_0.contextData.inFurnitureName = var_0.name

			if SlideExtraSystem.IsOpen(arg_132_0.room) and arg_132_0.contextData.inFurnitureName == SlideConst.SLIDE_ZONE then
				arg_132_0:SyncInterestTransformByTf(var_0.transform:Find("StayPoint"))
			elseif not arg_132_0.apartment then
				for iter_136_0, iter_136_1 in pairs(arg_132_0.ladyDict) do
					if iter_136_1.ladyBaseZone == arg_132_0.contextData.inFurnitureName then
						arg_132_0:SyncInterestTransform(iter_136_1)

						break
					end
				end
			end

			arg_132_0:ChangePlayerPosition()
			arg_132_0:TriggerLadyDistance()
			arg_132_0:CheckInSector()
			arg_136_0()

			return
		end,
		function(arg_137_0)
			arg_132_0:UpdateZoneList()
			arg_132_0:ShowBlackScreen(false, arg_137_0)

			return
		end,
		function(arg_138_0)
			arg_132_0:emit(var_0_0.HIDE_BLOCK)
			arg_138_0()

			return
		end
	}, arg_132_2)

	return
end

function var_0_0.ActiveCamera(arg_139_0, arg_139_1)
	table.Foreach(arg_139_0.cameras, function(arg_140_0, arg_140_1)
		setActive(arg_140_1, arg_140_1 == arg_139_1)

		return
	end)

	if isActive(arg_139_1) then
		arg_139_0:OnCameraBlendFinished(arg_139_1)
	end

	return
end

function var_0_0.ActiveCameraByName(arg_141_0, arg_141_1)
	local var_141_0 = arg_141_0.cameraRoot:Find(arg_141_1)

	assert(var_141_0, "ActiveCameraByName: " .. arg_141_1 .. " not found")
	table.Foreach(arg_141_0.cameras, function(arg_142_0, arg_142_1)
		setActive(arg_142_1, false)

		return
	end)
	setActive(var_141_0, true)

	arg_141_0.cameras[var_0_0.CAMERA.CUSTOM] = var_141_0:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	return
end

function var_0_0.ShowBlackScreen(arg_143_0, arg_143_1, arg_143_2)
	local var_143_0 = arg_143_0.blackSceneInfo or {
		color = "#000000",
		time = 0.3,
		delay = arg_143_1 and 0 or 0.3
	}

	setImageColor(arg_143_0.blackLayer, Color.NewHex(var_143_0.color))
	setActive(arg_143_0.blackLayer, true)
	setCanvasGroupAlpha(arg_143_0.blackLayer, arg_143_1 and 0 or 1)
	arg_143_0:managedTween(LeanTween.alphaCanvas, function()
		if not arg_143_1 then
			setActive(arg_143_0.blackLayer, false)
		end

		existCall(arg_143_2)

		return
	end, GetComponent(arg_143_0.blackLayer, typeof(CanvasGroup)), arg_143_1 and 1 or 0, var_143_0.time):setDelay(var_143_0.delay)

	return
end

function var_0_0.RegisterOrbits(arg_145_0, arg_145_1)
	arg_145_0 = arg_145_0.scene
	arg_145_0.orbits = {
		original = arg_145_1.m_Orbits
	}
	arg_145_0.orbits.current = _.range(3):map(function(arg_146_0)
		return Cinemachine.CinemachineFreeLook.Orbit.New(arg_145_0.orbits.original[arg_146_0 - 1].m_Height, arg_145_0.orbits.original[arg_146_0 - 1].m_Radius)
	end)
	arg_145_0.surroudCamera = arg_145_1

	return
end

function var_0_0.SetCameraObrits(arg_147_0)
	arg_147_0 = arg_147_0.scene

	if not arg_147_0.surroudCamera then
		return
	end

	local var_147_0 = arg_147_0.orbits.original[1]

	for iter_147_0 = 0, #arg_147_0.orbits.current - 1 do
		arg_147_0.orbits.current[iter_147_0 + 1].m_Height = math.lerp(var_147_0.m_Height, arg_147_0.orbits.original[iter_147_0].m_Height, arg_147_0.pinchValue)
		arg_147_0.orbits.current[iter_147_0 + 1].m_Radius = arg_147_0.orbits.original[iter_147_0].m_Radius * arg_147_0.pinchValue
	end

	arg_147_0.surroudCamera.m_Orbits = arg_147_0.orbits.current

	return
end

function var_0_0.RevertCameraOrbit(arg_148_0)
	arg_148_0 = arg_148_0.scene

	if not arg_148_0.surroudCamera then
		return
	end

	for iter_148_0 = 0, #arg_148_0.orbits.current - 1 do
		arg_148_0.orbits.current[iter_148_0 + 1].m_Height = arg_148_0.orbits.original[iter_148_0].m_Height
		arg_148_0.orbits.current[iter_148_0 + 1].m_Radius = arg_148_0.orbits.original[iter_148_0].m_Radius
	end

	arg_148_0.surroudCamera.m_Orbits = arg_148_0.orbits.current
	arg_148_0.surroudCamera = nil

	return
end

function var_0_0.ActiveStateCamera(arg_149_0, arg_149_1, arg_149_2)
	local var_149_0 = {
		base = function(arg_150_0)
			arg_149_0:RegisterCameraBlendFinished(arg_149_0.cameras[var_0_0.CAMERA.POV], arg_150_0)
			arg_149_0:ActiveCamera(arg_149_0.cameras[var_0_0.CAMERA.POV])

			return
		end,
		watch = function(arg_151_0)
			assert(arg_149_0.apartment)
			arg_149_0:SyncInterestTransform(arg_149_0:GetCurrentLadyEnv())
			arg_149_0:SetCameraLady(arg_149_0:GetCurrentLadyEnv())
			arg_149_0:RegisterCameraBlendFinished(arg_149_0.cameras[var_0_0.CAMERA.ROLE], arg_151_0)
			arg_149_0:ActiveCamera(arg_149_0.cameras[var_0_0.CAMERA.ROLE])

			return
		end,
		walk = function(arg_152_0)
			arg_149_0:RegisterCameraBlendFinished(arg_149_0.cameras[var_0_0.CAMERA.POV], arg_152_0)
			arg_149_0:ActiveCamera(arg_149_0.cameras[var_0_0.CAMERA.POV])

			return
		end,
		ik = function(arg_153_0)
			arg_153_0()

			return
		end,
		gift = function(arg_154_0)
			assert(arg_149_0.apartment)
			arg_149_0:SetCameraLady(arg_149_0:GetCurrentLadyEnv())
			arg_149_0:RegisterCameraBlendFinished(arg_149_0.cameras[var_0_0.CAMERA.GIFT], arg_154_0)
			arg_149_0:ActiveCamera(arg_149_0.cameras[var_0_0.CAMERA.GIFT])

			return
		end,
		standby = function(arg_155_0)
			assert(arg_149_0.apartment)
			arg_149_0:SetCameraLady(arg_149_0:GetCurrentLadyEnv())

			arg_149_0.cameras[var_0_0.CAMERA.ROLE2].transform.position = arg_149_0.cameraRole.transform.position

			arg_149_0:RegisterCameraBlendFinished(arg_149_0.cameras[var_0_0.CAMERA.ROLE2], arg_155_0)
			arg_149_0:ActiveCamera(arg_149_0.cameras[var_0_0.CAMERA.ROLE2])

			return
		end,
		talk = function(arg_156_0)
			assert(arg_149_0.apartment)
			arg_149_0:SetCameraLady(arg_149_0:GetCurrentLadyEnv())
			arg_149_0:SyncInterestTransform(arg_149_0:GetCurrentLadyEnv())
			arg_149_0:RegisterCameraBlendFinished(arg_149_0.cameras[var_0_0.CAMERA.TALK], arg_156_0)
			arg_149_0:ActiveCamera(arg_149_0.cameras[var_0_0.CAMERA.TALK])

			return
		end
	}

	table.insert({}, function(arg_157_0)
		switch(arg_149_1, var_149_0, arg_157_0, arg_157_0)

		return
	end)
	seriesAsync({}, arg_149_2)

	return
end

function var_0_0.GetSceneItem(arg_158_0, arg_158_1)
	local var_158_0

	if string.find(arg_158_1, "FurnitureSlots/") == 1 then
		arg_158_1 = string.gsub(arg_158_1, "^FurnitureSlots/", "", 1)
		var_158_0 = arg_158_0.slotRoot:Find(arg_158_1)
	else
		var_158_0 = arg_158_0.modelRoot:Find(arg_158_1)
	end

	if not var_158_0 then
		warning(string.format("Missing scene item path: %s", arg_158_1))
	end

	return var_158_0
end

function var_0_0.SetSceneAnimSpeed(arg_159_0, arg_159_1, arg_159_2)
	table.Ipairs(arg_159_1 or {}, function(arg_160_0, arg_160_1)
		if arg_159_0.sceneAnimatorDict[arg_160_1] then
			arg_159_0.sceneAnimatorDict[arg_160_1].animator.speed = arg_159_2
		end

		return
	end)

	return
end

function var_0_0.SetExtraAnimSpeed(arg_161_0, arg_161_1, arg_161_2, arg_161_3)
	table.Ipairs(arg_161_2 or {}, function(arg_162_0, arg_162_1)
		if arg_161_1.extraItems[arg_162_1[1]] then
			arg_161_1.extraItems[arg_162_1[1]].trans:GetComponent(typeof(Animator)).speed = arg_161_3
		end

		return
	end)

	return
end

function var_0_0.PlayEnterSceneAnim(arg_163_0, arg_163_1, arg_163_2, arg_163_3)
	arg_163_3 = arg_163_3 or 1

	local var_163_0 = {}

	if arg_163_1 and #arg_163_1 > 0 then
		table.Ipairs(arg_163_1, function(arg_164_0, arg_164_1)
			arg_163_0:PlaySceneItemAnim(arg_164_1[1], arg_164_1[2], arg_163_2)
			arg_163_0:SetSceneAnimSpeed({
				arg_164_1[1]
			}, arg_163_3)
			table.insert(var_163_0, arg_164_1[1])

			return
		end)
	end

	arg_163_0:ResetSceneItemAnimators(var_163_0)

	return
end

function var_0_0.PlayEnterExtraItem(arg_165_0, arg_165_1, arg_165_2, arg_165_3)
	arg_165_3 = arg_165_3 or 1

	local var_165_0 = {}

	if arg_165_2 and #arg_165_2 > 0 then
		table.Ipairs(arg_165_2, function(arg_166_0, arg_166_1)
			local var_166_0 = arg_166_1[3] and Vector3.New(unpack(arg_166_1[3]))
			local var_166_1 = arg_166_1[4] and Quaternion.Euler(unpack(arg_166_1[4]))

			if #arg_166_1 > 4 then
				local var_166_2 = arg_166_1[5] or nil

				arg_165_0:LoadCharacterExtraItem(arg_165_1, arg_166_1[1], arg_166_1[2], var_166_0, var_166_1, var_166_2, arg_165_3)
				table.insert(var_165_0, arg_166_1[1])

				return
			end
		end)
	end

	arg_165_0:ResetCharacterExtraItem(arg_165_1, var_165_0)

	return
end

function var_0_0.HideSceneItem(arg_167_0, arg_167_1, arg_167_2)
	if arg_167_2 and #arg_167_2 > 0 then
		if arg_167_1.tempHideSceneItems and #arg_167_1.tempHideSceneItems > 0 then
			arg_167_0:ResetTempHideSceneItems(arg_167_1, arg_167_2)
		end

		arg_167_1.tempHideSceneItems = {}

		table.Ipairs(arg_167_2, function(arg_168_0, arg_168_1)
			setActive(arg_167_0:GetSceneItem(arg_168_1), false)
			table.insert(arg_167_1.tempHideSceneItems, arg_168_1)

			return
		end)
	end

	return
end

function var_0_0.ResetTempHideSceneItems(arg_169_0, arg_169_1, arg_169_2)
	arg_169_2 = arg_169_2 or {}

	if arg_169_1.tempHideSceneItems and #arg_169_1.tempHideSceneItems > 0 then
		table.Ipairs(arg_169_1.tempHideSceneItems, function(arg_170_0, arg_170_1)
			if table.contains(arg_169_2, arg_170_1) then
				return
			end

			setActive(arg_169_0:GetSceneItem(arg_170_1), true)

			return
		end)

		arg_169_1.tempHideSceneItems = nil
	end

	return
end

function var_0_0.EnableCurrentHeadIK(arg_171_0, arg_171_1)
	arg_171_0:EnableHeadIK(arg_171_0:GetCurrentLadyEnv(), arg_171_1)

	return
end

function var_0_0.EnableHeadIK(arg_172_0, arg_172_1, arg_172_2)
	arg_172_1.ladyHeadIKComp.enableIk = arg_172_2

	return
end

function var_0_0.SettingHeadAimIK(arg_173_0, arg_173_1, arg_173_2, arg_173_3)
	local var_173_0

	if arg_173_2[1] == 0 then
		arg_173_0:EnableHeadIK(arg_173_1, false)

		return
	elseif arg_173_2[1] == 1 then
		arg_173_0:EnableHeadIK(arg_173_1, true)

		var_173_0 = arg_173_0.mainCameraTF:Find("AimTarget")
	elseif arg_173_2[1] == 2 then
		arg_173_0:EnableHeadIK(arg_173_1, true)
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

function var_0_0.ResetHeadAimIK(arg_175_0, arg_175_1)
	arg_175_0:EnableHeadIK(arg_175_1, true)

	arg_175_1.ladyHeadIKComp.AimTarget = arg_175_0.mainCameraTF:Find("AimTarget")
	arg_175_1.ladyHeadIKComp.HeadWeight = arg_175_1.ladyHeadIKData.HeadWeight
	arg_175_1.ladyHeadIKComp.BodyWeight = arg_175_1.ladyHeadIKData.BodyWeight

	return
end

function var_0_0.SetIKTimelineStatus(arg_176_0, arg_176_1, arg_176_2, arg_176_3, arg_176_4, arg_176_5)
	arg_176_0:emit(RoomIKSystem.SET_IK_TIMELINE_STATUS, arg_176_1, arg_176_2, arg_176_3, arg_176_4, arg_176_5)

	return
end

function var_0_0.ExitIKTimelineStatus(arg_177_0, arg_177_1, arg_177_2)
	arg_177_0:emit(RoomIKSystem.EXIT_IK_TIMELINE_STATUS, arg_177_1, arg_177_2)

	return
end

function var_0_0.HideCharacter(arg_178_0, arg_178_1)
	for iter_178_0, iter_178_1 in pairs(arg_178_0.ladyDict) do
		if iter_178_0 ~= arg_178_1 then
			arg_178_0:HideCharacterBylayer(iter_178_1)
		end
	end

	return
end

function var_0_0.RevertCharacter(arg_179_0, arg_179_1)
	for iter_179_0, iter_179_1 in pairs(arg_179_0.ladyDict) do
		if iter_179_0 ~= arg_179_1 then
			arg_179_0:RevertCharacterBylayer(iter_179_1)
		end
	end

	return
end

function var_0_0.HideCharacterBylayer(arg_180_0, arg_180_1)
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

	Dorm3dHxHelper.SetModelHolyLightActive(arg_180_1.lady, arg_180_0.holyLightRoot, false)

	return
end

function var_0_0.RevertCharacterBylayer(arg_181_0, arg_181_1)
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

	Dorm3dHxHelper.SetModelHolyLightActive(arg_181_1.lady, arg_181_0.holyLightRoot, true)

	return
end

function var_0_0.EnterFurnitureWatchMode(arg_182_0)
	arg_182_0:SetAllBlackbloardValue("inLockLayer", true)
	arg_182_0:EnableJoystick(true)
	arg_182_0:HideCharacter()

	return
end

function var_0_0.ExitFurnitureWatchMode(arg_183_0, arg_183_1)
	arg_183_0:HideFurnitureSlots()

	local var_183_0 = arg_183_0.cameras[var_0_0.CAMERA.POV]

	seriesAsync({
		function(arg_184_0)
			arg_183_0.furniturePOV = nil

			arg_183_0:EnableJoystick(false)
			arg_183_0:emit(var_0_0.SHOW_BLOCK)
			arg_183_0:ShowBlackScreen(true, arg_184_0)

			return
		end,
		function(arg_185_0)
			existCall(arg_183_1)
			arg_183_0:RevertCharacter()
			arg_183_0:SetAllBlackbloardValue("inLockLayer", false)
			arg_183_0:RegisterCameraBlendFinished(var_183_0, arg_185_0)
			arg_183_0:ActiveCamera(var_183_0)

			return
		end,
		function(arg_186_0)
			arg_183_0:ShowBlackScreen(false, arg_186_0)

			return
		end
	}, function()
		arg_183_0:emit(var_0_0.HIDE_BLOCK)

		return
	end)
	arg_183_0:RefreshSlots()

	return
end

function var_0_0.SwitchFurnitureZone(arg_188_0, arg_188_1)
	local var_188_0 = arg_188_0:GetFurnitureByName(arg_188_1:GetWatchCameraName()):Find("FurnitureWatch Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	if arg_188_0.cameraFurnitureWatch and arg_188_0.cameraFurnitureWatch ~= var_188_0 then
		arg_188_0:UnRegisterCameraBlendFinished(arg_188_0.cameraFurnitureWatch)
		setActive(arg_188_0.cameraFurnitureWatch, false)
	end

	arg_188_0.cameraFurnitureWatch = var_188_0
	arg_188_0.cameras[var_0_0.CAMERA.FURNITURE_WATCH] = arg_188_0.cameraFurnitureWatch
	arg_188_0.furniturePOV = arg_188_0.cameraFurnitureWatch:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim)

	arg_188_0:RegisterCameraBlendFinished(arg_188_0.cameraFurnitureWatch, function()
		arg_188_0:emit(var_0_0.HIDE_BLOCK)

		return
	end)
	arg_188_0:emit(var_0_0.SHOW_BLOCK)
	arg_188_0:ActiveCamera(arg_188_0.cameraFurnitureWatch)

	return
end

function var_0_0.HideFurnitureSlots(arg_190_0)
	if arg_190_0.displaySlots then
		arg_190_0:UpdateDisplaySlots({})
		table.Foreach(arg_190_0.displaySlots, function(arg_191_0, arg_191_1)
			if IsNil(arg_191_1.trans:Find("Selector")) then
				return
			end

			setActive(arg_191_1.trans:Find("Selector"), false)

			return
		end)

		arg_190_0.displaySlots = nil
	end

	return
end

function var_0_0.DisplayFurnitureSlots(arg_192_0, arg_192_1)
	arg_192_0:HideFurnitureSlots()

	arg_192_0.displaySlots = {}

	_.each(arg_192_1, function(arg_193_0)
		arg_192_0.displaySlots[arg_193_0] = arg_192_0.slotDict[arg_193_0]

		if not arg_192_0.displaySlots[arg_193_0] then
			errorMsg("Slot " .. arg_193_0 .. " Not Binding Scene Object")

			return
		end

		if arg_192_0.displaySlots[arg_193_0].trans:Find("Selector") then
			setActive(var_193_0:Find("Selector"), true)
		end

		return
	end)

	return
end

function var_0_0.UpdateDisplaySlots(arg_194_0, arg_194_1)
	table.Foreach(arg_194_0.displaySlots, function(arg_195_0, arg_195_1)
		if not IsNil(arg_195_1.trans:Find("Selector")) then
			setActive(arg_195_1.trans:Find("Selector/Normal"), arg_194_1[arg_195_0] == 0)
			setActive(arg_195_1.trans:Find("Selector/Active"), arg_194_1[arg_195_0] == 1)
			setActive(arg_195_1.trans:Find("Selector/Ban"), arg_194_1[arg_195_0] == 2)
		end

		local var_195_0 = arg_194_0.slotDict[arg_195_0].model

		if arg_194_0.slotDict[arg_195_0].displayModelName and arg_194_0.slotDict[arg_195_0].displayModelName ~= "" then
			var_195_0 = arg_195_1.trans:GetChild(arg_195_1.trans.childCount - 1)
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

function var_0_0.EnterPhotoMode(arg_198_0, arg_198_1, arg_198_2)
	arg_198_0:SetAllBlackbloardValue("inLockLayer", true)
	arg_198_0:emit(var_0_0.ENABLE_SCENEBLOCK, true)
	seriesAsync({
		function(arg_199_0)
			arg_198_0:TempHideUI(true, arg_199_0)

			return
		end,
		function(arg_200_0)
			arg_198_0:ShowBlackScreen(true, arg_200_0)

			return
		end,
		function(arg_201_0)
			local var_201_0 = arg_198_0.apartment:GetConfigID()

			arg_198_0:SwitchAnim(arg_198_0.ladyDict[var_201_0], arg_198_2)
			arg_198_0.ladyDict[var_201_0].ladyAnimator:Update(0)
			arg_198_0:ResetCharPoint(arg_198_0.ladyDict[var_201_0], arg_198_1:GetWatchCameraName())
			arg_198_0:SyncInterestTransform(arg_198_0.ladyDict[var_201_0])
			setActive(arg_198_0.ladyDict[var_201_0].ladySafeCollider, true)
			arg_198_0:HideCharacter(var_201_0)

			arg_198_0.cameras[var_0_0.CAMERA.PHOTO].m_XAxis.Value = 180
			arg_198_0.cameras[var_0_0.CAMERA.PHOTO].m_XAxis = arg_198_0.cameras[var_0_0.CAMERA.PHOTO].m_XAxis
			arg_198_0.cameras[var_0_0.CAMERA.PHOTO].m_YAxis.Value = 0.7
			arg_198_0.cameras[var_0_0.CAMERA.PHOTO].m_YAxis = arg_198_0.cameras[var_0_0.CAMERA.PHOTO].m_YAxis
			arg_198_0.pinchValue = 1

			arg_198_0:RegisterOrbits(arg_198_0.cameras[var_0_0.CAMERA.PHOTO])
			arg_198_0:SetCameraObrits()
			setActive(arg_198_0.restrictedBox, true)
			arg_198_0:RegisterCameraBlendFinished(arg_198_0.cameras[var_0_0.CAMERA.PHOTO], arg_201_0)
			arg_198_0:ActiveCamera(arg_198_0.cameras[var_0_0.CAMERA.PHOTO])

			return
		end,
		function(arg_202_0)
			arg_198_0:ShowBlackScreen(false, arg_202_0)

			return
		end
	}, function()
		arg_198_0:EnableJoystick(true)

		return
	end)

	return
end

function var_0_0.ExitPhotoMode(arg_204_0)
	arg_204_0:emit(var_0_0.SHOW_BLOCK)
	arg_204_0:EnableJoystick(false)
	seriesAsync({
		function(arg_205_0)
			arg_204_0:ShowBlackScreen(true, arg_205_0)

			return
		end,
		function(arg_206_0)
			arg_204_0:RevertCameraOrbit()

			local var_206_0 = arg_204_0:GetCurrentLadyEnv()

			arg_204_0:SwitchAnim(var_206_0, var_0_0.ANIM.IDLE)
			setActive(var_206_0.ladySafeCollider, false)
			onNextTick(function()
				arg_204_0:ChangeCharacterPosition(var_206_0)

				return
			end)

			if arg_204_0.contextData.photoFreeMode then
				arg_204_0:EnablePOVLayer(false)

				arg_204_0.contextData.photoFreeMode = nil
			end

			setActive(arg_204_0.restrictedBox, false)
			arg_204_0:RegisterCameraBlendFinished(arg_204_0.cameras[var_0_0.CAMERA.POV], arg_206_0)
			arg_204_0:ActiveCamera(arg_204_0.cameras[var_0_0.CAMERA.POV])

			return
		end,
		function(arg_208_0)
			arg_204_0:RevertCharacter(arg_204_0.apartment:GetConfigID())
			arg_204_0:ShowBlackScreen(false, arg_208_0)

			return
		end
	}, function()
		arg_204_0:RefreshSlots()
		arg_204_0:SetAllBlackbloardValue("inLockLayer", false)
		arg_204_0:emit(var_0_0.HIDE_BLOCK)
		arg_204_0:emit(var_0_0.ENABLE_SCENEBLOCK, false)
		arg_204_0:TempHideUI(false)

		return
	end)

	return
end

function var_0_0.SwitchCameraZone(arg_210_0, arg_210_1, arg_210_2, arg_210_3)
	arg_210_0:emit(var_0_0.SHOW_BLOCK)
	seriesAsync({
		function(arg_211_0)
			arg_210_0:ShowBlackScreen(true, arg_211_0)

			return
		end,
		function(arg_212_0)
			arg_210_0:SwitchAnim(arg_210_0:GetCurrentLadyEnv(), arg_210_2)
			onNextTick(function()
				arg_210_0:ResetCharPoint(var_0, arg_210_1:GetWatchCameraName())
				arg_210_0:SyncInterestTransform(var_0)

				if arg_210_0.contextData.photoFreeMode then
					arg_210_0.camBrain.enabled = false

					arg_210_0:SwitchPhotoCamera()

					arg_210_0.camBrain.enabled = true

					onDelayTick(function()
						arg_210_0.camBrain.enabled = false

						arg_210_0:SwitchPhotoCamera()

						arg_210_0.camBrain.enabled = true

						return
					end, 0.1)
				end

				arg_212_0()

				return
			end)

			return
		end,
		function(arg_215_0)
			arg_210_0:ShowBlackScreen(false, arg_215_0)

			return
		end
	}, function()
		arg_210_0:emit(var_0_0.HIDE_BLOCK)
		existCall(arg_210_3)

		return
	end)

	return
end

function var_0_0.SwitchPhotoCamera(arg_217_0)
	if not arg_217_0.contextData.photoFreeMode then
		arg_217_0:EnableJoystick(false)
		arg_217_0:EnablePOVLayer(true)

		local var_217_0 = arg_217_0.cameras[var_0_0.CAMERA.PHOTO_FREE]:Find("PhotoFree Camera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)):GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim)
		local var_217_1 = arg_217_0.mainCameraTF.rotation:ToEulerAngles()

		var_217_0.m_HorizontalAxis.Value = var_217_1.y
		var_217_0.m_HorizontalAxis = var_217_0.m_HorizontalAxis
		var_217_0.m_VerticalAxis.Value = arg_217_0:GetNearestAngle(var_217_1.x, var_217_0.m_VerticalAxis.m_MinValue, var_217_0.m_VerticalAxis.m_MaxValue)
		var_217_0.m_VerticalAxis = var_217_0.m_VerticalAxis

		local var_217_2 = arg_217_0:GetRestritedHeightRange()

		arg_217_0.mainCameraTF.position.y = math.clamp(arg_217_0.mainCameraTF.position.y, var_217_2[1], var_217_2[2])
		arg_217_0.cameras[var_0_0.CAMERA.PHOTO_FREE].transform.position = arg_217_0.mainCameraTF.position

		arg_217_0:emit(Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED, (math.InverseLerp(var_217_2[1], var_217_2[2], arg_217_0.mainCameraTF.position.y)))
		arg_217_0:ActiveCamera(arg_217_0.cameras[var_0_0.CAMERA.PHOTO_FREE])
	else
		arg_217_0:EnableJoystick(true)
		arg_217_0:EnablePOVLayer(false)
		arg_217_0:ActiveCamera(arg_217_0.cameras[var_0_0.CAMERA.PHOTO])
	end

	arg_217_0.contextData.photoFreeMode = not arg_217_0.contextData.photoFreeMode

	return
end

function var_0_0.SetPhotoCameraHeight(arg_218_0, arg_218_1)
	local var_218_0 = arg_218_0:GetRestritedHeightRange()

	arg_218_0.cameras[var_0_0.CAMERA.PHOTO_FREE]:GetComponent(typeof(UnityEngine.CharacterController)):Move(Vector3.New(0, math.lerp(var_218_0[1], var_218_0[2], arg_218_1) - arg_218_0.cameras[var_0_0.CAMERA.PHOTO_FREE].position.y, 0))
	onNextTick(function()
		local var_219_0 = arg_218_0:GetRestritedHeightRange()

		arg_218_0:emit(Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED, (math.InverseLerp(var_219_0[1], var_219_0[2], var_0.position.y)))

		return
	end)

	return
end

function var_0_0.ResetPhotoCameraPosition(arg_220_0)
	arg_220_0.cameras[var_0_0.CAMERA.PHOTO].m_XAxis.Value = 180
	arg_220_0.cameras[var_0_0.CAMERA.PHOTO].m_XAxis = arg_220_0.cameras[var_0_0.CAMERA.PHOTO].m_XAxis
	arg_220_0.cameras[var_0_0.CAMERA.PHOTO].m_YAxis.Value = 0.7
	arg_220_0.cameras[var_0_0.CAMERA.PHOTO].m_YAxis = arg_220_0.cameras[var_0_0.CAMERA.PHOTO].m_YAxis

	return
end

function var_0_0.ResetCurrentCharPoint(arg_221_0, arg_221_1)
	arg_221_0:ResetCharPoint(arg_221_0:GetCurrentLadyEnv(), arg_221_1)

	return
end

function var_0_0.ResetCharPoint(arg_222_0, arg_222_1, arg_222_2)
	local var_222_0 = arg_222_0.furnitures:Find(arg_222_2 .. "/StayPoint")

	arg_222_1.lady.position = var_222_0.position
	arg_222_1.lady.rotation = var_222_0.rotation

	return
end

function var_0_0.GetNearestAngle(arg_223_0, arg_223_1, arg_223_2, arg_223_3)
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

function var_0_0.PlayTimeline(arg_224_0, arg_224_1, arg_224_2)
	if arg_224_0.waitForTimeline then
		table.insert({}, function(arg_225_0)
			arg_224_0.waitForTimeline = nil

			arg_224_0.waitForTimeline()
			arg_225_0()

			return
		end)
	end

	table.insert({}, function(arg_226_0)
		arg_224_0:LoadTimelineScene(arg_224_1.name, false, nil, arg_226_0)

		return
	end)

	if arg_224_1.scene and arg_224_1.sceneRoot then
		table.insert({}, function(arg_227_0)
			arg_224_0:ChangeArtScene(arg_224_1.scene .. "|" .. arg_224_1.sceneRoot, arg_227_0)

			return
		end)
	end

	table.insert({}, function(arg_228_0)
		local var_228_0 = Dorm3dHxHelper.GetTimelineMainCharacter()

		Dorm3dHxHelper.ShowHolyLight({
			var_228_0
		}, arg_224_0.holyLightRoot)

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

		arg_224_0.nowTimelinePlayer = TimelinePlayer.New(GameObject.Find("[sequence]").transform)

		TimelineSupport.InitSubtitle(arg_224_0.nowTimelinePlayer.comDirector, arg_224_0.apartment:GetCallName())
		arg_224_0.nowTimelinePlayer:Register(arg_224_1.time, function(arg_231_0, arg_231_1, arg_231_2)
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
						arg_224_0:DoTimelineOption(arg_224_1.options[arg_231_1.intParameter], function(arg_236_0)
							arg_231_2.selectIndex = arg_236_0
							arg_231_2.optionIndex = var_0[arg_236_0].flag

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

						arg_224_0:DoTimelineTouch(arg_224_1.touchs[arg_231_1.intParameter], function(arg_238_0)
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
					if arg_224_0.canTriggerAccompanyPerformance then
						arg_224_0.canTriggerAccompanyPerformance = false

						arg_231_0:SetTime(arg_224_1.accompanys[arg_231_1.intParameter][math.random(#arg_224_1.accompanys[arg_231_1.intParameter])])
					end

					return
				end,
				TimelineIKStart = function()
					arg_231_2.selectIndex = nil

					local var_242_0 = arg_224_0:GetCurrentLadyEnv()

					if var_242_0:CheckIkTimelineStatus(arg_231_1.intParameter) then
						arg_224_0:emit(RoomIKSystem.SET_IK_TIMELINE_STATUS, var_242_0, var_228_0.gameObject, arg_231_1.intParameter, var_228_2)
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

					arg_224_0:emit(AimIKSystem.ENTER_TIMELINE_AIMIK_STATUS, arg_231_1.intParameter)

					return
				end
			}, function()
				warning("other event trigger:" .. arg_231_1.stringParameter)

				return
			end)

			if arg_231_2.finish then
				arg_224_0.timelineMark = arg_231_2
				arg_224_0.timelineFinishCall = nil

				pg.m02:sendNotification(var_0_0.TIMELINE_END)

				local var_231_0 = arg_224_0:GetCurrentLadyEnv()

				if var_231_0.ikTimelineMode then
					arg_224_0:emit(RoomIKSystem.EXIT_IK_TIMELINE_STATUS, var_231_0)
				end

				arg_228_0()
			end

			return
		end)

		function arg_224_0.timelineFinishCall()
			arg_224_0.nowTimelinePlayer:TriggerEvent({
				stringParameter = "TimelineEnd"
			})

			return
		end

		arg_224_0:HideCharacter()
		setActive(arg_224_0.mainCameraTF, false)
		setActive(var_228_2, true)
		eachChild(arg_224_0.rtTimelineScreen, function(arg_247_0)
			setActive(arg_247_0, false)

			return
		end)
		setActive(arg_224_0.rtTimelineScreen, true)
		setActive(arg_224_0.rtTimelineScreen:Find("btn_skip"), arg_224_0.inReplayTalk)
		arg_224_0.nowTimelinePlayer:Start()

		return
	end)
	table.insert({}, function(arg_248_0)
		arg_224_0:ShowBlackScreen(true, function()
			arg_224_0.nowTimelinePlayer:Stop()
			arg_224_0.nowTimelinePlayer:Dispose()

			arg_224_0.nowTimelinePlayer = nil

			arg_224_0:UnloadTimelineScene(arg_224_1.name, false, arg_248_0)

			return
		end)

		return
	end)

	local var_224_0 = arg_224_0.dormSceneMgr.artSceneInfo

	table.insert({}, function(arg_250_0)
		arg_224_0:RevertArtScene(var_224_0, arg_250_0)

		return
	end)
	seriesAsync({}, function()
		setActive(arg_224_0.rtTimelineScreen, false)
		arg_224_0:RevertCharacter()
		setActive(arg_224_0.mainCameraTF, true)
		arg_224_0:InitHolyLight()

		arg_224_0.timelineMark = nil

		existCall(arg_224_2, arg_224_0.timelineMark, function(arg_252_0)
			arg_224_0:ShowBlackScreen(false, arg_252_0)

			return
		end)

		return
	end)

	return
end

function var_0_0.GetCurrentLadyEnv(arg_253_0)
	if not arg_253_0.apartment then
		return nil
	end

	return arg_253_0.ladyDict[arg_253_0.apartment:GetConfigID()]
end

function var_0_0.PlayCurrentSingleAction(arg_254_0, ...)
	return arg_254_0:PlaySingleAction(arg_254_0:GetCurrentLadyEnv(), ...)
end

function var_0_0.PlaySingleAction(arg_255_0, arg_255_1, arg_255_2, arg_255_3, arg_255_4)
	arg_255_1:PlaySingleAction(arg_255_2, arg_255_3, arg_255_4)

	return
end

function var_0_0.SwitchCurrentAnim(arg_256_0, ...)
	return arg_256_0:SwitchAnim(arg_256_0:GetCurrentLadyEnv(), ...)
end

function var_0_0.SwitchAnim(arg_257_0, arg_257_1, arg_257_2, arg_257_3)
	arg_257_1:SwitchAnim(arg_257_2, arg_257_3)

	return
end

function var_0_0.PlayFaceAnim(arg_258_0, arg_258_1, arg_258_2, arg_258_3)
	arg_258_1:PlayFaceAnim(arg_258_2, arg_258_3)

	return
end

function var_0_0.RegisterAnimCallback(arg_259_0, arg_259_1, arg_259_2)
	arg_259_0:GetCurrentLadyEnv().animCallbacks[arg_259_1] = arg_259_2

	return
end

function var_0_0.SetCharacterAnimSpeed(arg_260_0, arg_260_1)
	local var_260_0 = arg_260_0:GetCurrentLadyEnv()

	var_260_0.ladyAnimator.speed = arg_260_1
	var_260_0.ladyHeadIKComp.blinkSpeed = var_260_0.ladyHeadIKData.blinkSpeed * arg_260_1
	var_260_0.ladyHeadIKComp.DampTime = arg_260_1 > 0 and var_260_0.ladyHeadIKData.DampTime / arg_260_1 or var_260_0.ladyHeadIKData.DampTime * math.huge

	return
end

function var_0_0.OnAnimationEvent(arg_261_0, arg_261_1)
	if arg_261_1.animatorClipInfo.weight < 0.5 then
		return
	end

	existCall((table.removebykey(arg_261_0.animEventCallbacks, arg_261_1.stringParameter)))

	return
end

function var_0_0.RegisterAnimEventCallback(arg_262_0, arg_262_1, arg_262_2)
	arg_262_0.animEventCallbacks[arg_262_1] = arg_262_2

	return
end

function var_0_0.PlaySceneItemAnim(arg_263_0, arg_263_1, arg_263_2, arg_263_3)
	arg_263_0.sceneAnimatorDict = arg_263_0.sceneAnimatorDict or {}

	if not arg_263_0.sceneAnimatorDict[arg_263_1] then
		local var_263_0 = arg_263_0:GetSceneItem(pg.dorm3d_scene_animator[arg_263_1].item_name)

		assert(var_263_0, "Missing Scene Animator in pg.dorm3d_scene_animator: " .. arg_263_1 .. " " .. pg.dorm3d_scene_animator[arg_263_1].item_name)

		if not var_263_0 then
			return
		end

		local var_263_1 = var_263_0:GetComponent(typeof(Animator))

		if not var_263_1 then
			return
		end

		arg_263_0.sceneAnimatorDict[arg_263_1] = {
			trans = var_263_0,
			animator = var_263_1
		}
	end

	if not arg_263_3 then
		if arg_263_0.sceneAnimatorDict[arg_263_1].animator:GetCurrentAnimatorStateInfo(0):IsName(arg_263_2) then
			return
		end
	end

	arg_263_0.sceneAnimatorDict[arg_263_1].animator:PlayInFixedTime(arg_263_2)

	return
end

function var_0_0.ResetSceneItemAnimators(arg_264_0, arg_264_1)
	if not arg_264_0.sceneAnimatorDict then
		return
	end

	table.Foreach(arg_264_0.sceneAnimatorDict, function(arg_265_0, arg_265_1)
		if arg_264_1 and table.contains(arg_264_1, arg_265_0) then
			return
		end

		setActive(arg_265_1.trans, false)
		setActive(arg_265_1.trans, true)

		arg_264_0.sceneAnimatorDict[arg_265_0] = nil

		return
	end)

	return
end

function var_0_0.LoadCharacterExtraItem(arg_266_0, arg_266_1, arg_266_2, arg_266_3, arg_266_4, arg_266_5, arg_266_6, arg_266_7)
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
		(function(arg_267_0)
			if arg_266_6 then
				local var_267_0 = arg_267_0:GetComponent(typeof(Animator))

				if var_267_0 then
					var_267_0:Play(arg_266_6)

					var_267_0.speed = arg_266_7
				end
			end

			return
		end)(arg_266_1.extraItems[arg_266_2].trans)

		return
	end

	local var_266_1

	if arg_266_3 == "" then
		var_266_1 = arg_266_1.lady
	elseif arg_266_3 == "scene_root" then
		var_266_1 = arg_266_0.modelRoot
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

	arg_266_0.loader:GetPrefab(string.lower("dorm3d/" .. arg_266_2), "", function(arg_269_0)
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

function var_0_0.ResetCharacterExtraItem(arg_270_0, arg_270_1, arg_270_2)
	if not arg_270_1.extraItems then
		return
	end

	table.Foreach(arg_270_1.extraItems, function(arg_271_0, arg_271_1)
		if arg_270_2 and table.contains(arg_270_2, arg_271_0) then
			return
		end

		arg_270_0.loader:ReturnPrefab(arg_271_1.trans.gameObject)

		arg_270_1.extraItems[arg_271_0] = nil

		return
	end)

	return
end

function var_0_0.RegisterCameraBlendFinished(arg_272_0, arg_272_1, arg_272_2)
	arg_272_0.cameraBlendCallbacks[arg_272_1] = arg_272_2

	return
end

function var_0_0.UnRegisterCameraBlendFinished(arg_273_0, arg_273_1)
	arg_273_0.cameraBlendCallbacks[arg_273_1] = nil

	return
end

function var_0_0.OnCameraBlendFinished(arg_274_0, arg_274_1)
	if not arg_274_1 then
		return
	end

	existCall((table.removebykey(arg_274_0.cameraBlendCallbacks, arg_274_1)))

	return
end

function var_0_0.PlayHeartFX(arg_275_0, arg_275_1)
	setActive(arg_275_0.ladyDict[arg_275_1].effectHeart, false)
	setActive(arg_275_0.ladyDict[arg_275_1].effectHeart, true)
	pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_joyful")

	return
end

function var_0_0.PlayExpression(arg_276_0, arg_276_1)
	local var_276_0 = arg_276_1.name

	if arg_276_0.expressionDict[arg_276_1.name] then
		arg_276_0.expressionDict[arg_276_1.name].timer:Reset(nil, 5)
		arg_276_0.expressionDict[arg_276_1.name].timer:Start()

		if arg_276_0.expressionDict[arg_276_1.name].instance then
			setActive(arg_276_0.expressionDict[arg_276_1.name].instance, false)
			setActive(arg_276_0.expressionDict[arg_276_1.name].instance, true)
		end

		return
	end

	local var_276_1 = {
		name = arg_276_1.name,
		timer = Timer.New(function()
			arg_276_0:RemoveExpression(var_276_0)

			return
		end, 5, 1, true)
	}

	arg_276_0.expressionDict[arg_276_1.name] = var_276_1

	arg_276_0.loader:GetPrefab("dorm3D/effect/prefab/expression/" .. arg_276_1.name, arg_276_1.name, function(arg_278_0)
		var_276_1.instance = arg_278_0

		onNextTick(function()
			setParent(arg_278_0, arg_276_0:GetCurrentLadyEnv().ladyHeadCenter)

			return
		end)
		setLocalPosition(arg_278_0, Vector3(0, 0, -0.2))
		setActive(arg_278_0, false)
		setActive(arg_278_0, true)

		return
	end, var_276_1)

	return
end

function var_0_0.RemoveExpression(arg_280_0, arg_280_1)
	if not arg_280_0.expressionDict[arg_280_1] then
		return
	end

	arg_280_0.loader:ClearRequest(arg_280_0.expressionDict[arg_280_1])

	if arg_280_0.expressionDict[arg_280_1].instance then
		arg_280_0.loader:ReturnPrefab(arg_280_0.expressionDict[arg_280_1].instance)
	end

	arg_280_0.expressionDict[arg_280_1] = nil

	return
end

function var_0_0.ShowOrHideCanWatchMark(arg_281_0, arg_281_1, arg_281_2)
	setActive(arg_281_1.ladyWatchFloat, arg_281_2)

	return
end

function var_0_0.RegisterGlobalVolume(arg_282_0)
	local var_282_0 = GraphicsInterface.Instance.GetOrAddVolumeComponent(arg_282_0.globalVolume, typeof(BLHX.Rendering.CustomDepthOfField))
	local var_282_1 = GraphicsInterface.Instance.GetOrAddVolumeComponent(arg_282_0.globalVolume, typeof(UnityEngine.Rendering.Universal.ColorAdjustments))

	arg_282_0.originalCameraSettings = {
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
	arg_282_0.originalCameraSettings.depthOfField.enabled = true

	local var_282_2 = arg_282_0.globalVolume:GetComponent(typeof(UnityEngine.Rendering.Volume))

	arg_282_0.originalVolume = {
		profile = var_282_2.sharedProfile,
		weight = var_282_2.weight
	}

	return
end

function var_0_0.SettingCamera(arg_283_0, arg_283_1)
	arg_283_0.activeCameraSettings = arg_283_1

	local var_283_0 = GraphicsInterface.Instance.GetOrAddVolumeComponent(arg_283_0.globalVolume, typeof(BLHX.Rendering.CustomDepthOfField))
	local var_283_1 = GraphicsInterface.Instance.GetOrAddVolumeComponent(arg_283_0.globalVolume, typeof(UnityEngine.Rendering.Universal.ColorAdjustments))

	var_283_0.enabled:Override(arg_283_1.depthOfField.enabled)
	var_283_0.gaussianStart:Override(arg_283_1.depthOfField.focusDistance.value)
	var_283_0.gaussianEnd:Override(arg_283_1.depthOfField.focusDistance.value + arg_283_1.depthOfField.focusDistance.length)
	var_283_0.blurRadius:Override(arg_283_1.depthOfField.blurRadius.value)
	var_283_1.postExposure:Override(arg_283_1.postExposure.value)
	var_283_1.contrast:Override(arg_283_1.contrast.value)
	var_283_1.saturation:Override(arg_283_1.saturate.value)

	return
end

function var_0_0.GetCameraSettings(arg_284_0)
	return arg_284_0.originalCameraSettings
end

function var_0_0.RevertCameraSettings(arg_285_0)
	arg_285_0:SettingCamera(arg_285_0.originalCameraSettings)

	arg_285_0.activeCameraSettings = nil

	return
end

function var_0_0.SetVolumeProfile(arg_286_0, arg_286_1, arg_286_2)
	if arg_286_0.cameraVolume then
		arg_286_0:RevertVolumeProfile()
	end

	arg_286_0.loader:GetPrefab("dorm3d/effect/volume/" .. arg_286_1, "", function(arg_287_0)
		arg_286_0.cameraVolume = arg_287_0

		return
	end)

	return
end

function var_0_0.RevertVolumeProfile(arg_288_0)
	if arg_288_0.cameraVolume then
		arg_288_0.loader:ReturnPrefab(arg_288_0.cameraVolume)

		arg_288_0.cameraVolume = nil
	end

	return
end

function var_0_0.RecordCharacterLight(arg_289_0)
	tolua.loadassembly("Yongshi.BLRP.Runtime.AOT")

	local var_289_0 = arg_289_0.characterLight:GetComponent(typeof("BLHX.Rendering.CharacterLight"))

	arg_289_0.originalCharacterColor = {
		color = ReflectionHelp.RefGetProperty(typeof("BLHX.Rendering.CharacterLight"), "characterLightColor", var_289_0),
		intensity = ReflectionHelp.RefGetProperty(typeof("BLHX.Rendering.CharacterLight"), "characterLightIntensity", var_289_0)
	}

	return
end

function var_0_0.SetCharacterLight(arg_290_0, arg_290_1, arg_290_2, arg_290_3)
	local var_290_0 = arg_290_0.characterLight:GetComponent(typeof(Light))
	local var_290_1 = arg_290_0.characterLight:GetComponent(typeof("BLHX.Rendering.CharacterLight"))

	ReflectionHelp.RefSetProperty(typeof("BLHX.Rendering.CharacterLight"), "characterLightColor", var_290_1, (Color.Lerp(arg_290_0.originalCharacterColor.color, arg_290_1, arg_290_3)))
	ReflectionHelp.RefSetProperty(typeof("BLHX.Rendering.CharacterLight"), "characterLightIntensity", var_290_1, (math.lerp(arg_290_0.originalCharacterColor.intensity, arg_290_2, arg_290_3)))

	return
end

function var_0_0.RevertCharacterLight(arg_291_0)
	arg_291_0:SetCharacterLight(arg_291_0.originalCharacterColor.color, arg_291_0.originalCharacterColor.intensity, 1)

	return
end

function var_0_0.onBackPressed(arg_292_0)
	if arg_292_0.exited or arg_292_0.retainCount > 0 then
		-- block empty
	else
		arg_292_0:closeView()
	end

	return
end

function var_0_0.LoadTimelineScene(arg_293_0, arg_293_1, arg_293_2, arg_293_3, arg_293_4)
	arg_293_0.dormSceneMgr:LoadTimelineScene({
		name = arg_293_1,
		assetRootName = arg_293_0.apartment:getConfig("asset_name"),
		isCache = arg_293_2,
		waitForTimeline = arg_293_3,
		loadSceneFunc = function(arg_294_0, arg_294_1)
			local var_294_0 = Dorm3dHxHelper.GetTimelineMainCharacter()

			Dorm3dHxHelper.HideCharacterPart(var_294_0, nil, true)
			arg_293_0:HXCharacter(var_294_0)

			return
		end
	}, arg_293_4)

	return
end

function var_0_0.UnloadTimelineScene(arg_295_0, arg_295_1, arg_295_2, arg_295_3)
	arg_295_0.dormSceneMgr:UnloadTimelineScene(arg_295_1, arg_295_2, arg_295_3)

	return
end

function var_0_0.ChangeArtScene(arg_296_0, arg_296_1, arg_296_2)
	table.insert({}, function(arg_297_0)
		arg_296_0.dormSceneMgr:ChangeArtScene(arg_296_1, arg_297_0)

		return
	end)
	table.insert({}, function(arg_298_0)
		setActive(arg_296_0.slotRoot, false)
		arg_298_0()

		return
	end)
	warning(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>", arg_296_1, arg_296_0.dormSceneMgr.sceneInfo, Dorm3dSceneMgr.IsSameSceneInfo(arg_296_1, arg_296_0.dormSceneMgr.sceneInfo))

	if Dorm3dSceneMgr.IsSameSceneInfo(arg_296_1, arg_296_0.dormSceneMgr.sceneInfo) then
		table.insert({}, function(arg_299_0)
			arg_296_0:SwitchDayNight(1)
			arg_296_0:TempHideContact(true)
			arg_299_0()

			return
		end)
	end

	seriesAsync({}, arg_296_2)

	return
end

function var_0_0.RevertArtScene(arg_300_0, arg_300_1, arg_300_2)
	table.insert({}, function(arg_301_0)
		arg_300_0.dormSceneMgr:ChangeArtScene(arg_300_1, arg_301_0)

		return
	end)
	table.insert({}, function(arg_302_0)
		setActive(arg_300_0.slotRoot, true)
		arg_302_0()

		return
	end)
	table.insert({}, function(arg_303_0)
		arg_300_0:SwitchDayNight(arg_300_0.contextData.timeIndex)
		onNextTick(function()
			arg_300_0:RefreshSlots()
			arg_300_0:TempHideContact(false)
			arg_303_0()

			return
		end)

		return
	end)
	seriesAsync({}, arg_300_2)

	return
end

function var_0_0.ChangeSubScene(arg_305_0, arg_305_1, arg_305_2)
	table.insert({}, function(arg_306_0)
		arg_305_0.dormSceneMgr:ChangeSubScene(arg_305_1, arg_306_0)

		return
	end)

	local var_305_0 = arg_305_0:GetCurrentLadyEnv()

	table.insert({}, function(arg_307_0)
		if Dorm3dSceneMgr.IsSameSceneInfo(arg_305_1, arg_305_0.dormSceneMgr.sceneInfo) then
			var_305_0.ladyActiveZone = var_305_0.walkBornPoint or var_305_0.ladyBaseZone
		else
			local var_307_0 = var_305_0

			var_307_0.ladyActiveZone = var_305_0.walkBornPoint or "Default"
		end

		arg_307_0()

		return
	end)

	if not Dorm3dSceneMgr.IsSameSceneInfo(arg_305_1, arg_305_0.dormSceneMgr.subSceneInfo) then
		table.insert({}, function(arg_308_0)
			local var_308_0, var_308_1 = Dorm3dSceneMgr.ParseInfo(arg_305_1)

			arg_305_0:ResetSceneStructure(SceneManager.GetSceneByName(var_308_0 .. "_base"))

			if Dorm3dSceneMgr.IsSameSceneInfo(arg_305_1, arg_305_0.dormSceneMgr.sceneInfo) then
				arg_305_0:RefreshSlots()
			else
				arg_305_0:SwitchAnim(var_305_0, var_0_0.ANIM.IDLE)
			end

			if not Dorm3dSceneMgr.IsSameSceneInfo(arg_305_0.dormSceneMgr.subSceneInfo, arg_305_0.dormSceneMgr.sceneInfo) then
				arg_305_0:RefreshSlotsEmpty()
			end

			arg_308_0()

			return
		end)
	end

	table.insert({}, function(arg_309_0)
		onNextTick(function()
			arg_305_0:ChangeCharacterPosition(var_305_0)
			arg_305_0:ChangePlayerPosition(var_305_0.ladyActiveZone)
			arg_305_0:TriggerLadyDistance()
			arg_305_0:CheckInSector()
			arg_309_0()

			return
		end)

		return
	end)
	seriesAsync({}, arg_305_2)

	return
end

function var_0_0.IsPointInSector(arg_311_0, arg_311_1)
	local var_311_0 = arg_311_1 - arg_311_0.Position

	if (arg_311_1 - arg_311_0.Position).y > arg_311_0.Radius then
		return false
	end

	var_311_0.y = 0

	local var_311_1

	if var_311_0.magnitude > arg_311_0.Radius then
		do return false end

		var_311_1 = Vector3.Angle
	end

	return var_311_1(arg_311_0.Rotation * Vector3.forward, var_311_0) <= arg_311_0.Angle / 2
end

function var_0_0.GetRestritedHeightRange(arg_312_0)
	if not arg_312_0.isMultiFloor then
		return arg_312_0.restrictedHeightRange
	else
		for iter_312_0 = #arg_312_0.restrictedHeightRange, 1, -1 do
			if arg_312_0.mainCameraTF.position.y >= arg_312_0.restrictedHeightRange[iter_312_0][1] then
				return arg_312_0.restrictedHeightRange[iter_312_0]
			end
		end

		return arg_312_0.restrictedHeightRange[1]
	end

	return
end

function var_0_0.willExit(arg_313_0)
	var_0_0.super.willExit(arg_313_0)
	arg_313_0.joystickTimer:Stop()
	arg_313_0.moveStickTimer:Stop()
	UpdateBeat:RemoveListener(arg_313_0.updateHandler)

	if arg_313_0.moveTimer then
		arg_313_0.moveTimer:Stop()

		arg_313_0.moveTimer = nil
	end

	if arg_313_0.moveWaitTimer then
		arg_313_0.moveWaitTimer:Stop()

		arg_313_0.moveWaitTimer = nil
	end

	GlobalClickEventMgr.Inst:RemoveBeginPinchFunc()
	GlobalClickEventMgr.Inst:RemovePinchFunc()
	GlobalClickEventMgr.Inst:RemoveEndPinchFunc()

	if not IsNil(arg_313_0.furnitures) then
		eachChild(arg_313_0.furnitures, function(arg_314_0)
			local var_314_0 = GetComponent(arg_314_0, typeof(EventTriggerListener))

			if not var_314_0 then
				return
			end

			var_314_0:ClearEvents()

			return
		end)
	end

	pg.IKMgr.GetInstance():ResetActiveIKs()

	for iter_313_0, iter_313_1 in pairs(arg_313_0.ladyDict) do
		GetComponent(iter_313_1.lady, typeof(EventTriggerListener)):ClearEvents()
	end

	arg_313_0.camBrainEvenetHandler.OnBlendStarted = nil
	arg_313_0.camBrainEvenetHandler.OnBlendFinished = nil

	arg_313_0:UnOverlayPanel(arg_313_0.blockLayer, arg_313_0._tf)
	table.Foreach(arg_313_0.expressionDict, function(arg_315_0)
		arg_313_0:RemoveExpression(arg_315_0)

		return
	end)
	arg_313_0.loader:Clear()
	pg.ClickEffectMgr.GetInstance():SetClickEffect("NORMAL")
	pg.NodeCanvasMgr.GetInstance():Clear()
	arg_313_0.dormSceneMgr:Dispose()

	arg_313_0.dormSceneMgr = nil

	ReflectionHelp.RefSetProperty(typeof("UnityEngine.LightmapSettings"), "lightmaps", nil, nil)

	if arg_313_0.transformFilter then
		arg_313_0.transformFilter:Dispose()
	end

	return
end

return var_0_0
