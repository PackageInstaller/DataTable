local IslandCheaterTavernPlayRoomInfoPage = class("IslandCheaterTavernPlayRoomInfoPage", import("...page.temp.IslandExternalBridgePage"))

function IslandCheaterTavernPlayRoomInfoPage:AddListeners()
	self:AddListener(GAME.PLAY_ROOM_ALL_LOAD_OVER, self.OnRoomAllLoadDone)
	self:AddListener(GAME.PLAY_ROOM_REDAY_ROOM_REFRESH, self.OnRefreshModel)
	self:AddListener(GAME.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH, self.OnRefreshModel)
	self:AddListener(GAME.ISLAND_CHEATER_CHANGE_VIEW_DRESSID, self.OnRefreshModel)
	self:AddListener(GAME.PLAY_ROOM_ENTER_LOAD, self.OnRefreshModel)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:RemoveListeners()
	self:RemoveListener(GAME.PLAY_ROOM_ALL_LOAD_OVER, self.OnRoomAllLoadDone)
	self:RemoveListener(GAME.PLAY_ROOM_REDAY_ROOM_REFRESH, self.OnRefreshModel)
	self:RemoveListener(GAME.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH, self.OnRefreshModel)
	self:RemoveListener(GAME.ISLAND_CHEATER_CHANGE_VIEW_DRESSID, self.OnRefreshModel)
	self:RemoveListener(GAME.PLAY_ROOM_ENTER_LOAD, self.OnRefreshModel)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:getUIName()
	return "IslandCheaterTavernPlayRoomInfoDisplayUI"
end

function IslandCheaterTavernPlayRoomInfoPage:OnLoaded()
	local var_4_0 = self._tf:Find("adapt/playerList")

	self.playerCharTF = {}

	for iter_4_0 = 1, 4 do
		self.playerCharTF[iter_4_0] = var_4_0:Find("playerItem" .. iter_4_0):Find("charPos")
	end

	return
end

function IslandCheaterTavernPlayRoomInfoPage:OnShow(arg_5_1)
	self.sceneRoomType = arg_5_1

	self:AddSubLayers(self:GetContext())

	self.isExit = false
	self.playerIndexDic = {}
	self.modelDataDic = {}

	self:LoadRoomPlayerModel()

	self.unReadyEffectList = {}
	self.readyEffectList = {}

	self:LoadLightEffect(self.playerSlotCount)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:GetContext()
	return Context.New({
		mediator = PlayRoomInfoMediator,
		viewComponent = PlayRoomInfoScene
	})
end

function IslandCheaterTavernPlayRoomInfoPage:AddSubLayers(arg_7_1)
	arg_7_1.data = {
		container = self._tf,
		onClose = function()
			pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_9_0)
				self:Hide()
				arg_9_0()

				return
			end)

			return
		end,
		sceneRoomType = self.sceneRoomType
	}

	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(IslandMediator),
		context = arg_7_1
	})

	return
end

function IslandCheaterTavernPlayRoomInfoPage:OnRoomAllLoadDone()
	IslandCheaterTavernRecordTools.StartGame()

	return
end

function IslandCheaterTavernPlayRoomInfoPage:OnRefreshModel()
	self:LoadRoomPlayerModel()
	self:RefreshLight()

	return
end

function IslandCheaterTavernPlayRoomInfoPage:RefreshLight()
	local var_12_0 = getProxy(PlayRoomProxy)
	local var_12_1 = self.playRoomProxy:GetGameLoadData()

	if var_12_1 == nil then
		if self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.CustomRoom then
			var_12_1 = var_12_0:GetRoomData()
		elseif self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.MatchInfoRoom then
			var_12_1 = var_12_0:GetMatchRoomData()
		end
	end

	if var_12_1 == nil then
		return
	end

	local var_12_2 = var_12_1.teamPosList

	for iter_12_0 = 1, self.playerSlotCount do
		if var_12_2[iter_12_0] and var_12_2[iter_12_0][1] then
			if self.playRoomProxy:GetGameLoadData() or table.keyof(var_12_1.readyList, var_12_2[iter_12_0][1]) then
				setActive(self.unReadyEffectList[iter_12_0], false)
				setActive(self.readyEffectList[iter_12_0], true)
			else
				setActive(self.unReadyEffectList[iter_12_0], true)
				setActive(self.readyEffectList[iter_12_0], false)
			end
		else
			setActive(self.unReadyEffectList[iter_12_0], false)
			setActive(self.readyEffectList[iter_12_0], false)
		end
	end

	return
end

function IslandCheaterTavernPlayRoomInfoPage:LoadRoomPlayerModel()
	self.playRoomProxy = getProxy(PlayRoomProxy)

	local var_13_0 = self.playRoomProxy:GetGameLoadData()

	if var_13_0 == nil then
		if self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.CustomRoom then
			var_13_0 = self.playRoomProxy:GetRoomData()
		elseif self.sceneRoomType == IslandCheaterTavernConst.SceneRoomType.MatchInfoRoom then
			var_13_0 = self.playRoomProxy:GetMatchRoomData()
		end
	end

	if var_13_0 == nil then
		return
	end

	local var_13_1 = var_13_0.teamPosList

	self.playerSlotCount = PlayRoomTools.GetMaxTeamCnt(var_13_0.gameType)
	self.dressHelperDic = {}

	for iter_13_0 = 1, self.playerSlotCount do
		if var_13_1[iter_13_0] then
			if var_13_0.playerDataList[var_13_1[iter_13_0][1]] then
				self.playerIndexDic[iter_13_0] = var_13_1[iter_13_0][1]

				local var_13_2 = PlayRoomTools.GetGameViewID(var_13_0.playerDataList[var_13_1[iter_13_0][1]].user_view)

				if not self.dressHelperDic[iter_13_0] then
					self.dressHelperDic[iter_13_0] = IslandShipDressHelperMiniGameNew.New()

					self.dressHelperDic[iter_13_0]:SetShipId(var_13_2.ship_id, var_13_2.dress_list or {})
				end

				self:LoadCharacter(iter_13_0, (CheaterTavernHelper.GetModelDataByViewData(var_13_2)))
			else
				self:UnloadCharacter(iter_13_0)
			end
		end
	end

	return
end

function IslandCheaterTavernPlayRoomInfoPage:Preload(arg_14_1)
	self:PrepareCharacterScene(arg_14_1)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:PrepareCharacterScene(arg_15_1)
	self.isLoadCharacterScene = true

	seriesAsync({
		function(arg_16_0)
			self:CreateCharacterContainer()
			self:LoadCharacterScene(arg_16_0)

			return
		end,
		function(arg_17_0)
			self:ModifyCameraMask()
			self:ActivityCharacterCamera()
			self:InitSceneTimeline()
			arg_17_0()

			return
		end
	}, arg_15_1)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:CreateCharacterContainer()
	self.roleContainer = GameObject.New("roleContainer").transform

	pg.ViewUtils.SetLayer(self.roleContainer, Layer.Character3D)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:ModifyCameraMask()
	local var_19_1 = ((IsNil(IslandCameraMgr.instance) or nil) and CheatTavernCameraMgr.instance)._mainCamera

	self.defaultCullingMask = ((IsNil(IslandCameraMgr.instance) or nil) and CheatTavernCameraMgr.instance)._mainCamera.cullingMask

	LuaHelper.SetCamCullingMask(var_19_1, "Character3D")

	return
end

function IslandCheaterTavernPlayRoomInfoPage:ActivityCharacterCamera()
	local var_20_0 = self:GetActiveCamName()
	local var_20_1 = IslandCameraMgr.instance

	if IsNil(IslandCameraMgr.instance) then
		var_20_1 = CheatTavernCameraMgr.instance
	end

	local var_20_2 = var_20_1:GetVirtualCamera(var_20_0)

	var_20_2.Follow = self.roleContainer
	var_20_2.LookAt = self.roleContainer

	var_20_1:ActiveVirtualCamera(var_20_0)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:InitSceneTimeline()
	local var_21_0 = GameObject.Find("[sequence]")

	if var_21_0 then
		local var_21_1 = var_21_0:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

		TimelineSupport.DynamicBinding(var_21_1)
		var_21_1:Play()
	end

	return
end

function IslandCheaterTavernPlayRoomInfoPage:ClearCharacterScene(arg_22_1)
	self.isExit = true

	if self.isLoadCharacterScene then
		self:UnLoadLightEffect()
		self:ClearCharacterContainer()
		self:UnLoadCharacterScene(function()
			self:ActivityPlayerCamera()
			existCall(arg_22_1)

			return
		end)
		self:ResetCameraMask()
		self:emitCore(ISLAND_EVT.REFRESH_WEATHER_SYSTEM)
	end

	self.playerIndexDic = {}
	self.modelDataDic = {}
	self.isLoadCharacterScene = false

	return
end

function IslandCheaterTavernPlayRoomInfoPage:OnHome()
	self:ClearCharacterScene(function()
		self:emit(BaseUI.ON_HOME)

		return
	end)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:LoadCharacter(arg_26_1, arg_26_2)
	self:UnloadCharacter(arg_26_1)

	self.modelDataDic[arg_26_1] = self.modelDataDic[arg_26_1] or {}
	self.modelDataDic[arg_26_1].modelData = arg_26_2

	self:_LoadModel(arg_26_2, function(arg_27_0)
		if self.modelDataDic[arg_26_1] == nil or self.modelDataDic[arg_26_1].modelData.model ~= arg_26_2.model then
			self:GetPoolMgr():ReturnCharacter(arg_26_2.model, arg_26_2.animator, arg_27_0)

			return
		end

		local var_27_0 = arg_27_0

		GetOrAddComponent(arg_27_0, typeof(CharacterHandleController))

		self.modelDataDic[arg_26_1].role = var_27_0

		pg.ViewUtils.SetLayer(var_27_0.transform, Layer.Character3D)
		setParent(var_27_0, self.roleContainer)

		var_27_0.transform.eulerAngles = Vector3(0, 180, 0)

		local var_27_1 = GameObject.Find("UICamera"):GetComponent(typeof(Camera)):WorldToScreenPoint(self.playerCharTF[arg_26_1].position)
		local var_27_3 = ((IsNil(IslandCameraMgr.instance) or nil) and CheatTavernCameraMgr.instance)._mainCamera:ScreenToWorldPoint(Vector3(var_27_1.x, var_27_1.y, 10))

		var_27_0.transform.localPosition = Vector3(var_27_3.x, var_27_3.y + 0.4, var_27_3.z)

		self:OnCharLoaded(arg_26_1, arg_26_2)

		return
	end)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:_LoadModel(arg_28_1, arg_28_2)
	pg.UIMgr.GetInstance():LoadingOn()
	self:GetPoolMgr():GetCharacter(arg_28_1.model, arg_28_1.animator, function(arg_29_0)
		arg_28_2(arg_29_0)
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:UnloadCharacter(arg_30_1)
	if self.modelDataDic[arg_30_1] and self.modelDataDic[arg_30_1].role then
		pg.ViewUtils.SetLayer(self.modelDataDic[arg_30_1].role.transform, Layer.Default)
		self:GetPoolMgr():ReturnCharacter(self.modelDataDic[arg_30_1].modelData.model, self.modelDataDic[arg_30_1].modelData.animator, self.modelDataDic[arg_30_1].role)
	end

	self.modelDataDic[arg_30_1] = nil
	self.playerIndexDic[arg_30_1] = nil

	return
end

function IslandCheaterTavernPlayRoomInfoPage:LoadLightEffect(arg_31_1)
	arg_31_1 = arg_31_1 or 0

	local var_31_0, var_31_1 = self:GetLigthEffectPath()
	local var_31_2 = {}

	for iter_31_0 = 1, arg_31_1 do
		local var_31_3 = GameObject.Find("UICamera"):GetComponent(typeof(Camera)):WorldToScreenPoint(self.playerCharTF[iter_31_0].position)
		local var_31_5 = ((IsNil(IslandCameraMgr.instance) or nil) and CheatTavernCameraMgr.instance)._mainCamera:ScreenToWorldPoint(Vector3(var_31_3.x, var_31_3.y, 10))
		local var_31_6 = Vector3(var_31_5.x, var_31_5.y + 0.4, var_31_5.z)

		table.insert(var_31_2, function(arg_32_0)
			self:GetPoolMgr():GetSceneProductEffect(var_31_0, function(arg_33_0)
				if self.isExit then
					self:GetPoolMgr():ReturnSceneProductEffect(var_31_0, arg_33_0)
				else
					setActive(arg_33_0, false)

					arg_33_0.transform.localPosition = var_31_6

					setParent(arg_33_0, self.roleContainer)

					self.unReadyEffectList[iter_31_0] = arg_33_0
				end

				arg_32_0()

				return
			end)

			return
		end)
		table.insert(var_31_2, function(arg_34_0)
			self:GetPoolMgr():GetSceneProductEffect(var_31_1, function(arg_35_0)
				if self.isExit then
					self:GetPoolMgr():ReturnSceneProductEffect(var_31_1, arg_35_0)
				else
					setActive(arg_35_0, false)
					setParent(arg_35_0, self.roleContainer)

					arg_35_0.transform.localPosition = var_31_6
					self.readyEffectList[iter_31_0] = arg_35_0
				end

				arg_34_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_31_2, function()
		self:RefreshLight()

		return
	end)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:UnLoadLightEffect()
	local var_37_0, var_37_1 = self:GetLigthEffectPath()

	for iter_37_0, iter_37_1 in ipairs(self.readyEffectList) do
		self:GetPoolMgr():ReturnSceneProductEffect(var_37_1, iter_37_1)
	end

	self.readyEffectList = {}

	for iter_37_2, iter_37_3 in ipairs(self.unReadyEffectList) do
		self:GetPoolMgr():ReturnSceneProductEffect(var_37_0, iter_37_3)
	end

	self.unReadyEffectList = {}

	return
end

function IslandCheaterTavernPlayRoomInfoPage:ClearCharacterContainer()
	for iter_38_0, iter_38_1 in ipairs(self.dressHelperDic or {}) do
		iter_38_1:Destroy()
	end

	for iter_38_2 = 1, self.playerSlotCount or 0 do
		self:UnloadCharacter(iter_38_2)
	end

	if not IsNil(self.roleContainer) then
		Object.Destroy(self.roleContainer.gameObject)

		self.roleContainer = nil
	end

	return
end

function IslandCheaterTavernPlayRoomInfoPage:ResetCameraMask()
	local var_39_0 = IslandCameraMgr.instance

	if IsNil(IslandCameraMgr.instance) then
		var_39_0 = CheatTavernCameraMgr.instance
	end

	if self.defaultCullingMask and var_39_0 then
		LuaHelper.ResetCamCullingMask(var_39_0._mainCamera, self.defaultCullingMask)
	end

	return
end

function IslandCheaterTavernPlayRoomInfoPage:ActivityPlayerCamera()
	if not IslandCameraMgr.instance then
		return
	end

	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:OnHide()
	IslandCheaterTavernPlayRoomInfoPage.super.OnHide(self)
	self:ClearCharacterScene()

	return
end

function IslandCheaterTavernPlayRoomInfoPage:OnDisable()
	self:RemoveSubLayers(self:GetContext())
	self:ClearCharacterScene()

	return
end

function IslandCheaterTavernPlayRoomInfoPage:OnDestroy()
	self:ClearCharacterScene()

	for iter_43_0, iter_43_1 in pairs(self.cards or {}) do
		iter_43_1:Dispose()
	end

	self.cards = nil

	return
end

function IslandCheaterTavernPlayRoomInfoPage:GetActiveCamName()
	return IslandConst.CHARA_CAMERA_NAME
end

function IslandCheaterTavernPlayRoomInfoPage:OnCharLoaded(arg_45_1, arg_45_2)
	if self.dressHelperDic[arg_45_1] then
		self.dressHelperDic[arg_45_1]:OnRoleLoaded(self.modelDataDic[arg_45_1].role.transform, arg_45_2)
	end

	return
end

function IslandCheaterTavernPlayRoomInfoPage:LoadCharacterScene(arg_46_1)
	SceneOpMgr.Inst:LoadSceneAsyncWithProgress("island/scenesres/scenes/bar/map_xyd_bar_character01_scene", "map_xyd_bar_character01", LoadSceneMode.Additive, function(arg_47_0)
		if arg_47_0 == 1 then
			arg_46_1()
		end

		return
	end)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:UnLoadCharacterScene(arg_48_1)
	SceneOpMgr.Inst:UnloadSceneAsync("island/scenesres/scenes/character/map_xyd_bar_character01_scene", "map_xyd_bar_character01", function()
		if arg_48_1 then
			arg_48_1()
		end

		return
	end)

	return
end

function IslandCheaterTavernPlayRoomInfoPage:GetLigthEffectPath()
	return "island/effect/prefab/game/bar/vfx_bar_quan_y", "island/effect/prefab/game/bar/vfx_bar_quan_b"
end

function IslandCheaterTavernPlayRoomInfoPage:OnInit()
	return
end

function IslandCheaterTavernPlayRoomInfoPage:closeView()
	self.contextData.onClose()

	return
end

return IslandCheaterTavernPlayRoomInfoPage
