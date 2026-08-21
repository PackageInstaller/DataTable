local var_0_0 = class("CarWashScene", import("view.dorm3d.Core.Dorm3dBaseScene"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dCarWashUI"
end

function var_0_0.forceGC(arg_2_0)
	return true
end

function var_0_0.GetDefaultSystemClasses()
	return CarWashConst.GetDefaultSystemClasses()
end

function var_0_0.loadingQueue(arg_4_0)
	return function(arg_5_0)
		pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_6_0)
			return arg_5_0(arg_6_0)
		end)

		return
	end
end

function var_0_0.preload(arg_7_0, arg_7_1)
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
	arg_7_0.loader = AutoLoader.New()

	seriesAsync({
		function(arg_8_0)
			SceneOpMgr.Inst:LoadSceneAsync(arg_7_0.sceneInfo[1].path, arg_7_0.sceneInfo[1].name, LoadSceneMode.Additive, function(arg_9_0, arg_9_1)
				SceneManager.SetActiveScene(arg_9_0)
				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			SceneOpMgr.Inst:LoadSceneAsync(arg_7_0.sceneInfo[2].path, arg_7_0.sceneInfo[2].name, LoadSceneMode.Additive, function(arg_11_0, arg_11_1)
				arg_10_0()

				return
			end)

			return
		end,
		function(arg_12_0)
			arg_7_0.loader:GetPrefab(pg.dorm3d_carwash[arg_7_0.contextData.groupId].character_prefab, "", function(arg_13_0)
				arg_7_0.ladyGO = arg_13_0

				arg_12_0()

				return
			end)

			return
		end
	}, arg_7_1)

	return
end

function var_0_0.willExit(arg_14_0)
	var_0_0.super.willExit(arg_14_0)

	if arg_14_0.updateHandler then
		UpdateBeat:RemoveListener(arg_14_0.updateHandler)

		arg_14_0.updateHandler = nil
	end

	arg_14_0.loader:Clear()
	seriesAsync(underscore.map(arg_14_0.sceneInfo, function(arg_15_0)
		return function(arg_16_0)
			SceneOpMgr.Inst:UnloadSceneAsync(arg_15_0.path, arg_15_0.name, arg_16_0)

			return
		end
	end), function()
		return
	end)

	return
end

function var_0_0.init(arg_18_0)
	arg_18_0:InitSceneRefs()
	arg_18_0:InitExtraSystem({
		CarWashGameFlowSystem
	})
	arg_18_0:InitPage()
	arg_18_0:InitExtraSystem(CarWashConst.GetGameplaySystemClasses())
	arg_18_0:InitHX()

	return
end

function var_0_0.InitHX(arg_19_0)
	arg_19_0.holyLightRoot = arg_19_0._tf:Find("HolyLightRoot")

	Dorm3dHxHelper.ReplaceCharacterParts(arg_19_0.ladyGO.transform)
	Dorm3dHxHelper.HideCharacterPart(arg_19_0.ladyGO.transform, nil, true)
	Dorm3dHxHelper.ShowHolyLight({
		arg_19_0.ladyGO.transform
	}, arg_19_0.holyLightRoot, true)

	return
end

function var_0_0.InitPage(arg_20_0)
	arg_20_0.mainPage = CarWashMainPage.New(arg_20_0._tf, arg_20_0.event, arg_20_0.contextData)
	arg_20_0.gamePage = CarWashGamePage.New(arg_20_0._tf:Find("game"), arg_20_0.event, arg_20_0.contextData)
	arg_20_0.phase2Page = CarWashPhase2Page.New(arg_20_0._tf:Find("phase2"), arg_20_0.event, arg_20_0.contextData)
	arg_20_0.endPage = CarWashEndPage.New(arg_20_0._tf:Find("end"), arg_20_0.event, arg_20_0.contextData)

	return
end

function var_0_0.InitSceneRefs(arg_21_0)
	setActive(GameObject.Find("Camera"), false)

	arg_21_0.mainCameraGO = GameObject.Find("BackYardMainCamera")
	arg_21_0.mainCameraTF = arg_21_0.mainCameraGO.transform
	arg_21_0.mainCamera = arg_21_0.mainCameraGO:GetComponent(typeof(Camera))
	arg_21_0.cameraRoot = GameObject.Find("CM Cameras").transform
	arg_21_0.raycastCamera = arg_21_0.mainCameraTF:Find("CameraForRaycast"):GetComponent(typeof(Camera))
	arg_21_0.sceneRaycaster = arg_21_0.raycastCamera:GetComponent(typeof(UnityEngine.EventSystems.PhysicsRaycaster))

	return
end

function var_0_0.didEnter(arg_22_0)
	arg_22_0:emit(CarWashGameFlowSystem.START_GAME, function()
		arg_22_0:StartUpdate()

		return
	end)

	return
end

function var_0_0.StartUpdate(arg_24_0)
	if arg_24_0.updateHandler then
		return
	end

	arg_24_0.updateHandler = UpdateBeat:CreateListener(function()
		xpcall(function()
			arg_24_0:Update()

			return
		end, function(...)
			errorMsg(debug.traceback(...))

			return
		end)

		return
	end)

	UpdateBeat:AddListener(arg_24_0.updateHandler)

	return
end

function var_0_0.Update(arg_28_0)
	if arg_28_0.exited then
		return
	end

	if arg_28_0.systemManager then
		arg_28_0.systemManager:Update(Time.deltaTime)
	end

	return
end

return var_0_0
