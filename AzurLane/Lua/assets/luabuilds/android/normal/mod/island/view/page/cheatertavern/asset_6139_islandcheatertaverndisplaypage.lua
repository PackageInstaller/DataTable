class = var_0_10000

local var_0_0 = "IslandCheaterTavernDisplayPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..ship.IslandBaseShipDisplayPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCheaterTavernDisplayUI"
end

function var_0_1.AddListeners(arg_2_0)
	return
end

function var_0_1.RemoveListeners(arg_3_0)
	return
end

function var_0_1.NeedCache(arg_4_0)
	return false
end

function var_0_1.AddSubLayers(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10003

	local var_5_0 = var_1_10002(var_1_10003)
	local var_5_1 = var_2.getCurrentContext(var_5_0)
	local var_5_2 = var_3.getContextByMediator

	IslandMediator = var_1_10006

	local var_5_3 = var_5_2(var_5_1, var_1_10006)

	arg_5_1.data = {
		container = arg_5_0._tf,
		onClose = function()
			local var_6_0 = arg_5_0

			var_0.Hide(var_6_0)

			return
		end
	}
	pg = var_5

	local var_5_4 = var_5.m02
	local var_5_5 = var_5.sendNotification

	GAME = var_1_10007

	var_5_5(var_5_4, var_1_10007.LOAD_LAYERS, {
		parentContext = var_5_3,
		context = arg_5_1
	})

	return
end

function var_0_1.RemoveSubLayers(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10003

	local var_7_0 = var_1_10002(var_1_10003)
	local var_7_1 = var_2.getCurrentContext(var_7_0)

	if var_3.getContextByMediator(var_7_1, arg_7_1.mediator) then
		pg = var_7_1

		local var_7_2 = var_7_1.m02
		local var_7_3 = var_5.sendNotification

		GAME = var_1_10007

		var_7_3(var_7_2, var_1_10007.REMOVE_LAYERS, {
			context = var_4
		})
	end

	return
end

function var_0_1.GetContext(arg_8_0)
	Context = var_1_10001

	local var_8_0 = var_1_10001.New
	local var_8_1 = {}

	PlayRoomEntranceMediator = var_1_10003
	var_8_1.mediator = var_1_10003
	PlayRoomCheatBarEntranceScene = var_1_10003
	var_8_1.viewComponent = var_1_10003

	return var_8_0(var_8_1)
end

function var_0_1.OnInit(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.uiCloseBtn

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.Hide(var_10_0)

		return
	end

	SPX_PANEL = var_1_10005

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10005)

	return
end

function var_0_1.OnLoaded(arg_11_0)
	PlayRoomPop = var_1_10001

	local var_11_0 = var_1_10001.New
	local var_11_1 = arg_11_0._tf

	arg_11_0.playRoomPop = var_11_0(var_2.Find(var_11_1, "playRoomPop"), arg_11_0)

	local var_11_2 = arg_11_0.playRoomPop

	var_1.didEnter(var_11_2)

	return
end

function var_0_1.OnShow(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.AddSubLayers
	local var_12_2 = arg_12_0

	var_12_1(var_12_0, arg_12_0.GetContext(var_12_2))

	local var_12_3 = arg_12_0.playRoomPop

	var_1.Show(var_12_3, true)

	PlayRoomTools = var_1

	local var_12_4 = var_1.SetGameTypeID

	PlayRoomConst = var_12_3

	var_12_4(var_12_3.GAME_TYPE.CHEATER_TAVERN)

	getProxy = var_12_4
	IslandProxy = var_2

	local var_12_5 = var_12_4(var_2)
	local var_12_6 = var_1.GetIsland(var_12_5)
	local var_12_7 = var_1.GetCharacterAgency(var_12_6)
	local var_12_8 = var_1.GetViewGameShipViewId

	PlayRoomTools = var_12_2

	local var_12_9 = var_12_8(var_12_7, var_12_2.GetGameTypeID())
	local var_12_10 = var_1:GetShipById(var_12_9)

	if not arg_12_0.shipDressHelper then
		IslandShipDressHelperNew = var_4
		arg_12_0.shipDressHelper = var_4.New()
	end

	local var_12_11 = arg_12_0.shipDressHelper

	var_4.SetShipId(var_12_11, var_12_10.configId, {}, true)

	local var_12_12 = arg_12_0
	local var_12_13 = arg_12_0.LoadCharacter
	local var_12_14 = var_12_10

	var_12_13(var_12_12, var_12_10.GetModel(var_12_14))

	setText = var_12_13

	local var_12_15 = arg_12_0.uiNameText

	getProxy = var_6
	PlayerProxy = var_12_14

	local var_12_16 = var_6(var_12_14)

	var_12_13(var_12_15, var_6.getRawData(var_12_16).name)

	return
end

function var_0_1.OnHide(arg_13_0)
	arg_13_0:RemoveSubLayers(arg_13_0:GetContext())

	local var_13_0 = arg_13_0.playRoomPop

	var_1.Show(var_13_0, false)
	arg_13_0:UnloadCharacter(arg_13_0.loadData)

	arg_13_0.loadData = nil

	if arg_13_0.shipDressHelper then
		local var_13_1 = arg_13_0.shipDressHelper

		var_1.Destroy(var_13_1)
	end

	return
end

function var_0_1.OnDisable(arg_14_0)
	var_0_1.super.OnDisable(arg_14_0)
	arg_14_0:RemoveSubLayers(arg_14_0:GetContext())

	return
end

function var_0_1.OnDestroy(arg_15_0)
	arg_15_0:OnHide()

	local var_15_0 = arg_15_0.playRoomPop

	var_1.willExit(var_15_0)

	arg_15_0.playRoomPop = nil

	return
end

function var_0_1.OnEnable(arg_16_0)
	arg_16_0:OnShow()

	return
end

function var_0_1.OnCharLoaded(arg_17_0, arg_17_1)
	if arg_17_0.shipDressHelper then
		local var_17_0 = arg_17_0.shipDressHelper

		var_2.OnRoleLoaded(var_17_0, arg_17_0.role.transform, arg_17_1)
	end

	return
end

function var_0_1.GetSmoothRotateObject(arg_18_0)
	local var_18_0 = arg_18_0._tf

	return var_1.Find(var_18_0, "adapt/char")
end

function var_0_1.SetCharterPos(arg_19_0)
	if not arg_19_0.role then
		return
	end

	GameObject = var_1

	local var_19_0 = var_1.Find("UICamera")
	local var_19_1 = var_1.GetComponent

	typeof = var_1_10003
	Camera = var_1_10004

	local var_19_2 = var_19_1(var_19_0, var_1_10003(var_1_10004))
	local var_19_3 = var_1.WorldToScreenPoint(var_19_2, arg_19_0.uiCharPos.position)

	IslandCameraMgr = var_19_2

	local var_19_4 = var_19_2.instance

	IsNil = var_4

	if var_4(var_19_4) then
		CheatTavernCameraMgr = var_4
		var_19_4 = var_4.instance
	end

	local var_19_5 = var_19_4._mainCamera
	local var_19_6 = var_4.ScreenToWorldPoint

	Vector3 = var_1_10006

	local var_19_7 = var_19_6(var_19_5, var_1_10006(var_19_3.x, var_19_3.y, 7))

	arg_19_0.role.transform.localPosition = var_19_7

	return
end

function var_0_1.LoadCharacter(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:UnloadCharacter(arg_20_0.loadData)

	arg_20_0.loadData = {
		isCommander = arg_20_2,
		modelData = arg_20_1
	}

	local function var_20_0(arg_21_0, arg_21_1)
		if arg_20_0.loadData == nil then
			return
		end

		if var_0.modelData.model ~= arg_20_0.loadData.modelData.model then
			local var_21_0 = arg_20_0

			var_2.UnloadCharacter(var_21_0, var_0)

			return
		end

		local var_21_1 = arg_20_0

		var_21_1.role = arg_21_0
		GetOrAddComponent = var_21_1

		local var_21_2 = arg_20_0.role

		typeof = var_2_10004
		CharacterHandleController = var_2_10005

		var_21_1(var_21_2, var_2_10004(var_2_10005))

		pg = var_21_1

		local var_21_3 = var_21_1.ViewUtils.SetLayer
		local var_21_4 = arg_20_0.role.transform

		Layer = var_4

		var_21_3(var_21_4, var_4.Character3D)

		setParent = var_21_3

		var_21_3(arg_20_0.role, arg_20_0.roleContainer)

		local var_21_5 = arg_20_0.role.transform

		Vector3 = var_3
		var_21_5.eulerAngles = var_3(0, 180, 0)

		local var_21_6 = arg_20_0

		var_2.SetCharterPos(var_21_6)

		local var_21_7 = arg_20_0
		local var_21_8

		var_21_8, GetOrAddComponent = var_2.GetSmoothRotateObject(var_21_7), var_21_7
		typeof = var_5
		SmoothRotateObject = var_6

		local var_21_9 = var_21_7(var_21_8, var_5(var_6))

		var_3.SetUp(var_21_9, arg_20_0.role.transform)

		pg = var_4
		var_3.rotationSpeed = var_4.island_set.character_detail_camera_speed.key_value_int

		if arg_21_1 and arg_21_1 ~= "" then
			GetOrAddComponent = var_21_9

			local var_21_10 = arg_20_0.role.transform
			local var_21_11 = var_6.GetChild(var_21_10, 0)

			typeof = var_21_10
			Animator = var_8

			local var_21_12 = var_21_9(var_21_11, var_21_10(var_8))

			for iter_21_0 = 1, var_21_12.layerCount do
				var_21_12:CrossFadeInFixedTime(arg_21_1, 0, iter_21_0 - 1)
			end
		end

		local var_21_13 = arg_20_0

		var_5.OnCharLoaded(var_21_13, var_0.modelData)

		return
	end

	arg_20_0:_LoadModel(var_3, var_20_0)

	return
end

function var_0_1.LoadCharacterScene(arg_22_0, arg_22_1)
	local var_22_0 = "island/scenesres/scenes/bar/map_xyd_bar_character02_scene"

	SceneOpMgr = var_1_10003

	local var_22_1 = var_1_10003.Inst
	local var_22_2 = var_3.LoadSceneAsyncWithProgress
	local var_22_3 = var_22_0
	local var_22_4 = "map_xyd_bar_character02"

	LoadSceneMode = var_1_10007

	var_22_2(var_22_1, var_22_3, var_22_4, var_1_10007.Additive, function(arg_23_0)
		if arg_23_0 == 1 then
			arg_22_1()
		end

		return
	end)

	return
end

function var_0_1.UnLoadCharacterScene(arg_24_0, arg_24_1)
	local var_24_0 = "island/scenesres/scenes/bar/map_xyd_bar_character02_scene"

	SceneOpMgr = var_1_10003

	local var_24_1 = var_1_10003.Inst

	var_3.UnloadSceneAsync(var_24_1, var_24_0, "map_xyd_bar_character02", function()
		if arg_24_1 then
			arg_24_1()
		end

		return
	end)

	return
end

return var_0_1
