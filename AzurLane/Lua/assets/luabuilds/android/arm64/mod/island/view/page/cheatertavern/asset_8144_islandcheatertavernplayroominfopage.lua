class = var_0_10000

local var_0_0 = "IslandCheaterTavernPlayRoomInfoPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...page.temp.IslandExternalBridgePage"))

function var_0_1.AddListeners(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.AddListener

	GAME = var_1_10004

	var_1_1(var_1_0, var_1_10004.PLAY_ROOM_ALL_LOAD_OVER, arg_1_0.OnRoomAllLoadDone)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.AddListener

	GAME = var_4

	var_1_3(var_1_2, var_4.PLAY_ROOM_REDAY_ROOM_REFRESH, arg_1_0.OnRefreshModel)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.AddListener

	GAME = var_4

	var_1_5(var_1_4, var_4.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH, arg_1_0.OnRefreshModel)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.AddListener

	GAME = var_4

	var_1_7(var_1_6, var_4.ISLAND_CHEATER_CHANGE_VIEW_DRESSID, arg_1_0.OnRefreshModel)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.AddListener

	GAME = var_4

	var_1_9(var_1_8, var_4.PLAY_ROOM_ENTER_LOAD, arg_1_0.OnRefreshModel)

	return
end

function var_0_1.RemoveListeners(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.RemoveListener

	GAME = var_1_10004

	var_2_1(var_2_0, var_1_10004.PLAY_ROOM_ALL_LOAD_OVER, arg_2_0.OnRoomAllLoadDone)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.RemoveListener

	GAME = var_4

	var_2_3(var_2_2, var_4.PLAY_ROOM_REDAY_ROOM_REFRESH, arg_2_0.OnRefreshModel)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.RemoveListener

	GAME = var_4

	var_2_5(var_2_4, var_4.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH, arg_2_0.OnRefreshModel)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.RemoveListener

	GAME = var_4

	var_2_7(var_2_6, var_4.ISLAND_CHEATER_CHANGE_VIEW_DRESSID, arg_2_0.OnRefreshModel)

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.RemoveListener

	GAME = var_4

	var_2_9(var_2_8, var_4.PLAY_ROOM_ENTER_LOAD, arg_2_0.OnRefreshModel)

	return
end

function var_0_1.getUIName(arg_3_0)
	return "IslandCheaterTavernPlayRoomInfoDisplayUI"
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "adapt/playerList")

	arg_4_0.playerCharTF = {}

	for iter_4_0 = 1, 4 do
		local var_4_2 = var_4_1:Find("playerItem" .. iter_4_0)

		arg_4_0.playerCharTF[iter_4_0] = var_4_2:Find("charPos")
	end

	return
end

function var_0_1.OnShow(arg_5_0, arg_5_1)
	arg_5_0.sceneRoomType = arg_5_1

	arg_5_0:AddSubLayers(arg_5_0:GetContext())

	arg_5_0.isExit = false
	arg_5_0.playerIndexDic = {}
	arg_5_0.modelDataDic = {}

	arg_5_0:LoadRoomPlayerModel()

	arg_5_0.unReadyEffectList = {}
	arg_5_0.readyEffectList = {}

	arg_5_0:LoadLightEffect(arg_5_0.playerSlotCount)

	return
end

function var_0_1.GetContext(arg_6_0)
	Context = var_1_10001

	local var_6_0 = var_1_10001.New
	local var_6_1 = {}

	PlayRoomInfoMediator = var_1_10004
	var_6_1.mediator = var_1_10004
	PlayRoomInfoScene = var_1_10004
	var_6_1.viewComponent = var_1_10004

	return var_6_0(var_6_1)
end

function var_0_1.AddSubLayers(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_7_0 = var_1_10002(var_1_10004)
	local var_7_1 = var_2.getCurrentContext(var_7_0)
	local var_7_2 = var_3.getContextByMediator

	IslandMediator = var_1_10007

	local var_7_3 = var_7_2(var_7_1, var_1_10007)

	arg_7_1.data = {
		container = arg_7_0._tf,
		onClose = function()
			pg = var_2_10000

			local var_8_0 = var_2_10000.SceneAnimMgr.GetInstance()

			var_0.CommonSceneChange(var_8_0, "Dorm3DLoading", function(arg_9_0)
				local var_9_0 = arg_7_0

				var_1.Hide(var_9_0)
				arg_9_0()

				return
			end)

			return
		end,
		sceneRoomType = arg_7_0.sceneRoomType
	}
	pg = var_5

	local var_7_4 = var_5.m02
	local var_7_5 = var_5.sendNotification

	GAME = var_1_10008

	var_7_5(var_7_4, var_1_10008.LOAD_LAYERS, {
		parentContext = var_7_3,
		context = arg_7_1
	})

	return
end

function var_0_1.OnRoomAllLoadDone(arg_10_0)
	IslandCheaterTavernRecordTools = var_1_10001

	var_1_10001.StartGame()

	return
end

function var_0_1.OnRefreshModel(arg_11_0)
	arg_11_0:LoadRoomPlayerModel()
	arg_11_0:RefreshLight()

	return
end

function var_0_1.RefreshLight(arg_12_0)
	getProxy = var_1_10001
	PlayRoomProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = arg_12_0.playRoomProxy
	local var_12_3

	if var_2.GetGameLoadData(var_12_1) == nil then
		local var_12_2 = arg_12_0.sceneRoomType

		IslandCheaterTavernConst = var_12_1

		if var_12_2 == var_12_1.SceneRoomType.CustomRoom then
			var_12_3 = var_12_0:GetRoomData()
		else
			local var_12_4 = arg_12_0.sceneRoomType

			IslandCheaterTavernConst = var_4

			if var_12_4 == var_4.SceneRoomType.MatchInfoRoom then
				var_12_3 = var_12_0:GetMatchRoomData()
			end
		end
	end

	if var_12_3 == nil then
		return
	end

	local var_12_5 = var_12_3.teamPosList

	for iter_12_0 = 1, arg_12_0.playerSlotCount do
		if var_12_5[iter_12_0] and var_12_5[iter_12_0][1] then
			local var_12_6 = arg_12_0.playRoomProxy

			if not var_8.GetGameLoadData(var_12_6) then
				table = var_8

				if var_8.keyof(var_12_3.readyList, var_12_5[iter_12_0][1]) then
					setActive = var_8

					var_8(arg_12_0.unReadyEffectList[iter_12_0], false)

					setActive = var_8

					var_8(arg_12_0.readyEffectList[iter_12_0], true)
				else
					setActive = var_8

					var_8(arg_12_0.unReadyEffectList[iter_12_0], true)

					setActive = var_8

					var_8(arg_12_0.readyEffectList[iter_12_0], false)
				end

				if false then
					setActive = var_8

					var_8(arg_12_0.unReadyEffectList[iter_12_0], false)

					setActive = var_8

					var_8(arg_12_0.readyEffectList[iter_12_0], false)
				end
			end
		end
	end

	return
end

function var_0_1.LoadRoomPlayerModel(arg_13_0)
	getProxy = var_1_10001
	PlayRoomProxy = var_1_10003
	arg_13_0.playRoomProxy = var_1_10001(var_1_10003)

	local var_13_0 = arg_13_0.playRoomProxy
	local var_13_1 = arg_13_0.playRoomProxy
	local var_13_3

	if var_2.GetGameLoadData(var_13_1) == nil then
		local var_13_2 = arg_13_0.sceneRoomType

		IslandCheaterTavernConst = var_13_1

		if var_13_2 == var_13_1.SceneRoomType.CustomRoom then
			var_13_3 = var_13_0:GetRoomData()
		else
			local var_13_4 = arg_13_0.sceneRoomType

			IslandCheaterTavernConst = var_13_1

			if var_13_4 == var_13_1.SceneRoomType.MatchInfoRoom then
				var_13_3 = var_13_0:GetMatchRoomData()
			end
		end
	end

	if var_13_3 == nil then
		return
	end

	local var_13_5 = var_13_3.teamPosList

	PlayRoomTools = var_13_1
	arg_13_0.playerSlotCount = var_13_1.GetMaxTeamCnt(var_13_3.gameType)
	arg_13_0.dressHelperDic = {}

	for iter_13_0 = 1, arg_13_0.playerSlotCount do
		if var_13_5[iter_13_0] then
			local var_13_6 = var_13_5[iter_13_0][1]

			if var_13_3.playerDataList[var_13_6] then
				local var_13_7 = arg_13_0.playerIndexDic

				var_13_7[iter_13_0] = var_13_6
				PlayRoomTools = var_13_7

				local var_13_8 = var_13_7.GetGameViewID(var_9.user_view)
				local var_13_9

				if not arg_13_0.dressHelperDic[iter_13_0] then
					var_13_9 = arg_13_0.dressHelperDic
					IslandShipDressHelperMiniGameNew = var_12
					var_13_9[iter_13_0] = var_12.New()

					local var_13_10 = arg_13_0.dressHelperDic[iter_13_0]

					var_13_9 = var_13_9.SetShipId

					local var_13_11 = var_13_8.ship_id
					local var_13_12

					if not var_13_8.dress_list then
						var_13_12 = {}
					end

					var_13_9(var_13_10, var_13_11, var_13_12)
				end

				CheaterTavernHelper = var_13_9

				local var_13_13 = var_13_9.GetModelDataByViewData(var_13_8)

				arg_13_0:LoadCharacter(iter_13_0, var_13_13)
			else
				arg_13_0:UnloadCharacter(iter_13_0)
			end
		end
	end

	return
end

function var_0_1.Preload(arg_14_0, arg_14_1)
	arg_14_0:PrepareCharacterScene(arg_14_1)

	return
end

function var_0_1.PrepareCharacterScene(arg_15_0, arg_15_1)
	arg_15_0.isLoadCharacterScene = true
	seriesAsync = var_2

	var_2({
		function(arg_16_0)
			local var_16_0 = arg_15_0

			var_1.CreateCharacterContainer(var_16_0)

			local var_16_1 = arg_15_0

			var_1.LoadCharacterScene(var_16_1, arg_16_0)

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_15_0

			var_1.ModifyCameraMask(var_17_0)

			local var_17_1 = arg_15_0

			var_1.ActivityCharacterCamera(var_17_1)

			local var_17_2 = arg_15_0

			var_1.InitSceneTimeline(var_17_2)
			arg_17_0()

			return
		end
	}, arg_15_1)

	return
end

function var_0_1.CreateCharacterContainer(arg_18_0)
	GameObject = var_1_10001
	arg_18_0.roleContainer = var_1_10001.New("roleContainer").transform
	pg = var_1

	local var_18_0 = var_1.ViewUtils.SetLayer
	local var_18_1 = arg_18_0.roleContainer

	Layer = var_1_10004

	var_18_0(var_18_1, var_1_10004.Character3D)

	return
end

function var_0_1.ModifyCameraMask(arg_19_0)
	IslandCameraMgr = var_1_10001

	local var_19_0 = var_1_10001.instance

	IsNil = var_1_10002

	if var_1_10002(var_19_0) then
		CheatTavernCameraMgr = var_2
		var_19_0 = var_2.instance
	end

	arg_19_0.defaultCullingMask = var_19_0._mainCamera.cullingMask
	LuaHelper = var_3

	var_3.SetCamCullingMask(var_2, "Character3D")

	return
end

function var_0_1.ActivityCharacterCamera(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.GetActiveCamName(var_20_0)

	IslandCameraMgr = var_1_10002

	local var_20_2 = var_1_10002.instance

	IsNil = var_20_0

	if var_20_0(var_20_2) then
		CheatTavernCameraMgr = var_3
		var_20_2 = var_3.instance
	end

	local var_20_3 = var_20_2:GetVirtualCamera(var_20_1)

	var_20_3.Follow = arg_20_0.roleContainer
	var_20_3.LookAt = arg_20_0.roleContainer

	var_20_2:ActiveVirtualCamera(var_20_1)

	return
end

function var_0_1.InitSceneTimeline(arg_21_0)
	GameObject = var_1_10001

	if var_1_10001.Find("[sequence]") then
		local var_21_0 = var_1
		local var_21_1 = var_1.GetComponent

		typeof = var_1_10005
		UnityEngine = var_1_10007

		local var_21_2 = var_21_1(var_21_0, var_1_10005(var_1_10007.Playables.PlayableDirector))

		TimelineSupport = var_3

		var_3.DynamicBinding(var_21_2)
		var_21_2:Play()
	end

	return
end

function var_0_1.ClearCharacterScene(arg_22_0, arg_22_1)
	arg_22_0.isExit = true

	if arg_22_0.isLoadCharacterScene then
		arg_22_0:UnLoadLightEffect()
		arg_22_0:ClearCharacterContainer()
		arg_22_0:UnLoadCharacterScene(function()
			local var_23_0 = arg_22_0

			var_0.ActivityPlayerCamera(var_23_0)

			existCall = var_0

			var_0(arg_22_1)

			return
		end)
		arg_22_0:ResetCameraMask()

		local var_22_0 = arg_22_0
		local var_22_1 = arg_22_0.emitCore

		ISLAND_EVT = var_5

		var_22_1(var_22_0, var_5.REFRESH_WEATHER_SYSTEM)
	end

	arg_22_0.playerIndexDic = {}
	arg_22_0.modelDataDic = {}
	arg_22_0.isLoadCharacterScene = false

	return
end

function var_0_1.OnHome(arg_24_0)
	arg_24_0:ClearCharacterScene(function()
		local var_25_0 = arg_24_0
		local var_25_1 = var_0.emit

		BaseUI = var_2_10003

		var_25_1(var_25_0, var_2_10003.ON_HOME)

		return
	end)

	return
end

function var_0_1.LoadCharacter(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:UnloadCharacter(arg_26_1)

	local var_26_0

	if not arg_26_0.modelDataDic[arg_26_1] then
		var_26_0 = {}
	end

	arg_26_0.modelDataDic[arg_26_1] = var_26_0
	arg_26_0.modelDataDic[arg_26_1].modelData = arg_26_2

	local function var_26_1(arg_27_0)
		if arg_26_0.modelDataDic[arg_26_1] == nil or var_1.modelData.model ~= arg_26_2.model then
			local var_27_0 = arg_26_0
			local var_27_1 = var_2.GetPoolMgr(var_27_0)

			var_2.ReturnCharacter(var_27_1, arg_26_2.model, arg_26_2.animator, arg_27_0)

			return
		end

		local var_27_2 = arg_27_0

		GetOrAddComponent = var_2_10003

		local var_27_3 = var_27_2

		typeof = var_2_10006
		CharacterHandleController = var_2_10008

		var_2_10003(var_27_3, var_2_10006(var_2_10008))

		local var_27_4 = arg_26_0.modelDataDic[arg_26_1]

		var_27_4.role = var_27_2
		pg = var_27_4

		local var_27_5 = var_27_4.ViewUtils.SetLayer
		local var_27_6 = var_27_2.transform

		Layer = var_6

		var_27_5(var_27_6, var_6.Character3D)

		setParent = var_27_5

		var_27_5(var_27_2, arg_26_0.roleContainer)

		local var_27_7 = var_27_2.transform

		Vector3 = var_4
		var_27_7.eulerAngles = var_4(0, 180, 0)
		GameObject = var_27_7

		local var_27_8 = var_27_7.Find("UICamera")
		local var_27_9 = var_3.GetComponent

		typeof = var_6
		Camera = var_8

		local var_27_10 = var_27_9(var_27_8, var_6(var_8))
		local var_27_11 = arg_26_0.playerCharTF[arg_26_1]
		local var_27_12 = var_27_10
		local var_27_13 = var_27_10.WorldToScreenPoint(var_27_12, var_27_11.position)

		IslandCameraMgr = var_6

		local var_27_14 = var_6.instance

		IsNil = var_27_12

		if var_27_12(var_27_14) then
			CheatTavernCameraMgr = var_7
			var_27_14 = var_7.instance
		end

		local var_27_15 = var_27_14._mainCamera
		local var_27_16 = var_7.ScreenToWorldPoint

		Vector3 = var_2_10010

		local var_27_17 = var_27_16(var_27_15, var_2_10010(var_27_13.x, var_27_13.y, 10))
		local var_27_18 = var_27_2.transform

		Vector3 = var_27_15
		var_27_18.localPosition = var_27_15(var_27_17.x, var_27_17.y + 0.4, var_27_17.z)

		local var_27_19 = arg_26_0

		var_8.OnCharLoaded(var_27_19, arg_26_1, arg_26_2)

		return
	end

	arg_26_0:_LoadModel(arg_26_2, var_26_1)

	return
end

function var_0_1._LoadModel(arg_28_0, arg_28_1, arg_28_2)
	pg = var_1_10003

	local var_28_0 = var_1_10003.UIMgr.GetInstance()

	var_3.LoadingOn(var_28_0)

	local var_28_1 = arg_28_0:GetPoolMgr()

	var_3.GetCharacter(var_28_1, arg_28_1.model, arg_28_1.animator, function(arg_29_0)
		arg_28_2(arg_29_0)

		pg = var_1

		local var_29_0 = var_1.UIMgr.GetInstance()

		var_1.LoadingOff(var_29_0)

		return
	end)

	return
end

function var_0_1.UnloadCharacter(arg_30_0, arg_30_1)
	if arg_30_0.modelDataDic[arg_30_1] and var_2.role then
		local var_30_0 = var_2.modelData

		pg = var_1_10004

		local var_30_1 = var_1_10004.ViewUtils.SetLayer
		local var_30_2 = var_2.role.transform

		Layer = var_1_10007

		var_30_1(var_30_2, var_1_10007.Default)

		local var_30_3 = arg_30_0:GetPoolMgr()

		var_4.ReturnCharacter(var_30_3, var_30_0.model, var_30_0.animator, var_2.role)
	end

	arg_30_0.modelDataDic[arg_30_1] = nil
	arg_30_0.playerIndexDic[arg_30_1] = nil

	return
end

function var_0_1.LoadLightEffect(arg_31_0, arg_31_1)
	arg_31_1 = arg_31_1 or 0

	local var_31_0, var_31_1 = arg_31_0:GetLigthEffectPath()
	local var_31_2 = {}

	for iter_31_0 = 1, arg_31_1 do
		GameObject = var_1_10009

		local var_31_3 = var_1_10009.Find("UICamera")

		var_1_10009 = var_1_10009.GetComponent
		typeof = var_1_10012
		Camera = var_1_10014
		var_1_10009 = var_1_10009(var_31_3, var_1_10012(var_1_10014))

		local var_31_4 = arg_31_0.playerCharTF[iter_31_0]
		local var_31_5 = var_1_10009
		local var_31_6 = var_1_10009.WorldToScreenPoint(var_31_5, var_31_4.position)

		IslandCameraMgr = var_1_10012
		var_1_10012 = var_1_10012.instance
		IsNil = var_31_5

		if var_31_5(var_1_10012) then
			CheatTavernCameraMgr = var_13
			var_1_10012 = var_13.instance
		end

		local var_31_7 = var_1_10012._mainCamera
		local var_31_8 = var_13.ScreenToWorldPoint

		Vector3 = var_1_10016

		local var_31_9 = var_31_8(var_31_7, var_1_10016(var_31_6.x, var_31_6.y, 10))

		Vector3 = var_1_10014
		var_1_10014 = var_1_10014(var_31_9.x, var_31_9.y + 0.4, var_31_9.z)
		table = var_31_7

		var_31_7.insert(var_31_2, function(arg_32_0)
			local var_32_0 = arg_31_0
			local var_32_1 = var_1.GetPoolMgr(var_32_0)

			var_1.GetSceneProductEffect(var_32_1, var_31_0, function(arg_33_0)
				if arg_31_0.isExit then
					local var_33_0 = arg_31_0
					local var_33_1 = var_1.GetPoolMgr(var_33_0)

					var_1.ReturnSceneProductEffect(var_33_1, var_31_0, arg_33_0)
				else
					setActive = var_1

					var_1(arg_33_0, false)

					local var_33_2 = arg_33_0.transform

					var_33_2.localPosition = var_1_10014
					setParent = var_33_2

					var_33_2(arg_33_0, arg_31_0.roleContainer)

					arg_31_0.unReadyEffectList[iter_31_0] = arg_33_0
				end

				arg_32_0()

				return
			end)

			return
		end)

		table = var_15

		var_15.insert(var_31_2, function(arg_34_0)
			local var_34_0 = arg_31_0
			local var_34_1 = var_1.GetPoolMgr(var_34_0)

			var_1.GetSceneProductEffect(var_34_1, var_31_1, function(arg_35_0)
				if arg_31_0.isExit then
					local var_35_0 = arg_31_0
					local var_35_1 = var_1.GetPoolMgr(var_35_0)

					var_1.ReturnSceneProductEffect(var_35_1, var_31_1, arg_35_0)
				else
					setActive = var_1

					var_1(arg_35_0, false)

					setParent = var_1

					var_1(arg_35_0, arg_31_0.roleContainer)

					arg_35_0.transform.localPosition = var_1_10014
					arg_31_0.readyEffectList[iter_31_0] = arg_35_0
				end

				arg_34_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_31_2, function()
		local var_36_0 = arg_31_0

		var_0.RefreshLight(var_36_0)

		return
	end)

	return
end

function var_0_1.UnLoadLightEffect(arg_37_0)
	local var_37_0 = arg_37_0
	local var_37_1, var_37_2 = arg_37_0.GetLigthEffectPath(var_37_0)

	ipairs = var_37_0

	for iter_37_0, iter_37_1 in var_37_0(arg_37_0.readyEffectList) do
		local var_37_3 = arg_37_0:GetPoolMgr()

		var_8.ReturnSceneProductEffect(var_37_3, var_37_2, iter_37_1)
	end

	arg_37_0.readyEffectList = {}
	ipairs = var_3

	for iter_37_2, iter_37_3 in var_3(arg_37_0.unReadyEffectList) do
		local var_37_4 = arg_37_0:GetPoolMgr()

		var_8.ReturnSceneProductEffect(var_37_4, var_37_1, iter_37_3)
	end

	arg_37_0.unReadyEffectList = {}

	return
end

function var_0_1.ClearCharacterContainer(arg_38_0)
	ipairs = var_1_10001

	local var_38_0

	if not arg_38_0.dressHelperDic then
		var_38_0 = {}
	end

	for iter_38_0, iter_38_1 in var_1_10001(var_38_0) do
		iter_38_1:Destroy()
	end

	local var_38_1 = 1
	local var_38_2

	if not arg_38_0.playerSlotCount then
		var_38_2 = 0
	end

	for iter_38_2 = var_38_1, var_38_2 do
		arg_38_0:UnloadCharacter(iter_38_2)
	end

	IsNil = var_38_1

	if not var_38_1(arg_38_0.roleContainer) then
		Object = var_1

		var_1.Destroy(arg_38_0.roleContainer.gameObject)

		arg_38_0.roleContainer = nil
	end

	return
end

function var_0_1.ResetCameraMask(arg_39_0)
	IslandCameraMgr = var_1_10001

	local var_39_0 = var_1_10001.instance

	IsNil = var_1_10002

	if var_1_10002(var_39_0) then
		CheatTavernCameraMgr = var_2
		var_39_0 = var_2.instance
	end

	if arg_39_0.defaultCullingMask and var_39_0 then
		local var_39_1 = var_39_0._mainCamera

		LuaHelper = var_1_10003

		var_1_10003.ResetCamCullingMask(var_39_1, arg_39_0.defaultCullingMask)
	end

	return
end

function var_0_1.ActivityPlayerCamera(arg_40_0)
	IslandCameraMgr = var_1_10001

	if not var_1_10001.instance then
		return
	end

	IslandCameraMgr = var_1

	local var_40_0 = var_1.instance
	local var_40_1 = var_1.ActiveVirtualCamera

	IslandConst = var_1_10004

	var_40_1(var_40_0, var_1_10004.FOLLOW_CAMERA_NAME)

	return
end

function var_0_1.OnHide(arg_41_0)
	var_0_1.super.OnHide(arg_41_0)
	arg_41_0:ClearCharacterScene()

	return
end

function var_0_1.OnDisable(arg_42_0)
	arg_42_0:RemoveSubLayers(arg_42_0:GetContext())
	arg_42_0:ClearCharacterScene()

	return
end

function var_0_1.OnDestroy(arg_43_0)
	arg_43_0:ClearCharacterScene()

	pairs = var_1

	local var_43_0

	if not arg_43_0.cards then
		var_43_0 = {}
	end

	for iter_43_0, iter_43_1 in var_1(var_43_0) do
		iter_43_1:Dispose()
	end

	arg_43_0.cards = nil

	return
end

function var_0_1.GetActiveCamName(arg_44_0)
	IslandConst = var_1_10001

	return var_1_10001.CHARA_CAMERA_NAME
end

function var_0_1.OnCharLoaded(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_0.dressHelperDic[arg_45_1] then
		var_3:OnRoleLoaded(arg_45_0.modelDataDic[arg_45_1].role.transform, arg_45_2)
	end

	return
end

function var_0_1.LoadCharacterScene(arg_46_0, arg_46_1)
	local var_46_0 = "island/scenesres/scenes/bar/map_xyd_bar_character01_scene"

	SceneOpMgr = var_1_10003

	local var_46_1 = var_1_10003.Inst
	local var_46_2 = var_3.LoadSceneAsyncWithProgress
	local var_46_3 = var_46_0
	local var_46_4 = "map_xyd_bar_character01"

	LoadSceneMode = var_1_10008

	var_46_2(var_46_1, var_46_3, var_46_4, var_1_10008.Additive, function(arg_47_0)
		if arg_47_0 == 1 then
			arg_46_1()
		end

		return
	end)

	return
end

function var_0_1.UnLoadCharacterScene(arg_48_0, arg_48_1)
	local var_48_0 = "island/scenesres/scenes/character/map_xyd_bar_character01_scene"

	SceneOpMgr = var_1_10003

	local var_48_1 = var_1_10003.Inst

	var_3.UnloadSceneAsync(var_48_1, var_48_0, "map_xyd_bar_character01", function()
		if arg_48_1 then
			arg_48_1()
		end

		return
	end)

	return
end

function var_0_1.GetLigthEffectPath(arg_50_0)
	return "island/effect/prefab/game/bar/vfx_bar_quan_y", "island/effect/prefab/game/bar/vfx_bar_quan_b"
end

function var_0_1.OnInit(arg_51_0)
	return
end

function var_0_1.closeView(arg_52_0)
	arg_52_0.contextData.onClose()

	return
end

return var_0_1
