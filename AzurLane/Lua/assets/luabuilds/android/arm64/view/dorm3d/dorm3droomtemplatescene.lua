class = var_0_10000

local var_0_0 = "Dorm3dRoomTemplateScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Core.Dorm3dBaseScene"))

var_0_1.CAMERA = {
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
var_0_1.CAMERA_MAX_OPERATION = {
	RIGHT = "right",
	DOWN = "donw",
	ZOOMIN = "zoom_in",
	ZOOMOUT = "zoom_out",
	UP = "up",
	LEFT = "left"
}
var_0_1.ANIM = {
	IDLE = "Idle"
}
var_0_1.PLAY_EXPRESSION = "Dorm3dRoomTemplateScene.PLAY_EXPRESSION"
var_0_1.MOVE_PLAYER_TO_FURNITURE = "Dorm3dRoomTemplateScene.MOVE_PLAYER_TO_FURNITURE"
var_0_1.SHOW_BLOCK = "Dorm3dRoomTemplateScene.SHOW_BLOCK"
var_0_1.HIDE_BLOCK = "Dorm3dRoomTemplateScene.HIDE_BLOCK"
var_0_1.ON_ROLEWATCH_CAMERA_MAX = "Dorm3dRoomTemplateScene.ON_ROLEWATCH_CAMERA_MAX"
var_0_1.ON_STICK_MOVE = "Dorm3dRoomTemplateScene.ON_STICK_MOVE"
var_0_1.ENABLE_SCENEBLOCK = "Dorm3dRoomTemplateScene.ENABLE_SCENEBLOCK"
var_0_1.ON_POV_STICK_MOVE_BEGIN = "Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_BEGIN"
var_0_1.ON_POV_STICK_MOVE = "Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE"
var_0_1.ON_POV_STICK_MOVE_END = "Dorm3dRoomTemplateScene.ON_POV_STICK_MOVE_END"
var_0_1.ON_POV_STICK_VIEW = "Dorm3dRoomTemplateScene.ON_POV_STICK_VIEW"
var_0_1.ON_ENTER_SECTOR = "Dorm3dRoomTemplateScene.ON_ENTER_SECTOR"
var_0_1.ON_CHANGE_DISTANCE = "Dorm3dRoomTemplateScene.ON_CHANGE_DISTANCE"
var_0_1.CLICK_CHARACTER = "Dorm3dRoomTemplateScene.CLICK_CHARACTER"
var_0_1.CLICK_CONTACT = "Dorm3dRoomTemplateScene.CLICK_CONTACT"
var_0_1.DISTANCE_TRIGGER = "Dorm3dRoomTemplateScene.DISTANCE_TRIGGER"
var_0_1.WALK_DISTANCE_TRIGGER = "Dorm3dRoomTemplateScene.WALK_DISTANCE_TRIGGER"
var_0_1.CHANGE_WATCH = "Dorm3dRoomTemplateScene.CHANGE_WATCH"
var_0_1.PHOTO_CALL = "Dorm3dRoomTemplateScene.PHOTO_CALL"
var_0_1.SHIFT_ZONE_SAFE = "Dorm3dRoomTemplateScene.SHIFT_ZONE_SAFE"
var_0_1.TIMELINE_END = "Dorm3dRoomTemplateScene.TIMELINE_END"
var_0_1.TRIGGER_TIMELINE_PLAYER_EVENT = "Dorm3dRoomTemplateScene.TRIGGER_TIMELINE_PLAYER_EVENT"
var_0_1.POV_CLOSE_DISTANCE = 1.5
var_0_1.POV_PENDING_CLOSE_DISTANCE = 2

function var_0_1.getUIName(arg_1_0)
	return nil
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

function var_0_1.getBGM(arg_6_0)
	pg = var_1_10001

	if var_1_10001.dorm3d_rooms[arg_6_0.contextData.roomId].room_bgm and var_1 ~= "" then
		return var_1
	else
		return var_0_1.super.getBGM(arg_6_0)
	end

	return
end

function var_0_1.Ctor(arg_7_0, ...)
	var_0_1.super.Ctor(arg_7_0, ...)

	AutoLoader = var_1
	arg_7_0.loader = var_1.New()
	arg_7_0.scene = arg_7_0

	return
end

function var_0_1.SetRoom(arg_8_0, arg_8_1)
	arg_8_0.room = arg_8_1

	return
end

function var_0_1.preload(arg_9_0, arg_9_1)
	tolua = var_1_10002

	var_1_10002.loadassembly("MagicaClothV2")

	tolua = var_2

	var_2.loadassembly("ParadoxNotion")

	tolua = var_2

	var_2.loadassembly("Yongshi.BLRP.Runtime")

	pairs = var_2

	for iter_9_0, iter_9_1 in var_2({
		_MonoManager = "ParadoxNotion.Services.MonoManager"
	}) do
		GameObject = var_1_10007

		if not var_1_10007.Find(iter_9_0) then
			GameObject = var_1_10007
			var_1_10007 = var_1_10007.New(iter_9_0)
			GetOrAddComponent = var_1_10008

			local var_9_0 = var_1_10007

			typeof = var_1_10011

			var_1_10008(var_9_0, var_1_10011(iter_9_1))
		end
	end

	getProxy = var_2
	ApartmentProxy = var_4

	local var_9_1 = var_2(var_4)

	arg_9_0.room = var_2.getRoom(var_9_1, arg_9_0.contextData.roomId)

	local var_9_2 = {}

	table = var_3

	var_3.insert(var_9_2, function(arg_10_0)
		local var_10_0 = arg_9_0

		Dorm3dSceneMgr = var_2_10002

		local var_10_1 = var_2_10002.New
		local var_10_2 = arg_9_0.room

		var_10_0.dormSceneMgr = var_10_1(var_4.getConfig(var_10_2, "scene_info"), arg_10_0)

		return
	end)

	table = var_3

	var_3.insert(var_9_2, function(arg_11_0)
		local var_11_0 = arg_9_0

		var_1.LoadCharacter(var_11_0, arg_9_0.contextData.groupIds, arg_11_0)

		return
	end)

	seriesAsync = var_3

	var_3(var_9_2, arg_9_1)

	return
end

function var_0_1.init(arg_12_0)
	arg_12_0:BindEvent()
	arg_12_0:InitData()
	arg_12_0:initScene()
	arg_12_0:initNodeCanvas()

	local var_12_0 = arg_12_0.room
	local var_12_1

	if var_1.isPersonalRoom(var_12_0) then
		var_12_1 = arg_12_0.contextData.groupIds[1]
		getProxy = var_1_10002
		ApartmentProxy = var_1_10004

		local var_12_2 = var_1_10002(var_1_10004)
		local var_12_3 = var_2.getApartment(var_12_2, var_12_1)
		local var_12_4 = var_2.GetCurSkinId(var_12_3)
		local var_12_5 = arg_12_0.ladyDict[var_12_1]

		setActive = var_12_3

		var_12_3(var_12_5.ladyGameObject, false)

		var_12_5.skinId = var_12_4
		var_12_5.ladyGameObject = arg_12_0.skinDict[var_12_4].ladyGameObject
		setActive = var_5

		var_5(var_12_5.ladyGameObject, true)
	end

	pairs = var_12_1

	for iter_12_0, iter_12_1 in var_12_1(arg_12_0.ladyDict) do
		arg_12_0:InitCharacter(iter_12_1, iter_12_0)
	end

	local var_12_6 = arg_12_0.room

	if not var_1.isPersonalRoom(var_12_6) then
		underscore = var_1

		local var_12_7

		if not var_1.detect(arg_12_0.contextData.groupIds, function(arg_13_0)
			return arg_12_0.contextData.ladyZone[arg_13_0] == arg_12_0.contextData.inFurnitureName
		end) then
			var_12_7 = arg_12_0.contextData.groupIds[1]
		end

		if var_12_7 then
			arg_12_0:SyncInterestTransform(arg_12_0.ladyDict[var_12_7])
		end

		SlideExtraSystem = var_2

		if var_2.IsOpen(arg_12_0.room) then
			local var_12_8 = arg_12_0.contextData.inFurnitureName

			SlideConst = var_3

			if var_12_8 == var_3.SLIDE_ZONE then
				local var_12_9 = arg_12_0
				local var_12_10 = arg_12_0.SyncInterestTransformByTf
				local var_12_11 = arg_12_0:GetFurnitureByName(arg_12_0.contextData.inFurnitureName)

				var_12_10(var_12_9, var_5.Find(var_12_11, "StayPoint"))
			end
		end
	end

	arg_12_0.retainCount = 0

	local var_12_12 = arg_12_0._tf

	arg_12_0.sceneBlockLayer = var_1.Find(var_12_12, "SceneBlock")
	setActive = var_1

	var_1(arg_12_0.sceneBlockLayer, false)

	local var_12_13 = arg_12_0._tf

	arg_12_0.blockLayer = var_1.Find(var_12_13, "Block")
	setActive = var_1

	var_1(arg_12_0.blockLayer, false)

	local var_12_14 = arg_12_0._tf

	arg_12_0.blackLayer = var_1.Find(var_12_14, "BlackScreen")
	setActive = var_1

	var_1(arg_12_0.blackLayer, false)

	local var_12_15 = arg_12_0._tf

	arg_12_0.holyLightRoot = var_1.Find(var_12_15, "HolyLightRoot")

	arg_12_0:InitHolyLight()
	arg_12_0:ChangePlayerPosition()

	arg_12_0.cacheSceneDic = {}
	arg_12_0.sceneGroupDic = {}
	arg_12_0.lastSceneRootDict = {}
	pg = var_1

	local var_12_16 = var_1.ClickEffectMgr.GetInstance()

	var_1.SetClickEffect(var_12_16, "DORM3D")

	return
end

function var_0_1.BindEvent(arg_14_0)
	arg_14_0:bind(var_0_1.PLAY_EXPRESSION, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_14_0

		var_2.PlayExpression(var_15_0, arg_15_1)

		return
	end)
	arg_14_0:bind(var_0_1.SHOW_BLOCK, function()
		local var_16_0 = arg_14_0

		var_16_0.retainCount = arg_14_0.retainCount + 1
		setActive = var_16_0

		var_16_0(arg_14_0.blockLayer, true)

		return
	end)
	arg_14_0:bind(var_0_1.HIDE_BLOCK, function()
		local var_17_0 = arg_14_0

		math = var_2_10001
		var_17_0.retainCount = var_2_10001.max(arg_14_0.retainCount - 1, 0)

		if arg_14_0.retainCount > 0 then
			return
		end

		setActive = var_0

		var_0(arg_14_0.blockLayer, false)

		return
	end)
	arg_14_0:bind(var_0_1.ENABLE_SCENEBLOCK, function(arg_18_0, arg_18_1)
		setActive = var_2_10002

		var_2_10002(arg_14_0.sceneBlockLayer, arg_18_1)

		return
	end)
	arg_14_0:bind(var_0_1.ON_STICK_MOVE, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_14_0

		var_2.OnStickMove(var_19_0, arg_19_1)

		return
	end)
	arg_14_0:bind(var_0_1.ON_POV_STICK_MOVE_BEGIN, function(arg_20_0, arg_20_1)
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

		local var_21_0 = arg_14_0

		var_21_0.moveStickDraging = nil
		isActive = var_21_0

		if var_21_0(arg_14_0.cameras[var_0_1.CAMERA.PHOTO_FREE]) then
			local var_21_1 = arg_14_0
			local var_21_2 = var_0.emit

			Dorm3dPhotoMediator = var_3

			local var_21_3 = var_3.CAMERA_STICK_MOVE

			Vector2 = var_2_10004

			var_21_2(var_21_1, var_21_3, var_2_10004.zero)
		end

		return
	end

	arg_14_0:bind(var_0_1.ON_POV_STICK_MOVE_END, function(arg_22_0, arg_22_1)
		var_14_0()

		return
	end)
	arg_14_0:bind(var_0_1.ON_POV_STICK_MOVE, function(arg_23_0, arg_23_1)
		if arg_14_0.pinchMode then
			var_14_0()

			return
		end

		if not arg_14_0.moveStickDraging then
			return
		end

		local var_23_0 = arg_14_0

		var_23_0.moveStickPosition = arg_14_0.moveStickPosition + arg_23_1
		isActive = var_23_0

		local var_23_1 = arg_14_0.povLayer

		if var_23_0(var_4.Find(var_23_1, "Guide")) then
			setActive = var_2

			local var_23_2 = arg_14_0.povLayer

			var_2(var_4.Find(var_23_2, "Guide"), false)
		end

		return
	end)

	Screen = var_2

	local var_14_1 = 32.4 / var_2.height

	arg_14_0:bind(var_0_1.ON_POV_STICK_VIEW, function(arg_24_0, arg_24_1)
		if arg_14_0.pinchMode then
			return
		end

		local var_24_0 = (arg_24_1 * var_14_1).x
		local var_24_1 = arg_24_1.y

		local function var_24_2(arg_25_0, arg_25_1, arg_25_2)
			local var_25_0 = arg_25_0[arg_25_1]

			var_25_0.m_InputAxisValue = arg_25_2
			arg_25_0[arg_25_1] = var_25_0

			return
		end

		isActive = var_2_10005

		if var_2_10005(arg_14_0.cameras[var_0_1.CAMERA.POV]) then
			var_24_2(arg_14_0.compPovAim, "m_HorizontalAxis", var_24_0)
			var_24_2(arg_14_0.compPovAim, "m_VerticalAxis", var_24_1)
		else
			isActive = var_5

			if var_5(arg_14_0.cameras[var_0_1.CAMERA.PHOTO_FREE]) then
				local var_24_3 = arg_14_0.cameras[var_0_1.CAMERA.PHOTO_FREE]
				local var_24_4 = var_5.Find(var_24_3, "PhotoFree Camera")
				local var_24_5 = var_5.GetComponent

				typeof = var_8
				Cinemachine = var_2_10010

				local var_24_6 = var_24_5(var_24_4, var_8(var_2_10010.CinemachineVirtualCamera))
				local var_24_7 = var_5.GetCinemachineComponent

				Cinemachine = var_8

				local var_24_8 = var_24_7(var_24_6, var_8.CinemachineCore.Stage.Aim)

				var_24_2(var_24_8, "m_HorizontalAxis", var_24_0)
				var_24_2(var_24_8, "m_VerticalAxis", var_24_1)
			end
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

	arg_14_0:bind(var_0_1.PHOTO_CALL, function(arg_26_0, arg_26_1, ...)
		if var_14_2[arg_26_1] then
			local var_26_0 = arg_14_0
			local var_26_1 = var_2.GetCurrentLadyEnv(var_26_0)

			arg_14_0[arg_26_1](arg_14_0, var_26_1, ...)
		else
			arg_14_0[arg_26_1](arg_14_0, ...)
		end

		return
	end)
	arg_14_0:bind(var_0_1.SHIFT_ZONE_SAFE, function(arg_27_0, arg_27_1)
		local var_27_0 = arg_14_0

		var_2.ShiftZoneSafe(var_27_0, arg_27_1)

		return
	end)
	arg_14_0:bind(var_0_1.TRIGGER_TIMELINE_PLAYER_EVENT, function(arg_28_0, arg_28_1)
		if not arg_14_0.nowTimelinePlayer then
			warning = var_2

			var_2("nowTimelinePlayer is nil, can't trigger event", arg_28_1)

			return
		end

		local var_28_0 = arg_14_0.nowTimelinePlayer

		var_2.TriggerEvent(var_28_0, arg_28_1)

		return
	end)

	return
end

function var_0_1.initScene(arg_29_0)
	unpack = var_1_10001
	string = var_1_10003

	local var_29_0, var_29_1 = var_1_10001(var_1_10003.split(arg_29_0.dormSceneMgr.sceneInfo, "|"))

	SceneManager = var_3

	local var_29_2 = var_3.GetSceneByName(var_29_0 .. "_base")

	arg_29_0:ResetSceneStructure(var_29_2)

	GameObject = var_4
	arg_29_0.mainCameraTF = var_4.Find("BackYardMainCamera").transform

	local var_29_3 = arg_29_0.mainCameraTF
	local var_29_4 = var_4.GetComponent

	typeof = var_7
	Cinemachine = var_1_10009
	arg_29_0.camBrain = var_29_4(var_29_3, var_7(var_1_10009.CinemachineBrain))

	local var_29_5 = arg_29_0.mainCameraTF
	local var_29_6 = var_4.GetComponent

	typeof = var_7
	CameraBrainEventsHandler = var_9
	arg_29_0.camBrainEvenetHandler = var_29_6(var_29_5, var_7(var_9))

	local var_29_7 = arg_29_0.mainCameraTF
	local var_29_8 = var_4.Find(var_29_7, "CameraForRaycast")
	local var_29_9 = var_4.GetComponent

	typeof = var_7
	Camera = var_9
	arg_29_0.raycastCamera = var_29_9(var_29_8, var_7(var_9))

	local var_29_10 = arg_29_0.raycastCamera
	local var_29_11 = var_4.GetComponent

	typeof = var_7
	UnityEngine = var_9
	arg_29_0.sceneRaycaster = var_29_11(var_29_10, var_7(var_9.EventSystems.PhysicsRaycaster))
	GameObject = var_4
	arg_29_0.player = var_4.Find("Player").transform

	local var_29_12 = arg_29_0.player

	arg_29_0.playerEye = var_4.Find(var_29_12, "Eye")

	local var_29_13 = arg_29_0.player

	arg_29_0.playerFoot = var_4.Find(var_29_13, "Foot")
	setActive = var_4

	var_4(arg_29_0.playerFoot, false)

	local var_29_14 = arg_29_0.player
	local var_29_15 = var_4.GetComponent

	typeof = var_7
	UnityEngine = var_9
	arg_29_0.playerController = var_29_15(var_29_14, var_7(var_9.CharacterController))
	arg_29_0.attachedPoints = {}
	eachChild = var_4

	var_4(arg_29_0.furnitures, function(arg_30_0)
		table = var_2_10001

		var_2_10001.insert(arg_29_0.attachedPoints, 1, arg_30_0)

		return
	end)

	GameObject = var_4
	arg_29_0.modelRoot = var_4.Find("scene_root").transform
	GameObject = var_4
	arg_29_0.slotRoot = var_4.Find("FurnitureSlots").transform
	setActive = var_4

	var_4(arg_29_0.slotRoot, true)
	arg_29_0:InitSlots()

	tolua = var_4

	var_4.loadassembly("Cinemachine")

	GameObject = var_4

	local var_29_16 = var_4.Find("CM Cameras").transform

	eachChild = var_5

	var_5(var_29_16, function(arg_31_0)
		setActive = var_2_10001

		var_2_10001(arg_31_0, false)

		return
	end)

	arg_29_0.camBrain.enabled = false
	arg_29_0.camBrain.enabled = true

	local var_29_17 = var_29_16:Find("Aim Camera")
	local var_29_18 = var_5.GetComponent

	typeof = var_8
	Cinemachine = var_1_10010
	arg_29_0.cameraAim = var_29_18(var_29_17, var_8(var_1_10010.CinemachineVirtualCamera))

	local var_29_19 = var_29_16:Find("Aim2 Camera")
	local var_29_20 = var_5.GetComponent

	typeof = var_8
	Cinemachine = var_10
	arg_29_0.cameraAim2 = var_29_20(var_29_19, var_8(var_10.CinemachineVirtualCamera))
	arg_29_0.cameraFree = nil
	arg_29_0.cameraFurnitureWatch = nil

	local var_29_21 = var_29_16:Find("Role Camera")
	local var_29_22 = var_5.GetComponent

	typeof = var_8
	Cinemachine = var_10
	arg_29_0.cameraRole = var_29_22(var_29_21, var_8(var_10.CinemachineVirtualCamera))

	local var_29_23 = var_29_16:Find("Role2 Camera")
	local var_29_24 = var_5.GetComponent

	typeof = var_8
	Cinemachine = var_10
	arg_29_0.cameraRole2 = var_29_24(var_29_23, var_8(var_10.CinemachineVirtualCamera))

	local var_29_25 = var_29_16:Find("Talk Camera")
	local var_29_26 = var_5.GetComponent

	typeof = var_8
	Cinemachine = var_10

	local var_29_27 = var_29_26(var_29_25, var_8(var_10.CinemachineVirtualCamera))
	local var_29_28 = var_29_16:Find("Gift Camera")
	local var_29_29 = var_6.GetComponent

	typeof = var_9
	Cinemachine = var_1_10011
	arg_29_0.cameraGift = var_29_29(var_29_28, var_9(var_1_10011.CinemachineVirtualCamera))

	local var_29_30 = {
		arg_29_0.cameraAim,
		arg_29_0.cameraAim2,
		arg_29_0.cameraRole,
		[var_0_1.CAMERA.TALK] = var_29_27,
		[var_0_1.CAMERA.GIFT] = arg_29_0.cameraGift,
		[var_0_1.CAMERA.ROLE2] = arg_29_0.cameraRole2
	}
	local var_29_31 = var_0_1.CAMERA.PHOTO
	local var_29_32 = var_29_16:Find("Photo Camera")
	local var_29_33 = var_8.GetComponent

	typeof = var_11
	Cinemachine = var_1_10013
	var_29_30[var_29_31] = var_29_33(var_29_32, var_11(var_1_10013.CinemachineFreeLook))
	var_29_30[var_0_1.CAMERA.PHOTO_FREE] = var_29_16:Find("PhotoFree Controller")

	local var_29_34 = var_0_1.CAMERA.POV
	local var_29_35 = var_29_16:Find("FP Camera")
	local var_29_36 = var_8.GetComponent

	typeof = var_11
	Cinemachine = var_13
	var_29_30[var_29_34] = var_29_36(var_29_35, var_11(var_13.CinemachineVirtualCamera))

	local var_29_37 = var_0_1.CAMERA.SKIN
	local var_29_38 = arg_29_0.room

	if var_8.isPersonalRoom(var_29_38) then
		local var_29_39 = var_29_16:Find("Skin Camera")
		local var_29_40 = var_8.GetComponent

		typeof = var_11
		Cinemachine = var_13

		local var_29_41

		if not var_29_40(var_29_39, var_11(var_13.CinemachineVirtualCamera)) then
			var_29_41 = nil
		end

		var_29_30[var_29_37] = var_29_41
		arg_29_0.cameras = var_29_30
		setActive = var_29_30

		local var_29_42 = arg_29_0.cameras[var_0_1.CAMERA.PHOTO_FREE]

		var_29_30(var_8.Find(var_29_42, "PhotoFree Camera"), true)

		local var_29_43 = arg_29_0.cameras[var_0_1.CAMERA.POV]
		local var_29_44 = var_6.GetCinemachineComponent

		Cinemachine = var_9
		arg_29_0.compPovAim = var_29_44(var_29_43, var_9.CinemachineCore.Stage.Aim)
		arg_29_0.cameraRoot = var_29_16
		arg_29_0.POVOriginalFOV = arg_29_0:GetPOVFOV()
		GameObject = var_6
		arg_29_0.restrictedBox = var_6.Find("RestrictedArea").transform
		setActive = var_6

		var_6(arg_29_0.restrictedBox, false)

		local var_29_45 = arg_29_0.cameras[var_0_1.CAMERA.PHOTO_FREE]
		local var_29_46 = var_6.GetComponent

		typeof = var_9
		CharacterController = var_11

		local var_29_47 = var_29_46(var_29_45, var_9(var_11)).radius

		arg_29_0.isMultiFloor = arg_29_0.restrictedBox.childCount > 2

		local var_29_48 = "Floor"
		local var_29_49 = "Celling"
		local var_29_50

		if arg_29_0.isMultiFloor then
			arg_29_0.restrictedHeightRange = {}
			var_29_50 = 0
			math = var_29_42

			for iter_29_0 = var_29_50, var_29_42.floor(arg_29_0.restrictedBox.childCount / 2) - 1 do
				local var_29_51 = iter_29_0 == 0 and var_29_48 or var_29_48 .. "_" .. iter_29_0
				local var_29_52 = iter_29_0 == 0 and var_29_49 or var_29_49 .. "_" .. iter_29_0

				table = var_1_10015
				var_1_10015 = var_1_10015.insert

				local var_29_53 = arg_29_0.restrictedHeightRange
				local var_29_54 = {}
				local var_29_55 = arg_29_0.restrictedBox

				var_29_54[1] = var_19.Find(var_29_55, var_29_51).position.y + var_29_47

				local var_29_56 = arg_29_0.restrictedBox

				var_29_54[2] = var_19.Find(var_29_56, var_29_52).position.y - var_29_47

				var_1_10015(var_29_53, var_29_54)
			end
		else
			var_29_50 = {}

			local var_29_57 = arg_29_0.restrictedBox

			var_29_50[1] = var_10.Find(var_29_57, var_29_48).position.y + var_29_47

			local var_29_58 = arg_29_0.restrictedBox

			var_29_50[2] = var_10.Find(var_29_58, var_29_49).position.y - var_29_47
			arg_29_0.restrictedHeightRange = var_29_50
		end

		GameObject = var_29_50
		arg_29_0.ladyInterest = var_29_50.Find("InterestProxy").transform
		GameObject = var_9

		local var_29_59 = var_9.Find("[MainBlock]").transform

		arg_29_0.daynightCtrlComp = var_9.GetComponent(var_29_59, "DayNightCtrl")

		local var_29_60 = arg_29_0

		arg_29_0.SwitchDayNight(var_29_60, arg_29_0.contextData.timeIndex)

		getSceneRootTFDic = var_10
		SceneManager = var_29_60
		arg_29_0.tfCutIn = var_10(var_29_60.GetSceneByName(var_29_0 .. "_base")).CutIn

		if arg_29_0.tfCutIn then
			local var_29_61 = {}
			local var_29_62 = arg_29_0.tfCutIn
			local var_29_63 = var_11.Find(var_29_62, "lady")

			var_29_61.lady = var_11.GetChild(var_29_63, 0)

			local var_29_64 = arg_29_0.tfCutIn
			local var_29_65 = var_11.Find(var_29_64, "player")

			var_29_61.player = var_11.GetChild(var_29_65, 0)
			arg_29_0.modelCutIn = var_29_61
			setActive = var_29_61

			var_29_61(arg_29_0.tfCutIn, false)
		end

		return
	end
end

function var_0_1.SwitchDayNight(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_2 then
		IsNil = var_1_10003

		if not var_1_10003(arg_32_2) then
			arg_32_2:SwitcherToIndex(arg_32_1 - 1)

			goto label_32_0
		end
	end

	IsNil = var_1_10003

	if not var_1_10003(arg_32_0.daynightCtrlComp) then
		local var_32_0 = arg_32_0.daynightCtrlComp

		var_3.SwitcherToIndex(var_32_0, arg_32_1 - 1)
	end

	::label_32_0::

	arg_32_0:InitLightSettings()

	return
end

function var_0_1.InitLightSettings(arg_33_0)
	GameObject = var_1_10001
	arg_33_0.globalVolume = var_1_10001.Find("GlobalVolume")

	arg_33_0:RegisterGlobalVolume()

	GameObject = var_1
	arg_33_0.characterLight = var_1.Find("CharacterLight")

	arg_33_0:RecordCharacterLight()

	GameObject = var_1

	local var_33_0 = var_1.Find("[Lighting]").transform

	table = var_1_10002

	local var_33_1 = var_1_10002.IpairsCArray
	local var_33_2 = var_33_0
	local var_33_3 = var_33_0.GetComponentsInChildren

	typeof = var_1_10007
	Light = var_1_10009

	var_33_1(var_33_3(var_33_2, var_1_10007(var_1_10009), true), function(arg_34_0, arg_34_1)
		UnityEngine = var_2_10002
		arg_34_1.shadows = var_2_10002.LightShadows.None

		return
	end)

	return
end

function var_0_1.ResetSceneStructure(arg_35_0, arg_35_1)
	table = var_1_10002

	var_1_10002.IpairsCArray(arg_35_1:GetRootGameObjects(), function(arg_36_0, arg_36_1)
		if arg_36_1.name == "Furnitures" then
			local var_36_0 = arg_35_0

			tf = var_2_10003
			var_36_0.furnitures = var_2_10003(arg_36_1)
			eachChild = var_36_0

			var_36_0(arg_35_0.furnitures, function(arg_37_0)
				if arg_37_0:Find("FreeLook Camera") then
					setActive = var_1

					var_1(arg_37_0:Find("FreeLook Camera"), false)
				end

				if arg_37_0:Find("FreeLook Camera") then
					setActive = var_1

					var_1(arg_37_0:Find("RoleWatch Camera"), false)
				end

				if arg_37_0:Find("IKCamera") then
					setActive = var_1

					var_1(arg_37_0:Find("IKCamera"), false)
				end

				local var_37_0 = arg_37_0
				local var_37_1 = arg_37_0.GetComponent

				typeof = var_4
				UnityEngine = var_3_10006

				if not var_37_1(var_37_0, var_4(var_3_10006.Collider)) then
					return
				end

				var_1.enabled = false

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.InitSlots(arg_38_0)
	local var_38_0 = arg_38_0.room
	local var_38_1 = var_1.GetSlots(var_38_0)
	local var_38_2 = arg_38_0.modelRoot
	local var_38_3 = var_2.GetComponentsInChildren

	typeof = var_1_10005
	Transform = var_1_10007

	local var_38_4 = var_38_3(var_38_2, var_1_10005(var_1_10007), true)
	local var_38_5 = var_2.ToTable(var_38_4)

	arg_38_0.slotDict = {}
	_ = var_3

	var_3.each(var_38_1, function(arg_39_0)
		local var_39_0 = arg_39_0:GetFurnitureName()
		local var_39_1 = arg_39_0
		local var_39_2 = arg_39_0.GetConfigID(var_39_1)
		local var_39_3 = arg_38_0.slotRoot
		local var_39_4 = var_3.Find

		tostring = var_2_10006

		if not var_39_4(var_39_3, var_2_10006(var_39_2)) then
			errorMsg = var_39_1

			var_39_1("Not Find Slot: " .. var_39_2)

			return
		end

		local var_39_5 = {
			trans = var_3,
			sceneHides = {}
		}
		local var_39_6 = var_3

		if var_3.Find(var_39_6, "Selector") then
			GetOrAddComponent = var_6

			local var_39_7 = var_5

			typeof = var_2_10009
			EventTriggerListener = var_2_10011

			local var_39_8 = var_6(var_39_7, var_2_10009(var_2_10011))

			var_6.AddPointClickFunc(var_39_8, function(arg_40_0, arg_40_1)
				local var_40_0 = arg_38_0
				local var_40_1 = var_2.emit

				Dorm3dRoomMediator = var_3_10005

				var_40_1(var_40_0, var_3_10005.ON_CLICK_FURNITURE_SLOT, var_39_2)

				return
			end)

			setActive = var_39_6

			var_39_6(var_5, false)
		end

		local var_39_9

		ipairs = var_39_6

		for iter_39_0, iter_39_1 in var_39_6(var_38_5) do
			if iter_39_1.name == var_39_0 then
				var_39_9 = iter_39_1

				break
			end
		end

		if var_39_9 then
			var_39_5.model = var_39_9
		end

		arg_38_0.slotDict[var_39_2] = var_39_5

		return
	end)

	return
end

function var_0_1.SetContactStateDic(arg_41_0, arg_41_1)
	arg_41_0.contactStateDic = arg_41_1
	arg_41_0.hideContactStateDic = {}
	arg_41_0.contactInRangeDic = {}
	arg_41_0.transRangeDic = {
		list = {}
	}

	local var_41_0

	if not arg_41_0.transformFilter then
		BLHX = var_41_0
		var_41_0 = var_41_0.Rendering.TransformFilter.New()
	end

	arg_41_0.transformFilter = var_41_0
	pairs = var_41_0

	for iter_41_0, iter_41_1 in var_41_0(arg_41_0.contactStateDic) do
		local var_41_1 = arg_41_0.hideContactStateDic

		math = var_1_10008
		var_1_10008 = var_1_10008.min

		local var_41_2 = iter_41_1

		ApartmentRoom = var_1_10011
		var_41_1[iter_41_0] = var_1_10008(var_41_2, var_1_10011.ITEM_UNLOCK)

		local var_41_3 = arg_41_0.contactInRangeDic

		var_41_3[iter_41_0] = false
		pg = var_41_3

		local var_41_4 = var_41_3.dorm3d_collection_template[iter_41_0].vfx_prefab

		var_1_10008 = arg_41_0.transRangeDic
		var_1_10008[iter_41_0] = {
			#arg_41_0.transRangeDic.list + 1,
			#var_41_4
		}
		table = var_1_10008
		var_1_10008 = var_1_10008.insertto

		local var_41_5 = arg_41_0.transRangeDic.list

		underscore = var_1_10011

		var_1_10008(var_41_5, var_1_10011.map(var_41_4, function(arg_42_0)
			local var_42_0 = arg_41_0.modelRoot

			return var_1.Find(var_42_0, arg_42_0)
		end))
	end

	local var_41_6 = arg_41_0.transformFilter

	var_2.Init(var_41_6, arg_41_0.mainCameraTF, arg_41_0.transRangeDic.list, 2, 60)
	arg_41_0:ActiveContact()

	return
end

function var_0_1.TempHideContact(arg_43_0, arg_43_1)
	arg_43_0.hideConcatFlag = arg_43_1

	arg_43_0:ActiveContact()

	return
end

function var_0_1.ActiveContact(arg_44_0)
	pairs = var_1_10001

	for iter_44_0, iter_44_1 in var_1_10001(arg_44_0.contactInRangeDic) do
		local var_44_0 = arg_44_0
		local var_44_1 = arg_44_0.UpdateContactDisplay
		local var_44_2 = iter_44_0
		local var_44_3

		if not arg_44_0.contactInRangeDic[iter_44_0] or arg_44_0.hideConcatFlag or not arg_44_0.contactStateDic[iter_44_0] then
			var_44_3 = arg_44_0.hideContactStateDic[iter_44_0]
		end

		var_44_1(var_44_0, var_44_2, var_44_3)
	end

	return
end

function var_0_1.UpdateContactDisplay(arg_45_0, arg_45_1, arg_45_2)
	pg = var_1_10003

	local var_45_0 = var_1_10003.dorm3d_collection_template[arg_45_1]

	ipairs = var_1_10004

	for iter_45_0, iter_45_1 in var_1_10004(var_45_0.vfx_prefab) do
		local var_45_1 = arg_45_0.modelRoot
		local var_45_2 = var_9.Find(var_45_1, iter_45_1)

		if arg_45_0:IsModeInHidePending(iter_45_1) then
			-- block empty
		else
			local var_45_3 = arg_45_0.modelRoot

			if not var_10.Find(var_45_3, iter_45_1) then
				warning = var_10

				var_10(arg_45_1, iter_45_1)
			else
				setActive = var_10

				local var_45_4 = var_45_2

				ApartmentRoom = var_13

				var_10(var_45_4, arg_45_2 == var_13.ITEM_FIRST)
			end
		end
	end

	ipairs = var_4

	for iter_45_2, iter_45_3 in var_4(var_45_0.model) do
		if arg_45_0:IsModeInHidePending(iter_45_3) then
			-- block empty
		else
			local var_45_5 = arg_45_0.modelRoot

			if not var_9.Find(var_45_5, iter_45_3) then
				warning = var_9

				var_9(arg_45_1, iter_45_3)
			else
				local var_45_6 = arg_45_0.modelRoot
				local var_45_7 = var_9.Find(var_45_6, iter_45_3)
				local var_45_8 = arg_45_0

				if arg_45_0.CheckSceneItemActive(var_45_8, var_45_7) then
					GetComponent = var_45_6

					local var_45_9 = var_45_7

					typeof = var_1_10014
					EventTriggerListener = var_1_10016

					local var_45_10 = var_45_6(var_45_9, var_1_10014(var_1_10016))

					ApartmentRoom = var_45_8

					if arg_45_2 == var_45_8.ITEM_FIRST then
						if not var_45_10 then
							GetOrAddComponent = var_12
							var_1_10014 = var_45_7
							typeof = var_1_10015
							EventTriggerListener = var_1_10017
							var_45_10 = var_12(var_1_10014, var_1_10015(var_1_10017))
						end

						var_1_10014 = var_45_10

						var_45_10.AddPointClickFunc(var_1_10014, function(arg_46_0, arg_46_1)
							local var_46_0 = arg_45_0

							var_2.emit(var_46_0, var_0_1.CLICK_CONTACT, arg_45_1)

							return
						end)

						var_45_10.enabled = true
					elseif var_45_10 then
						var_45_10.enabled = false
					end

					setActive = var_12
					var_1_10014 = var_45_7
					ApartmentRoom = var_1_10015
					var_1_10015 = var_1_10015.ITEM_LOCK < arg_45_2

					var_12(var_1_10014, var_1_10015)
				end
			end
		end
	end

	return
end

function var_0_1.SetFloatEnable(arg_47_0, arg_47_1)
	arg_47_0.enableFloatUpdate = arg_47_1

	if arg_47_1 then
		arg_47_0:UpdateFloatPosition()
	end

	return
end

function var_0_1.UpdateFloatPosition(arg_48_0)
	local var_48_0 = arg_48_0:GetCurrentLadyEnv()
	local var_48_1 = arg_48_0
	local var_48_2 = arg_48_0.GetScreenPosition
	local var_48_3 = var_48_0.ladyHeadCenter.position

	Vector3 = var_1_10006

	local var_48_4 = var_48_2(var_48_1, var_48_3 + var_1_10006(0, 0.2, 0))
	local var_48_5 = arg_48_0:GetLocalPosition(var_48_4, arg_48_0.rtFloatPage)

	setLocalPosition = var_48_1

	local var_48_6 = arg_48_0.rtFloatPage

	var_48_1(var_6.Find(var_48_6, "lady"), var_48_5)

	return
end

function var_0_1.LoadCharacter(arg_49_0, arg_49_1, arg_49_2)
	arg_49_0.hxMatDict = {}
	arg_49_0.ladyDict = {}
	arg_49_0.skinDict = {}

	local var_49_0 = {}

	ipairs = var_1_10004

	for iter_49_0, iter_49_1 in var_1_10004(arg_49_1) do
		table = var_1_10009

		var_1_10009.insert(var_49_0, function(arg_50_0)
			local var_50_0 = arg_49_0

			var_1.LoadSingleCharacter(var_50_0, iter_49_1, arg_50_0)

			return
		end)
	end

	parallelAsync = var_4

	var_4(var_49_0, arg_49_2)

	return
end

function var_0_1.LoadCharacterAdditionally(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = {}

	ipairs = var_1_10004

	for iter_51_0, iter_51_1 in var_1_10004(arg_51_1) do
		table = var_1_10009

		var_1_10009.insert(var_51_0, function(arg_52_0)
			local var_52_0 = arg_51_0

			var_1.LoadSingleCharacter(var_52_0, iter_51_1, function()
				local var_53_0 = arg_51_0

				var_0.InitCharacter(var_53_0, arg_51_0.ladyDict[iter_51_1], iter_51_1)
				arg_52_0()

				return
			end)

			return
		end)
	end

	parallelAsync = var_4

	var_4(var_51_0, arg_51_2)

	return
end

function var_0_1.LoadSingleCharacter(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = {}

	LadyEnv = var_1_10004

	local var_54_1 = var_1_10004.New(arg_54_0)
	local var_54_2 = arg_54_0.ladyDict

	var_54_2[arg_54_1] = var_54_1
	getProxy = var_54_2
	ApartmentProxy = var_1_10007

	local var_54_3 = var_54_2(var_1_10007)
	local var_54_4 = var_5.getApartment(var_54_3, arg_54_1)
	local var_54_5 = var_5.getConfig(var_54_4, "asset_name")
	local var_54_6 = var_5
	local var_54_7 = var_5.GetSkinModelID
	local var_54_8 = arg_54_0.room
	local var_54_9 = var_54_7(var_54_6, var_10.getConfig(var_54_8, "tag"))

	Dorm3dSkin = var_54_4

	local var_54_10 = var_54_4.New({
		configId = var_54_9
	})
	local var_54_11 = var_8.GetModelName(var_54_10)

	assert = var_10

	var_10(var_54_11)

	ipairs = var_10

	for iter_54_0, iter_54_1 in var_10({
		"common",
		var_54_11
	}) do
		string = var_1_10015
		var_1_10015 = var_1_10015.format("dorm3d/character/%s/res/%s", var_54_5, iter_54_1)
		checkABExist = var_1_10016

		if var_1_10016(var_1_10015) then
			table = var_1_10016

			var_1_10016.insert(var_54_0, function(arg_55_0)
				local var_55_0 = arg_54_0.loader

				var_1.LoadBundle(var_55_0, var_1_10015, function(arg_56_0)
					ipairs = var_3_10001

					for iter_56_0, iter_56_1 in var_3_10001(arg_56_0:GetAllAssetNames()) do
						string = var_3_10006
						var_3_10006 = var_3_10006.find
						string = var_3_10008

						local var_56_0

						var_3_10006, var_56_0, var_3_10008 = var_3_10006(var_3_10008.lower(iter_56_1), "material_hx[/\\](.*).mat")

						if var_3_10006 then
							arg_54_0.hxMatDict[var_3_10008 .. " (Instance)"] = {
								arg_56_0,
								iter_56_1
							}
							arg_54_0.hxMatDict[var_3_10008] = {
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

	var_54_1.skinId = var_54_9
	var_54_1.skinIdList = {
		var_54_9
	}
	table = var_10

	var_10.insert(var_54_0, function(arg_57_0)
		string = var_2_10001

		local var_57_0 = var_2_10001.format("dorm3d/character/%s/prefabs/%s", var_54_5, var_54_11)
		local var_57_1 = arg_54_0.loader

		var_2.GetPrefab(var_57_1, var_57_0, "", function(arg_58_0)
			var_54_1.ladyGameObject = arg_58_0
			arg_54_0.skinDict[var_54_9] = {
				ladyGameObject = arg_58_0
			}

			arg_57_0()

			return
		end)

		return
	end)

	local var_54_12 = arg_54_0.room

	if var_10.isPersonalRoom(var_54_12) then
		ipairs = var_10

		for iter_54_2, iter_54_3 in var_10(var_5:GetAllModelIds()) do
			table = var_1_10015

			if not var_1_10015.contains(var_54_1.skinIdList, iter_54_3) then
				Dorm3dSkin = var_1_10015

				local var_54_13 = var_1_10015.New({
					configId = iter_54_3
				})

				if var_8.IsShow(var_54_13) or iter_54_3 == 199033 then
					local var_54_14 = var_8

					var_1_10015 = var_8.GetModelName(var_54_14)
					string = var_1_10016
					var_1_10016 = var_1_10016.format("dorm3d/character/%s/prefabs/%s", var_54_5, var_1_10015)
					checkABExist = var_54_14

					if var_54_14(var_1_10016) then
						table = var_17

						var_17.insert(var_54_1.skinIdList, iter_54_3)

						table = var_17

						var_17.insert(var_54_0, function(arg_59_0)
							local var_59_0 = arg_54_0.loader

							var_1.GetPrefab(var_59_0, var_1_10016, "", function(arg_60_0)
								local var_60_0 = arg_54_0.skinDict

								var_60_0[iter_54_3] = {
									ladyGameObject = arg_60_0
								}
								GetComponent = var_60_0

								local var_60_1 = var_60_0(arg_60_0, "GraphOwner")

								var_60_1.enabled = false
								setActive = var_60_1

								var_60_1(arg_60_0, false)
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

	if arg_54_0.contextData.pendingDic[arg_54_1] then
		pg = var_10

		if var_10.dorm3d_welcome[arg_54_0.contextData.pendingDic[arg_54_1]].item_prefab ~= "" then
			table = var_11

			var_11.insert(var_54_0, function(arg_61_0)
				string = var_2_10001

				local var_61_0 = var_2_10001.lower("dorm3d/furniture/item/" .. var_0.item_prefab)
				local var_61_1 = arg_54_0.loader

				var_2.GetPrefab(var_61_1, var_61_0, "", function(arg_62_0)
					local var_62_0 = var_54_1

					var_62_0.tfPendintItem = arg_62_0.transform
					setActive = var_62_0

					var_62_0(arg_62_0, false)
					arg_61_0()

					return
				end)

				return
			end)
		end
	end

	parallelAsync = var_10

	var_10(var_54_0, arg_54_2)

	return
end

function var_0_1.HXCharacter(arg_63_0, arg_63_1)
	HXSet = var_1_10002

	if not var_1_10002.isHx() then
		return
	end

	Dorm3dHxHelper = var_2

	if var_2.ReplaceCharacterParts(arg_63_1) then
		return
	end

	local var_63_0 = arg_63_1
	local var_63_1 = arg_63_1.GetComponentsInChildren

	typeof = var_1_10005
	SkinnedMeshRenderer = var_1_10007

	local var_63_2 = var_63_1(var_63_0, var_1_10005(var_1_10007), true)

	table = var_1_10003

	var_1_10003.IpairsCArray(var_63_2, function(arg_64_0, arg_64_1)
		local var_64_0 = arg_64_1.sharedMaterials
		local var_64_1 = false

		table = var_2_10004

		var_2_10004.IpairsCArray(var_64_0, function(arg_65_0, arg_65_1)
			if arg_65_1 == nil then
				return
			end

			local var_65_0 = arg_65_1.name

			if not arg_63_0.hxMatDict[var_65_0] then
				return
			end

			var_64_1 = true
			unpack = var_3

			local var_65_1, var_65_2 = var_3(arg_63_0.hxMatDict[var_65_0])
			local var_65_3 = var_65_1
			local var_65_4 = var_65_1.LoadAssetSync
			local var_65_5 = var_65_2

			typeof = var_3_10009
			Material = var_3_10011

			local var_65_6

			var_65_6[arg_65_0], var_65_6 = var_65_4(var_65_3, var_65_5, var_3_10009(var_3_10011), false, false), var_64_0
			warning = var_65_6

			var_65_6("Replace HX Material", arg_63_0.hxMatDict[var_65_0][2])

			return
		end)

		if var_64_1 then
			arg_64_1.sharedMaterials = var_64_0
			GraphicsInterface = var_4

			local var_64_2 = var_4.Instance
			local var_64_3 = var_4.UpdateCharacterMaterialLst

			go = var_7

			var_64_3(var_64_2, var_7(arg_63_1))
		end

		return
	end)

	return
end

function var_0_1.InitHolyLight(arg_66_0)
	local var_66_0 = {}

	pairs = var_1_10002

	for iter_66_0, iter_66_1 in var_1_10002(arg_66_0.ladyDict) do
		table = var_1_10007

		var_1_10007.insert(var_66_0, iter_66_1.lady)
	end

	Dorm3dHxHelper = var_2

	var_2.ShowHolyLight(var_66_0, arg_66_0.holyLightRoot, true)

	return
end

function var_0_1.InitCharacter(arg_67_0, arg_67_1, arg_67_2)
	arg_67_1:InitCharacter(arg_67_2)

	Dorm3dHxHelper = var_3

	var_3.HideCharacterPart(arg_67_1.lady)
	arg_67_0:HXCharacter(arg_67_1.lady)
	arg_67_1:SetZone(arg_67_0.contextData.ladyZone[arg_67_2])
	arg_67_0:ChangeCharacterPosition(arg_67_1)

	return
end

function var_0_1.SetCameraLady(arg_68_0, arg_68_1)
	arg_68_0.cameraAim2.LookAt = arg_68_1.ladyInterestRoot
	arg_68_0.cameras[var_0_1.CAMERA.TALK].Follow = arg_68_1.ladyInterestRoot
	arg_68_0.cameras[var_0_1.CAMERA.TALK].LookAt = arg_68_1.ladyInterestRoot
	arg_68_0.cameraGift.Follow = arg_68_0.ladyInterest
	arg_68_0.cameraGift.LookAt = arg_68_0.ladyInterest
	arg_68_0.cameraRole2.LookAt = arg_68_1.ladyInterestRoot
	arg_68_0.cameras[var_0_1.CAMERA.PHOTO].Follow = arg_68_0.ladyInterest
	arg_68_0.cameras[var_0_1.CAMERA.PHOTO].LookAt = arg_68_0.ladyInterest

	return
end

function var_0_1.initNodeCanvas(arg_69_0)
	pg = var_1_10001

	local var_69_0 = var_1_10001.NodeCanvasMgr.GetInstance()

	var_1.Active(var_69_0)
	var_1:RegisterFunc("DistanceTrigger", function(arg_70_0)
		local var_70_0 = arg_69_0

		var_1.emit(var_70_0, var_0_1.DISTANCE_TRIGGER, arg_70_0, arg_69_0.ladyDict[arg_70_0].dis)

		return
	end)
	var_1:RegisterFunc("ShortWaitAction", function(arg_71_0)
		local var_71_0 = arg_69_0

		var_1.DoShortWait(var_71_0, arg_71_0)

		return
	end)
	var_1:RegisterFunc("WatchShortWaitAction", function(arg_72_0)
		local var_72_0 = arg_69_0

		var_1.DoShortWait(var_72_0, arg_72_0)

		return
	end)
	var_1:RegisterFunc("WalkDistanceTrigger", function(arg_73_0)
		local var_73_0 = arg_69_0

		var_1.emit(var_73_0, var_0_1.WALK_DISTANCE_TRIGGER, arg_73_0, arg_69_0.ladyDict[arg_73_0].dis)

		return
	end)
	var_1:RegisterFunc("ChangeWatch", function(arg_74_0)
		local var_74_0 = arg_69_0

		var_1.emit(var_74_0, var_0_1.CHANGE_WATCH, arg_74_0)

		return
	end)

	return
end

function var_0_1.SetAllBlackbloardValue(arg_75_0, arg_75_1, arg_75_2)
	arg_75_0[arg_75_1] = arg_75_2
	pairs = var_1_10003

	for iter_75_0, iter_75_1 in var_1_10003(arg_75_0.ladyDict) do
		arg_75_0:SetBlackboardValue(iter_75_1, arg_75_1, arg_75_2)
	end

	return
end

function var_0_1.SetBlackboardValue(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	arg_76_1:SetBlackboardValue(arg_76_2, arg_76_3)

	return
end

function var_0_1.GetBlackboardValue(arg_77_0, arg_77_1, arg_77_2)
	return arg_77_1:GetBlackboardValue(arg_77_2)
end

function var_0_1.didEnter(arg_78_0)
	Screen = var_1_10001

	local var_78_0 = -21.6 / var_1_10001.height

	Vector2 = var_1_10002
	arg_78_0.joystickDelta = var_1_10002.zero
	FrameTimer = var_2
	arg_78_0.joystickTimer = var_2.New(function()
		local var_79_0 = (arg_78_0.joystickDelta * var_78_0).x
		local var_79_1 = var_0.y

		local function var_79_2(arg_80_0, arg_80_1, arg_80_2)
			local var_80_0 = arg_80_0[arg_80_1]

			var_80_0.m_InputAxisValue = arg_80_2
			arg_80_0[arg_80_1] = var_80_0

			return
		end

		if arg_78_0.surroudCamera and not arg_78_0.pinchMode then
			var_79_2(arg_78_0.surroudCamera, "m_XAxis", var_79_0)
			var_79_2(arg_78_0.surroudCamera, "m_YAxis", var_79_1)
		elseif arg_78_0.furniturePOV and arg_78_0.cameras[var_0_1.CAMERA.FURNITURE_WATCH] then
			isActive = var_4

			if var_4(arg_78_0.cameras[var_0_1.CAMERA.FURNITURE_WATCH]) then
				var_79_2(arg_78_0.furniturePOV, "m_HorizontalAxis", var_79_0)
				var_79_2(arg_78_0.furniturePOV, "m_VerticalAxis", var_79_1)
			end
		end

		local var_79_3 = arg_78_0

		Vector2 = var_2_10005
		var_79_3.joystickDelta = var_2_10005.zero

		return
	end, 1, -1)

	local var_78_1 = arg_78_0.joystickTimer

	var_2.Start(var_78_1)

	local var_78_2 = 1.75

	FrameTimer = var_1_10003
	arg_78_0.moveStickTimer = var_1_10003.New(function()
		if not arg_78_0.moveStickDraging then
			return
		end

		local var_81_0 = arg_78_0.moveStickPosition
		local var_81_1 = 200
		local var_81_2 = var_81_0 - arg_78_0.moveStickOrigin
		local var_81_3 = var_2.ClampMagnitude(var_81_2, var_81_1) / var_81_1
		local var_81_4 = arg_78_0

		var_81_4.moveStickPosition = arg_78_0.moveStickOrigin + var_2
		Vector3 = var_81_4

		local var_81_5 = var_81_4.New(var_81_3.x, 0, var_81_3.y)
		local var_81_6 = arg_78_0.mainCameraTF
		local var_81_7 = var_5.TransformDirection(var_81_6, var_81_5)

		var_81_7.y = 0

		local var_81_8 = var_81_7:Normalize()

		var_5.Mul(var_81_8, var_78_2)

		isActive = var_6

		local var_81_10

		if var_6(arg_78_0.cameras[var_0_1.CAMERA.POV]) then
			local var_81_9 = arg_78_0.playerController

			var_81_10.SimpleMove(var_81_9, var_5)

			var_81_10 = arg_78_0
			var_81_10.tweenFOV = true
		else
			isActive = var_81_10

			if var_81_10(arg_78_0.cameras[var_0_1.CAMERA.PHOTO_FREE]) then
				local var_81_11 = arg_78_0.cameras[var_0_1.CAMERA.PHOTO_FREE]
				local var_81_12 = var_6.GetComponent

				typeof = var_9
				UnityEngine = var_2_10011

				local var_81_13 = var_81_12(var_81_11, var_9(var_2_10011.CharacterController))
				local var_81_14 = var_6.Move

				Time = var_2_10010

				var_81_14(var_81_13, var_5 * var_2_10010.deltaTime)

				local var_81_15 = arg_78_0
				local var_81_16 = var_7.emit

				Dorm3dPhotoMediator = var_10

				var_81_16(var_81_15, var_10.CAMERA_STICK_MOVE, var_81_3:Normalize())

				onNextTick = var_81_16

				var_81_16(function()
					local var_82_0 = arg_78_0.cameras[var_0_1.CAMERA.PHOTO_FREE]
					local var_82_1 = arg_78_0
					local var_82_2 = var_1.GetRestritedHeightRange(var_82_1)

					math = var_3_10002

					local var_82_3 = var_3_10002.InverseLerp(var_82_2[1], var_82_2[2], var_82_0.position.y)
					local var_82_4 = arg_78_0
					local var_82_5 = var_3.emit

					Dorm3dPhotoMediator = var_6

					var_82_5(var_82_4, var_6.CAMERA_LIFT_CHANGED, var_82_3)

					return
				end)
			end
		end

		return
	end, 1, -1)

	local var_78_3 = arg_78_0.moveStickTimer

	var_3.Start(var_78_3)

	arg_78_0.pinchMode = false
	arg_78_0.pinchSize = 0
	arg_78_0.pinchValue = 1
	arg_78_0.pinchNodeOrder = 1
	GlobalClickEventMgr = var_3

	local var_78_4 = var_3.Inst

	var_3.AddBeginPinchFunc(var_78_4, function(arg_83_0, arg_83_1)
		local var_83_0

		if arg_78_0.surroudCamera then
			isActive = var_83_0

			if var_83_0(arg_78_0.surroudCamera) then
				var_83_0 = arg_78_0
				var_83_0.pinchMode = true
				var_83_0 = arg_78_0

				local var_83_1 = arg_83_0 - arg_83_1

				var_83_0.pinchSize = var_2_10003.Magnitude(var_83_1)
				var_83_0 = arg_78_0
				var_2_10003 = arg_83_1.x < arg_83_0.x and -1 or 1
				var_83_0.pinchNodeOrder = var_2_10003

				return
			end
		end

		isActive = var_83_0

		if var_83_0(arg_78_0.cameras[var_0_1.CAMERA.POV]) then
			local var_83_2 = arg_83_0 - arg_83_1
			local var_83_3 = var_2.Magnitude(var_83_2)

			Screen = var_2_10003

			if var_83_3 < var_2_10003.height * 0.5 then
				arg_78_0.pinchMode = true

				local var_83_4 = arg_78_0
				local var_83_5 = arg_83_0 - arg_83_1

				var_83_4.pinchSize = var_5.Magnitude(var_83_5)
				arg_78_0.pinchNodeOrder = arg_83_1.x < arg_83_0.x and -1 or 1
			end

			return
		end

		return
	end)

	local var_78_5 = 0.01

	IsUnityEditor = var_78_1

	if var_78_1 then
		var_78_5 = 0.1
	end

	local var_78_6 = var_78_5 * 1080

	Screen = var_78_4

	local var_78_7 = var_78_6 / var_78_4.height

	GlobalClickEventMgr = var_78_6

	local var_78_8 = var_78_6.Inst

	var_4.AddPinchFunc(var_78_8, function(arg_84_0, arg_84_1)
		if not arg_78_0.pinchMode then
			return
		end

		local var_84_0 = arg_84_0 - arg_84_1
		local var_84_1 = var_2.Magnitude(var_84_0)
		local var_84_2 = arg_78_0.pinchSize - var_84_1
		local var_84_3 = arg_78_0.pinchNodeOrder * (arg_84_1.x < arg_84_0.x and -1 or 1)
		local var_84_4 = var_84_2 * var_78_7 * var_84_3

		isActive = var_5

		local var_84_5

		if var_5(arg_78_0.cameras[var_0_1.CAMERA.POV]) then
			var_84_5 = 0.5

			local var_84_6 = 1
			local var_84_7 = arg_78_0

			math = var_8
			var_84_7.pinchValue = var_8.clamp(arg_78_0.pinchValue + var_84_4, var_84_5, var_84_6)
			arg_78_0.pinchSize = var_84_1

			local var_84_8 = arg_78_0

			var_7.SetPOVFOV(var_84_8, arg_78_0.POVOriginalFOV * arg_78_0.pinchValue)

			arg_78_0.tweenFOV = nil

			return
		end

		isActive = var_84_5

		if var_84_5(arg_78_0.surroudCamera) and arg_78_0.surroudCamera == arg_78_0.cameras[var_0_1.CAMERA.PHOTO] then
			local var_84_9 = 0.5
			local var_84_10 = 1
			local var_84_11 = arg_78_0
			local var_84_12 = var_7.SetPinchValue

			math = var_2_10010

			var_84_12(var_84_11, var_2_10010.clamp(arg_78_0.pinchValue + var_84_4, var_84_9, var_84_10))

			arg_78_0.pinchSize = var_84_1

			return
		end

		return
	end)

	GlobalClickEventMgr = var_4

	local var_78_9 = var_4.Inst

	var_4.AddEndPinchFunc(var_78_9, function()
		arg_78_0.pinchMode = false
		arg_78_0.pinchSize = 0

		return
	end)

	arg_78_0.cameraBlendCallbacks = {}
	arg_78_0.activeCMCamera = nil

	function arg_78_0.camBrainEvenetHandler.OnBlendStarted(arg_86_0)
		if arg_78_0.activeCMCamera then
			local var_86_0 = arg_78_0

			var_1.OnCameraBlendFinished(var_86_0, arg_78_0.activeCMCamera)
		end

		local var_86_1 = arg_78_0.camBrain.ActiveVirtualCamera

		arg_78_0.activeCMCamera = var_86_1

		return
	end

	function arg_78_0.camBrainEvenetHandler.OnBlendFinished(arg_87_0)
		arg_78_0.activeCMCamera = nil

		local var_87_0 = arg_78_0

		var_1.OnCameraBlendFinished(var_87_0, arg_87_0)

		return
	end

	arg_78_0.expressionDict = {}

	arg_78_0:OverlayPanel(arg_78_0.blockLayer)
	arg_78_0:ActiveCamera(arg_78_0.cameras[var_0_1.CAMERA.POV])

	local var_78_10
	local var_78_11
	local var_78_12 = arg_78_0.resumeCallback

	function arg_78_0.resumeCallback()
		var_78_11 = true

		if var_78_10 then
			existCall = var_0

			var_0(var_78_12)
		end

		return
	end

	arg_78_0:RefreshSlots(nil, function()
		var_78_10 = true
		arg_78_0.doneFirstSlotFresh = true

		if var_78_11 then
			existCall = var_0

			var_0(var_78_12)
		end

		return
	end)

	UpdateBeat = var_7
	arg_78_0.updateHandler = var_7:CreateListener(function()
		xpcall = var_2_10000

		var_2_10000(function()
			local var_91_0 = arg_78_0

			var_0.Update(var_91_0)

			return
		end, function(...)
			errorMsg = var_3_10000
			debug = var_3_10002

			var_3_10000(var_3_10002.traceback(...))

			return
		end)

		return
	end)
	UpdateBeat = var_7

	var_7:AddListener(arg_78_0.updateHandler)
	arg_78_0:InitExtraSystem()

	return
end

function var_0_1.InitData(arg_93_0)
	local var_93_0

	if not arg_93_0.contextData.ladyZone then
		var_93_0 = arg_93_0.contextData
		var_93_0.ladyZone = {}
		var_93_0 = nil

		local var_93_1 = arg_93_0.room
		local var_93_2 = var_2.getConfig(var_93_1, "default_zone")

		ipairs = var_1_10003

		for iter_93_0, iter_93_1 in var_1_10003(var_93_2) do
			local var_93_3 = arg_93_0.contextData.ladyZone

			var_93_3[iter_93_1[1]] = iter_93_1[2]
			table = var_93_3

			if var_93_3.contains(arg_93_0.contextData.groupIds, iter_93_1[1]) then
				var_93_0 = var_93_0 or arg_93_0.contextData.ladyZone[iter_93_1[1]]
			end
		end

		arg_93_0.contextData.inFurnitureName = var_93_0 or var_93_2[1][2]
	end

	_ = var_93_0

	local var_93_4 = var_93_0.select
	local var_93_5 = arg_93_0.room

	arg_93_0.zoneDatas = var_93_4(var_3.GetZones(var_93_5), function(arg_94_0)
		return not arg_94_0:IsGlobal()
	end)
	arg_93_0.activeLady = {}

	return
end

function var_0_1.Update(arg_95_0)
	local var_95_0 = arg_95_0.raycastCamera
	local var_95_1 = arg_95_0.mainCameraTF
	local var_95_2 = var_2.GetComponent

	typeof = var_1_10005
	Camera = var_1_10007
	var_95_0.fieldOfView = var_95_2(var_95_1, var_1_10005(var_1_10007)).fieldOfView

	local var_95_5

	if arg_95_0.tweenFOV then
		Damp = var_95_5

		local var_95_3 = 1
		local var_95_4 = 1

		Time = var_5
		var_95_5 = var_95_5(var_95_3, var_95_4, var_5.deltaTime)
		Mathf = var_2
		arg_95_0.pinchValue = var_2.Lerp(arg_95_0.pinchValue, 1, var_95_5)

		arg_95_0:SetPOVFOV(arg_95_0.POVOriginalFOV * arg_95_0.pinchValue)

		if arg_95_0.pinchValue > 0.99 then
			arg_95_0.tweenFOV = nil
		end
	end

	isActive = var_95_5

	if var_95_5(arg_95_0.cameras[var_0_1.CAMERA.POV]) then
		arg_95_0:TriggerLadyDistance()
	end

	if arg_95_0.contactInRangeDic then
		local var_95_6 = arg_95_0.transformFilter
		local var_95_7 = var_1.Execute(var_95_6)
		local var_95_8 = var_1.ToTable(var_95_7)

		pairs = var_2

		for iter_95_0, iter_95_1 in var_2(arg_95_0.contactInRangeDic) do
			pg = var_1_10007
			var_1_10007 = var_1_10007.dorm3d_collection_template[iter_95_0]

			local var_95_9 = arg_95_0.transRangeDic[iter_95_0]

			underscore = var_1_10009

			local var_95_10 = var_1_10009(var_95_8)
			local var_95_11 = var_1_10009.chain(var_95_10)

			var_1_10009 = var_1_10009.slice
			unpack = var_1_10012

			local var_95_12 = var_1_10009(var_95_11, var_1_10012(var_95_9))
			local var_95_13 = var_1_10009.any(var_95_12, function(arg_96_0)
				return arg_96_0
			end)

			var_1_10009 = var_1_10009.value(var_95_13)
			tobool = var_1_10010

			if var_1_10010(iter_95_1) ~= var_1_10009 then
				var_1_10010 = arg_95_0.contactInRangeDic
				var_1_10010[iter_95_0] = var_1_10009
				var_1_10012 = arg_95_0
				var_1_10010 = arg_95_0.UpdateContactDisplay

				local var_95_14 = iter_95_0
				local var_95_15

				if not var_1_10009 or arg_95_0.hideConcatFlag or not arg_95_0.contactStateDic[iter_95_0] then
					var_95_15 = arg_95_0.hideContactStateDic[iter_95_0]
				end

				var_1_10010(var_1_10012, var_95_14, var_95_15)
			end
		end
	end

	if arg_95_0.enableFloatUpdate then
		arg_95_0:UpdateFloatPosition()
	end

	arg_95_0:CheckInSector()

	if arg_95_0.systemManager then
		local var_95_16 = arg_95_0.systemManager
		local var_95_17 = var_1.Update

		Time = var_4

		var_95_17(var_95_16, var_4.deltaTime)
	end

	return
end

function var_0_1.CheckInSector(arg_97_0)
	isActive = var_1_10001

	if not var_1_10001(arg_97_0.cameras[var_0_1.CAMERA.POV]) then
		return
	end

	local var_97_0 = arg_97_0.mainCameraTF.position

	pairs = var_1_10002

	for iter_97_0, iter_97_1 in var_1_10002(arg_97_0.ladyDict) do
		if iter_97_1.lady then
			tobool = var_7

			local var_97_1 = var_7(arg_97_0.activeLady[iter_97_0])
			local var_97_2 = {
				Radius = 2,
				Angle = 120,
				Position = iter_97_1.lady.position,
				Rotation = iter_97_1.lady.rotation
			}

			tobool = var_9

			if var_97_1 ~= var_9(var_0_1.IsPointInSector(var_97_2, var_97_0)) then
				arg_97_0.activeLady[iter_97_0] = not var_97_1

				arg_97_0:emit(var_0_1.ON_ENTER_SECTOR, iter_97_0)
			end
		end
	end

	return
end

function var_0_1.TriggerLadyDistance(arg_98_0)
	pairs = var_1_10001

	for iter_98_0, iter_98_1 in var_1_10001(arg_98_0.ladyDict) do
		if iter_98_1.lady then
			iter_98_1.dis = (iter_98_1.lady.position - arg_98_0.player.position).magnitude

			local var_98_0

			if not arg_98_0:GetBlackboardValue(iter_98_1, "inPending") or not var_0_1.POV_PENDING_CLOSE_DISTANCE then
				var_98_0 = var_0_1.POV_CLOSE_DISTANCE
			end

			if var_98_0 > iter_98_1.dis ~= arg_98_0:GetBlackboardValue(iter_98_1, "inDistance") then
				arg_98_0:SetBlackboardValue(iter_98_1, "inDistance", iter_98_1.dis < var_0_1.POV_CLOSE_DISTANCE)
				arg_98_0:emit(var_0_1.ON_CHANGE_DISTANCE, iter_98_0, iter_98_1.dis < var_0_1.POV_CLOSE_DISTANCE)
			end
		end
	end

	return
end

function var_0_1.OnStickMove(arg_99_0, arg_99_1)
	arg_99_0.joystickDelta = arg_99_1

	return
end

function var_0_1.SetPinchValue(arg_100_0, arg_100_1)
	arg_100_0.pinchValue = arg_100_1

	arg_100_0:SetCameraObrits()

	return
end

function var_0_1.GetPOVFOV(arg_101_0)
	local var_101_0 = arg_101_0.cameras[var_0_1.CAMERA.POV].m_Lens

	ReflectionHelp = var_2

	local var_101_1 = var_2.RefGetField

	typeof = var_1_10004

	return var_101_1(var_1_10004("Cinemachine.LensSettings"), "FieldOfView", var_101_0)
end

function var_0_1.SetPOVFOV(arg_102_0, arg_102_1)
	local var_102_0 = arg_102_0.cameras[var_0_1.CAMERA.POV].m_Lens

	ReflectionHelp = var_3

	local var_102_1 = var_3.RefSetField

	typeof = var_1_10005

	var_102_1(var_1_10005("Cinemachine.LensSettings"), "FieldOfView", var_102_0, arg_102_1)

	arg_102_0.cameras[var_0_1.CAMERA.POV].m_Lens = var_102_0

	return
end

function var_0_1.RefreshSlots(arg_103_0, arg_103_1, arg_103_2)
	arg_103_1 = arg_103_1 or arg_103_0.room

	local var_103_0 = arg_103_1:GetSlots()
	local var_103_1 = arg_103_1:GetFurnitures()

	arg_103_0:emit(var_0_1.SHOW_BLOCK)

	table = var_5

	var_5.ParallelIpairsAsync(var_103_0, function(arg_104_0, arg_104_1, arg_104_2)
		local var_104_0 = arg_104_1:GetConfigID()

		if not arg_103_0.slotDict[var_104_0] then
			return arg_104_2()
		end

		_ = var_4

		local var_104_1

		if not var_4.detect(var_103_1, function(arg_105_0)
			return arg_105_0:GetSlotID() == var_104_0
		end) or not var_4:GetModel() then
			var_104_1 = false
		end

		local var_104_2 = arg_103_0.slotDict[var_104_0].model

		arg_103_0.slotDict[var_104_0].displayModelName = var_104_1
		arg_103_0.slotDict[var_104_0].furnitureId = var_4 and var_4:GetConfigID()

		local function var_104_3(arg_106_0)
			table = var_3_10001

			local var_106_0 = var_3_10001.Foreach
			local var_106_1

			if not arg_103_0.slotDict[var_104_0].sceneHides then
				var_106_1 = {}
			end

			var_106_0(var_106_1, function(arg_107_0, arg_107_1)
				setActive = var_4_10002

				var_4_10002(arg_107_1.trans, arg_107_1.visible)

				return
			end)

			arg_103_0.slotDict[var_104_0].sceneHides = {}

			if var_104_2 then
				setActive = var_1

				var_1(var_104_2, var_104_1 == "")
			end

			if arg_106_0 and #arg_106_0:getConfig("scene_hides") > 0 then
				table = var_2

				var_2.Ipairs(var_1, function(arg_108_0, arg_108_1)
					local var_108_0 = arg_103_0.modelRoot
					local var_108_1 = var_2.Find(var_108_0, arg_108_1)

					assert = var_4_10003

					local var_108_2 = var_108_1

					string = var_4_10006

					local var_108_3 = var_4_10006.format
					local var_108_4 = "dorm3d_furniture_template:%d scene_hides missing scene item :%s"
					local var_108_5 = arg_106_0

					var_4_10003(var_108_2, var_108_3(var_108_4, var_9.GetConfigID(var_108_5), arg_108_1))

					isActive = var_4_10003

					local var_108_6 = var_4_10003(var_108_1)

					table = var_108_0

					var_108_0.insert(arg_103_0.slotDict[var_104_0].sceneHides, {
						name = arg_108_1,
						trans = var_108_1,
						visible = var_108_6
					})

					setActive = var_4

					var_4(var_108_1, false)

					return
				end)
			end

			return
		end

		if var_104_1 == false or var_104_1 == "" then
			local var_104_4 = arg_103_0.loader

			var_8.ClearRequest(var_104_4, "slot_" .. var_104_0)
			var_104_3()
			arg_104_2()

			return
		end

		local var_104_5 = arg_103_0.slotDict[var_104_0].trans
		local var_104_6 = arg_103_0.loader

		if var_9.GetLoadingRP(var_104_6, "slot_" .. var_104_0) then
			local var_104_7 = arg_103_0

			var_9.emit(var_104_7, var_0_1.HIDE_BLOCK)
		end

		local var_104_8 = arg_103_0.loader

		var_9.GetPrefabBYStopLoading(var_104_8, "dorm3d/furniture/prefabs/" .. var_104_1, "", function(arg_109_0)
			assert = var_3_10001

			var_3_10001(arg_109_0)

			setParent = var_3_10001

			var_3_10001(arg_109_0, var_104_5)
			var_104_3(var_0)
			arg_104_2()

			return
		end, "slot_" .. var_104_0)

		return
	end, function()
		local var_110_0 = arg_103_0

		var_0.emit(var_110_0, var_0_1.HIDE_BLOCK)

		existCall = var_0

		var_0(arg_103_2)

		warning = var_0

		var_0("RefreshSlots", "Done")

		local var_110_1 = arg_103_0
		local var_110_2 = var_0.emit

		Dorm3dRoomMediator = var_3

		var_110_2(var_110_1, var_3.REFRESH_FURNITURE_AND_SLOTS_DONE)

		return
	end)

	return
end

function var_0_1.RefreshSlotsEmpty(arg_111_0, arg_111_1)
	Clone = var_1_10002

	local var_111_0 = var_1_10002(arg_111_0.room)

	var_111_0.furnitures = {}

	arg_111_0:RefreshSlots(var_111_0, arg_111_1)

	return
end

function var_0_1.CheckSceneItemActiveByPath(arg_112_0, arg_112_1)
	local var_112_0 = arg_112_0:GetSceneItem(arg_112_1)

	return arg_112_0:CheckSceneItemActive(var_112_0)
end

function var_0_1.CheckSceneItemActive(arg_113_0, arg_113_1)
	local var_113_0 = true
	local var_113_1

	table = var_1_10004

	var_1_10004.Checkout(arg_113_0.slotDict, function(arg_114_0, arg_114_1)
		underscore = var_2_10002

		if var_2_10002.detect(arg_114_1.sceneHides, function(arg_115_0)
			return arg_115_0.trans == arg_113_1
		end) then
			var_113_0 = false
			var_113_1 = arg_114_1.furnitureId

			return false
		end

		return
	end)

	return var_113_0, var_113_1
end

function var_0_1.ChangeCharacterPosition(arg_116_0, arg_116_1)
	arg_116_0:ResetCharPoint(arg_116_1, arg_116_1.ladyActiveZone)
	arg_116_0:SyncInterestTransform(arg_116_1)

	return
end

function var_0_1.SyncCurrentInterestTransform(arg_117_0)
	local var_117_0 = arg_117_0:GetCurrentLadyEnv()

	arg_117_0:SyncInterestTransform(var_117_0)

	return
end

function var_0_1.SyncInterestTransform(arg_118_0, arg_118_1)
	arg_118_0.ladyInterest.position = arg_118_1.ladyInterestRoot.position
	arg_118_0.ladyInterest.rotation = arg_118_1.ladyInterestRoot.rotation

	return
end

function var_0_1.SyncInterestTransformByTf(arg_119_0, arg_119_1)
	arg_119_0.ladyInterest.position = arg_119_1.position
	arg_119_0.ladyInterest.rotation = arg_119_1.rotation

	return
end

function var_0_1.ChangePlayerPosition(arg_120_0, arg_120_1)
	arg_120_1 = arg_120_1 or arg_120_0.contextData.inFurnitureName

	local var_120_0 = arg_120_0.furnitures
	local var_120_1 = var_2.Find(var_120_0, arg_120_1)
	local var_120_2 = var_2.Find(var_120_1, "PlayerPoint").position

	arg_120_0.player.position = var_120_2
	arg_120_0.cameras[var_0_1.CAMERA.POV].transform.position = arg_120_0.playerEye.position

	local var_120_3 = arg_120_0.ladyInterest.position - arg_120_0.playerEye.position

	Quaternion = var_5

	local var_120_4 = var_5.LookRotation(var_120_3).eulerAngles.y
	local var_120_5 = var_5.x
	local var_120_6 = arg_120_0.compPovAim.m_HorizontalAxis

	var_120_6.Value = arg_120_0:GetNearestAngle(var_120_4, var_120_6.m_MinValue, var_120_6.m_MaxValue)
	arg_120_0.compPovAim.m_HorizontalAxis = var_120_6

	local var_120_7 = arg_120_0.compPovAim.m_VerticalAxis

	var_120_7.Value = var_120_5
	arg_120_0.compPovAim.m_VerticalAxis = var_120_7

	return
end

function var_0_1.GetAttachedFurnitureName(arg_121_0)
	return arg_121_0.contextData.inFurnitureName
end

function var_0_1.GetFurnitureByName(arg_122_0, arg_122_1)
	underscore = var_1_10002

	return var_1_10002.detect(arg_122_0.attachedPoints, function(arg_123_0)
		return arg_123_0.name == arg_122_1
	end)
end

function var_0_1.GetSlotByID(arg_124_0, arg_124_1)
	local var_124_0

	if arg_124_0.displaySlots[arg_124_1] then
		var_124_0 = arg_124_0.displaySlots[arg_124_1].trans
	end

	return var_124_0
end

function var_0_1.GetScreenPosition(arg_125_0, arg_125_1, arg_125_2)
	arg_125_2 = arg_125_2 or arg_125_0.raycastCamera

	if arg_125_2:WorldToScreenPoint(arg_125_1).z < 0 then
		local var_125_0 = var_3.x
		local var_125_1 = var_3.x < 0 and -1 or 1

		Screen = var_6
		var_3.x = var_125_0 + var_125_1 * var_6.width

		local var_125_2 = var_3.y
		local var_125_3 = var_3.y < 0 and -1 or 1

		Screen = var_6
		var_3.y = var_125_2 + var_125_3 * var_6.height
		var_3.z = -var_3.z
	end

	return var_3
end

function var_0_1.GetLocalPosition(arg_126_0, arg_126_1, arg_126_2)
	LuaHelper = var_1_10003

	local var_126_0 = var_1_10003.ScreenToLocal
	local var_126_1 = arg_126_2
	local var_126_2 = arg_126_1

	pg = var_1_10007

	return var_126_0(var_126_1, var_126_2, var_1_10007.UIMgr.GetInstance().uiCameraComp)
end

function var_0_1.GetModelRoot(arg_127_0)
	return arg_127_0.modelRoot
end

function var_0_1.ShiftZoneSafe(arg_128_0, arg_128_1)
	local var_128_0 = {}
	local var_128_1 = arg_128_0.room

	if var_3.isPersonalRoom(var_128_1) and not arg_128_0:GetBlackboardValue(arg_128_0:GetCurrentLadyEnv(), "inPending") then
		table = var_3

		var_3.insert(var_128_0, function(arg_129_0)
			local var_129_0 = arg_128_0
			local var_129_1 = var_1.OutOfLazy
			local var_129_2 = arg_128_0.apartment

			var_129_1(var_129_0, var_4.GetConfigID(var_129_2), arg_129_0)

			return
		end)
	end

	table = var_3

	var_3.insert(var_128_0, function(arg_130_0)
		local var_130_0 = arg_128_0

		var_1.ShiftZone(var_130_0, arg_128_1, arg_130_0)

		return
	end)

	seriesAsync = var_3

	var_3(var_128_0, function()
		local var_131_0 = arg_128_0

		var_0.CheckQueue(var_131_0)

		return
	end)

	return
end

function var_0_1.ShiftZone(arg_132_0, arg_132_1, arg_132_2)
	if not arg_132_0:GetFurnitureByName(arg_132_1) then
		errorMsg = var_1_10004

		var_1_10004(arg_132_1 .. " Not Find")

		existCall = var_1_10004

		var_1_10004(arg_132_2)

		return
	end

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_133_0)
			local var_133_0 = arg_132_0

			var_1.emit(var_133_0, var_0_1.SHOW_BLOCK)

			local var_133_1 = arg_132_0

			var_1.ShowBlackScreen(var_133_1, true, arg_133_0)

			return
		end,
		function(arg_134_0)
			if not arg_132_0.shiftLady then
				local var_134_0 = arg_132_0.room

				if var_1.isPersonalRoom(var_134_0) then
					local var_134_2

					if not arg_132_0.shiftLady then
						local var_134_1 = arg_132_0.apartment

						var_134_2 = var_1.GetConfigID(var_134_1)
					end

					arg_132_0.shiftLady = nil
					arg_132_0.contextData.ladyZone[var_134_2] = var_0.name

					local var_134_3 = arg_132_0.ladyDict[var_134_2]

					var_2.SetZone(var_134_3, arg_132_0.contextData.ladyZone[var_134_2])

					local var_134_4 = arg_132_0

					if var_3.GetBlackboardValue(var_134_4, var_2, "inPending") then
						local var_134_5 = arg_132_0

						var_3.SetOutPending(var_134_5, var_2)

						local var_134_6 = arg_132_0

						var_3.SwitchAnim(var_134_6, var_2, var_0_1.ANIM.IDLE)

						onNextTick = var_3

						var_3(function()
							local var_135_0 = arg_132_0

							var_0.ChangeCharacterPosition(var_135_0, var_0)
							arg_134_0()

							return
						end)
					else
						local var_134_7 = arg_132_0

						var_3.ChangeCharacterPosition(var_134_7, var_2)
						arg_134_0()
					end
				else
					arg_134_0()
				end

				return
			end
		end,
		function(arg_136_0)
			local var_136_0 = arg_132_0.contextData

			var_136_0.inFurnitureName = var_0.name
			SlideExtraSystem = var_136_0

			if var_136_0.IsOpen(arg_132_0.room) then
				local var_136_1 = arg_132_0.contextData.inFurnitureName

				SlideConst = var_2

				if var_136_1 == var_2.SLIDE_ZONE then
					local var_136_2 = arg_132_0
					local var_136_3 = var_1.SyncInterestTransformByTf
					local var_136_4 = var_0.transform

					var_136_3(var_136_2, var_4.Find(var_136_4, "StayPoint"))

					goto label_136_0
				end
			end

			if not arg_132_0.apartment then
				pairs = var_1

				for iter_136_0, iter_136_1 in var_1(arg_132_0.ladyDict) do
					if iter_136_1.ladyBaseZone == arg_132_0.contextData.inFurnitureName then
						local var_136_5 = arg_132_0

						var_6.SyncInterestTransform(var_136_5, iter_136_1)

						break
					end
				end
			end

			::label_136_0::

			local var_136_6 = arg_132_0

			var_1.ChangePlayerPosition(var_136_6)

			local var_136_7 = arg_132_0

			var_1.TriggerLadyDistance(var_136_7)

			local var_136_8 = arg_132_0

			var_1.CheckInSector(var_136_8)
			arg_136_0()

			return
		end,
		function(arg_137_0)
			local var_137_0 = arg_132_0

			var_1.UpdateZoneList(var_137_0)

			local var_137_1 = arg_132_0

			var_1.ShowBlackScreen(var_137_1, false, arg_137_0)

			return
		end,
		function(arg_138_0)
			local var_138_0 = arg_132_0

			var_1.emit(var_138_0, var_0_1.HIDE_BLOCK)
			arg_138_0()

			return
		end
	}, arg_132_2)

	return
end

function var_0_1.ActiveCamera(arg_139_0, arg_139_1)
	isActive = var_1_10002

	local var_139_0 = var_1_10002(arg_139_1)

	table = var_1_10003

	var_1_10003.Foreach(arg_139_0.cameras, function(arg_140_0, arg_140_1)
		setActive = var_2_10002

		var_2_10002(arg_140_1, arg_140_1 == arg_139_1)

		return
	end)

	if var_139_0 then
		arg_139_0:OnCameraBlendFinished(arg_139_1)
	end

	return
end

function var_0_1.ActiveCameraByName(arg_141_0, arg_141_1)
	local var_141_0 = arg_141_0.cameraRoot
	local var_141_1 = var_2.Find(var_141_0, arg_141_1)

	assert = var_1_10003

	var_1_10003(var_141_1, "ActiveCameraByName: " .. arg_141_1 .. " not found")

	table = var_1_10003

	var_1_10003.Foreach(arg_141_0.cameras, function(arg_142_0, arg_142_1)
		setActive = var_2_10002

		var_2_10002(arg_142_1, false)

		return
	end)

	setActive = var_3

	var_3(var_141_1, true)

	local var_141_2 = arg_141_0.cameras
	local var_141_3 = var_0_1.CAMERA.CUSTOM
	local var_141_4 = var_141_1
	local var_141_5 = var_141_1.GetComponent

	typeof = var_8
	Cinemachine = var_1_10010
	var_141_2[var_141_3] = var_141_5(var_141_4, var_8(var_1_10010.CinemachineVirtualCamera))

	return
end

function var_0_1.ShowBlackScreen(arg_143_0, arg_143_1, arg_143_2)
	local var_143_0

	if not arg_143_0.blackSceneInfo then
		var_143_0 = {
			color = "#000000",
			time = 0.3
		}
		var_1_10004 = arg_143_1 and 0 or 0.3
		var_143_0.delay = var_1_10004
	end

	setImageColor = var_1_10004

	local var_143_1 = arg_143_0.blackLayer

	Color = var_1_10007

	var_1_10004(var_143_1, var_1_10007.NewHex(var_143_0.color))

	setActive = var_1_10004

	var_1_10004(arg_143_0.blackLayer, true)

	setCanvasGroupAlpha = var_1_10004

	var_1_10004(arg_143_0.blackLayer, arg_143_1 and 0 or 1)

	local var_143_2 = arg_143_0
	local var_143_3 = arg_143_0.managedTween

	LeanTween = var_7

	local var_143_4 = var_7.alphaCanvas

	local function var_143_5()
		if not arg_143_1 then
			setActive = var_0

			var_0(arg_143_0.blackLayer, false)
		end

		existCall = var_0

		var_0(arg_143_2)

		return
	end

	GetComponent = var_9

	local var_143_6 = arg_143_0.blackLayer

	typeof = var_1_10012
	CanvasGroup = var_1_10014

	local var_143_7 = var_143_3(var_143_2, var_143_4, var_143_5, var_9(var_143_6, var_1_10012(var_1_10014)), arg_143_1 and 1 or 0, var_143_0.time)

	var_4.setDelay(var_143_7, var_143_0.delay)

	return
end

function var_0_1.RegisterOrbits(arg_145_0, arg_145_1)
	arg_145_0 = arg_145_0.scene
	arg_145_0.orbits = {
		original = arg_145_1.m_Orbits
	}

	local var_145_0 = arg_145_0.orbits

	_ = var_3

	local var_145_1 = var_3.range(3)

	var_145_0.current = var_3.map(var_145_1, function(arg_146_0)
		local var_146_0 = arg_145_0.orbits.original[arg_146_0 - 1]

		Cinemachine = var_2

		return var_2.CinemachineFreeLook.Orbit.New(var_146_0.m_Height, var_146_0.m_Radius)
	end)
	arg_145_0.surroudCamera = arg_145_1

	return
end

function var_0_1.SetCameraObrits(arg_147_0)
	if not arg_147_0.scene.surroudCamera then
		return
	end

	local var_147_0 = arg_147_0.orbits.original[1]

	for iter_147_0 = 0, #arg_147_0.orbits.current - 1 do
		local var_147_1 = arg_147_0.orbits.current[iter_147_0 + 1]
		local var_147_2 = arg_147_0.orbits.original[iter_147_0]

		math = var_1_10009
		var_147_1.m_Height = var_1_10009.lerp(var_147_0.m_Height, var_147_2.m_Height, arg_147_0.pinchValue)
		var_147_1.m_Radius = var_147_2.m_Radius * arg_147_0.pinchValue
	end

	var_1.m_Orbits = arg_147_0.orbits.current

	return
end

function var_0_1.RevertCameraOrbit(arg_148_0)
	if not arg_148_0.scene.surroudCamera then
		return
	end

	for iter_148_0 = 0, #arg_148_0.orbits.current - 1 do
		local var_148_0 = arg_148_0.orbits.current[iter_148_0 + 1]

		var_148_0.m_Height = arg_148_0.orbits.original[iter_148_0].m_Height
		var_148_0.m_Radius = var_7.m_Radius
	end

	var_1.m_Orbits = arg_148_0.orbits.current
	arg_148_0.surroudCamera = nil

	return
end

function var_0_1.ActiveStateCamera(arg_149_0, arg_149_1, arg_149_2)
	local var_149_0 = {
		base = function(arg_150_0)
			local var_150_0 = arg_149_0

			var_1.RegisterCameraBlendFinished(var_150_0, arg_149_0.cameras[var_0_1.CAMERA.POV], arg_150_0)

			local var_150_1 = arg_149_0

			var_1.ActiveCamera(var_150_1, arg_149_0.cameras[var_0_1.CAMERA.POV])

			return
		end,
		watch = function(arg_151_0)
			assert = var_2_10001

			var_2_10001(arg_149_0.apartment)

			local var_151_0 = arg_149_0
			local var_151_1 = var_1.SyncInterestTransform
			local var_151_2 = arg_149_0

			var_151_1(var_151_0, var_4.GetCurrentLadyEnv(var_151_2))

			local var_151_3 = arg_149_0
			local var_151_4 = var_1.SetCameraLady
			local var_151_5 = arg_149_0

			var_151_4(var_151_3, var_4.GetCurrentLadyEnv(var_151_5))

			local var_151_6 = arg_149_0

			var_1.RegisterCameraBlendFinished(var_151_6, arg_149_0.cameras[var_0_1.CAMERA.ROLE], arg_151_0)

			local var_151_7 = arg_149_0

			var_1.ActiveCamera(var_151_7, arg_149_0.cameras[var_0_1.CAMERA.ROLE])

			return
		end,
		walk = function(arg_152_0)
			local var_152_0 = arg_149_0

			var_1.RegisterCameraBlendFinished(var_152_0, arg_149_0.cameras[var_0_1.CAMERA.POV], arg_152_0)

			local var_152_1 = arg_149_0

			var_1.ActiveCamera(var_152_1, arg_149_0.cameras[var_0_1.CAMERA.POV])

			return
		end,
		ik = function(arg_153_0)
			arg_153_0()

			return
		end,
		gift = function(arg_154_0)
			assert = var_2_10001

			var_2_10001(arg_149_0.apartment)

			local var_154_0 = arg_149_0
			local var_154_1 = var_1.SetCameraLady
			local var_154_2 = arg_149_0

			var_154_1(var_154_0, var_4.GetCurrentLadyEnv(var_154_2))

			local var_154_3 = arg_149_0

			var_1.RegisterCameraBlendFinished(var_154_3, arg_149_0.cameras[var_0_1.CAMERA.GIFT], arg_154_0)

			local var_154_4 = arg_149_0

			var_1.ActiveCamera(var_154_4, arg_149_0.cameras[var_0_1.CAMERA.GIFT])

			return
		end,
		standby = function(arg_155_0)
			assert = var_2_10001

			var_2_10001(arg_149_0.apartment)

			local var_155_0 = arg_149_0
			local var_155_1 = var_1.SetCameraLady
			local var_155_2 = arg_149_0

			var_155_1(var_155_0, var_4.GetCurrentLadyEnv(var_155_2))

			arg_149_0.cameras[var_0_1.CAMERA.ROLE2].transform.position = arg_149_0.cameraRole.transform.position

			local var_155_3 = arg_149_0

			var_1.RegisterCameraBlendFinished(var_155_3, arg_149_0.cameras[var_0_1.CAMERA.ROLE2], arg_155_0)

			local var_155_4 = arg_149_0

			var_1.ActiveCamera(var_155_4, arg_149_0.cameras[var_0_1.CAMERA.ROLE2])

			return
		end,
		talk = function(arg_156_0)
			assert = var_2_10001

			var_2_10001(arg_149_0.apartment)

			local var_156_0 = arg_149_0
			local var_156_1 = var_1.SetCameraLady
			local var_156_2 = arg_149_0

			var_156_1(var_156_0, var_4.GetCurrentLadyEnv(var_156_2))

			local var_156_3 = arg_149_0
			local var_156_4 = var_1.SyncInterestTransform
			local var_156_5 = arg_149_0

			var_156_4(var_156_3, var_4.GetCurrentLadyEnv(var_156_5))

			local var_156_6 = arg_149_0

			var_1.RegisterCameraBlendFinished(var_156_6, arg_149_0.cameras[var_0_1.CAMERA.TALK], arg_156_0)

			local var_156_7 = arg_149_0

			var_1.ActiveCamera(var_156_7, arg_149_0.cameras[var_0_1.CAMERA.TALK])

			return
		end
	}
	local var_149_1 = {}

	table = var_1_10005

	var_1_10005.insert(var_149_1, function(arg_157_0)
		switch = var_2_10001

		var_2_10001(arg_149_1, var_149_0, arg_157_0, arg_157_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_149_1, arg_149_2)

	return
end

function var_0_1.GetSceneItem(arg_158_0, arg_158_1)
	local var_158_0

	string = var_1_10003

	local var_158_1

	if var_1_10003.find(arg_158_1, "FurnitureSlots/") == 1 then
		string = var_3
		arg_158_1 = var_3.gsub(arg_158_1, "^FurnitureSlots/", "", 1)
		var_158_1 = arg_158_0.slotRoot
		var_158_0 = var_3.Find(var_158_1, arg_158_1)
	else
		var_158_1 = arg_158_0.modelRoot
		var_158_0 = var_3.Find(var_158_1, arg_158_1)
	end

	if not var_158_0 then
		warning = var_3
		string = var_158_1

		var_3(var_158_1.format("Missing scene item path: %s", arg_158_1))
	end

	return var_158_0
end

function var_0_1.SetSceneAnimSpeed(arg_159_0, arg_159_1, arg_159_2)
	table = var_1_10003

	var_1_10003.Ipairs(arg_159_1 or {}, function(arg_160_0, arg_160_1)
		if arg_159_0.sceneAnimatorDict[arg_160_1] then
			arg_159_0.sceneAnimatorDict[arg_160_1].animator.speed = arg_159_2
		end

		return
	end)

	return
end

function var_0_1.SetExtraAnimSpeed(arg_161_0, arg_161_1, arg_161_2, arg_161_3)
	table = var_1_10004

	var_1_10004.Ipairs(arg_161_2 or {}, function(arg_162_0, arg_162_1)
		local var_162_0 = arg_162_1[1]

		if arg_161_1.extraItems[var_162_0] then
			local var_162_1 = arg_161_1.extraItems[var_162_0].trans
			local var_162_2 = var_3.GetComponent

			typeof = var_2_10006
			Animator = var_2_10008
			var_162_2(var_162_1, var_2_10006(var_2_10008)).speed = arg_161_3
		end

		return
	end)

	return
end

function var_0_1.PlayEnterSceneAnim(arg_163_0, arg_163_1, arg_163_2, arg_163_3)
	arg_163_3 = arg_163_3 or 1

	local var_163_0 = {}

	if arg_163_1 and #arg_163_1 > 0 then
		table = var_5

		var_5.Ipairs(arg_163_1, function(arg_164_0, arg_164_1)
			local var_164_0 = arg_163_0

			var_2.PlaySceneItemAnim(var_164_0, arg_164_1[1], arg_164_1[2], arg_163_2)

			local var_164_1 = arg_163_0

			var_2.SetSceneAnimSpeed(var_164_1, {
				arg_164_1[1]
			}, arg_163_3)

			table = var_2

			var_2.insert(var_163_0, arg_164_1[1])

			return
		end)
	end

	arg_163_0:ResetSceneItemAnimators(var_163_0)

	return
end

function var_0_1.PlayEnterExtraItem(arg_165_0, arg_165_1, arg_165_2, arg_165_3)
	arg_165_3 = arg_165_3 or 1

	local var_165_0 = {}

	if arg_165_2 and #arg_165_2 > 0 then
		table = var_5

		var_5.Ipairs(arg_165_2, function(arg_166_0, arg_166_1)
			local var_166_0

			if arg_166_1[3] then
				Vector3 = var_166_0
				var_166_0 = var_166_0.New
				unpack = var_2_10004
				var_166_0 = var_166_0(var_2_10004(arg_166_1[3]))
			end

			local var_166_1

			if arg_166_1[4] then
				Quaternion = var_166_1
				var_166_1 = var_166_1.Euler
				unpack = var_2_10005
				var_166_1 = var_166_1(var_2_10005(arg_166_1[4]))
			end

			local var_166_2

			if not (#arg_166_1 > 4) or not arg_166_1[5] then
				var_166_2 = nil
			end

			local var_166_3 = arg_165_0

			var_5.LoadCharacterExtraItem(var_166_3, arg_165_1, arg_166_1[1], arg_166_1[2], var_166_0, var_166_1, var_166_2, arg_165_3)

			table = var_5

			var_5.insert(var_165_0, arg_166_1[1])

			return
		end)
	end

	arg_165_0:ResetCharacterExtraItem(arg_165_1, var_165_0)

	return
end

function var_0_1.HideSceneItem(arg_167_0, arg_167_1, arg_167_2)
	if arg_167_2 and #arg_167_2 > 0 then
		if arg_167_1.tempHideSceneItems and #arg_167_1.tempHideSceneItems > 0 then
			arg_167_0:ResetTempHideSceneItems(arg_167_1, arg_167_2)
		end

		arg_167_1.tempHideSceneItems = {}
		table = var_3

		var_3.Ipairs(arg_167_2, function(arg_168_0, arg_168_1)
			local var_168_0 = arg_167_0
			local var_168_1 = var_2.GetSceneItem(var_168_0, arg_168_1)

			setActive = var_2_10003

			var_2_10003(var_168_1, false)

			table = var_2_10003

			var_2_10003.insert(arg_167_1.tempHideSceneItems, arg_168_1)

			return
		end)
	end

	return
end

function var_0_1.ResetTempHideSceneItems(arg_169_0, arg_169_1, arg_169_2)
	arg_169_2 = arg_169_2 or {}

	if arg_169_1.tempHideSceneItems and #arg_169_1.tempHideSceneItems > 0 then
		table = var_3

		var_3.Ipairs(arg_169_1.tempHideSceneItems, function(arg_170_0, arg_170_1)
			table = var_2_10002

			if var_2_10002.contains(arg_169_2, arg_170_1) then
				return
			end

			local var_170_0 = arg_169_0
			local var_170_1 = var_2.GetSceneItem(var_170_0, arg_170_1)

			setActive = var_2_10003

			var_2_10003(var_170_1, true)

			return
		end)

		arg_169_1.tempHideSceneItems = nil
	end

	return
end

function var_0_1.EnableCurrentHeadIK(arg_171_0, arg_171_1)
	local var_171_0 = arg_171_0:GetCurrentLadyEnv()

	arg_171_0:EnableHeadIK(var_171_0, arg_171_1)

	return
end

function var_0_1.EnableHeadIK(arg_172_0, arg_172_1, arg_172_2)
	arg_172_1.ladyHeadIKComp.enableIk = arg_172_2

	return
end

function var_0_1.SettingHeadAimIK(arg_173_0, arg_173_1, arg_173_2, arg_173_3)
	local var_173_0

	if arg_173_2[1] == 0 then
		arg_173_0:EnableHeadIK(arg_173_1, false)

		return
	elseif arg_173_2[1] == 1 then
		arg_173_0:EnableHeadIK(arg_173_1, true)

		local var_173_1 = arg_173_0.mainCameraTF

		var_173_0 = var_5.Find(var_173_1, "AimTarget")
	elseif arg_173_2[1] == 2 then
		arg_173_0:EnableHeadIK(arg_173_1, true)

		table = var_5

		local var_173_2 = var_5.IpairsCArray
		local var_173_3 = arg_173_1.lady
		local var_173_4 = var_7.GetComponentsInChildren

		typeof = var_1_10010
		Transform = var_1_10012

		var_173_2(var_173_4(var_173_3, var_1_10010(var_1_10012), true), function(arg_174_0, arg_174_1)
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

function var_0_1.ResetHeadAimIK(arg_175_0, arg_175_1)
	arg_175_0:EnableHeadIK(arg_175_1, true)

	local var_175_0 = arg_175_1.ladyHeadIKComp
	local var_175_1 = arg_175_0.mainCameraTF

	var_175_0.AimTarget = var_3.Find(var_175_1, "AimTarget")
	arg_175_1.ladyHeadIKComp.HeadWeight = arg_175_1.ladyHeadIKData.HeadWeight
	arg_175_1.ladyHeadIKComp.BodyWeight = arg_175_1.ladyHeadIKData.BodyWeight

	return
end

function var_0_1.SetIKTimelineStatus(arg_176_0, arg_176_1, arg_176_2, arg_176_3, arg_176_4, arg_176_5)
	local var_176_0 = arg_176_0
	local var_176_1 = arg_176_0.emit

	RoomIKSystem = var_1_10009

	var_176_1(var_176_0, var_1_10009.SET_IK_TIMELINE_STATUS, arg_176_1, arg_176_2, arg_176_3, arg_176_4, arg_176_5)

	return
end

function var_0_1.ExitIKTimelineStatus(arg_177_0, arg_177_1, arg_177_2)
	local var_177_0 = arg_177_0
	local var_177_1 = arg_177_0.emit

	RoomIKSystem = var_1_10006

	var_177_1(var_177_0, var_1_10006.EXIT_IK_TIMELINE_STATUS, arg_177_1, arg_177_2)

	return
end

function var_0_1.HideCharacter(arg_178_0, arg_178_1)
	pairs = var_1_10002

	for iter_178_0, iter_178_1 in var_1_10002(arg_178_0.ladyDict) do
		if iter_178_0 ~= arg_178_1 then
			arg_178_0:HideCharacterBylayer(iter_178_1)
		end
	end

	return
end

function var_0_1.RevertCharacter(arg_179_0, arg_179_1)
	pairs = var_1_10002

	for iter_179_0, iter_179_1 in var_1_10002(arg_179_0.ladyDict) do
		if iter_179_0 ~= arg_179_1 then
			arg_179_0:RevertCharacterBylayer(iter_179_1)
		end
	end

	return
end

function var_0_1.HideCharacterBylayer(arg_180_0, arg_180_1)
	local var_180_0 = "Bip001"
	local var_180_1 = arg_180_1.lady
	local var_180_2 = var_3.Find(var_180_1, "all")

	for iter_180_0 = 0, var_180_2.childCount - 1 do
		if var_180_2:GetChild(iter_180_0).name ~= var_180_0 then
			pg = var_9

			local var_180_3 = var_9.ViewUtils.SetLayer
			local var_180_4 = var_8

			Layer = var_1_10012

			var_180_3(var_180_4, var_1_10012.UIHidden)
		end
	end

	if arg_180_1.tfPendintItem then
		pg = var_4

		local var_180_5 = var_4.ViewUtils.SetLayer
		local var_180_6 = arg_180_1.tfPendintItem

		Layer = iter_180_0

		var_180_5(var_180_6, iter_180_0.UIHidden)
	end

	local var_180_7

	if arg_180_1.ladyWatchFloat then
		pg = var_180_7
		var_180_7 = var_180_7.ViewUtils.SetLayer

		local var_180_8 = arg_180_1.ladyWatchFloat

		Layer = iter_180_0

		var_180_7(var_180_8, iter_180_0.UIHidden)
	end

	Dorm3dHxHelper = var_180_7

	var_180_7.SetModelHolyLightActive(arg_180_1.lady, arg_180_0.holyLightRoot, false)

	return
end

function var_0_1.RevertCharacterBylayer(arg_181_0, arg_181_1)
	local var_181_0 = "Bip001"
	local var_181_1 = arg_181_1.lady
	local var_181_2 = var_3.Find(var_181_1, "all")

	for iter_181_0 = 0, var_181_2.childCount - 1 do
		if var_181_2:GetChild(iter_181_0).name ~= var_181_0 then
			pg = var_9

			local var_181_3 = var_9.ViewUtils.SetLayer
			local var_181_4 = var_8

			Layer = var_1_10012

			var_181_3(var_181_4, var_1_10012.Character3D)
		end
	end

	if arg_181_1.tfPendintItem then
		pg = var_4

		local var_181_5 = var_4.ViewUtils.SetLayer
		local var_181_6 = arg_181_1.tfPendintItem

		Layer = iter_181_0

		var_181_5(var_181_6, iter_181_0.Default)
	end

	local var_181_7

	if arg_181_1.ladyWatchFloat then
		pg = var_181_7
		var_181_7 = var_181_7.ViewUtils.SetLayer

		local var_181_8 = arg_181_1.ladyWatchFloat

		Layer = iter_181_0

		var_181_7(var_181_8, iter_181_0.Default)
	end

	Dorm3dHxHelper = var_181_7

	var_181_7.SetModelHolyLightActive(arg_181_1.lady, arg_181_0.holyLightRoot, true)

	return
end

function var_0_1.EnterFurnitureWatchMode(arg_182_0)
	arg_182_0:SetAllBlackbloardValue("inLockLayer", true)
	arg_182_0:EnableJoystick(true)
	arg_182_0:HideCharacter()

	return
end

function var_0_1.ExitFurnitureWatchMode(arg_183_0, arg_183_1)
	arg_183_0:HideFurnitureSlots()

	local var_183_0 = arg_183_0.cameras[var_0_1.CAMERA.POV]

	seriesAsync = var_3

	var_3({
		function(arg_184_0)
			arg_183_0.furniturePOV = nil

			local var_184_0 = arg_183_0

			var_1.EnableJoystick(var_184_0, false)

			local var_184_1 = arg_183_0

			var_1.emit(var_184_1, var_0_1.SHOW_BLOCK)

			local var_184_2 = arg_183_0

			var_1.ShowBlackScreen(var_184_2, true, arg_184_0)

			return
		end,
		function(arg_185_0)
			existCall = var_2_10001

			var_2_10001(arg_183_1)

			local var_185_0 = arg_183_0

			var_1.RevertCharacter(var_185_0)

			local var_185_1 = arg_183_0

			var_1.SetAllBlackbloardValue(var_185_1, "inLockLayer", false)

			local var_185_2 = arg_183_0

			var_1.RegisterCameraBlendFinished(var_185_2, var_183_0, arg_185_0)

			local var_185_3 = arg_183_0

			var_1.ActiveCamera(var_185_3, var_183_0)

			return
		end,
		function(arg_186_0)
			local var_186_0 = arg_183_0

			var_1.ShowBlackScreen(var_186_0, false, arg_186_0)

			return
		end
	}, function()
		local var_187_0 = arg_183_0

		var_0.emit(var_187_0, var_0_1.HIDE_BLOCK)

		return
	end)
	arg_183_0:RefreshSlots()

	return
end

function var_0_1.SwitchFurnitureZone(arg_188_0, arg_188_1)
	local var_188_0 = arg_188_0
	local var_188_1 = arg_188_0.GetFurnitureByName
	local var_188_2 = arg_188_1
	local var_188_3 = var_188_1(var_188_0, arg_188_1.GetWatchCameraName(var_188_2))
	local var_188_4 = var_2.Find(var_188_3, "FurnitureWatch Camera")
	local var_188_5 = var_3.GetComponent

	typeof = var_6
	Cinemachine = var_1_10008

	local var_188_6 = var_188_5(var_188_4, var_6(var_1_10008.CinemachineVirtualCamera))

	if arg_188_0.cameraFurnitureWatch and arg_188_0.cameraFurnitureWatch ~= var_188_6 then
		arg_188_0:UnRegisterCameraBlendFinished(arg_188_0.cameraFurnitureWatch)

		setActive = var_4

		var_4(arg_188_0.cameraFurnitureWatch, false)
	end

	arg_188_0.cameraFurnitureWatch = var_188_6
	arg_188_0.cameras[var_0_1.CAMERA.FURNITURE_WATCH] = arg_188_0.cameraFurnitureWatch

	local var_188_7 = arg_188_0.cameraFurnitureWatch
	local var_188_8 = var_4.GetCinemachineComponent

	Cinemachine = var_188_2
	arg_188_0.furniturePOV = var_188_8(var_188_7, var_188_2.CinemachineCore.Stage.Aim)

	arg_188_0:RegisterCameraBlendFinished(arg_188_0.cameraFurnitureWatch, function()
		local var_189_0 = arg_188_0

		var_0.emit(var_189_0, var_0_1.HIDE_BLOCK)

		return
	end)
	arg_188_0:emit(var_0_1.SHOW_BLOCK)
	arg_188_0:ActiveCamera(arg_188_0.cameraFurnitureWatch)

	return
end

function var_0_1.HideFurnitureSlots(arg_190_0)
	if arg_190_0.displaySlots then
		arg_190_0:UpdateDisplaySlots({})

		table = var_1

		var_1.Foreach(arg_190_0.displaySlots, function(arg_191_0, arg_191_1)
			local var_191_0 = arg_191_1.trans

			IsNil = var_2_10003

			if var_2_10003(var_191_0:Find("Selector")) then
				return
			end

			setActive = var_3

			var_3(var_191_0:Find("Selector"), false)

			return
		end)

		arg_190_0.displaySlots = nil
	end

	return
end

function var_0_1.DisplayFurnitureSlots(arg_192_0, arg_192_1)
	arg_192_0:HideFurnitureSlots()

	arg_192_0.displaySlots = {}
	_ = var_2

	var_2.each(arg_192_1, function(arg_193_0)
		arg_192_0.displaySlots[arg_193_0] = arg_192_0.slotDict[arg_193_0]

		if not arg_192_0.displaySlots[arg_193_0] then
			errorMsg = var_1

			var_1("Slot " .. arg_193_0 .. " Not Binding Scene Object")

			return
		end

		local var_193_0 = arg_192_0.displaySlots[arg_193_0].trans

		if var_1.Find(var_193_0, "Selector") then
			setActive = var_2

			var_2(var_1:Find("Selector"), true)
		end

		return
	end)

	return
end

function var_0_1.UpdateDisplaySlots(arg_194_0, arg_194_1)
	table = var_1_10002

	var_1_10002.Foreach(arg_194_0.displaySlots, function(arg_195_0, arg_195_1)
		local var_195_0 = arg_195_1.trans

		IsNil = var_2_10003

		if not var_2_10003(var_195_0:Find("Selector")) then
			setActive = var_3

			var_3(var_195_0:Find("Selector/Normal"), arg_194_1[arg_195_0] == 0)

			setActive = var_3

			var_3(var_195_0:Find("Selector/Active"), arg_194_1[arg_195_0] == 1)

			setActive = var_3

			var_3(var_195_0:Find("Selector/Ban"), arg_194_1[arg_195_0] == 2)
		end

		local var_195_1 = arg_194_0.slotDict[arg_195_0].model

		if arg_194_0.slotDict[arg_195_0].displayModelName and var_4 ~= "" then
			var_195_1 = var_195_0:GetChild(var_195_0.childCount - 1)
		end

		local function var_195_2(arg_196_0, arg_196_1)
			local var_196_0 = arg_196_0
			local var_196_1 = arg_196_0.GetComponentsInChildren

			typeof = var_3_10005
			Renderer = var_3_10007

			local var_196_2 = var_196_1(var_196_0, var_3_10005(var_3_10007), true)

			table = var_3_10003

			var_3_10003.IpairsCArray(var_196_2, function(arg_197_0, arg_197_1)
				if arg_197_1.material and var_2:HasProperty("_FinalTint") then
					var_2:SetColor("_FinalTint", arg_196_1)
				end

				return
			end)

			return
		end

		if var_195_1 then
			if arg_194_1[arg_195_0] == 1 then
				local var_195_3 = var_195_2
				local var_195_4 = var_195_1

				Color = var_2_10009

				var_195_3(var_195_4, var_2_10009.NewHex("3F83AE73"))
			else
				local var_195_5 = var_195_2
				local var_195_6 = var_195_1

				Color = var_2_10009

				var_195_5(var_195_6, var_2_10009.New(0, 0, 0, 0))
			end
		end

		return
	end)

	return
end

function var_0_1.EnterPhotoMode(arg_198_0, arg_198_1, arg_198_2)
	arg_198_0:SetAllBlackbloardValue("inLockLayer", true)
	arg_198_0:emit(var_0_1.ENABLE_SCENEBLOCK, true)

	seriesAsync = var_3

	var_3({
		function(arg_199_0)
			local var_199_0 = arg_198_0

			var_1.TempHideUI(var_199_0, true, arg_199_0)

			return
		end,
		function(arg_200_0)
			local var_200_0 = arg_198_0

			var_1.ShowBlackScreen(var_200_0, true, arg_200_0)

			return
		end,
		function(arg_201_0)
			local var_201_0 = arg_198_0.apartment
			local var_201_1 = var_1.GetConfigID(var_201_0)
			local var_201_2 = arg_198_0.ladyDict[var_201_1]
			local var_201_3 = arg_198_0

			var_3.SwitchAnim(var_201_3, var_201_2, arg_198_2)

			local var_201_4 = var_201_2.ladyAnimator

			var_3.Update(var_201_4, 0)

			local var_201_5 = arg_198_0
			local var_201_6 = var_3.ResetCharPoint
			local var_201_7 = var_201_2
			local var_201_8 = arg_198_1

			var_201_6(var_201_5, var_201_7, var_7.GetWatchCameraName(var_201_8))

			local var_201_9 = arg_198_0

			var_3.SyncInterestTransform(var_201_9, var_201_2)

			setActive = var_3

			var_3(var_201_2.ladySafeCollider, true)

			local var_201_10 = arg_198_0

			var_3.HideCharacter(var_201_10, var_201_1)

			local var_201_11 = arg_198_0.cameras[var_0_1.CAMERA.PHOTO].m_XAxis

			var_201_11.Value = 180
			var_3.m_XAxis = var_201_11

			local var_201_12 = var_3.m_YAxis

			var_201_12.Value = 0.7
			var_3.m_YAxis = var_201_12
			arg_198_0.pinchValue = 1

			local var_201_13 = arg_198_0

			var_5.RegisterOrbits(var_201_13, arg_198_0.cameras[var_0_1.CAMERA.PHOTO])

			local var_201_14 = arg_198_0

			var_5.SetCameraObrits(var_201_14)

			setActive = var_5

			var_5(arg_198_0.restrictedBox, true)

			local var_201_15 = arg_198_0

			var_5.RegisterCameraBlendFinished(var_201_15, var_3, arg_201_0)

			local var_201_16 = arg_198_0

			var_5.ActiveCamera(var_201_16, var_3)

			return
		end,
		function(arg_202_0)
			local var_202_0 = arg_198_0

			var_1.ShowBlackScreen(var_202_0, false, arg_202_0)

			return
		end
	}, function()
		local var_203_0 = arg_198_0

		var_0.EnableJoystick(var_203_0, true)

		return
	end)

	return
end

function var_0_1.ExitPhotoMode(arg_204_0)
	arg_204_0:emit(var_0_1.SHOW_BLOCK)
	arg_204_0:EnableJoystick(false)

	seriesAsync = var_1

	var_1({
		function(arg_205_0)
			local var_205_0 = arg_204_0

			var_1.ShowBlackScreen(var_205_0, true, arg_205_0)

			return
		end,
		function(arg_206_0)
			local var_206_0 = arg_204_0

			var_1.RevertCameraOrbit(var_206_0)

			local var_206_1 = arg_204_0
			local var_206_2 = var_1.GetCurrentLadyEnv(var_206_1)
			local var_206_3 = arg_204_0

			var_2.SwitchAnim(var_206_3, var_206_2, var_0_1.ANIM.IDLE)

			setActive = var_2

			var_2(var_206_2.ladySafeCollider, false)

			onNextTick = var_2

			var_2(function()
				local var_207_0 = arg_204_0

				var_0.ChangeCharacterPosition(var_207_0, var_206_2)

				return
			end)

			local var_206_5

			if arg_204_0.contextData.photoFreeMode then
				local var_206_4 = arg_204_0

				var_206_5.EnablePOVLayer(var_206_4, false)

				var_206_5 = arg_204_0.contextData
				var_206_5.photoFreeMode = nil
			end

			setActive = var_206_5

			var_206_5(arg_204_0.restrictedBox, false)

			local var_206_6 = arg_204_0.cameras[var_0_1.CAMERA.POV]
			local var_206_7 = arg_204_0

			var_3.RegisterCameraBlendFinished(var_206_7, var_206_6, arg_206_0)

			local var_206_8 = arg_204_0

			var_3.ActiveCamera(var_206_8, var_206_6)

			return
		end,
		function(arg_208_0)
			local var_208_0 = arg_204_0
			local var_208_1 = var_1.RevertCharacter
			local var_208_2 = arg_204_0.apartment

			var_208_1(var_208_0, var_4.GetConfigID(var_208_2))

			local var_208_3 = arg_204_0

			var_1.ShowBlackScreen(var_208_3, false, arg_208_0)

			return
		end
	}, function()
		local var_209_0 = arg_204_0

		var_0.RefreshSlots(var_209_0)

		local var_209_1 = arg_204_0

		var_0.SetAllBlackbloardValue(var_209_1, "inLockLayer", false)

		local var_209_2 = arg_204_0

		var_0.emit(var_209_2, var_0_1.HIDE_BLOCK)

		local var_209_3 = arg_204_0

		var_0.emit(var_209_3, var_0_1.ENABLE_SCENEBLOCK, false)

		local var_209_4 = arg_204_0

		var_0.TempHideUI(var_209_4, false)

		return
	end)

	return
end

function var_0_1.SwitchCameraZone(arg_210_0, arg_210_1, arg_210_2, arg_210_3)
	arg_210_0:emit(var_0_1.SHOW_BLOCK)

	seriesAsync = var_4

	var_4({
		function(arg_211_0)
			local var_211_0 = arg_210_0

			var_1.ShowBlackScreen(var_211_0, true, arg_211_0)

			return
		end,
		function(arg_212_0)
			local var_212_0 = arg_210_0
			local var_212_1 = var_1.GetCurrentLadyEnv(var_212_0)
			local var_212_2 = arg_210_0

			var_2.SwitchAnim(var_212_2, var_212_1, arg_210_2)

			onNextTick = var_2

			var_2(function()
				local var_213_0 = arg_210_0
				local var_213_1 = var_0.ResetCharPoint
				local var_213_2 = var_212_1
				local var_213_3 = arg_210_1

				var_213_1(var_213_0, var_213_2, var_4.GetWatchCameraName(var_213_3))

				local var_213_4 = arg_210_0

				var_0.SyncInterestTransform(var_213_4, var_212_1)

				if arg_210_0.contextData.photoFreeMode then
					arg_210_0.camBrain.enabled = false

					local var_213_5 = arg_210_0

					var_0.SwitchPhotoCamera(var_213_5)

					local var_213_6 = arg_210_0.camBrain

					var_213_6.enabled = true
					onDelayTick = var_213_6

					var_213_6(function()
						arg_210_0.camBrain.enabled = false

						local var_214_0 = arg_210_0

						var_0.SwitchPhotoCamera(var_214_0)

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
			local var_215_0 = arg_210_0

			var_1.ShowBlackScreen(var_215_0, false, arg_215_0)

			return
		end
	}, function()
		local var_216_0 = arg_210_0

		var_0.emit(var_216_0, var_0_1.HIDE_BLOCK)

		existCall = var_0

		var_0(arg_210_3)

		return
	end)

	return
end

function var_0_1.SwitchPhotoCamera(arg_217_0)
	if not arg_217_0.contextData.photoFreeMode then
		arg_217_0:EnableJoystick(false)
		arg_217_0:EnablePOVLayer(true)

		local var_217_0 = arg_217_0.cameras[var_0_1.CAMERA.PHOTO_FREE]
		local var_217_1 = arg_217_0.cameras[var_0_1.CAMERA.PHOTO_FREE]
		local var_217_2 = var_2.Find(var_217_1, "PhotoFree Camera")
		local var_217_3 = var_2.GetComponent

		typeof = var_5
		Cinemachine = var_1_10007

		local var_217_4 = var_217_3(var_217_2, var_5(var_1_10007.CinemachineVirtualCamera))
		local var_217_5 = var_2.GetCinemachineComponent

		Cinemachine = var_5

		local var_217_6 = var_217_5(var_217_4, var_5.CinemachineCore.Stage.Aim)
		local var_217_7 = arg_217_0.mainCameraTF.rotation
		local var_217_8 = var_3.ToEulerAngles(var_217_7)
		local var_217_9 = var_217_6.m_HorizontalAxis

		var_217_9.Value = var_217_8.y
		var_217_6.m_HorizontalAxis = var_217_9

		local var_217_10 = var_217_6.m_VerticalAxis
		local var_217_11 = arg_217_0

		var_217_10.Value = arg_217_0.GetNearestAngle(var_217_11, var_217_8.x, var_217_10.m_MinValue, var_217_10.m_MaxValue)
		var_217_6.m_VerticalAxis = var_217_10

		local var_217_12 = arg_217_0.mainCameraTF.position
		local var_217_13 = arg_217_0
		local var_217_14 = arg_217_0.GetRestritedHeightRange(var_217_13)

		math = var_217_11

		local var_217_15 = var_217_11.InverseLerp(var_217_14[1], var_217_14[2], var_217_12.y)

		math = var_217_13
		var_217_12.y = var_217_13.clamp(var_217_12.y, var_217_14[1], var_217_14[2])
		var_217_0.transform.position = var_217_12

		local var_217_16 = arg_217_0
		local var_217_17 = arg_217_0.emit

		Dorm3dPhotoMediator = var_12

		var_217_17(var_217_16, var_12.CAMERA_LIFT_CHANGED, var_217_15)
		arg_217_0:ActiveCamera(arg_217_0.cameras[var_0_1.CAMERA.PHOTO_FREE])
	else
		arg_217_0:EnableJoystick(true)
		arg_217_0:EnablePOVLayer(false)
		arg_217_0:ActiveCamera(arg_217_0.cameras[var_0_1.CAMERA.PHOTO])
	end

	arg_217_0.contextData.photoFreeMode = not arg_217_0.contextData.photoFreeMode

	return
end

function var_0_1.SetPhotoCameraHeight(arg_218_0, arg_218_1)
	local var_218_0 = arg_218_0.cameras[var_0_1.CAMERA.PHOTO_FREE]
	local var_218_1 = arg_218_0:GetRestritedHeightRange()

	math = var_1_10004

	local var_218_2 = var_1_10004.lerp(var_218_1[1], var_218_1[2], arg_218_1)
	local var_218_3 = var_218_0
	local var_218_4 = var_218_0.GetComponent

	typeof = var_8
	UnityEngine = var_1_10010

	local var_218_5 = var_218_4(var_218_3, var_8(var_1_10010.CharacterController))
	local var_218_6 = var_5.Move

	Vector3 = var_1_10009

	var_218_6(var_218_5, var_1_10009.New(0, var_218_2 - var_218_0.position.y, 0))

	onNextTick = var_218_6

	var_218_6(function()
		local var_219_0 = arg_218_0
		local var_219_1 = var_0.GetRestritedHeightRange(var_219_0)

		math = var_2_10001

		local var_219_2 = var_2_10001.InverseLerp(var_219_1[1], var_219_1[2], var_218_0.position.y)
		local var_219_3 = arg_218_0
		local var_219_4 = var_2.emit

		Dorm3dPhotoMediator = var_5

		var_219_4(var_219_3, var_5.CAMERA_LIFT_CHANGED, var_219_2)

		return
	end)

	return
end

function var_0_1.ResetPhotoCameraPosition(arg_220_0)
	local var_220_0 = arg_220_0.cameras[var_0_1.CAMERA.PHOTO].m_XAxis

	var_220_0.Value = 180
	var_1.m_XAxis = var_220_0

	local var_220_1 = var_1.m_YAxis

	var_220_1.Value = 0.7
	var_1.m_YAxis = var_220_1

	return
end

function var_0_1.ResetCurrentCharPoint(arg_221_0, arg_221_1)
	local var_221_0 = arg_221_0:GetCurrentLadyEnv()

	arg_221_0:ResetCharPoint(var_221_0, arg_221_1)

	return
end

function var_0_1.ResetCharPoint(arg_222_0, arg_222_1, arg_222_2)
	local var_222_0 = arg_222_0.furnitures
	local var_222_1 = var_3.Find(var_222_0, arg_222_2 .. "/StayPoint")

	arg_222_1.lady.position = var_222_1.position
	arg_222_1.lady.rotation = var_222_1.rotation

	return
end

function var_0_1.GetNearestAngle(arg_223_0, arg_223_1, arg_223_2, arg_223_3)
	if arg_223_3 < arg_223_2 then
		arg_223_3 = arg_223_3 + 360
	end

	if arg_223_2 <= arg_223_1 and arg_223_1 <= arg_223_3 then
		return arg_223_1
	end

	local var_223_0 = (arg_223_2 + arg_223_3) / 2

	Mathf = var_1_10005
	arg_223_1 = var_223_0 - var_1_10005.DeltaAngle(arg_223_1, var_223_0)
	math = var_1_10006

	return (var_1_10006.clamp(arg_223_1, arg_223_2, arg_223_3))
end

function var_0_1.PlayTimeline(arg_224_0, arg_224_1, arg_224_2)
	local var_224_0 = {}

	if arg_224_0.waitForTimeline then
		table = var_4

		var_4.insert(var_224_0, function(arg_225_0)
			local var_225_0 = arg_224_0.waitForTimeline

			arg_224_0.waitForTimeline = nil

			var_225_0()
			arg_225_0()

			return
		end)
	end

	table = var_4

	var_4.insert(var_224_0, function(arg_226_0)
		local var_226_0 = arg_224_0

		var_1.LoadTimelineScene(var_226_0, arg_224_1.name, false, nil, arg_226_0)

		return
	end)

	if arg_224_1.scene and arg_224_1.sceneRoot then
		table = var_4

		var_4.insert(var_224_0, function(arg_227_0)
			local var_227_0 = arg_224_0

			var_1.ChangeArtScene(var_227_0, arg_224_1.scene .. "|" .. arg_224_1.sceneRoot, arg_227_0)

			return
		end)
	end

	table = var_4

	var_4.insert(var_224_0, function(arg_228_0)
		Dorm3dHxHelper = var_2_10001

		local var_228_0 = var_2_10001.GetTimelineMainCharacter()

		Dorm3dHxHelper = var_2_10002

		var_2_10002.ShowHolyLight({
			var_228_0
		}, arg_224_0.holyLightRoot)

		GameObject = var_2

		local var_228_1 = var_2.Find("[actor]").transform
		local var_228_2 = var_2.GetComponentsInChildren

		typeof = var_2_10006
		Animator = var_2_10008

		local var_228_3 = var_228_2(var_228_1, var_2_10006(var_2_10008), true)

		table = var_4

		var_4.IpairsCArray(var_228_3, function(arg_229_0, arg_229_1)
			GetOrAddComponent = var_3_10002

			local var_229_0 = arg_229_1.transform

			typeof = var_3_10005
			DftAniEvent = var_3_10007

			var_3_10002(var_229_0, var_3_10005(var_3_10007))

			return
		end)

		if not var_228_0 then
			local var_228_4 = var_2
			local var_228_5 = var_2.GetComponentInChildren

			typeof = var_7
			var_228_0 = var_228_5(var_228_4, var_7("BLHXCharacterPropertiesController")).transform
		end

		local var_228_6

		eachChild = var_228_1
		GameObject = var_7

		var_228_1(var_7.Find("[camera]").transform, function(arg_230_0)
			if arg_230_0.tag == "MainCamera" then
				var_228_6 = arg_230_0
			end

			return
		end)

		assert = var_228_1

		var_228_1(var_228_6, "Missing MainCamera")

		GameObject = var_228_1

		local var_228_7 = var_228_1.Find("[sequence]").transform
		local var_228_8 = arg_224_0

		TimelinePlayer = var_7
		var_228_8.nowTimelinePlayer = var_7.New(var_228_7)
		TimelineSupport = var_228_8

		local var_228_9 = var_228_8.InitSubtitle
		local var_228_10 = arg_224_0.nowTimelinePlayer.comDirector
		local var_228_11 = arg_224_0.apartment

		var_228_9(var_228_10, var_9.GetCallName(var_228_11))

		local var_228_12 = arg_224_0.nowTimelinePlayer

		var_6.Register(var_228_12, arg_224_1.time, function(arg_231_0, arg_231_1, arg_231_2)
			switch = var_3_10003

			var_3_10003(arg_231_1.stringParameter, {
				TimelinePause = function()
					local var_232_0 = arg_231_0

					var_0.SetSpeed(var_232_0, 0)

					return
				end,
				TimelineResume = function()
					local var_233_0 = arg_231_0

					var_0.SetSpeed(var_233_0, 1)

					return
				end,
				TimelinePlayOnTime = function()
					if arg_231_1.intParameter == 0 or arg_231_1.intParameter == arg_231_2.selectIndex then
						local var_234_0 = arg_231_0

						var_0.SetTime(var_234_0, arg_231_1.floatParameter)
					end

					return
				end,
				TimelineSelectStart = function()
					arg_231_2.selectIndex = nil

					if arg_224_1.options then
						local var_235_0 = arg_224_1.options[arg_231_1.intParameter]
						local var_235_1 = arg_224_0

						var_1.DoTimelineOption(var_235_1, var_235_0, function(arg_236_0)
							arg_231_2.selectIndex = arg_236_0
							arg_231_2.optionIndex = var_235_0[arg_236_0].flag

							local var_236_0 = arg_231_0

							var_1.Play(var_236_0)

							return
						end)
					end

					return
				end,
				TimelineTouchStart = function()
					arg_231_2.selectIndex = nil

					if arg_224_1.touchs then
						local var_237_0 = arg_224_1.touchs[arg_231_1.intParameter]
						local var_237_1 = arg_224_0

						var_1.DoTimelineTouch(var_237_1, arg_224_1.touchs[arg_231_1.intParameter], function(arg_238_0)
							arg_231_2.selectIndex = arg_238_0
							arg_231_2.optionIndex = var_237_0[arg_238_0].flag

							return
						end)
					end

					return
				end,
				TimelineSelectLoop = function()
					if not arg_231_2.selectIndex then
						local var_239_0 = arg_231_0

						var_0.RawSetTime(var_239_0, arg_231_1.floatParameter)
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

						local var_241_0 = arg_224_1.accompanys[arg_231_1.intParameter]

						math = var_1

						local var_241_1 = var_241_0[var_1.random(#var_241_0)]
						local var_241_2 = arg_231_0

						var_2.SetTime(var_241_2, var_241_1)
					end

					return
				end,
				TimelineIKStart = function()
					arg_231_2.selectIndex = nil

					local var_242_0 = arg_231_1.intParameter
					local var_242_1 = arg_224_0
					local var_242_2 = var_1.GetCurrentLadyEnv(var_242_1)

					if var_1.CheckIkTimelineStatus(var_242_2, var_242_0) then
						local var_242_3 = arg_224_0
						local var_242_4 = var_2.emit

						RoomIKSystem = var_5

						var_242_4(var_242_3, var_5.SET_IK_TIMELINE_STATUS, var_1, var_228_0.gameObject, var_242_0, var_228_6)
					end

					return
				end,
				TimelineEnd = function()
					arg_231_2.finish = true

					local var_243_0 = arg_231_0

					var_0.SetSpeed(var_243_0, 0)

					return
				end,
				TimelineAimIKStart = function()
					arg_231_2.selectIndex = nil

					local var_244_0 = arg_231_1.intParameter
					local var_244_1 = arg_224_0
					local var_244_2 = var_1.emit

					AimIKSystem = var_4_10004

					var_244_2(var_244_1, var_4_10004.ENTER_TIMELINE_AIMIK_STATUS, var_244_0)

					return
				end
			}, function()
				warning = var_4_10000

				var_4_10000("other event trigger:" .. arg_231_1.stringParameter)

				return
			end)

			if arg_231_2.finish then
				arg_224_0.timelineMark = arg_231_2

				local var_231_0 = arg_224_0

				var_231_0.timelineFinishCall = nil
				pg = var_231_0

				local var_231_1 = var_231_0.m02

				var_3.sendNotification(var_231_1, var_0_1.TIMELINE_END)

				local var_231_2 = arg_224_0

				if var_3.GetCurrentLadyEnv(var_231_2).ikTimelineMode then
					local var_231_3 = arg_224_0
					local var_231_4 = var_4.emit

					RoomIKSystem = var_7

					var_231_4(var_231_3, var_7.EXIT_IK_TIMELINE_STATUS, var_3)
				end

				arg_228_0()
			end

			return
		end)

		function arg_224_0.timelineFinishCall()
			local var_246_0 = arg_224_0.nowTimelinePlayer

			var_0.TriggerEvent(var_246_0, {
				stringParameter = "TimelineEnd"
			})

			return
		end

		local var_228_13 = arg_224_0

		var_6.HideCharacter(var_228_13)

		setActive = var_6

		var_6(arg_224_0.mainCameraTF, false)

		setActive = var_6

		var_6(var_228_6, true)

		eachChild = var_6

		var_6(arg_224_0.rtTimelineScreen, function(arg_247_0)
			setActive = var_3_10001

			var_3_10001(arg_247_0, false)

			return
		end)

		setActive = var_6

		var_6(arg_224_0.rtTimelineScreen, true)

		setActive = var_6

		local var_228_14 = arg_224_0.rtTimelineScreen

		var_6(var_8.Find(var_228_14, "btn_skip"), arg_224_0.inReplayTalk)

		local var_228_15 = arg_224_0.nowTimelinePlayer

		var_6.Start(var_228_15)

		return
	end)

	table = var_4

	var_4.insert(var_224_0, function(arg_248_0)
		local var_248_0 = arg_224_0

		var_1.ShowBlackScreen(var_248_0, true, function()
			local var_249_0 = arg_224_0.nowTimelinePlayer

			var_0.Stop(var_249_0)

			local var_249_1 = arg_224_0.nowTimelinePlayer

			var_0.Dispose(var_249_1)

			arg_224_0.nowTimelinePlayer = nil

			local var_249_2 = arg_224_0

			var_0.UnloadTimelineScene(var_249_2, arg_224_1.name, false, arg_248_0)

			return
		end)

		return
	end)

	local var_224_1 = arg_224_0.dormSceneMgr.artSceneInfo

	table = var_1_10005

	var_1_10005.insert(var_224_0, function(arg_250_0)
		local var_250_0 = arg_224_0

		var_1.RevertArtScene(var_250_0, var_224_1, arg_250_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_224_0, function()
		setActive = var_2_10000

		var_2_10000(arg_224_0.rtTimelineScreen, false)

		local var_251_0 = arg_224_0

		var_0.RevertCharacter(var_251_0)

		setActive = var_0

		var_0(arg_224_0.mainCameraTF, true)

		local var_251_1 = arg_224_0

		var_0.InitHolyLight(var_251_1)

		local var_251_2 = arg_224_0.timelineMark
		local var_251_3 = arg_224_0

		var_251_3.timelineMark = nil
		existCall = var_251_3

		var_251_3(arg_224_2, var_251_2, function(arg_252_0)
			local var_252_0 = arg_224_0

			var_1.ShowBlackScreen(var_252_0, false, arg_252_0)

			return
		end)

		return
	end)

	return
end

function var_0_1.GetCurrentLadyEnv(arg_253_0)
	if not arg_253_0.apartment then
		return nil
	end

	local var_253_0 = arg_253_0.ladyDict
	local var_253_1 = arg_253_0.apartment

	return var_253_0[var_2.GetConfigID(var_253_1)]
end

function var_0_1.PlayCurrentSingleAction(arg_254_0, ...)
	local var_254_0 = arg_254_0:GetCurrentLadyEnv()

	return arg_254_0:PlaySingleAction(var_254_0, ...)
end

function var_0_1.PlaySingleAction(arg_255_0, arg_255_1, arg_255_2, arg_255_3, arg_255_4)
	arg_255_1:PlaySingleAction(arg_255_2, arg_255_3, arg_255_4)

	return
end

function var_0_1.SwitchCurrentAnim(arg_256_0, ...)
	local var_256_0 = arg_256_0:GetCurrentLadyEnv()

	return arg_256_0:SwitchAnim(var_256_0, ...)
end

function var_0_1.SwitchAnim(arg_257_0, arg_257_1, arg_257_2, arg_257_3)
	arg_257_1:SwitchAnim(arg_257_2, arg_257_3)

	return
end

function var_0_1.PlayFaceAnim(arg_258_0, arg_258_1, arg_258_2, arg_258_3)
	arg_258_1:PlayFaceAnim(arg_258_2, arg_258_3)

	return
end

function var_0_1.RegisterAnimCallback(arg_259_0, arg_259_1, arg_259_2)
	arg_259_0:GetCurrentLadyEnv().animCallbacks[arg_259_1] = arg_259_2

	return
end

function var_0_1.SetCharacterAnimSpeed(arg_260_0, arg_260_1)
	arg_260_0:GetCurrentLadyEnv().ladyAnimator.speed = arg_260_1
	var_2.ladyHeadIKComp.blinkSpeed = var_2.ladyHeadIKData.blinkSpeed * arg_260_1

	if arg_260_1 > 0 then
		var_2.ladyHeadIKComp.DampTime = var_2.ladyHeadIKData.DampTime / arg_260_1
	else
		local var_260_0 = var_2.ladyHeadIKComp
		local var_260_1 = var_2.ladyHeadIKData.DampTime

		math = var_1_10005
		var_260_0.DampTime = var_260_1 * var_1_10005.huge
	end

	return
end

function var_0_1.OnAnimationEvent(arg_261_0, arg_261_1)
	if arg_261_1.animatorClipInfo.weight < 0.5 then
		return
	end

	local var_261_0 = arg_261_1.stringParameter

	table = var_1_10005

	local var_261_1 = var_1_10005.removebykey(arg_261_0.animEventCallbacks, var_261_0)

	existCall = var_1_10006

	var_1_10006(var_261_1)

	return
end

function var_0_1.RegisterAnimEventCallback(arg_262_0, arg_262_1, arg_262_2)
	arg_262_0.animEventCallbacks[arg_262_1] = arg_262_2

	return
end

function var_0_1.PlaySceneItemAnim(arg_263_0, arg_263_1, arg_263_2, arg_263_3)
	local var_263_0

	if not arg_263_0.sceneAnimatorDict then
		var_263_0 = {}
	end

	arg_263_0.sceneAnimatorDict = var_263_0

	if not arg_263_0.sceneAnimatorDict[arg_263_1] then
		pg = var_4

		local var_263_1 = var_4.dorm3d_scene_animator[arg_263_1]
		local var_263_2 = arg_263_0:GetSceneItem(var_263_1.item_name)

		assert = var_1_10006

		var_1_10006(var_263_2, "Missing Scene Animator in pg.dorm3d_scene_animator: " .. arg_263_1 .. " " .. var_263_1.item_name)

		if not var_263_2 then
			return
		end

		local var_263_3 = var_263_2
		local var_263_4 = var_263_2.GetComponent

		typeof = var_9
		Animator = var_11

		if not var_263_4(var_263_3, var_9(var_11)) then
			return
		end

		arg_263_0.sceneAnimatorDict[arg_263_1] = {
			trans = var_263_2,
			animator = var_6
		}
	end

	if not arg_263_3 then
		local var_263_5 = arg_263_0.sceneAnimatorDict[arg_263_1].animator
		local var_263_6 = var_4.GetCurrentAnimatorStateInfo(var_263_5, 0)

		if var_4.IsName(var_263_6, arg_263_2) then
			return
		end
	end

	local var_263_7 = arg_263_0.sceneAnimatorDict[arg_263_1].animator

	var_4.PlayInFixedTime(var_263_7, arg_263_2)

	return
end

function var_0_1.ResetSceneItemAnimators(arg_264_0, arg_264_1)
	if not arg_264_0.sceneAnimatorDict then
		return
	end

	table = var_2

	var_2.Foreach(arg_264_0.sceneAnimatorDict, function(arg_265_0, arg_265_1)
		if arg_264_1 then
			table = var_2

			if var_2.contains(arg_264_1, arg_265_0) then
				return
			end
		end

		setActive = var_2

		var_2(arg_265_1.trans, false)

		setActive = var_2

		var_2(arg_265_1.trans, true)

		arg_264_0.sceneAnimatorDict[arg_265_0] = nil

		return
	end)

	return
end

function var_0_1.LoadCharacterExtraItem(arg_266_0, arg_266_1, arg_266_2, arg_266_3, arg_266_4, arg_266_5, arg_266_6, arg_266_7)
	local function var_266_0(arg_267_0)
		if arg_266_6 then
			local var_267_0 = arg_267_0
			local var_267_1 = arg_267_0.GetComponent

			typeof = var_2_10004
			Animator = var_2_10006

			if var_267_1(var_267_0, var_2_10004(var_2_10006)) then
				var_1:Play(arg_266_6)

				var_1.speed = arg_266_7
			end
		end

		return
	end

	local var_266_1

	if not arg_266_1.extraItems then
		var_266_1 = {}
	end

	arg_266_1.extraItems = var_266_1

	if arg_266_1.extraItems[arg_266_2] then
		var_266_0(arg_266_1.extraItems[arg_266_2].trans)

		return
	end

	local var_266_2

	if arg_266_3 == "" then
		var_266_2 = arg_266_1.lady
	elseif arg_266_3 == "scene_root" then
		var_266_2 = arg_266_0.modelRoot
	else
		table = var_1_10010

		local var_266_3 = var_1_10010.IpairsCArray
		local var_266_4 = arg_266_1.lady
		local var_266_5 = var_12.GetComponentsInChildren

		typeof = var_1_10015
		Transform = var_1_10017

		var_266_3(var_266_5(var_266_4, var_1_10015(var_1_10017), true), function(arg_268_0, arg_268_1)
			if arg_268_1.name == arg_266_3 then
				var_266_2 = arg_268_1
			end

			return
		end)
	end

	if not var_266_2 then
		return
	end

	local var_266_6 = arg_266_0.loader
	local var_266_7 = var_10.GetPrefab

	string = var_1_10013

	var_266_7(var_266_6, var_1_10013.lower("dorm3d/" .. arg_266_2), "", function(arg_269_0)
		setParent = var_2_10001

		var_2_10001(arg_269_0, var_266_2)

		if arg_266_4 then
			setLocalPosition = var_1

			var_1(arg_269_0, arg_266_4)
		end

		if arg_266_5 then
			setLocalRotation = var_1

			var_1(arg_269_0, arg_266_5)
		end

		var_266_0(arg_269_0)

		arg_266_1.extraItems[arg_266_2] = {
			trans = arg_269_0.transform,
			handler = var_266_2
		}

		return
	end)

	return
end

function var_0_1.ResetCharacterExtraItem(arg_270_0, arg_270_1, arg_270_2)
	if not arg_270_1.extraItems then
		return
	end

	table = var_3

	var_3.Foreach(arg_270_1.extraItems, function(arg_271_0, arg_271_1)
		if arg_270_2 then
			table = var_2

			if var_2.contains(arg_270_2, arg_271_0) then
				return
			end
		end

		local var_271_0 = arg_270_0.loader

		var_2.ReturnPrefab(var_271_0, arg_271_1.trans.gameObject)

		arg_270_1.extraItems[arg_271_0] = nil

		return
	end)

	return
end

function var_0_1.RegisterCameraBlendFinished(arg_272_0, arg_272_1, arg_272_2)
	arg_272_0.cameraBlendCallbacks[arg_272_1] = arg_272_2

	return
end

function var_0_1.UnRegisterCameraBlendFinished(arg_273_0, arg_273_1)
	arg_273_0.cameraBlendCallbacks[arg_273_1] = nil

	return
end

function var_0_1.OnCameraBlendFinished(arg_274_0, arg_274_1)
	if not arg_274_1 then
		return
	end

	table = var_1_10002

	local var_274_0 = var_1_10002.removebykey(arg_274_0.cameraBlendCallbacks, arg_274_1)

	existCall = var_1_10003

	var_1_10003(var_274_0)

	return
end

function var_0_1.PlayHeartFX(arg_275_0, arg_275_1)
	local var_275_0 = arg_275_0.ladyDict[arg_275_1]

	setActive = var_1_10003

	var_1_10003(var_275_0.effectHeart, false)

	setActive = var_1_10003

	var_1_10003(var_275_0.effectHeart, true)

	pg = var_1_10003

	local var_275_1 = var_1_10003.CriMgr.GetInstance()

	var_3.PlaySE_V3(var_275_1, "ui-dorm_joyful")

	return
end

function var_0_1.PlayExpression(arg_276_0, arg_276_1)
	local var_276_0 = arg_276_1.name
	local var_276_1 = arg_276_0.expressionDict[var_276_0]
	local var_276_2 = 5

	if var_276_1 then
		local var_276_3 = var_276_1.timer

		var_5.Reset(var_276_3, nil, var_276_2)
		var_5:Start()

		if var_276_1.instance then
			setActive = var_1_10006

			var_1_10006(var_276_1.instance, false)

			setActive = var_1_10006

			var_1_10006(var_276_1.instance, true)
		end

		return
	end

	local var_276_4 = {
		name = var_276_0
	}

	Timer = var_1_10006
	var_276_4.timer = var_1_10006.New(function()
		local var_277_0 = arg_276_0

		var_0.RemoveExpression(var_277_0, var_276_0)

		return
	end, var_276_2, 1, true)
	arg_276_0.expressionDict[var_276_0] = var_276_4

	local var_276_5 = arg_276_0.loader

	var_6.GetPrefab(var_276_5, "dorm3D/effect/prefab/expression/" .. var_276_0, var_276_0, function(arg_278_0)
		local var_278_0 = var_276_4

		var_278_0.instance = arg_278_0
		onNextTick = var_278_0

		var_278_0(function()
			local var_279_0 = arg_276_0
			local var_279_1 = var_0.GetCurrentLadyEnv(var_279_0)

			setParent = var_3_10001

			var_3_10001(arg_278_0, var_279_1.ladyHeadCenter)

			return
		end)

		setLocalPosition = var_278_0

		local var_278_1 = arg_278_0

		Vector3 = var_2_10004

		var_278_0(var_278_1, var_2_10004(0, 0, -0.2))

		setActive = var_278_0

		var_278_0(arg_278_0, false)

		setActive = var_278_0

		var_278_0(arg_278_0, true)

		return
	end, var_276_4)

	return
end

function var_0_1.RemoveExpression(arg_280_0, arg_280_1)
	if not arg_280_0.expressionDict[arg_280_1] then
		return
	end

	local var_280_0 = arg_280_0.loader

	var_3.ClearRequest(var_280_0, var_2)

	if var_2.instance then
		local var_280_1 = arg_280_0.loader

		var_3.ReturnPrefab(var_280_1, var_2.instance)
	end

	arg_280_0.expressionDict[arg_280_1] = nil

	return
end

function var_0_1.ShowOrHideCanWatchMark(arg_281_0, arg_281_1, arg_281_2)
	setActive = var_1_10003

	var_1_10003(arg_281_1.ladyWatchFloat, arg_281_2)

	return
end

function var_0_1.RegisterGlobalVolume(arg_282_0)
	local var_282_0 = arg_282_0.globalVolume

	GraphicsInterface = var_1_10002

	local var_282_1 = var_1_10002.Instance.GetOrAddVolumeComponent
	local var_282_2 = var_282_0

	typeof = var_1_10005
	BLHX = var_1_10007

	local var_282_3 = var_282_1(var_282_2, var_1_10005(var_1_10007.Rendering.CustomDepthOfField))

	GraphicsInterface = var_1_10003

	local var_282_4 = var_1_10003.Instance.GetOrAddVolumeComponent
	local var_282_5 = var_282_0

	typeof = var_1_10006
	UnityEngine = var_1_10008

	local var_282_6 = var_282_4(var_282_5, var_1_10006(var_1_10008.Rendering.Universal.ColorAdjustments))

	arg_282_0.originalCameraSettings = {
		depthOfField = {
			enabled = var_282_3.enabled.value,
			focusDistance = {
				length = 2,
				min = var_282_3.gaussianStart.min,
				value = var_282_3.gaussianStart.value
			},
			blurRadius = {
				min = var_282_3.blurRadius.min,
				max = var_282_3.blurRadius.max,
				value = var_282_3.blurRadius.value
			}
		},
		postExposure = {
			value = var_282_6.postExposure.value
		},
		contrast = {
			min = var_282_6.contrast.min,
			max = var_282_6.contrast.max,
			value = var_282_6.contrast.value
		},
		saturate = {
			min = var_282_6.saturation.min,
			max = var_282_6.saturation.max,
			value = var_282_6.saturation.value
		}
	}
	arg_282_0.originalCameraSettings.depthOfField.enabled = true

	local var_282_7 = var_282_0
	local var_282_8 = var_282_0.GetComponent

	typeof = var_7
	UnityEngine = var_1_10009

	local var_282_9 = var_282_8(var_282_7, var_7(var_1_10009.Rendering.Volume))

	arg_282_0.originalVolume = {
		profile = var_282_9.sharedProfile,
		weight = var_282_9.weight
	}

	return
end

function var_0_1.SettingCamera(arg_283_0, arg_283_1)
	arg_283_0.activeCameraSettings = arg_283_1

	local var_283_0 = arg_283_0.globalVolume

	GraphicsInterface = var_1_10003

	local var_283_1 = var_1_10003.Instance.GetOrAddVolumeComponent
	local var_283_2 = var_283_0

	typeof = var_1_10006
	BLHX = var_1_10008

	local var_283_3 = var_283_1(var_283_2, var_1_10006(var_1_10008.Rendering.CustomDepthOfField))

	GraphicsInterface = var_1_10004

	local var_283_4 = var_1_10004.Instance.GetOrAddVolumeComponent
	local var_283_5 = var_283_0

	typeof = var_1_10007
	UnityEngine = var_1_10009

	local var_283_6 = var_283_4(var_283_5, var_1_10007(var_1_10009.Rendering.Universal.ColorAdjustments))
	local var_283_7 = var_283_3.enabled

	var_5.Override(var_283_7, arg_283_1.depthOfField.enabled)

	local var_283_8 = var_283_3.gaussianStart

	var_5.Override(var_283_8, arg_283_1.depthOfField.focusDistance.value)

	local var_283_9 = var_283_3.gaussianEnd

	var_5.Override(var_283_9, arg_283_1.depthOfField.focusDistance.value + arg_283_1.depthOfField.focusDistance.length)

	local var_283_10 = var_283_3.blurRadius

	var_5.Override(var_283_10, arg_283_1.depthOfField.blurRadius.value)

	local var_283_11 = var_283_6.postExposure

	var_5.Override(var_283_11, arg_283_1.postExposure.value)

	local var_283_12 = var_283_6.contrast

	var_5.Override(var_283_12, arg_283_1.contrast.value)

	local var_283_13 = var_283_6.saturation

	var_5.Override(var_283_13, arg_283_1.saturate.value)

	return
end

function var_0_1.GetCameraSettings(arg_284_0)
	return arg_284_0.originalCameraSettings
end

function var_0_1.RevertCameraSettings(arg_285_0)
	arg_285_0:SettingCamera(arg_285_0.originalCameraSettings)

	arg_285_0.activeCameraSettings = nil

	return
end

function var_0_1.SetVolumeProfile(arg_286_0, arg_286_1, arg_286_2)
	if arg_286_0.cameraVolume then
		arg_286_0:RevertVolumeProfile()
	end

	local var_286_0 = arg_286_0.loader

	var_3.GetPrefab(var_286_0, "dorm3d/effect/volume/" .. arg_286_1, "", function(arg_287_0)
		arg_286_0.cameraVolume = arg_287_0

		return
	end)

	return
end

function var_0_1.RevertVolumeProfile(arg_288_0)
	if arg_288_0.cameraVolume then
		local var_288_0 = arg_288_0.loader

		var_1.ReturnPrefab(var_288_0, arg_288_0.cameraVolume)

		arg_288_0.cameraVolume = nil
	end

	return
end

function var_0_1.RecordCharacterLight(arg_289_0)
	tolua = var_1_10001

	var_1_10001.loadassembly("Yongshi.BLRP.Runtime.AOT")

	local var_289_0 = arg_289_0.characterLight
	local var_289_1 = var_1.GetComponent

	typeof = var_1_10004

	local var_289_2 = var_289_1(var_289_0, var_1_10004("BLHX.Rendering.CharacterLight"))
	local var_289_3 = {}

	ReflectionHelp = var_289_0

	local var_289_4 = var_289_0.RefGetProperty

	typeof = var_1_10005
	var_289_3.color = var_289_4(var_1_10005("BLHX.Rendering.CharacterLight"), "characterLightColor", var_289_2)
	ReflectionHelp = var_3

	local var_289_5 = var_3.RefGetProperty

	typeof = var_5
	var_289_3.intensity = var_289_5(var_5("BLHX.Rendering.CharacterLight"), "characterLightIntensity", var_289_2)
	arg_289_0.originalCharacterColor = var_289_3

	return
end

function var_0_1.SetCharacterLight(arg_290_0, arg_290_1, arg_290_2, arg_290_3)
	local var_290_0 = arg_290_0.characterLight
	local var_290_1 = var_4.GetComponent

	typeof = var_1_10007
	Light = var_1_10009

	local var_290_2 = var_290_1(var_290_0, var_1_10007(var_1_10009))

	Color = var_1_10005

	local var_290_3 = var_1_10005.Lerp(arg_290_0.originalCharacterColor.color, arg_290_1, arg_290_3)

	math = var_290_0

	local var_290_4 = var_290_0.lerp(arg_290_0.originalCharacterColor.intensity, arg_290_2, arg_290_3)
	local var_290_5 = arg_290_0.characterLight
	local var_290_6 = var_7.GetComponent

	typeof = var_10

	local var_290_7 = var_290_6(var_290_5, var_10("BLHX.Rendering.CharacterLight"))

	ReflectionHelp = var_8

	local var_290_8 = var_8.RefSetProperty

	typeof = var_10

	var_290_8(var_10("BLHX.Rendering.CharacterLight"), "characterLightColor", var_290_7, var_290_3)

	ReflectionHelp = var_290_8

	local var_290_9 = var_290_8.RefSetProperty

	typeof = var_10

	var_290_9(var_10("BLHX.Rendering.CharacterLight"), "characterLightIntensity", var_290_7, var_290_4)

	return
end

function var_0_1.RevertCharacterLight(arg_291_0)
	arg_291_0:SetCharacterLight(arg_291_0.originalCharacterColor.color, arg_291_0.originalCharacterColor.intensity, 1)

	return
end

function var_0_1.onBackPressed(arg_292_0)
	if arg_292_0.exited or arg_292_0.retainCount > 0 then
		-- block empty
	else
		arg_292_0:closeView()
	end

	return
end

function var_0_1.LoadTimelineScene(arg_293_0, arg_293_1, arg_293_2, arg_293_3, arg_293_4)
	local var_293_0 = arg_293_0.dormSceneMgr
	local var_293_1 = var_5.LoadTimelineScene
	local var_293_2 = {
		name = arg_293_1
	}
	local var_293_3 = arg_293_0.apartment

	var_293_2.assetRootName = var_9.getConfig(var_293_3, "asset_name")
	var_293_2.isCache = arg_293_2
	var_293_2.waitForTimeline = arg_293_3

	function var_293_2.loadSceneFunc(arg_294_0, arg_294_1)
		Dorm3dHxHelper = var_2_10002

		local var_294_0 = var_2_10002.GetTimelineMainCharacter()

		Dorm3dHxHelper = var_2_10003

		var_2_10003.HideCharacterPart(var_294_0, nil, true)

		local var_294_1 = arg_293_0

		var_3.HXCharacter(var_294_1, var_294_0)

		return
	end

	var_293_1(var_293_0, var_293_2, arg_293_4)

	return
end

function var_0_1.UnloadTimelineScene(arg_295_0, arg_295_1, arg_295_2, arg_295_3)
	local var_295_0 = arg_295_0.dormSceneMgr

	var_4.UnloadTimelineScene(var_295_0, arg_295_1, arg_295_2, arg_295_3)

	return
end

function var_0_1.ChangeArtScene(arg_296_0, arg_296_1, arg_296_2)
	local var_296_0 = {}

	table = var_1_10004

	var_1_10004.insert(var_296_0, function(arg_297_0)
		local var_297_0 = arg_296_0.dormSceneMgr

		var_1.ChangeArtScene(var_297_0, arg_296_1, arg_297_0)

		return
	end)

	table = var_4

	var_4.insert(var_296_0, function(arg_298_0)
		setActive = var_2_10001

		var_2_10001(arg_296_0.slotRoot, false)
		arg_298_0()

		return
	end)

	warning = var_4

	local var_296_1 = ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	local var_296_2 = arg_296_1
	local var_296_3 = arg_296_0.dormSceneMgr.sceneInfo

	Dorm3dSceneMgr = var_1_10009

	var_4(var_296_1, var_296_2, var_296_3, var_1_10009.IsSameSceneInfo(arg_296_1, arg_296_0.dormSceneMgr.sceneInfo))

	Dorm3dSceneMgr = var_4

	if var_4.IsSameSceneInfo(arg_296_1, arg_296_0.dormSceneMgr.sceneInfo) then
		table = var_4

		var_4.insert(var_296_0, function(arg_299_0)
			local var_299_0 = arg_296_0

			var_1.SwitchDayNight(var_299_0, 1)

			local var_299_1 = arg_296_0

			var_1.TempHideContact(var_299_1, true)
			arg_299_0()

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_296_0, arg_296_2)

	return
end

function var_0_1.RevertArtScene(arg_300_0, arg_300_1, arg_300_2)
	local var_300_0 = {}

	table = var_1_10004

	var_1_10004.insert(var_300_0, function(arg_301_0)
		local var_301_0 = arg_300_0.dormSceneMgr

		var_1.ChangeArtScene(var_301_0, arg_300_1, arg_301_0)

		return
	end)

	table = var_4

	var_4.insert(var_300_0, function(arg_302_0)
		setActive = var_2_10001

		var_2_10001(arg_300_0.slotRoot, true)
		arg_302_0()

		return
	end)

	table = var_4

	var_4.insert(var_300_0, function(arg_303_0)
		local var_303_0 = arg_300_0

		var_1.SwitchDayNight(var_303_0, arg_300_0.contextData.timeIndex)

		onNextTick = var_1

		var_1(function()
			local var_304_0 = arg_300_0

			var_0.RefreshSlots(var_304_0)

			local var_304_1 = arg_300_0

			var_0.TempHideContact(var_304_1, false)
			arg_303_0()

			return
		end)

		return
	end)

	seriesAsync = var_4

	var_4(var_300_0, arg_300_2)

	return
end

function var_0_1.ChangeSubScene(arg_305_0, arg_305_1, arg_305_2)
	local var_305_0 = {}

	table = var_1_10004

	var_1_10004.insert(var_305_0, function(arg_306_0)
		local var_306_0 = arg_305_0.dormSceneMgr

		var_1.ChangeSubScene(var_306_0, arg_305_1, arg_306_0)

		return
	end)

	local var_305_1 = arg_305_0:GetCurrentLadyEnv()

	table = var_1_10005

	var_1_10005.insert(var_305_0, function(arg_307_0)
		Dorm3dSceneMgr = var_2_10001

		if var_2_10001.IsSameSceneInfo(arg_305_1, arg_305_0.dormSceneMgr.sceneInfo) then
			local var_307_0 = var_305_1
			local var_307_1

			if not var_305_1.walkBornPoint then
				var_307_1 = var_305_1.ladyBaseZone
			end

			var_307_0.ladyActiveZone = var_307_1
		else
			local var_307_2 = var_305_1
			local var_307_3

			if not var_305_1.walkBornPoint then
				var_307_3 = "Default"
			end

			var_307_2.ladyActiveZone = var_307_3
		end

		arg_307_0()

		return
	end)

	Dorm3dSceneMgr = var_5

	if not var_5.IsSameSceneInfo(arg_305_1, arg_305_0.dormSceneMgr.subSceneInfo) then
		table = var_5

		var_5.insert(var_305_0, function(arg_308_0)
			Dorm3dSceneMgr = var_2_10001

			local var_308_0, var_308_1 = var_2_10001.ParseInfo(arg_305_1)
			local var_308_2 = var_308_0 .. "_base"
			local var_308_3 = arg_305_0
			local var_308_4 = var_3.ResetSceneStructure

			SceneManager = var_2_10006

			var_308_4(var_308_3, var_2_10006.GetSceneByName(var_308_2))

			Dorm3dSceneMgr = var_308_4

			if var_308_4.IsSameSceneInfo(arg_305_1, arg_305_0.dormSceneMgr.sceneInfo) then
				local var_308_5 = arg_305_0

				var_3.RefreshSlots(var_308_5)
			else
				local var_308_6 = arg_305_0

				var_3.SwitchAnim(var_308_6, var_305_1, var_0_1.ANIM.IDLE)
			end

			Dorm3dSceneMgr = var_3

			if not var_3.IsSameSceneInfo(arg_305_0.dormSceneMgr.subSceneInfo, arg_305_0.dormSceneMgr.sceneInfo) then
				local var_308_7 = arg_305_0

				var_3.RefreshSlotsEmpty(var_308_7)
			end

			arg_308_0()

			return
		end)
	end

	table = var_5

	var_5.insert(var_305_0, function(arg_309_0)
		onNextTick = var_2_10001

		var_2_10001(function()
			local var_310_0 = arg_305_0

			var_0.ChangeCharacterPosition(var_310_0, var_305_1)

			local var_310_1 = arg_305_0

			var_0.ChangePlayerPosition(var_310_1, var_305_1.ladyActiveZone)

			local var_310_2 = arg_305_0

			var_0.TriggerLadyDistance(var_310_2)

			local var_310_3 = arg_305_0

			var_0.CheckInSector(var_310_3)
			arg_309_0()

			return
		end)

		return
	end)

	seriesAsync = var_5

	var_5(var_305_0, arg_305_2)

	return
end

function var_0_1.IsPointInSector(arg_311_0, arg_311_1)
	if (arg_311_1 - arg_311_0.Position).y > arg_311_0.Radius then
		return false
	end

	var_2.y = 0

	if var_2.magnitude > arg_311_0.Radius then
		return false
	end

	local var_311_0 = arg_311_0.Rotation

	Vector3 = var_1_10005

	local var_311_1 = var_1_10005.Angle

	Vector3 = var_1_10007

	return var_311_1(var_311_0 * var_1_10007.forward, var_2) <= arg_311_0.Angle / 2
end

function var_0_1.GetRestritedHeightRange(arg_312_0)
	if not arg_312_0.isMultiFloor then
		return arg_312_0.restrictedHeightRange
	else
		for iter_312_0 = #arg_312_0.restrictedHeightRange, 1, -1 do
			local var_312_0 = arg_312_0.restrictedHeightRange[iter_312_0]

			if arg_312_0.mainCameraTF.position.y >= var_312_0[1] then
				return var_312_0
			end
		end

		return arg_312_0.restrictedHeightRange[1]
	end

	return
end

function var_0_1.willExit(arg_313_0)
	var_0_1.super.willExit(arg_313_0)

	local var_313_0 = arg_313_0.joystickTimer

	var_1.Stop(var_313_0)

	local var_313_1 = arg_313_0.moveStickTimer

	var_1.Stop(var_313_1)

	UpdateBeat = var_1

	var_1:RemoveListener(arg_313_0.updateHandler)

	if arg_313_0.moveTimer then
		local var_313_2 = arg_313_0.moveTimer

		var_1.Stop(var_313_2)

		arg_313_0.moveTimer = nil
	end

	if arg_313_0.moveWaitTimer then
		local var_313_3 = arg_313_0.moveWaitTimer

		var_1.Stop(var_313_3)

		arg_313_0.moveWaitTimer = nil
	end

	GlobalClickEventMgr = var_1

	local var_313_4 = var_1.Inst

	var_1.RemoveBeginPinchFunc(var_313_4)

	GlobalClickEventMgr = var_1

	local var_313_5 = var_1.Inst

	var_1.RemovePinchFunc(var_313_5)

	GlobalClickEventMgr = var_1

	local var_313_6 = var_1.Inst

	var_1.RemoveEndPinchFunc(var_313_6)

	IsNil = var_1

	if not var_1(arg_313_0.furnitures) then
		eachChild = var_1

		var_1(arg_313_0.furnitures, function(arg_314_0)
			GetComponent = var_2_10001

			local var_314_0 = arg_314_0

			typeof = var_2_10004
			EventTriggerListener = var_2_10006

			if not var_2_10001(var_314_0, var_2_10004(var_2_10006)) then
				return
			end

			var_1:ClearEvents()

			return
		end)
	end

	pg = var_1

	local var_313_7 = var_1.IKMgr.GetInstance()

	var_1.ResetActiveIKs(var_313_7)

	pairs = var_1

	for iter_313_0, iter_313_1 in var_1(arg_313_0.ladyDict) do
		GetComponent = var_1_10006

		local var_313_8 = iter_313_1.lady

		typeof = var_1_10009
		EventTriggerListener = var_1_10011
		var_1_10009 = var_1_10006(var_313_8, var_1_10009(var_1_10011))

		var_1_10006.ClearEvents(var_1_10009)
	end

	arg_313_0.camBrainEvenetHandler.OnBlendStarted = nil
	arg_313_0.camBrainEvenetHandler.OnBlendFinished = nil

	arg_313_0:UnOverlayPanel(arg_313_0.blockLayer, arg_313_0._tf)

	table = var_1

	var_1.Foreach(arg_313_0.expressionDict, function(arg_315_0)
		local var_315_0 = arg_313_0

		var_1.RemoveExpression(var_315_0, arg_315_0)

		return
	end)

	local var_313_9 = arg_313_0.loader

	var_1.Clear(var_313_9)

	pg = var_1

	local var_313_10 = var_1.ClickEffectMgr.GetInstance()

	var_1.SetClickEffect(var_313_10, "NORMAL")

	pg = var_1

	local var_313_11 = var_1.NodeCanvasMgr.GetInstance()

	var_1.Clear(var_313_11)

	local var_313_12 = arg_313_0.dormSceneMgr

	var_1.Dispose(var_313_12)

	arg_313_0.dormSceneMgr = nil
	ReflectionHelp = var_1

	local var_313_13 = var_1.RefSetProperty

	typeof = var_313_12

	var_313_13(var_313_12("UnityEngine.LightmapSettings"), "lightmaps", nil, nil)

	if arg_313_0.transformFilter then
		local var_313_14 = arg_313_0.transformFilter

		var_1.Dispose(var_313_14)
	end

	return
end

return var_0_1
