local IslandCheaterTavernDisplayPage = class("IslandCheaterTavernDisplayPage", import("..ship.IslandBaseShipDisplayPage"))

function IslandCheaterTavernDisplayPage:getUIName()
	return "IslandCheaterTavernDisplayUI"
end

function IslandCheaterTavernDisplayPage:AddListeners()
	return
end

function IslandCheaterTavernDisplayPage:RemoveListeners()
	return
end

function IslandCheaterTavernDisplayPage:NeedCache()
	return false
end

function IslandCheaterTavernDisplayPage:AddSubLayers(arg_5_1)
	arg_5_1.data = {
		container = self._tf,
		onClose = function()
			self:Hide()

			return
		end
	}

	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(IslandMediator),
		context = arg_5_1
	})

	return
end

function IslandCheaterTavernDisplayPage:RemoveSubLayers(arg_7_1)
	local var_7_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_7_1.mediator)

	if var_7_0 then
		pg.m02:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_7_0
		})
	end

	return
end

function IslandCheaterTavernDisplayPage:GetContext()
	return Context.New({
		mediator = PlayRoomEntranceMediator,
		viewComponent = PlayRoomCheatBarEntranceScene
	})
end

function IslandCheaterTavernDisplayPage:OnInit()
	onButton(self, self.uiCloseBtn, function()
		self:Hide()

		return
	end, SPX_PANEL)

	return
end

function IslandCheaterTavernDisplayPage:OnLoaded()
	self.playRoomPop = PlayRoomPop.New(self._tf:Find("playRoomPop"), self)

	self.playRoomPop:didEnter()

	return
end

function IslandCheaterTavernDisplayPage:OnShow()
	self:AddSubLayers(self:GetContext())
	self.playRoomPop:Show(true)
	PlayRoomTools.SetGameTypeID(PlayRoomConst.GAME_TYPE.CHEATER_TAVERN)

	local var_12_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()
	local var_12_1 = var_12_0:GetShipById((var_12_0:GetViewGameShipViewId(PlayRoomTools.GetGameTypeID())))

	self.shipDressHelper = self.shipDressHelper or IslandShipDressHelperNew.New()

	self.shipDressHelper:SetShipId(var_12_1.configId, {}, true)
	self:LoadCharacter(var_12_1:GetModel())
	setText(self.uiNameText, getProxy(PlayerProxy):getRawData().name)

	return
end

function IslandCheaterTavernDisplayPage:OnHide()
	self:RemoveSubLayers(self:GetContext())
	self.playRoomPop:Show(false)
	self:UnloadCharacter(self.loadData)

	self.loadData = nil

	if self.shipDressHelper then
		self.shipDressHelper:Destroy()
	end

	return
end

function IslandCheaterTavernDisplayPage:OnDisable()
	IslandCheaterTavernDisplayPage.super.OnDisable(self)
	self:RemoveSubLayers(self:GetContext())

	return
end

function IslandCheaterTavernDisplayPage:OnDestroy()
	self:OnHide()
	self.playRoomPop:willExit()

	self.playRoomPop = nil

	return
end

function IslandCheaterTavernDisplayPage:OnEnable()
	self:OnShow()

	return
end

function IslandCheaterTavernDisplayPage:OnCharLoaded(arg_17_1)
	if self.shipDressHelper then
		self.shipDressHelper:OnRoleLoaded(self.role.transform, arg_17_1)
	end

	return
end

function IslandCheaterTavernDisplayPage:GetSmoothRotateObject()
	return self._tf:Find("adapt/char")
end

function IslandCheaterTavernDisplayPage:SetCharterPos()
	if not self.role then
		return
	end

	local var_19_0 = GameObject.Find("UICamera"):GetComponent(typeof(Camera)):WorldToScreenPoint(self.uiCharPos.position)

	self.role.transform.localPosition = ((IsNil(IslandCameraMgr.instance) or nil) and CheatTavernCameraMgr.instance)._mainCamera:ScreenToWorldPoint(Vector3(var_19_0.x, var_19_0.y, 7))

	return
end

function IslandCheaterTavernDisplayPage:LoadCharacter(arg_20_1, arg_20_2)
	self:UnloadCharacter(self.loadData)

	local var_20_0 = {
		isCommander = arg_20_2,
		modelData = arg_20_1
	}

	self.loadData = var_20_0

	self:_LoadModel(var_20_0, function(arg_21_0, arg_21_1)
		if self.loadData == nil then
			return
		end

		if var_20_0.modelData.model ~= self.loadData.modelData.model then
			self:UnloadCharacter(var_20_0)

			return
		end

		self.role = arg_21_0

		GetOrAddComponent(self.role, typeof(CharacterHandleController))
		pg.ViewUtils.SetLayer(self.role.transform, Layer.Character3D)
		setParent(self.role, self.roleContainer)

		self.role.transform.eulerAngles = Vector3(0, 180, 0)

		self:SetCharterPos()

		local var_21_0 = GetOrAddComponent(self:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_21_0:SetUp(self.role.transform)

		var_21_0.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		if arg_21_1 and arg_21_1 ~= "" then
			local var_21_1 = GetOrAddComponent(self.role.transform:GetChild(0), typeof(Animator))

			for iter_21_0 = 1, var_21_1.layerCount do
				var_21_1:CrossFadeInFixedTime(arg_21_1, 0, iter_21_0 - 1)
			end
		end

		self:OnCharLoaded(var_20_0.modelData)

		return
	end)

	return
end

function IslandCheaterTavernDisplayPage:LoadCharacterScene(arg_22_1)
	SceneOpMgr.Inst:LoadSceneAsyncWithProgress("island/scenesres/scenes/bar/map_xyd_bar_character02_scene", "map_xyd_bar_character02", LoadSceneMode.Additive, function(arg_23_0)
		if arg_23_0 == 1 then
			arg_22_1()
		end

		return
	end)

	return
end

function IslandCheaterTavernDisplayPage:UnLoadCharacterScene(arg_24_1)
	SceneOpMgr.Inst:UnloadSceneAsync("island/scenesres/scenes/bar/map_xyd_bar_character02_scene", "map_xyd_bar_character02", function()
		if arg_24_1 then
			arg_24_1()
		end

		return
	end)

	return
end

return IslandCheaterTavernDisplayPage
