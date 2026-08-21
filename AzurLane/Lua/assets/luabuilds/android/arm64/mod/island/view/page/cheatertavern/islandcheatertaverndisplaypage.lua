local var_0_0 = class("IslandCheaterTavernDisplayPage", import("..ship.IslandBaseShipDisplayPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCheaterTavernDisplayUI"
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.RemoveListeners(arg_3_0)
	return
end

function var_0_0.NeedCache(arg_4_0)
	return false
end

function var_0_0.AddSubLayers(arg_5_0, arg_5_1)
	arg_5_1.data = {
		container = arg_5_0._tf,
		onClose = function()
			arg_5_0:Hide()

			return
		end
	}

	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(IslandMediator),
		context = arg_5_1
	})

	return
end

function var_0_0.RemoveSubLayers(arg_7_0, arg_7_1)
	local var_7_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_7_1.mediator)

	if var_7_0 then
		pg.m02:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_7_0
		})
	end

	return
end

function var_0_0.GetContext(arg_8_0)
	return Context.New({
		mediator = PlayRoomEntranceMediator,
		viewComponent = PlayRoomCheatBarEntranceScene
	})
end

function var_0_0.OnInit(arg_9_0)
	onButton(arg_9_0, arg_9_0.uiCloseBtn, function()
		arg_9_0:Hide()

		return
	end, SPX_PANEL)

	return
end

function var_0_0.OnLoaded(arg_11_0)
	arg_11_0.playRoomPop = PlayRoomPop.New(arg_11_0._tf:Find("playRoomPop"), arg_11_0)

	arg_11_0.playRoomPop:didEnter()

	return
end

function var_0_0.OnShow(arg_12_0)
	arg_12_0:AddSubLayers(arg_12_0:GetContext())
	arg_12_0.playRoomPop:Show(true)
	PlayRoomTools.SetGameTypeID(PlayRoomConst.GAME_TYPE.CHEATER_TAVERN)

	local var_12_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()
	local var_12_1 = var_12_0:GetShipById((var_12_0:GetViewGameShipViewId(PlayRoomTools.GetGameTypeID())))

	arg_12_0.shipDressHelper = arg_12_0.shipDressHelper or IslandShipDressHelperNew.New()

	arg_12_0.shipDressHelper:SetShipId(var_12_1.configId, {}, true)
	arg_12_0:LoadCharacter(var_12_1:GetModel())
	setText(arg_12_0.uiNameText, getProxy(PlayerProxy):getRawData().name)

	return
end

function var_0_0.OnHide(arg_13_0)
	arg_13_0:RemoveSubLayers(arg_13_0:GetContext())
	arg_13_0.playRoomPop:Show(false)
	arg_13_0:UnloadCharacter(arg_13_0.loadData)

	arg_13_0.loadData = nil

	if arg_13_0.shipDressHelper then
		arg_13_0.shipDressHelper:Destroy()
	end

	return
end

function var_0_0.OnDisable(arg_14_0)
	var_0_0.super.OnDisable(arg_14_0)
	arg_14_0:RemoveSubLayers(arg_14_0:GetContext())

	return
end

function var_0_0.OnDestroy(arg_15_0)
	arg_15_0:OnHide()
	arg_15_0.playRoomPop:willExit()

	arg_15_0.playRoomPop = nil

	return
end

function var_0_0.OnEnable(arg_16_0)
	arg_16_0:OnShow()

	return
end

function var_0_0.OnCharLoaded(arg_17_0, arg_17_1)
	if arg_17_0.shipDressHelper then
		arg_17_0.shipDressHelper:OnRoleLoaded(arg_17_0.role.transform, arg_17_1)
	end

	return
end

function var_0_0.GetSmoothRotateObject(arg_18_0)
	return arg_18_0._tf:Find("adapt/char")
end

function var_0_0.SetCharterPos(arg_19_0)
	if not arg_19_0.role then
		return
	end

	local var_19_0 = GameObject.Find("UICamera"):GetComponent(typeof(Camera)):WorldToScreenPoint(arg_19_0.uiCharPos.position)
	local var_19_1 = IslandCameraMgr.instance

	if IsNil(IslandCameraMgr.instance) then
		var_19_1 = CheatTavernCameraMgr.instance
	end

	arg_19_0.role.transform.localPosition = var_19_1._mainCamera:ScreenToWorldPoint(Vector3(var_19_0.x, var_19_0.y, 7))

	return
end

function var_0_0.LoadCharacter(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:UnloadCharacter(arg_20_0.loadData)

	local var_20_0 = {
		isCommander = arg_20_2,
		modelData = arg_20_1
	}

	arg_20_0.loadData = {
		isCommander = arg_20_2,
		modelData = arg_20_1
	}

	arg_20_0:_LoadModel({
		isCommander = arg_20_2,
		modelData = arg_20_1
	}, function(arg_21_0, arg_21_1)
		if arg_20_0.loadData == nil then
			return
		end

		if var_20_0.modelData.model ~= arg_20_0.loadData.modelData.model then
			arg_20_0:UnloadCharacter(var_20_0)

			return
		end

		arg_20_0.role = arg_21_0

		GetOrAddComponent(arg_20_0.role, typeof(CharacterHandleController))
		pg.ViewUtils.SetLayer(arg_20_0.role.transform, Layer.Character3D)
		setParent(arg_20_0.role, arg_20_0.roleContainer)

		arg_20_0.role.transform.eulerAngles = Vector3(0, 180, 0)

		arg_20_0:SetCharterPos()

		local var_21_0 = GetOrAddComponent(arg_20_0:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_21_0:SetUp(arg_20_0.role.transform)

		var_21_0.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		if arg_21_1 and arg_21_1 ~= "" then
			local var_21_1 = GetOrAddComponent(arg_20_0.role.transform:GetChild(0), typeof(Animator))

			for iter_21_0 = 1, var_21_1.layerCount do
				var_21_1:CrossFadeInFixedTime(arg_21_1, 0, iter_21_0 - 1)
			end
		end

		arg_20_0:OnCharLoaded(var_20_0.modelData)

		return
	end)

	return
end

function var_0_0.LoadCharacterScene(arg_22_0, arg_22_1)
	SceneOpMgr.Inst:LoadSceneAsyncWithProgress("island/scenesres/scenes/bar/map_xyd_bar_character02_scene", "map_xyd_bar_character02", LoadSceneMode.Additive, function(arg_23_0)
		if arg_23_0 == 1 then
			arg_22_1()
		end

		return
	end)

	return
end

function var_0_0.UnLoadCharacterScene(arg_24_0, arg_24_1)
	SceneOpMgr.Inst:UnloadSceneAsync("island/scenesres/scenes/bar/map_xyd_bar_character02_scene", "map_xyd_bar_character02", function()
		if arg_24_1 then
			arg_24_1()
		end

		return
	end)

	return
end

return var_0_0
