class = var_0_10000

local var_0_0 = "CarWashScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Core.Dorm3dBaseScene"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dCarWashUI"
end

function var_0_1.forceGC(arg_2_0)
	return true
end

function var_0_1.GetDefaultSystemClasses()
	CarWashConst = var_1_10000

	return var_1_10000.GetDefaultSystemClasses()
end

function var_0_1.loadingQueue(arg_4_0)
	return function(arg_5_0)
		pg = var_2_10001

		local var_5_0 = var_2_10001.SceneAnimMgr.GetInstance()

		var_1.Dorm3DSceneChange(var_5_0, function(arg_6_0)
			return arg_5_0(arg_6_0)
		end)

		return
	end
end

function var_0_1.preload(arg_7_0, arg_7_1)
	arg_7_0.sceneInfo = {
		{
			name = "map_carwash_01",
			path = "dorm3d/scenesres/scenes/carwash/map_carwash_01_scene"
		},
		{
			name = "carwash_gameplay",
			path = "dorm3d/scenesres/scenes/carwash/carwash_gameplay_scene"
		}
	}
	AutoLoader = var_2
	arg_7_0.loader = var_2.New()
	seriesAsync = var_2

	var_2({
		function(arg_8_0)
			SceneOpMgr = var_2_10001

			local var_8_0 = var_2_10001.Inst
			local var_8_1 = var_1.LoadSceneAsync
			local var_8_2 = arg_7_0.sceneInfo[1].path
			local var_8_3 = arg_7_0.sceneInfo[1].name

			LoadSceneMode = var_2_10005

			var_8_1(var_8_0, var_8_2, var_8_3, var_2_10005.Additive, function(arg_9_0, arg_9_1)
				SceneManager = var_3_10002

				var_3_10002.SetActiveScene(arg_9_0)
				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			SceneOpMgr = var_2_10001

			local var_10_0 = var_2_10001.Inst
			local var_10_1 = var_1.LoadSceneAsync
			local var_10_2 = arg_7_0.sceneInfo[2].path
			local var_10_3 = arg_7_0.sceneInfo[2].name

			LoadSceneMode = var_2_10005

			var_10_1(var_10_0, var_10_2, var_10_3, var_2_10005.Additive, function(arg_11_0, arg_11_1)
				arg_10_0()

				return
			end)

			return
		end,
		function(arg_12_0)
			pg = var_2_10001

			local var_12_0 = var_2_10001.dorm3d_carwash[arg_7_0.contextData.groupId].character_prefab
			local var_12_1 = arg_7_0.loader

			var_2.GetPrefab(var_12_1, var_12_0, "", function(arg_13_0)
				arg_7_0.ladyGO = arg_13_0

				arg_12_0()

				return
			end)

			return
		end
	}, arg_7_1)

	return
end

function var_0_1.willExit(arg_14_0)
	var_0_1.super.willExit(arg_14_0)

	if arg_14_0.updateHandler then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_14_0.updateHandler)

		arg_14_0.updateHandler = nil
	end

	local var_14_0 = arg_14_0.loader

	var_1.Clear(var_14_0)

	underscore = var_1

	local var_14_1 = var_1.map(arg_14_0.sceneInfo, function(arg_15_0)
		return function(arg_16_0)
			SceneOpMgr = var_3_10001

			local var_16_0 = var_3_10001.Inst

			var_1.UnloadSceneAsync(var_16_0, arg_15_0.path, arg_15_0.name, arg_16_0)

			return
		end
	end)

	seriesAsync = var_2

	var_2(var_14_1, function()
		return
	end)

	return
end

function var_0_1.init(arg_18_0)
	arg_18_0:InitSceneRefs()

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.InitExtraSystem
	local var_18_2 = {}

	CarWashGameFlowSystem = var_1_10004
	var_18_2[1] = var_1_10004

	var_18_1(var_18_0, var_18_2)
	arg_18_0:InitPage()

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.InitExtraSystem

	CarWashConst = var_18_2

	var_18_4(var_18_3, var_18_2.GetGameplaySystemClasses())
	arg_18_0:InitHX()

	return
end

function var_0_1.InitHX(arg_19_0)
	local var_19_0 = arg_19_0._tf

	arg_19_0.holyLightRoot = var_1.Find(var_19_0, "HolyLightRoot")
	Dorm3dHxHelper = var_1

	var_1.ReplaceCharacterParts(arg_19_0.ladyGO.transform)

	Dorm3dHxHelper = var_1

	var_1.HideCharacterPart(arg_19_0.ladyGO.transform, nil, true)

	Dorm3dHxHelper = var_1

	var_1.ShowHolyLight({
		arg_19_0.ladyGO.transform
	}, arg_19_0.holyLightRoot, true)

	return
end

function var_0_1.InitPage(arg_20_0)
	CarWashMainPage = var_1_10001
	arg_20_0.mainPage = var_1_10001.New(arg_20_0._tf, arg_20_0.event, arg_20_0.contextData)
	CarWashGamePage = var_1

	local var_20_0 = var_1.New
	local var_20_1 = arg_20_0._tf

	arg_20_0.gamePage = var_20_0(var_2.Find(var_20_1, "game"), arg_20_0.event, arg_20_0.contextData)
	CarWashPhase2Page = var_1

	local var_20_2 = var_1.New
	local var_20_3 = arg_20_0._tf

	arg_20_0.phase2Page = var_20_2(var_2.Find(var_20_3, "phase2"), arg_20_0.event, arg_20_0.contextData)
	CarWashEndPage = var_1

	local var_20_4 = var_1.New
	local var_20_5 = arg_20_0._tf

	arg_20_0.endPage = var_20_4(var_2.Find(var_20_5, "end"), arg_20_0.event, arg_20_0.contextData)

	return
end

function var_0_1.InitSceneRefs(arg_21_0)
	setActive = var_1_10001
	GameObject = var_1_10002

	var_1_10001(var_1_10002.Find("Camera"), false)

	GameObject = var_1_10001
	arg_21_0.mainCameraGO = var_1_10001.Find("BackYardMainCamera")
	arg_21_0.mainCameraTF = arg_21_0.mainCameraGO.transform

	local var_21_0 = arg_21_0.mainCameraGO
	local var_21_1 = var_1.GetComponent

	typeof = var_3
	Camera = var_1_10004
	arg_21_0.mainCamera = var_21_1(var_21_0, var_3(var_1_10004))
	GameObject = var_1
	arg_21_0.cameraRoot = var_1.Find("CM Cameras").transform

	local var_21_2 = arg_21_0.mainCameraTF
	local var_21_3 = var_1.Find(var_21_2, "CameraForRaycast")
	local var_21_4 = var_1.GetComponent

	typeof = var_3
	Camera = var_1_10004
	arg_21_0.raycastCamera = var_21_4(var_21_3, var_3(var_1_10004))

	local var_21_5 = arg_21_0.raycastCamera
	local var_21_6 = var_1.GetComponent

	typeof = var_3
	UnityEngine = var_1_10004
	arg_21_0.sceneRaycaster = var_21_6(var_21_5, var_3(var_1_10004.EventSystems.PhysicsRaycaster))

	return
end

function var_0_1.didEnter(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.emit

	CarWashGameFlowSystem = var_1_10003

	var_22_1(var_22_0, var_1_10003.START_GAME, function()
		local var_23_0 = arg_22_0

		var_0.StartUpdate(var_23_0)

		return
	end)

	return
end

function var_0_1.StartUpdate(arg_24_0)
	if arg_24_0.updateHandler then
		return
	end

	UpdateBeat = var_1
	arg_24_0.updateHandler = var_1:CreateListener(function()
		xpcall = var_2_10000

		var_2_10000(function()
			local var_26_0 = arg_24_0

			var_0.Update(var_26_0)

			return
		end, function(...)
			errorMsg = var_3_10000
			debug = var_3_10001

			var_3_10000(var_3_10001.traceback(...))

			return
		end)

		return
	end)
	UpdateBeat = var_1

	var_1:AddListener(arg_24_0.updateHandler)

	return
end

function var_0_1.Update(arg_28_0)
	if arg_28_0.exited then
		return
	end

	if arg_28_0.systemManager then
		local var_28_0 = arg_28_0.systemManager
		local var_28_1 = var_1.Update

		Time = var_1_10003

		var_28_1(var_28_0, var_1_10003.deltaTime)
	end

	return
end

return var_0_1
