class = var_0_10000

local var_0_0 = "Dorm3dDanceScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.Dorm3dGameTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dDanceUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.contextData.groupId

	pg = var_1_10003
	arg_2_0.gameConfig = var_1_10003.dorm3d_dance[var_2_0]

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.SetApartment

	getProxy = var_1_10006
	ApartmentProxy = var_1_10008

	local var_2_3 = var_1_10006(var_1_10008)

	var_2_2(var_2_1, var_6.getApartment(var_2_3, var_2_0))

	arg_2_0.sceneRootName = "publiccafe"
	arg_2_0.sceneName = "map_publiccafe_01_blue"
	pg = var_3
	arg_2_0.timelineSceneRootName = var_3.dorm3d_dorm_template[var_2_0].asset_name
	arg_2_0.timelineSceneName = arg_2_0.gameConfig.timeline_scene

	local var_2_4 = {}
	local var_2_5 = {}

	string = var_2_1
	var_2_5.path = var_2_1.lower("dorm3d/scenesres/scenes/" .. arg_2_0.sceneRootName .. "/" .. arg_2_0.sceneName .. "_scene")
	var_2_5.name = arg_2_0.sceneName
	var_2_4[1] = var_2_5

	local var_2_6 = {}

	string = var_5
	var_2_6.path = var_5.lower("dorm3d/character/" .. arg_2_0.timelineSceneRootName .. "/timeline/" .. arg_2_0.timelineSceneName .. "/" .. arg_2_0.timelineSceneName .. "_scene")
	var_2_6.name = arg_2_0.timelineSceneName
	var_2_4[2] = var_2_6
	arg_2_0.sceneInfo = var_2_4
	seriesAsync = var_2_4

	var_2_4({
		function(arg_3_0)
			SceneOpMgr = var_2_10001

			local var_3_0 = var_2_10001.Inst
			local var_3_1 = var_1.LoadSceneAsync
			local var_3_2 = arg_2_0.sceneInfo[1].path
			local var_3_3 = arg_2_0.sceneInfo[1].name

			LoadSceneMode = var_2_10006

			var_3_1(var_3_0, var_3_2, var_3_3, var_2_10006.Additive, function(arg_4_0, arg_4_1)
				SceneManager = var_3_10002

				var_3_10002.SetActiveScene(arg_4_0)
				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			SceneOpMgr = var_2_10001

			local var_5_0 = var_2_10001.Inst
			local var_5_1 = var_1.LoadSceneAsync
			local var_5_2 = arg_2_0.sceneInfo[2].path
			local var_5_3 = arg_2_0.sceneInfo[2].name

			LoadSceneMode = var_2_10006

			var_5_1(var_5_0, var_5_2, var_5_3, var_2_10006.Additive, function(arg_6_0, arg_6_1)
				arg_5_0()

				return
			end)

			return
		end
	}, arg_2_1)

	return
end

function var_0_1.init(arg_7_0)
	arg_7_0:InitScene()
	arg_7_0:InitUI()

	Dorm3dDanceConst = var_1
	arg_7_0.gameState = var_1.GAME_STATE.NONE
	CriWareMgr = var_1

	local var_7_0 = var_1.Inst

	arg_7_0.criatomPlayer = var_1.GetChannelData(var_7_0, "C_TIMELINE").channelPlayer.player
	GameObject = var_1

	local var_7_1 = var_1.Find("OverlayCamera").transform
	local var_7_2 = var_1.GetComponent

	typeof = var_1_10005
	Camera = var_1_10007
	arg_7_0.overlayCamera = var_7_2(var_7_1, var_1_10005(var_1_10007))
	arg_7_0.canvas = var_1:GetChild(0)
	pg = var_2

	local var_7_3 = var_2.BgmMgr.GetInstance()

	var_2.StopPlay(var_7_3)

	Dorm3dHxHelper = var_2

	local var_7_4 = var_2.GetTimelineMainCharacter()

	Dorm3dHxHelper = var_3

	var_3.ReplaceCharacterParts(var_7_4)

	Dorm3dHxHelper = var_3

	var_3.HideCharacterPart(var_7_4, nil, true)

	Dorm3dHxHelper = var_3

	var_3.ShowHolyLight({
		var_7_4
	}, arg_7_0.holyLightRoot)

	return
end

function var_0_1.InitUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.basePanel = var_1.Find(var_8_0, "Base")
	onButton = var_1

	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0._tf
	local var_8_3 = var_4.Find(var_8_2, "Base/BackBtn")

	local function var_8_4()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		BaseUI = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_BACK)

		return
	end

	SFX_DORM_BACK = var_8_2

	var_1(var_8_1, var_8_3, var_8_4, var_8_2)

	Dorm3dDancePrepareSubView = var_1

	local var_8_5 = var_1.New
	local var_8_6 = arg_8_0._tf
	local var_8_7 = var_3.Find(var_8_6, "Prepare")
	local var_8_8 = arg_8_0.event

	setmetatable = var_8_6
	arg_8_0.prepareView = var_8_5(var_8_7, var_8_8, var_8_6({}, {
		__index = arg_8_0.contextData
	}))
	Dorm3dDanceGameSubView = var_1

	local var_8_9 = var_1.New
	local var_8_10 = arg_8_0._tf
	local var_8_11 = var_3.Find(var_8_10, "Game")
	local var_8_12 = arg_8_0.event

	setmetatable = var_8_10
	arg_8_0.gameView = var_8_9(var_8_11, var_8_12, var_8_10({
		onSwitchCamera = function(arg_10_0)
			local var_10_0 = arg_8_0

			var_1.SwtichCamera(var_10_0, arg_10_0)

			return
		end,
		onTakePhoto = function()
			local var_11_0 = arg_8_0

			var_0.TakePhoto(var_11_0)

			return
		end,
		onEndGame = function()
			local var_12_0 = arg_8_0

			var_0.EndGame(var_12_0)

			return
		end,
		onShowOrHideBaseUI = function(arg_13_0)
			setActive = var_2_10001

			var_2_10001(arg_8_0.basePanel, arg_13_0)

			return
		end,
		onShowRealImage = function(arg_14_0, arg_14_1, arg_14_2)
			local var_14_0 = arg_8_0

			var_3.ShowRealImage(var_14_0, arg_14_0, arg_14_1, arg_14_2)

			return
		end,
		onShowPhotoWindow = function(arg_15_0)
			local var_15_0 = arg_8_0

			var_1.GamePause(var_15_0)

			local var_15_1 = arg_8_0.photoWindow

			var_1.Show(var_15_1)

			local var_15_2 = arg_8_0.photoWindow

			var_1.Flush(var_15_2, arg_15_0)

			return
		end
	}, {
		__index = arg_8_0.contextData
	}))
	Dorm3dDanceResultSubView = var_1

	local var_8_13 = var_1.New
	local var_8_14 = arg_8_0._tf
	local var_8_15 = var_3.Find(var_8_14, "Result")
	local var_8_16 = arg_8_0.event

	setmetatable = var_8_14
	arg_8_0.resultView = var_8_13(var_8_15, var_8_16, var_8_14({
		onAgain = function()
			local var_16_0 = arg_8_0

			var_0.InitData(var_16_0)

			local var_16_1 = arg_8_0

			var_0.PrepareGame(var_16_1)

			return
		end,
		onExit = function()
			local var_17_0 = arg_8_0
			local var_17_1 = var_0.emit

			BaseUI = var_2_10003

			var_17_1(var_17_0, var_2_10003.ON_BACK)

			return
		end,
		onShowRealImage = function(arg_18_0, arg_18_1, arg_18_2)
			local var_18_0 = arg_8_0

			var_3.ShowRealImage(var_18_0, arg_18_0, arg_18_1, arg_18_2)

			return
		end
	}, {
		__index = arg_8_0.contextData
	}))

	local var_8_17 = {}

	Dorm3dDanceConst = var_1_10002
	var_8_17[var_1_10002.VIEW_ENUM.PREPARE] = arg_8_0.prepareView
	Dorm3dDanceConst = var_2
	var_8_17[var_2.VIEW_ENUM.GAME] = arg_8_0.gameView
	Dorm3dDanceConst = var_2
	var_8_17[var_2.VIEW_ENUM.RESULT] = arg_8_0.resultView
	arg_8_0.viewDic = var_8_17
	Dorm3dDancePhotoWindow = var_8_17

	local var_8_18 = var_8_17.New
	local var_8_19 = arg_8_0._tf
	local var_8_20 = var_3.Find(var_8_19, "Photo")
	local var_8_21 = arg_8_0.event

	setmetatable = var_8_19
	arg_8_0.photoWindow = var_8_18(var_8_20, var_8_21, var_8_19({
		onHide = function()
			local var_19_0 = arg_8_0

			var_0.ShowOrHideUI(var_19_0, true)

			local var_19_1 = arg_8_0

			var_0.GameResume(var_19_1)

			return
		end,
		onShowRealImage = function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = arg_8_0

			var_3.ShowRealImage(var_20_0, arg_20_0, arg_20_1, arg_20_2)

			return
		end,
		onSaveImage = function(arg_21_0)
			local var_21_0 = arg_8_0

			var_1.SaveImage(var_21_0, arg_21_0)

			return
		end
	}, {
		__index = arg_8_0.contextData
	}))

	local var_8_22 = arg_8_0._tf

	arg_8_0.holyLightRoot = var_1.Find(var_8_22, "HolyLightRoot")

	return
end

function var_0_1.InitScene(arg_22_0)
	SceneManager = var_1_10001

	local var_22_0 = var_1_10001.GetSceneByName(arg_22_0.sceneName)
	local var_22_1 = var_1.GetRootGameObjects(var_22_0)

	table = var_1_10002

	var_1_10002.IpairsCArray(var_22_1, function(arg_23_0, arg_23_1)
		if arg_23_1.name == "MainCamera" then
			arg_22_0.mainCamera = arg_23_1.transform
		end

		return
	end)

	SceneManager = var_2

	local var_22_2 = var_2.GetSceneByName(arg_22_0.timelineSceneName)
	local var_22_3 = var_2.GetRootGameObjects(var_22_2)

	table = var_22_0

	var_22_0.IpairsCArray(var_22_3, function(arg_24_0, arg_24_1)
		if arg_24_1.name == arg_22_0.gameConfig.director_name then
			local var_24_0 = arg_22_0

			TimelinePlayer = var_3
			var_24_0.timelinePlayer = var_3.New(arg_24_1)
		elseif arg_24_1.name == "all_con" then
			local var_24_1 = arg_22_0
			local var_24_2 = arg_24_1.transform
			local var_24_3 = var_3.GetComponentInChildren

			typeof = var_2_10006
			Camera = var_2_10008
			var_24_1.timelineCamera = var_24_3(var_24_2, var_2_10006(var_2_10008))
			setActive = var_24_1

			var_24_1(arg_22_0.timelineCamera, false)
		end

		return
	end)

	arg_22_0.cmTracksDic = {}
	table = var_3

	local var_22_4 = var_3.IpairsCArray

	TimelineHelper = var_5

	var_22_4(var_5.GetTimelineTracks(arg_22_0.timelinePlayer.comDirector), function(arg_25_0, arg_25_1)
		_ = var_2_10002

		if var_2_10002.detect(arg_22_0.gameConfig.camera_tracks, function(arg_26_0)
			return arg_26_0 == arg_25_1.name
		end) then
			arg_22_0.cmTracksDic[arg_25_1.name] = arg_25_1
		end

		return
	end)

	local var_22_5 = arg_22_0.timelinePlayer

	var_3.Register(var_22_5, nil, function(arg_27_0, arg_27_1, arg_27_2)
		switch = var_2_10003

		var_2_10003(arg_27_1.stringParameter, {
			StartGame = function()
				local var_28_0 = arg_22_0.gameState

				Dorm3dDanceConst = var_3_10001

				if var_28_0 == var_3_10001.GAME_STATE.GAME then
					return
				end

				local var_28_1 = arg_22_0

				var_0.StartGame(var_28_1)

				return
			end,
			TimelinePlayOnTime = function()
				local var_29_0 = arg_27_0

				var_0.RawSetTime(var_29_0, arg_27_1.floatParameter)

				return
			end
		})

		return
	end)

	return
end

function var_0_1.didEnter(arg_30_0)
	arg_30_0:PrepareGame()

	return
end

function var_0_1.EnterView(arg_31_0, arg_31_1)
	pairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(arg_31_0.viewDic) do
		if iter_31_0 == arg_31_1 then
			iter_31_1:Show()
			iter_31_1:Flush()

			arg_31_0.currentView = iter_31_1
		else
			iter_31_1:Hide()
		end
	end

	return
end

function var_0_1.InitData(arg_32_0)
	arg_32_0.contextData.cucoloris = {}

	local var_32_0 = 1

	Dorm3dDanceConst = var_2

	for iter_32_0 = var_32_0, var_2.CUCOLORIS_COUNT do
		math = var_1_10005
		var_1_10005 = var_1_10005.random(1, #arg_32_0.gameConfig.cucoloris_group[iter_32_0])
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_32_1 = arg_32_0.contextData.cucoloris

		Dorm3dDanceCucoloris = var_1_10009

		var_1_10006(var_32_1, var_1_10009.New({
			configId = arg_32_0.gameConfig.cucoloris_group[iter_32_0][var_1_10005]
		}))
	end

	IsUnityEditor = var_32_0

	if var_32_0 then
		warning = var_32_0

		var_32_0("随机的剪影信息为：")

		local var_32_2 = 1

		Dorm3dDanceConst = var_2

		for iter_32_1 = var_32_2, var_2.CUCOLORIS_COUNT do
			warning = var_1_10005

			local var_32_3 = "ID" .. arg_32_0.contextData.cucoloris[iter_32_1].configId
			local var_32_4 = "时间"
			local var_32_5 = arg_32_0.contextData.cucoloris[iter_32_1]
			local var_32_6 = var_32_4 .. var_9.GetTime(var_32_5)
			local var_32_7 = "相机"
			local var_32_8 = arg_32_0.contextData.cucoloris[iter_32_1]

			var_1_10005(var_32_3, var_32_6, var_32_7 .. var_10.GetCamera(var_32_8))
		end
	end

	arg_32_0.contextData.photoData = {}
	arg_32_0.contextData.curCamera = arg_32_0.gameConfig.default_camera

	return
end

function var_0_1.PrepareGame(arg_33_0)
	Dorm3dDanceConst = var_1_10001
	arg_33_0.gameState = var_1_10001.GAME_STATE.PREPARE

	arg_33_0:InitData()

	local var_33_0 = arg_33_0
	local var_33_1 = arg_33_0.EnterView

	Dorm3dDanceConst = var_1_10004

	var_33_1(var_33_0, var_1_10004.VIEW_ENUM.PREPARE)

	setActive = var_33_1

	var_33_1(arg_33_0.mainCamera, false)

	setActive = var_33_1

	var_33_1(arg_33_0.timelineCamera, true)
	arg_33_0:SwtichCamera(arg_33_0.gameConfig.default_camera)

	local var_33_2 = arg_33_0.timelinePlayer

	var_1.Play(var_33_2)

	return
end

function var_0_1.StartGame(arg_34_0)
	local var_34_0 = arg_34_0.gameView

	var_1.ClearPhoto(var_34_0)

	Dorm3dDanceConst = var_1
	arg_34_0.gameState = var_1.GAME_STATE.GAME

	local var_34_1 = arg_34_0
	local var_34_2 = arg_34_0.EnterView

	Dorm3dDanceConst = var_1_10004

	var_34_2(var_34_1, var_1_10004.VIEW_ENUM.GAME)

	return
end

function var_0_1.EndGame(arg_35_0)
	arg_35_0:CalcScore()

	setActive = var_1

	var_1(arg_35_0.mainCamera, true)

	setActive = var_1

	var_1(arg_35_0.timelineCamera, false)

	local var_35_0 = arg_35_0.timelinePlayer

	var_1.Stop(var_35_0)

	Dorm3dDanceConst = var_1
	arg_35_0.gameState = var_1.GAME_STATE.RESULT

	local var_35_1 = arg_35_0
	local var_35_2 = arg_35_0.EnterView

	Dorm3dDanceConst = var_4

	var_35_2(var_35_1, var_4.VIEW_ENUM.RESULT)

	return
end

function var_0_1.CalcScore(arg_36_0)
	local var_36_0 = arg_36_0.contextData

	var_36_0.match = {}
	IsUnityEditor = var_36_0

	if var_36_0 then
		warning = var_36_0

		var_36_0("照片信息为：")

		var_36_0 = 1
		Dorm3dDanceConst = var_2

		for iter_36_0 = var_36_0, var_2.PHOTO_TIMES do
			local var_36_1 = arg_36_0.contextData.photoData[iter_36_0]

			warning = var_1_10006

			var_1_10006("ID " .. iter_36_0 .. " 时间 " .. var_36_1.time .. " 相机 " .. var_36_1.camera)
		end
	end

	IsUnityEditor = var_36_0

	if var_36_0 then
		warning = var_36_0

		var_36_0("二分图信息为")
	end

	local var_36_2 = {}
	local var_36_3 = 1

	Dorm3dDanceConst = var_1_10003

	for iter_36_1 = var_36_3, var_1_10003.CUCOLORIS_COUNT do
		local var_36_4 = arg_36_0.contextData.cucoloris[iter_36_1]
		local var_36_5 = 1

		Dorm3dDanceConst = var_1_10008

		for iter_36_2 = var_36_5, var_1_10008.PHOTO_TIMES do
			local var_36_6 = arg_36_0.contextData.photoData[iter_36_2]
			local var_36_7, var_36_8, var_36_9 = var_36_4:CalcScore(var_36_6)

			table = var_15

			var_15.insert(var_36_2, {
				iter_36_1,
				iter_36_2,
				var_36_7 + 1000 - var_36_9
			})

			IsUnityEditor = var_15

			if var_15 then
				warning = var_15

				var_15("剪影ID " .. iter_36_1 .. " 照片ID " .. iter_36_2 .. " 分数 " .. var_36_7 .. " 时间差 " .. var_36_9)
			end
		end
	end

	local var_36_10 = 0

	AlgorithmHelper = var_3

	local var_36_11 = var_3.KM

	Dorm3dDanceConst = iter_36_1

	local var_36_12, var_36_13 = var_36_11(iter_36_1.PHOTO_TIMES, var_36_2)
	local var_36_14 = 1

	Dorm3dDanceConst = var_6

	for iter_36_3 = var_36_14, var_6.CUCOLORIS_COUNT do
		var_1_10009 = arg_36_0.contextData.match
		var_1_10009[iter_36_3] = var_36_13[iter_36_3]

		local var_36_15 = arg_36_0.contextData.cucoloris[iter_36_3]
		local var_36_16, var_36_17

		var_1_10009, var_36_16, var_36_17 = var_1_10009.CalcScore(var_36_15, arg_36_0.contextData.photoData[var_36_13[iter_36_3]])
		var_36_10 = var_36_10 + var_1_10009
		IsUnityEditor = var_12

		if var_12 then
			warning = var_12

			var_12("剪影ID " .. iter_36_3 .. " 匹配照片ID " .. var_36_13[iter_36_3])
		end
	end

	pg = var_36_14

	local var_36_18 = var_36_14.m02
	local var_36_19 = var_5.sendNotification

	GAME = iter_36_3

	local var_36_20 = iter_36_3.APARTMENT_TRACK

	Dorm3dTrackCommand = var_1_10009

	var_36_19(var_36_18, var_36_20, var_1_10009.BuildDataDance(arg_36_0.contextData.groupId, var_36_10))

	return
end

function var_0_1.TakePhoto(arg_37_0)
	arg_37_0:GamePause()
	arg_37_0:ShowOrHideUI(false)

	local function var_37_0(arg_38_0)
		table = var_2_10001

		local var_38_0 = var_2_10001.insert
		local var_38_1 = arg_37_0.contextData.photoData
		local var_38_2 = {
			camera = arg_37_0.contextData.curCamera
		}
		local var_38_3 = arg_37_0.timelinePlayer

		var_38_2.time = var_5.GetTime(var_38_3)
		var_38_2.texture = arg_38_0

		var_38_0(var_38_1, var_38_2)

		local var_38_4 = arg_37_0.photoWindow

		var_1.Show(var_38_4)

		local var_38_5 = arg_37_0.photoWindow

		var_1.Flush(var_38_5, #arg_37_0.contextData.photoData, true)

		local var_38_6 = arg_37_0.gameView

		var_1.Flush(var_38_6)

		return
	end

	Dorm3dHxHelper = var_1_10002

	local var_37_1, var_37_2 = var_1_10002.GetHolyLightScreenShotInfo(arg_37_0.holyLightRoot)

	GraphicsInterface = var_4

	local var_37_3 = var_4.Instance

	var_4.TakePhotoWithPost(var_37_3, arg_37_0.timelineCamera, var_37_1, var_37_2, var_37_0)

	return
end

function var_0_1.GamePause(arg_39_0)
	local var_39_0 = arg_39_0.timelinePlayer

	var_1.SetSpeed(var_39_0, 0)

	local var_39_1 = arg_39_0.criatomPlayer

	var_1.SetVolume(var_39_1, 0)

	local var_39_2 = arg_39_0.criatomPlayer

	var_1.UpdateAll(var_39_2)

	return
end

function var_0_1.GameResume(arg_40_0)
	local var_40_0 = arg_40_0.timelinePlayer

	var_1.SetSpeed(var_40_0, 1)

	local var_40_1 = arg_40_0.criatomPlayer

	var_1.SetVolume(var_40_1, 1)

	local var_40_2 = arg_40_0.criatomPlayer

	var_1.UpdateAll(var_40_2)

	return
end

function var_0_1.ShowOrHideUI(arg_41_0, arg_41_1)
	if arg_41_1 then
		local var_41_0 = arg_41_0.currentView

		var_1_10002.Show(var_41_0)
	else
		local var_41_1 = arg_41_0.currentView

		var_1_10002.Hide(var_41_1)
	end

	setActive = var_1_10002

	var_1_10002(arg_41_0.basePanel, arg_41_1)

	return
end

function var_0_1.SwtichCamera(arg_42_0, arg_42_1)
	arg_42_0.cmTracksDic[arg_42_0.contextData.curCamera].muted = true
	arg_42_0.cmTracksDic[arg_42_1].muted = false

	local var_42_0 = arg_42_0.timelinePlayer
	local var_42_1 = var_2.SetTime
	local var_42_2 = arg_42_0.timelinePlayer

	var_42_1(var_42_0, var_5.GetTime(var_42_2))

	arg_42_0.contextData.curCamera = arg_42_1

	return
end

function var_0_1.ShowRealImage(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = arg_43_0.contextData.photoData[arg_43_1].texture
	local var_43_1 = arg_43_2
	local var_43_2 = arg_43_2.GetComponent

	typeof = var_1_10008
	RawImage = var_1_10010
	var_43_2(var_43_1, var_1_10008(var_1_10010)).texture = var_43_0
	arg_43_2.sizeDelta = arg_43_0.canvas.sizeDelta
	math = var_6

	local var_43_3 = var_6.max(arg_43_3.sizeDelta.x / arg_43_0.canvas.sizeDelta.x, arg_43_3.sizeDelta.y / arg_43_0.canvas.sizeDelta.y)

	Vector3 = var_43_1
	arg_43_2.localScale = var_43_1(var_43_3, var_43_3, 1)

	return
end

function var_0_1.SaveImage(arg_44_0, arg_44_1)
	local function var_44_0(arg_45_0)
		local var_45_0 = arg_44_1.sizeDelta.x / arg_44_0.canvas.sizeDelta.x

		Screen = var_2

		local var_45_1 = var_45_0 * var_2.width
		local var_45_2 = arg_44_1.sizeDelta.y / arg_44_0.canvas.sizeDelta.y

		Screen = var_3

		local var_45_3 = var_45_2 * var_3.height

		UnityEngine = var_3

		local var_45_4 = var_3.Texture2D.New(var_45_1, var_45_3)

		Screen = var_2_10004

		local var_45_5 = (var_2_10004.width - var_45_1) / 2

		Screen = var_5

		local var_45_6 = (var_5.height - var_45_3) / 2
		local var_45_7 = arg_45_0
		local var_45_8 = arg_45_0.GetPixels(var_45_7, var_45_5, var_45_6, var_45_1, var_45_3)

		var_45_4:SetPixels(var_45_8)
		var_45_4:Apply()

		Tex2DExtension = var_7

		local var_45_9 = var_7.EncodeToJPG(var_45_4)

		YSNormalTool = var_45_7

		var_45_7.MediaTool.SaveImageWithBytes(var_45_9, function(arg_46_0, arg_46_1)
			if arg_46_0 then
				pg = var_3_10002

				local var_46_0 = var_3_10002.TipsMgr.GetInstance()
				local var_46_1 = var_2.ShowTips

				i18n = var_3_10005

				var_46_1(var_46_0, var_3_10005("word_save_ok"))
			end

			return
		end)

		return
	end

	BLHX = var_1_10003

	var_1_10003.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(arg_44_0.overlayCamera, var_44_0)

	return
end

function var_0_1.willExit(arg_47_0)
	pairs = var_1_10001

	for iter_47_0, iter_47_1 in var_1_10001(arg_47_0.viewDic) do
		iter_47_1:Dispose()
	end

	local var_47_0 = arg_47_0.photoWindow

	var_1.Dispose(var_47_0)

	pg = var_1

	local var_47_1 = var_1.BgmMgr.GetInstance()

	var_1.ContinuePlay(var_47_1)

	underscore = var_1

	local var_47_2 = var_1.map(arg_47_0.sceneInfo, function(arg_48_0)
		return function(arg_49_0)
			SceneOpMgr = var_3_10001

			local var_49_0 = var_3_10001.Inst

			var_1.UnloadSceneAsync(var_49_0, arg_48_0.path, arg_48_0.name, arg_49_0)

			return
		end
	end)

	seriesAsync = var_2

	var_2(var_47_2, function()
		return
	end)

	return
end

return var_0_1
