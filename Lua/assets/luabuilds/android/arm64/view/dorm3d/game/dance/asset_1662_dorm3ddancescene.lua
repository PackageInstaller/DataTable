local Dorm3dDanceScene = class("Dorm3dDanceScene", import("view.dorm3d.Game.Dorm3dGameTemplate"))

function Dorm3dDanceScene:getUIName()
	return "Dorm3dDanceUI"
end

function Dorm3dDanceScene:preload(arg_2_1)
	self.gameConfig = pg.dorm3d_dance[self.contextData.groupId]

	self:SetApartment(getProxy(ApartmentProxy):getApartment(self.contextData.groupId))

	self.sceneRootName = "publiccafe"
	self.sceneName = "map_publiccafe_01_blue"
	self.timelineSceneRootName = pg.dorm3d_dorm_template[self.contextData.groupId].asset_name
	self.timelineSceneName = self.gameConfig.timeline_scene
	self.sceneInfo = {
		{
			path = string.lower("dorm3d/scenesres/scenes/" .. self.sceneRootName .. "/" .. self.sceneName .. "_scene"),
			name = self.sceneName
		},
		{
			path = string.lower("dorm3d/character/" .. self.timelineSceneRootName .. "/timeline/" .. self.timelineSceneName .. "/" .. self.timelineSceneName .. "_scene"),
			name = self.timelineSceneName
		}
	}

	seriesAsync({
		function(arg_3_0)
			SceneOpMgr.Inst:LoadSceneAsync(self.sceneInfo[1].path, self.sceneInfo[1].name, LoadSceneMode.Additive, function(arg_4_0, arg_4_1)
				SceneManager.SetActiveScene(arg_4_0)
				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			SceneOpMgr.Inst:LoadSceneAsync(self.sceneInfo[2].path, self.sceneInfo[2].name, LoadSceneMode.Additive, function(arg_6_0, arg_6_1)
				arg_5_0()

				return
			end)

			return
		end
	}, arg_2_1)

	return
end

function Dorm3dDanceScene:init()
	self:InitScene()
	self:InitUI()

	self.gameState = Dorm3dDanceConst.GAME_STATE.NONE
	self.criatomPlayer = CriWareMgr.Inst:GetChannelData("C_TIMELINE").channelPlayer.player

	local var_7_0 = GameObject.Find("OverlayCamera").transform

	self.overlayCamera = var_7_0:GetComponent(typeof(Camera))
	self.canvas = var_7_0:GetChild(0)

	pg.BgmMgr.GetInstance():StopPlay()

	local var_7_1 = Dorm3dHxHelper.GetTimelineMainCharacter()

	Dorm3dHxHelper.ReplaceCharacterParts(var_7_1)
	Dorm3dHxHelper.HideCharacterPart(var_7_1, nil, true)
	Dorm3dHxHelper.ShowHolyLight({
		var_7_1
	}, self.holyLightRoot)

	return
end

function Dorm3dDanceScene:InitUI()
	self.basePanel = self._tf:Find("Base")

	onButton(self, self._tf:Find("Base/BackBtn"), function()
		self:emit(BaseUI.ON_BACK)

		return
	end, SFX_DORM_BACK)

	self.prepareView = Dorm3dDancePrepareSubView.New(self._tf:Find("Prepare"), self.event, setmetatable({}, {
		__index = self.contextData
	}))
	self.gameView = Dorm3dDanceGameSubView.New(self._tf:Find("Game"), self.event, setmetatable({
		onSwitchCamera = function(arg_10_0)
			self:SwtichCamera(arg_10_0)

			return
		end,
		onTakePhoto = function()
			self:TakePhoto()

			return
		end,
		onEndGame = function()
			self:EndGame()

			return
		end,
		onShowOrHideBaseUI = function(arg_13_0)
			setActive(self.basePanel, arg_13_0)

			return
		end,
		onShowRealImage = function(arg_14_0, arg_14_1, arg_14_2)
			self:ShowRealImage(arg_14_0, arg_14_1, arg_14_2)

			return
		end,
		onShowPhotoWindow = function(arg_15_0)
			self:GamePause()
			self.photoWindow:Show()
			self.photoWindow:Flush(arg_15_0)

			return
		end
	}, {
		__index = self.contextData
	}))
	self.resultView = Dorm3dDanceResultSubView.New(self._tf:Find("Result"), self.event, setmetatable({
		onAgain = function()
			self:InitData()
			self:PrepareGame()

			return
		end,
		onExit = function()
			self:emit(BaseUI.ON_BACK)

			return
		end,
		onShowRealImage = function(arg_18_0, arg_18_1, arg_18_2)
			self:ShowRealImage(arg_18_0, arg_18_1, arg_18_2)

			return
		end
	}, {
		__index = self.contextData
	}))
	self.viewDic = {
		[Dorm3dDanceConst.VIEW_ENUM.PREPARE] = self.prepareView,
		[Dorm3dDanceConst.VIEW_ENUM.GAME] = self.gameView,
		[Dorm3dDanceConst.VIEW_ENUM.RESULT] = self.resultView
	}
	self.photoWindow = Dorm3dDancePhotoWindow.New(self._tf:Find("Photo"), self.event, setmetatable({
		onHide = function()
			self:ShowOrHideUI(true)
			self:GameResume()

			return
		end,
		onShowRealImage = function(arg_20_0, arg_20_1, arg_20_2)
			self:ShowRealImage(arg_20_0, arg_20_1, arg_20_2)

			return
		end,
		onSaveImage = function(arg_21_0)
			self:SaveImage(arg_21_0)

			return
		end
	}, {
		__index = self.contextData
	}))
	self.holyLightRoot = self._tf:Find("HolyLightRoot")

	return
end

function Dorm3dDanceScene:InitScene()
	table.IpairsCArray(SceneManager.GetSceneByName(self.sceneName):GetRootGameObjects(), function(arg_23_0, arg_23_1)
		if arg_23_1.name == "MainCamera" then
			self.mainCamera = arg_23_1.transform
		end

		return
	end)
	table.IpairsCArray(SceneManager.GetSceneByName(self.timelineSceneName):GetRootGameObjects(), function(arg_24_0, arg_24_1)
		if arg_24_1.name == self.gameConfig.director_name then
			self.timelinePlayer = TimelinePlayer.New(arg_24_1)
		elseif arg_24_1.name == "all_con" then
			self.timelineCamera = arg_24_1.transform:GetComponentInChildren(typeof(Camera))

			setActive(self.timelineCamera, false)
		end

		return
	end)

	self.cmTracksDic = {}

	table.IpairsCArray(TimelineHelper.GetTimelineTracks(self.timelinePlayer.comDirector), function(arg_25_0, arg_25_1)
		if _.detect(self.gameConfig.camera_tracks, function(arg_26_0)
			return arg_26_0 == arg_25_1.name
		end) then
			self.cmTracksDic[arg_25_1.name] = arg_25_1
		end

		return
	end)
	self.timelinePlayer:Register(nil, function(arg_27_0, arg_27_1, arg_27_2)
		switch(arg_27_1.stringParameter, {
			StartGame = function()
				if self.gameState == Dorm3dDanceConst.GAME_STATE.GAME then
					return
				end

				self:StartGame()

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

function Dorm3dDanceScene:didEnter()
	self:PrepareGame()

	return
end

function Dorm3dDanceScene:EnterView(arg_31_1)
	for iter_31_0, iter_31_1 in pairs(self.viewDic) do
		if iter_31_0 == arg_31_1 then
			iter_31_1:Show()
			iter_31_1:Flush()

			self.currentView = iter_31_1
		else
			iter_31_1:Hide()
		end
	end

	return
end

function Dorm3dDanceScene:InitData()
	self.contextData.cucoloris = {}

	for iter_32_0 = 1, Dorm3dDanceConst.CUCOLORIS_COUNT do
		table.insert(self.contextData.cucoloris, Dorm3dDanceCucoloris.New({
			configId = self.gameConfig.cucoloris_group[iter_32_0][math.random(1, #self.gameConfig.cucoloris_group[iter_32_0])]
		}))
	end

	if IsUnityEditor then
		warning("随机的剪影信息为：")

		for iter_32_1 = 1, Dorm3dDanceConst.CUCOLORIS_COUNT do
			warning("ID" .. self.contextData.cucoloris[iter_32_1].configId, "时间" .. self.contextData.cucoloris[iter_32_1]:GetTime(), "相机" .. self.contextData.cucoloris[iter_32_1]:GetCamera())
		end
	end

	self.contextData.photoData = {}
	self.contextData.curCamera = self.gameConfig.default_camera

	return
end

function Dorm3dDanceScene:PrepareGame()
	self.gameState = Dorm3dDanceConst.GAME_STATE.PREPARE

	self:InitData()
	self:EnterView(Dorm3dDanceConst.VIEW_ENUM.PREPARE)
	setActive(self.mainCamera, false)
	setActive(self.timelineCamera, true)
	self:SwtichCamera(self.gameConfig.default_camera)
	self.timelinePlayer:Play()

	return
end

function Dorm3dDanceScene:StartGame()
	self.gameView:ClearPhoto()

	self.gameState = Dorm3dDanceConst.GAME_STATE.GAME

	self:EnterView(Dorm3dDanceConst.VIEW_ENUM.GAME)

	return
end

function Dorm3dDanceScene:EndGame()
	self:CalcScore()
	setActive(self.mainCamera, true)
	setActive(self.timelineCamera, false)
	self.timelinePlayer:Stop()

	self.gameState = Dorm3dDanceConst.GAME_STATE.RESULT

	self:EnterView(Dorm3dDanceConst.VIEW_ENUM.RESULT)

	return
end

function Dorm3dDanceScene:CalcScore()
	self.contextData.match = {}

	if IsUnityEditor then
		warning("照片信息为：")

		for iter_36_0 = 1, Dorm3dDanceConst.PHOTO_TIMES do
			warning("ID " .. iter_36_0 .. " 时间 " .. self.contextData.photoData[iter_36_0].time .. " 相机 " .. self.contextData.photoData[iter_36_0].camera)
		end
	end

	if IsUnityEditor then
		warning("二分图信息为")
	end

	local var_36_0 = {}

	for iter_36_1 = 1, Dorm3dDanceConst.CUCOLORIS_COUNT do
		for iter_36_2 = 1, Dorm3dDanceConst.PHOTO_TIMES do
			local var_36_1, var_36_2, var_36_3 = self.contextData.cucoloris[iter_36_1]:CalcScore(self.contextData.photoData[iter_36_2])

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
		self.contextData.match[iter_36_3] = var_36_6[iter_36_3]

		local var_36_7, var_36_8, var_36_9 = self.contextData.cucoloris[iter_36_3]:CalcScore(self.contextData.photoData[var_36_6[iter_36_3]])

		var_36_4 = var_36_4 + var_36_7

		if IsUnityEditor then
			warning("剪影ID " .. iter_36_3 .. " 匹配照片ID " .. var_36_6[iter_36_3])
		end
	end

	pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataDance(self.contextData.groupId, var_36_4))

	return
end

function Dorm3dDanceScene:TakePhoto()
	self:GamePause()
	self:ShowOrHideUI(false)

	local var_37_0, var_37_1 = Dorm3dHxHelper.GetHolyLightScreenShotInfo(self.holyLightRoot)

	GraphicsInterface.Instance:TakePhotoWithPost(self.timelineCamera, var_37_0, var_37_1, function(arg_38_0)
		table.insert(self.contextData.photoData, {
			camera = self.contextData.curCamera,
			time = self.timelinePlayer:GetTime(),
			texture = arg_38_0
		})
		self.photoWindow:Show()
		self.photoWindow:Flush(#self.contextData.photoData, true)
		self.gameView:Flush()

		return
	end)

	return
end

function Dorm3dDanceScene:GamePause()
	self.timelinePlayer:SetSpeed(0)
	self.criatomPlayer:SetVolume(0)
	self.criatomPlayer:UpdateAll()

	return
end

function Dorm3dDanceScene:GameResume()
	self.timelinePlayer:SetSpeed(1)
	self.criatomPlayer:SetVolume(1)
	self.criatomPlayer:UpdateAll()

	return
end

function Dorm3dDanceScene:ShowOrHideUI(arg_41_1)
	if arg_41_1 then
		self.currentView:Show()
	else
		self.currentView:Hide()
	end

	setActive(self.basePanel, arg_41_1)

	return
end

function Dorm3dDanceScene:SwtichCamera(arg_42_1)
	self.cmTracksDic[self.contextData.curCamera].muted = true
	self.cmTracksDic[arg_42_1].muted = false

	self.timelinePlayer:SetTime(self.timelinePlayer:GetTime())

	self.contextData.curCamera = arg_42_1

	return
end

function Dorm3dDanceScene:ShowRealImage(arg_43_1, arg_43_2, arg_43_3)
	arg_43_2:GetComponent(typeof(RawImage)).texture = self.contextData.photoData[arg_43_1].texture
	arg_43_2.sizeDelta = self.canvas.sizeDelta

	local var_43_0 = math.max(arg_43_3.sizeDelta.x / self.canvas.sizeDelta.x, arg_43_3.sizeDelta.y / self.canvas.sizeDelta.y)

	arg_43_2.localScale = Vector3(var_43_0, var_43_0, 1)

	return
end

function Dorm3dDanceScene:SaveImage(arg_44_1)
	BLHX.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(self.overlayCamera, function(arg_45_0)
		local var_45_0 = UnityEngine.Texture2D.New(arg_44_1.sizeDelta.x / self.canvas.sizeDelta.x * Screen.width, arg_44_1.sizeDelta.y / self.canvas.sizeDelta.y * Screen.height)

		var_45_0:SetPixels((arg_45_0:GetPixels((Screen.width - arg_44_1.sizeDelta.x / self.canvas.sizeDelta.x * Screen.width) / 2, (Screen.height - arg_44_1.sizeDelta.y / self.canvas.sizeDelta.y * Screen.height) / 2, arg_44_1.sizeDelta.x / self.canvas.sizeDelta.x * Screen.width, arg_44_1.sizeDelta.y / self.canvas.sizeDelta.y * Screen.height)))
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

function Dorm3dDanceScene:willExit()
	for iter_47_0, iter_47_1 in pairs(self.viewDic) do
		iter_47_1:Dispose()
	end

	self.photoWindow:Dispose()
	pg.BgmMgr.GetInstance():ContinuePlay()
	seriesAsync(underscore.map(self.sceneInfo, function(arg_48_0)
		return function(arg_49_0)
			SceneOpMgr.Inst:UnloadSceneAsync(arg_48_0.path, arg_48_0.name, arg_49_0)

			return
		end
	end), function()
		return
	end)

	return
end

return Dorm3dDanceScene
