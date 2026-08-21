local var_0_0 = class("Dorm3dDanceScene", import("view.dorm3d.Game.Dorm3dGameTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dDanceUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	arg_2_0.gameConfig = pg.dorm3d_dance[arg_2_0.contextData.groupId]

	arg_2_0:SetApartment(getProxy(ApartmentProxy):getApartment(arg_2_0.contextData.groupId))

	arg_2_0.sceneRootName = "publiccafe"
	arg_2_0.sceneName = "map_publiccafe_01_blue"
	arg_2_0.timelineSceneRootName = pg.dorm3d_dorm_template[arg_2_0.contextData.groupId].asset_name
	arg_2_0.timelineSceneName = arg_2_0.gameConfig.timeline_scene
	arg_2_0.sceneInfo = {
		{
			path = string.lower("dorm3d/scenesres/scenes/" .. arg_2_0.sceneRootName .. "/" .. arg_2_0.sceneName .. "_scene"),
			name = arg_2_0.sceneName
		},
		{
			path = string.lower("dorm3d/character/" .. arg_2_0.timelineSceneRootName .. "/timeline/" .. arg_2_0.timelineSceneName .. "/" .. arg_2_0.timelineSceneName .. "_scene"),
			name = arg_2_0.timelineSceneName
		}
	}

	seriesAsync({
		function(arg_3_0)
			SceneOpMgr.Inst:LoadSceneAsync(arg_2_0.sceneInfo[1].path, arg_2_0.sceneInfo[1].name, LoadSceneMode.Additive, function(arg_4_0, arg_4_1)
				SceneManager.SetActiveScene(arg_4_0)
				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			SceneOpMgr.Inst:LoadSceneAsync(arg_2_0.sceneInfo[2].path, arg_2_0.sceneInfo[2].name, LoadSceneMode.Additive, function(arg_6_0, arg_6_1)
				arg_5_0()

				return
			end)

			return
		end
	}, arg_2_1)

	return
end

function var_0_0.init(arg_7_0)
	arg_7_0:InitScene()
	arg_7_0:InitUI()

	arg_7_0.gameState = Dorm3dDanceConst.GAME_STATE.NONE
	arg_7_0.criatomPlayer = CriWareMgr.Inst:GetChannelData("C_TIMELINE").channelPlayer.player

	local var_7_0 = GameObject.Find("OverlayCamera").transform

	arg_7_0.overlayCamera = var_7_0:GetComponent(typeof(Camera))
	arg_7_0.canvas = var_7_0:GetChild(0)

	pg.BgmMgr.GetInstance():StopPlay()

	local var_7_1 = Dorm3dHxHelper.GetTimelineMainCharacter()

	Dorm3dHxHelper.ReplaceCharacterParts(var_7_1)
	Dorm3dHxHelper.HideCharacterPart(var_7_1, nil, true)
	Dorm3dHxHelper.ShowHolyLight({
		var_7_1
	}, arg_7_0.holyLightRoot)

	return
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0.basePanel = arg_8_0._tf:Find("Base")

	onButton(arg_8_0, arg_8_0._tf:Find("Base/BackBtn"), function()
		arg_8_0:emit(BaseUI.ON_BACK)

		return
	end, SFX_DORM_BACK)

	arg_8_0.prepareView = Dorm3dDancePrepareSubView.New(arg_8_0._tf:Find("Prepare"), arg_8_0.event, setmetatable({}, {
		__index = arg_8_0.contextData
	}))
	arg_8_0.gameView = Dorm3dDanceGameSubView.New(arg_8_0._tf:Find("Game"), arg_8_0.event, setmetatable({
		onSwitchCamera = function(arg_10_0)
			arg_8_0:SwtichCamera(arg_10_0)

			return
		end,
		onTakePhoto = function()
			arg_8_0:TakePhoto()

			return
		end,
		onEndGame = function()
			arg_8_0:EndGame()

			return
		end,
		onShowOrHideBaseUI = function(arg_13_0)
			setActive(arg_8_0.basePanel, arg_13_0)

			return
		end,
		onShowRealImage = function(arg_14_0, arg_14_1, arg_14_2)
			arg_8_0:ShowRealImage(arg_14_0, arg_14_1, arg_14_2)

			return
		end,
		onShowPhotoWindow = function(arg_15_0)
			arg_8_0:GamePause()
			arg_8_0.photoWindow:Show()
			arg_8_0.photoWindow:Flush(arg_15_0)

			return
		end
	}, {
		__index = arg_8_0.contextData
	}))
	arg_8_0.resultView = Dorm3dDanceResultSubView.New(arg_8_0._tf:Find("Result"), arg_8_0.event, setmetatable({
		onAgain = function()
			arg_8_0:InitData()
			arg_8_0:PrepareGame()

			return
		end,
		onExit = function()
			arg_8_0:emit(BaseUI.ON_BACK)

			return
		end,
		onShowRealImage = function(arg_18_0, arg_18_1, arg_18_2)
			arg_8_0:ShowRealImage(arg_18_0, arg_18_1, arg_18_2)

			return
		end
	}, {
		__index = arg_8_0.contextData
	}))
	arg_8_0.viewDic = {
		[Dorm3dDanceConst.VIEW_ENUM.PREPARE] = arg_8_0.prepareView,
		[Dorm3dDanceConst.VIEW_ENUM.GAME] = arg_8_0.gameView,
		[Dorm3dDanceConst.VIEW_ENUM.RESULT] = arg_8_0.resultView
	}
	arg_8_0.photoWindow = Dorm3dDancePhotoWindow.New(arg_8_0._tf:Find("Photo"), arg_8_0.event, setmetatable({
		onHide = function()
			arg_8_0:ShowOrHideUI(true)
			arg_8_0:GameResume()

			return
		end,
		onShowRealImage = function(arg_20_0, arg_20_1, arg_20_2)
			arg_8_0:ShowRealImage(arg_20_0, arg_20_1, arg_20_2)

			return
		end,
		onSaveImage = function(arg_21_0)
			arg_8_0:SaveImage(arg_21_0)

			return
		end
	}, {
		__index = arg_8_0.contextData
	}))
	arg_8_0.holyLightRoot = arg_8_0._tf:Find("HolyLightRoot")

	return
end

function var_0_0.InitScene(arg_22_0)
	table.IpairsCArray(SceneManager.GetSceneByName(arg_22_0.sceneName):GetRootGameObjects(), function(arg_23_0, arg_23_1)
		if arg_23_1.name == "MainCamera" then
			arg_22_0.mainCamera = arg_23_1.transform
		end

		return
	end)
	table.IpairsCArray(SceneManager.GetSceneByName(arg_22_0.timelineSceneName):GetRootGameObjects(), function(arg_24_0, arg_24_1)
		if arg_24_1.name == arg_22_0.gameConfig.director_name then
			arg_22_0.timelinePlayer = TimelinePlayer.New(arg_24_1)
		elseif arg_24_1.name == "all_con" then
			arg_22_0.timelineCamera = arg_24_1.transform:GetComponentInChildren(typeof(Camera))

			setActive(arg_22_0.timelineCamera, false)
		end

		return
	end)

	arg_22_0.cmTracksDic = {}

	table.IpairsCArray(TimelineHelper.GetTimelineTracks(arg_22_0.timelinePlayer.comDirector), function(arg_25_0, arg_25_1)
		if _.detect(arg_22_0.gameConfig.camera_tracks, function(arg_26_0)
			return arg_26_0 == arg_25_1.name
		end) then
			arg_22_0.cmTracksDic[arg_25_1.name] = arg_25_1
		end

		return
	end)
	arg_22_0.timelinePlayer:Register(nil, function(arg_27_0, arg_27_1, arg_27_2)
		switch(arg_27_1.stringParameter, {
			StartGame = function()
				if arg_22_0.gameState == Dorm3dDanceConst.GAME_STATE.GAME then
					return
				end

				arg_22_0:StartGame()

				return
			end,
			TimelinePlayOnTime = function()
				arg_27_0:RawSetTime(arg_27_1.floatParameter)

				return
			end
		})

		return
	end)

	return
end

function var_0_0.didEnter(arg_30_0)
	arg_30_0:PrepareGame()

	return
end

function var_0_0.EnterView(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.viewDic) do
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

function var_0_0.InitData(arg_32_0)
	arg_32_0.contextData.cucoloris = {}

	for iter_32_0 = 1, Dorm3dDanceConst.CUCOLORIS_COUNT do
		table.insert(arg_32_0.contextData.cucoloris, Dorm3dDanceCucoloris.New({
			configId = arg_32_0.gameConfig.cucoloris_group[iter_32_0][math.random(1, #arg_32_0.gameConfig.cucoloris_group[iter_32_0])]
		}))
	end

	if IsUnityEditor then
		warning("随机的剪影信息为：")

		for iter_32_1 = 1, Dorm3dDanceConst.CUCOLORIS_COUNT do
			warning("ID" .. arg_32_0.contextData.cucoloris[iter_32_1].configId, "时间" .. arg_32_0.contextData.cucoloris[iter_32_1]:GetTime(), "相机" .. arg_32_0.contextData.cucoloris[iter_32_1]:GetCamera())
		end
	end

	arg_32_0.contextData.photoData = {}
	arg_32_0.contextData.curCamera = arg_32_0.gameConfig.default_camera

	return
end

function var_0_0.PrepareGame(arg_33_0)
	arg_33_0.gameState = Dorm3dDanceConst.GAME_STATE.PREPARE

	arg_33_0:InitData()
	arg_33_0:EnterView(Dorm3dDanceConst.VIEW_ENUM.PREPARE)
	setActive(arg_33_0.mainCamera, false)
	setActive(arg_33_0.timelineCamera, true)
	arg_33_0:SwtichCamera(arg_33_0.gameConfig.default_camera)
	arg_33_0.timelinePlayer:Play()

	return
end

function var_0_0.StartGame(arg_34_0)
	arg_34_0.gameView:ClearPhoto()

	arg_34_0.gameState = Dorm3dDanceConst.GAME_STATE.GAME

	arg_34_0:EnterView(Dorm3dDanceConst.VIEW_ENUM.GAME)

	return
end

function var_0_0.EndGame(arg_35_0)
	arg_35_0:CalcScore()
	setActive(arg_35_0.mainCamera, true)
	setActive(arg_35_0.timelineCamera, false)
	arg_35_0.timelinePlayer:Stop()

	arg_35_0.gameState = Dorm3dDanceConst.GAME_STATE.RESULT

	arg_35_0:EnterView(Dorm3dDanceConst.VIEW_ENUM.RESULT)

	return
end

function var_0_0.CalcScore(arg_36_0)
	arg_36_0.contextData.match = {}

	if IsUnityEditor then
		warning("照片信息为：")

		for iter_36_0 = 1, Dorm3dDanceConst.PHOTO_TIMES do
			warning("ID " .. iter_36_0 .. " 时间 " .. arg_36_0.contextData.photoData[iter_36_0].time .. " 相机 " .. arg_36_0.contextData.photoData[iter_36_0].camera)
		end
	end

	if IsUnityEditor then
		warning("二分图信息为")
	end

	local var_36_0 = {}

	for iter_36_1 = 1, Dorm3dDanceConst.CUCOLORIS_COUNT do
		for iter_36_2 = 1, Dorm3dDanceConst.PHOTO_TIMES do
			local var_36_1, var_36_2, var_36_3 = arg_36_0.contextData.cucoloris[iter_36_1]:CalcScore(arg_36_0.contextData.photoData[iter_36_2])

			table.insert(var_36_0, {
				iter_36_1,
				iter_36_2,
				var_36_1 + 1000 - var_36_3
			})

			if IsUnityEditor then
				warning("剪影ID " .. iter_36_1 .. " 照片ID " .. iter_36_2 .. " 分数 " .. var_36_1 .. " 时间差 " .. var_36_3)
			end
		end
	end

	local var_36_4 = 0
	local var_36_5, var_36_6 = AlgorithmHelper.KM(Dorm3dDanceConst.PHOTO_TIMES, var_36_0)

	for iter_36_3 = 1, Dorm3dDanceConst.CUCOLORIS_COUNT do
		arg_36_0.contextData.match[iter_36_3] = var_36_6[iter_36_3]

		local var_36_7, var_36_8, var_36_9 = arg_36_0.contextData.cucoloris[iter_36_3]:CalcScore(arg_36_0.contextData.photoData[var_36_6[iter_36_3]])

		var_36_4 = var_36_4 + var_36_7

		if IsUnityEditor then
			warning("剪影ID " .. iter_36_3 .. " 匹配照片ID " .. var_36_6[iter_36_3])
		end
	end

	pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataDance(arg_36_0.contextData.groupId, var_36_4))

	return
end

function var_0_0.TakePhoto(arg_37_0)
	arg_37_0:GamePause()
	arg_37_0:ShowOrHideUI(false)

	local var_37_0, var_37_1 = Dorm3dHxHelper.GetHolyLightScreenShotInfo(arg_37_0.holyLightRoot)

	GraphicsInterface.Instance:TakePhotoWithPost(arg_37_0.timelineCamera, var_37_0, var_37_1, function(arg_38_0)
		table.insert(arg_37_0.contextData.photoData, {
			camera = arg_37_0.contextData.curCamera,
			time = arg_37_0.timelinePlayer:GetTime(),
			texture = arg_38_0
		})
		arg_37_0.photoWindow:Show()
		arg_37_0.photoWindow:Flush(#arg_37_0.contextData.photoData, true)
		arg_37_0.gameView:Flush()

		return
	end)

	return
end

function var_0_0.GamePause(arg_39_0)
	arg_39_0.timelinePlayer:SetSpeed(0)
	arg_39_0.criatomPlayer:SetVolume(0)
	arg_39_0.criatomPlayer:UpdateAll()

	return
end

function var_0_0.GameResume(arg_40_0)
	arg_40_0.timelinePlayer:SetSpeed(1)
	arg_40_0.criatomPlayer:SetVolume(1)
	arg_40_0.criatomPlayer:UpdateAll()

	return
end

function var_0_0.ShowOrHideUI(arg_41_0, arg_41_1)
	if arg_41_1 then
		arg_41_0.currentView:Show()
	else
		arg_41_0.currentView:Hide()
	end

	setActive(arg_41_0.basePanel, arg_41_1)

	return
end

function var_0_0.SwtichCamera(arg_42_0, arg_42_1)
	arg_42_0.cmTracksDic[arg_42_0.contextData.curCamera].muted = true
	arg_42_0.cmTracksDic[arg_42_1].muted = false

	arg_42_0.timelinePlayer:SetTime(arg_42_0.timelinePlayer:GetTime())

	arg_42_0.contextData.curCamera = arg_42_1

	return
end

function var_0_0.ShowRealImage(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_2:GetComponent(typeof(RawImage)).texture = arg_43_0.contextData.photoData[arg_43_1].texture
	arg_43_2.sizeDelta = arg_43_0.canvas.sizeDelta

	local var_43_0 = math.max(arg_43_3.sizeDelta.x / arg_43_0.canvas.sizeDelta.x, arg_43_3.sizeDelta.y / arg_43_0.canvas.sizeDelta.y)

	arg_43_2.localScale = Vector3(var_43_0, var_43_0, 1)

	return
end

function var_0_0.SaveImage(arg_44_0, arg_44_1)
	BLHX.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(arg_44_0.overlayCamera, function(arg_45_0)
		local var_45_0 = UnityEngine.Texture2D.New(arg_44_1.sizeDelta.x / arg_44_0.canvas.sizeDelta.x * Screen.width, arg_44_1.sizeDelta.y / arg_44_0.canvas.sizeDelta.y * Screen.height)

		var_45_0:SetPixels((arg_45_0:GetPixels((Screen.width - arg_44_1.sizeDelta.x / arg_44_0.canvas.sizeDelta.x * Screen.width) / 2, (Screen.height - arg_44_1.sizeDelta.y / arg_44_0.canvas.sizeDelta.y * Screen.height) / 2, arg_44_1.sizeDelta.x / arg_44_0.canvas.sizeDelta.x * Screen.width, arg_44_1.sizeDelta.y / arg_44_0.canvas.sizeDelta.y * Screen.height)))
		var_45_0:Apply()
		YSNormalTool.MediaTool.SaveImageWithBytes(Tex2DExtension.EncodeToJPG(var_45_0), function(arg_46_0, arg_46_1)
			if arg_46_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.willExit(arg_47_0)
	for iter_47_0, iter_47_1 in pairs(arg_47_0.viewDic) do
		iter_47_1:Dispose()
	end

	arg_47_0.photoWindow:Dispose()
	pg.BgmMgr.GetInstance():ContinuePlay()
	seriesAsync(underscore.map(arg_47_0.sceneInfo, function(arg_48_0)
		return function(arg_49_0)
			SceneOpMgr.Inst:UnloadSceneAsync(arg_48_0.path, arg_48_0.name, arg_49_0)

			return
		end
	end), function()
		return
	end)

	return
end

return var_0_0
