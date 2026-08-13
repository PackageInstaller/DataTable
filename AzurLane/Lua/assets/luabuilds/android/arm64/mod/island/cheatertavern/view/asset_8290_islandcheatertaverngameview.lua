class = var_0_10000

local var_0_0 = "IslandCheaterTavernGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandView"))

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	return
end

function var_0_1.OnSceneInited(arg_2_0)
	return
end

function var_0_1.CreateViews(arg_3_0)
	arg_3_0.views = {}

	return
end

function var_0_1.AfterCoreInit(arg_4_0)
	if arg_4_0.weatherSystem then
		local var_4_0 = arg_4_0.weatherSystem

		var_1.Dispose(var_4_0)
	end

	IslandWeatherSystem = var_1
	arg_4_0.weatherSystem = var_1.New(arg_4_0)

	arg_4_0:InitSceneGameObject()

	arg_4_0.isSceneLoaded = true

	arg_4_0:PlayBGM()

	return
end

function var_0_1.IsLoaded(arg_5_0)
	local var_5_0 = arg_5_0:GetAllUnits()

	_ = var_1_10002

	local var_5_1

	if var_1_10002.all(arg_5_0.views, function(arg_6_0)
		return arg_6_0:IsLoaded()
	end) then
		_ = var_5_1
		var_5_1 = var_5_1.all(var_5_0, function(arg_7_0)
			return arg_7_0:IsLoaded()
		end)
	end

	return var_5_1
end

function var_0_1.IsInit(arg_8_0)
	return arg_8_0.isInit
end

function var_0_1.AddListeners(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.AddListener

	ISLAND_EVT = var_1_10004

	var_9_1(var_9_0, var_1_10004.GEN_UNIT, arg_9_0.OnGenUnit)

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.AddListener

	ISLAND_EVT = var_4

	var_9_3(var_9_2, var_4.RMOVE_UNIT, arg_9_0.OnRemoveUnit)

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.AddListener

	ISLAND_EVT = var_4

	var_9_5(var_9_4, var_4.INIT_CHEATERTAVERN_CAMERA, arg_9_0.OnInitCamera)

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.AddListener

	CheaterTavernEvent = var_4

	var_9_7(var_9_6, var_4.PLAYER_QUESTION_ANIMATION, arg_9_0.OnPlayerQuestion)

	local var_9_8 = arg_9_0
	local var_9_9 = arg_9_0.AddListener

	CheaterTavernEvent = var_4

	var_9_9(var_9_8, var_4.SHOOT_AND_TURN_TABLE, arg_9_0.OnPlayerShoot)

	local var_9_10 = arg_9_0
	local var_9_11 = arg_9_0.AddListener

	CheaterTavernEvent = var_4

	var_9_11(var_9_10, var_4.PLAYER_OUT_ANIMATION, arg_9_0.OnPlayerOut)

	local var_9_12 = arg_9_0
	local var_9_13 = arg_9_0.AddListener

	CheaterTavernEvent = var_4

	var_9_13(var_9_12, var_4.FIRST_TAKE_SHOOT_TIPS, arg_9_0.OnFirstTakeShootTip)

	local var_9_14 = arg_9_0
	local var_9_15 = arg_9_0.AddListener

	CheaterTavernEvent = var_4

	var_9_15(var_9_14, var_4.CLOSE_PREPARE_MAIN_PAGE, arg_9_0.OnCloseCheaterMainPage)

	local var_9_16 = arg_9_0
	local var_9_17 = arg_9_0.AddListener

	CheaterTavernEvent = var_4

	var_9_17(var_9_16, var_4.PLAY_ROOM_EXIT_ROOM_DONE, arg_9_0.OnExitRoomDone)

	local var_9_18 = arg_9_0
	local var_9_19 = arg_9_0.AddListener

	CheaterTavernEvent = var_4

	var_9_19(var_9_18, var_4.INITPLAYER_DATA_DONE, arg_9_0.OnInitPlayerDone)

	local var_9_20 = arg_9_0
	local var_9_21 = arg_9_0.AddListener

	CheaterTavernEvent = var_4

	var_9_21(var_9_20, var_4.PLAY_WIN_ANIMATION, arg_9_0.OnPlayWinAnimation)

	return
end

function var_0_1.RemoveListeners(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.RemoveListener

	ISLAND_EVT = var_1_10004

	var_10_1(var_10_0, var_1_10004.GEN_UNIT, arg_10_0.OnGenUnit)

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.RemoveListener

	ISLAND_EVT = var_4

	var_10_3(var_10_2, var_4.RMOVE_UNIT, arg_10_0.OnRemoveUnit)

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.RemoveListener

	ISLAND_EVT = var_4

	var_10_5(var_10_4, var_4.INIT_CHEATERTAVERN_CAMERA, arg_10_0.OnInitCamera)

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.RemoveListener

	CheaterTavernEvent = var_4

	var_10_7(var_10_6, var_4.PLAYER_QUESTION_ANIMATION, arg_10_0.OnPlayerQuestion)

	local var_10_8 = arg_10_0
	local var_10_9 = arg_10_0.RemoveListener

	CheaterTavernEvent = var_4

	var_10_9(var_10_8, var_4.SHOOT_AND_TURN_TABLE, arg_10_0.OnPlayerShoot)

	local var_10_10 = arg_10_0
	local var_10_11 = arg_10_0.RemoveListener

	CheaterTavernEvent = var_4

	var_10_11(var_10_10, var_4.PLAYER_OUT_ANIMATION, arg_10_0.OnPlayerOut)

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.RemoveListener

	CheaterTavernEvent = var_4

	var_10_13(var_10_12, var_4.FIRST_TAKE_SHOOT_TIPS, arg_10_0.OnFirstTakeShootTip)

	local var_10_14 = arg_10_0
	local var_10_15 = arg_10_0.RemoveListener

	CheaterTavernEvent = var_4

	var_10_15(var_10_14, var_4.CLOSE_PREPARE_MAIN_PAGE, arg_10_0.OnCloseCheaterMainPage)

	local var_10_16 = arg_10_0
	local var_10_17 = arg_10_0.RemoveListener

	CheaterTavernEvent = var_4

	var_10_17(var_10_16, var_4.PLAY_ROOM_EXIT_ROOM_DONE, arg_10_0.OnExitRoomDone)

	local var_10_18 = arg_10_0
	local var_10_19 = arg_10_0.RemoveListener

	CheaterTavernEvent = var_4

	var_10_19(var_10_18, var_4.INITPLAYER_DATA_DONE, arg_10_0.OnInitPlayerDone)

	local var_10_20 = arg_10_0
	local var_10_21 = arg_10_0.RemoveListener

	CheaterTavernEvent = var_4

	var_10_21(var_10_20, var_4.PLAY_WIN_ANIMATION, arg_10_0.OnPlayWinAnimation)

	return
end

function var_0_1.OnInitCamera(arg_11_0, arg_11_1)
	local var_11_0 = "lookSeet0" .. arg_11_1

	print = var_3

	local var_11_1 = "todo:lookSeet0"

	Time = var_1_10006

	var_3(var_11_1 .. var_1_10006.frameCount)

	CheatTavernCameraMgr = var_3

	local var_11_2 = var_3.instance

	var_3.ActiveVirtualCamera(var_11_2, var_11_0)

	CheatTavernCameraMgr = var_3
	var_3.instance._mainCamera.enabled = true

	return
end

function var_0_1.PlayBGM(arg_12_0)
	if not arg_12_0.isSceneLoaded then
		return
	end

	var_0_1.super.PlayBGM(arg_12_0)

	return
end

function var_0_1.OnCloseCheaterMainPage(arg_13_0)
	local var_13_0 = arg_13_0:GetSelfIsland()
	local var_13_1 = arg_13_0
	local var_13_2 = arg_13_0.NotifiyMeditor

	IslandBaseMediator = var_1_10005

	var_13_2(var_13_1, var_1_10005.SWITCH_MAP, var_13_0:GetLastExitPosition().mapId)

	return
end

function var_0_1.OnFirstTakeShootTip(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	local var_14_2 = var_1_10005.UNIT_LIST_CHEATER_ITEM

	IslandCheaterTavernConst = var_1_10006

	if var_14_1(var_14_0, var_14_2, var_1_10006.deskTableId) then
		var_2:OnFirstTakeShootTip(arg_14_1)
	end

	return
end

function var_0_1.OnPlayerQuestion(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetUnitModuleWithType

	IslandConst = var_1_10007

	if var_15_1(var_15_0, var_1_10007.UNIT_LIST_PLAYER, arg_15_1) then
		var_4:OnPlayerQuestion(arg_15_2)
	end

	if arg_15_3 then
		IslandCheaterTavernConst = var_1_10005

		local var_15_2 = var_1_10005.deskCharIdList[arg_15_3]
		local var_15_3 = arg_15_0
		local var_15_4 = arg_15_0.GetUnitModuleWithType

		IslandConst = var_1_10009

		if var_15_4(var_15_3, var_1_10009.UNIT_LIST_CHEATER_ITEM, var_15_2) then
			var_6:OnPlayerQuestion()
		end
	end

	return
end

function var_0_1.OnPlayWinAnimation(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.GetUnitModuleWithType

	IslandConst = var_1_10007

	if var_16_1(var_16_0, var_1_10007.UNIT_LIST_PLAYER, arg_16_1) then
		var_4:OnPlayWinAnimation(arg_16_2, arg_16_3)
	end

	if arg_16_2 then
		IslandCheaterTavernConst = var_1_10005

		local var_16_2 = var_1_10005.deskCharIdList[arg_16_3]
		local var_16_3 = arg_16_0
		local var_16_4 = arg_16_0.GetUnitModuleWithType

		IslandConst = var_1_10009

		if var_16_4(var_16_3, var_1_10009.UNIT_LIST_CHEATER_ITEM, var_16_2) then
			var_6:OnPlayWinAnimation()
		end
	end

	return
end

function var_0_1.OnPlayerShoot(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.GetUnitModuleWithType

	IslandConst = var_1_10009

	local var_17_2 = var_1_10009.UNIT_LIST_CHEATER_ITEM

	IslandCheaterTavernConst = var_1_10010

	if var_17_1(var_17_0, var_17_2, var_1_10010.deskTableId) then
		var_6:OnShoot(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	end

	return
end

function var_0_1.OnPlayerOut(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetUnitModuleWithType

	IslandConst = var_1_10007

	if var_18_1(var_18_0, var_1_10007.UNIT_LIST_PLAYER, arg_18_1) then
		var_4:OnPlayerOut(arg_18_1, arg_18_2)
	end

	local var_18_2 = arg_18_0
	local var_18_3 = arg_18_0.GetUnitModuleWithType

	IslandConst = var_8

	local var_18_4 = var_8.UNIT_LIST_CHEATER_ITEM

	IslandCheaterTavernConst = var_1_10009

	if var_18_3(var_18_2, var_18_4, var_1_10009.deskCharIdList[arg_18_2]) then
		var_5:OnPlayerOut(arg_18_3)
	end

	return
end

function var_0_1.OnExitRoomDone(arg_19_0)
	arg_19_0:ClearSceneObject()
	arg_19_0:InitSceneGameObject()

	return
end

function var_0_1.OnInitPlayerDone(arg_20_0)
	ipairs = var_1_10001
	IslandCheaterTavernConst = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10001(var_1_10003.deskCharIdList) do
		local var_20_0 = arg_20_0
		local var_20_1 = arg_20_0.GetUnitModuleWithType

		IslandConst = var_1_10009

		if var_20_1(var_20_0, var_1_10009.UNIT_LIST_CHEATER_ITEM, iter_20_1) then
			var_1_10009 = var_6

			var_6.InitDisplayState(var_1_10009)
		end
	end

	return
end

function var_0_1.ClearSceneObject(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.GetUnitListByKey

	IslandConst = var_1_10004

	local var_21_2 = var_21_1(var_21_0, var_1_10004.UNIT_LIST_PLAYER)
	local var_21_3 = {}

	ipairs = var_21_0

	for iter_21_0, iter_21_1 in var_21_0(var_21_2) do
		table = var_1_10008

		var_1_10008.insert(var_21_3, iter_21_1.id)
	end

	ipairs = var_3

	for iter_21_2, iter_21_3 in var_3(var_21_3) do
		var_1_10010 = arg_21_0

		local var_21_4 = arg_21_0.OnRemoveUnit

		IslandConst = var_1_10011

		var_21_4(var_1_10010, var_1_10011.UNIT_LIST_PLAYER, iter_21_3)
	end

	local var_21_5 = {}
	local var_21_6 = arg_21_0
	local var_21_7 = arg_21_0.GetUnitListByKey

	IslandConst = iter_21_3

	local var_21_8 = var_21_7(var_21_6, iter_21_3.UNIT_LIST_CHEATER_ITEM)

	ipairs = var_5

	for iter_21_4, iter_21_5 in var_5(var_21_8) do
		table = var_1_10010

		var_1_10010.insert(var_21_5, iter_21_5.id)
	end

	ipairs = var_5

	for iter_21_6, iter_21_7 in var_5(var_21_5) do
		local var_21_9 = arg_21_0
		local var_21_10 = arg_21_0.OnRemoveUnit

		IslandConst = var_1_10013

		var_21_10(var_21_9, var_1_10013.UNIT_LIST_CHEATER_ITEM, iter_21_7)
	end

	return
end

function var_0_1.InitSceneGameObject(arg_22_0)
	local var_22_0 = {}

	ipairs = var_1_10002
	IslandCheaterTavernConst = var_1_10004

	for iter_22_0, iter_22_1 in var_1_10002(var_1_10004.deskCharIdList) do
		pg = var_1_10007

		local var_22_1 = var_1_10007.island_world_objects[iter_22_1].unitId

		if 0 < var_22_1 then
			local var_22_2 = {}

			IslandConst = var_9
			var_22_2.typ = var_9.UNIT_TYPE_CHEATERTAVERN_CHAIR
			var_22_2.index = iter_22_0
			IslandDataConvertor = var_9

			local var_22_3 = var_9.WorldObj2IslandUnit(var_1_10007, var_22_2)

			table = var_1_10010

			var_1_10010.insert(var_22_0, var_22_3)
		end
	end

	pg = var_2

	local var_22_4 = var_2.island_world_objects

	IslandCheaterTavernConst = var_3

	local var_22_5 = var_22_4[var_3.deskTableId]
	local var_22_6 = {}

	IslandConst = var_4
	var_22_6.typ = var_4.UNIT_TYPE_CHEATERTAVERN_TABLE
	IslandDataConvertor = var_4

	local var_22_7 = var_4.WorldObj2IslandUnit(var_22_5, var_22_6)

	table = iter_22_0

	iter_22_0.insert(var_22_0, var_22_7)

	ipairs = var_5

	for iter_22_2, iter_22_3 in var_5(var_22_0) do
		arg_22_0:OnGenUnit(iter_22_3)
	end

	return
end

function var_0_1.RestartGame(arg_23_0)
	return
end

function var_0_1.OnEndPerformance(arg_24_0)
	return
end

function var_0_1.DisableOp(arg_25_0)
	return
end

function var_0_1.EnableOp(arg_26_0)
	return
end

function var_0_1.OnDispose(arg_27_0)
	ipairs = var_1_10001

	for iter_27_0, iter_27_1 in var_1_10001(arg_27_0.views) do
		iter_27_1:Dispose()
	end

	local var_27_0 = arg_27_0.weatherSystem

	var_1.Dispose(var_27_0)

	return
end

function var_0_1.OnRemoveUnit(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.GetUnitListByKey(var_28_0, arg_28_1)
	local var_28_2 = 0

	ipairs = var_28_0

	for iter_28_0, iter_28_1 in var_28_0(var_28_1 or {}) do
		if iter_28_1.id == arg_28_2 then
			var_28_2 = iter_28_0

			break
		end
	end

	if var_28_2 > 0 then
		local var_28_3 = var_28_1[var_28_2]

		arg_28_0:RemoveUnit(var_28_3)
		var_28_3:Dispose()
	end

	return
end

function var_0_1.OnAllPageClose(arg_29_0)
	arg_29_0.anyPageOpen = false

	return
end

function var_0_1.OnAnyPageOpen(arg_30_0, arg_30_1)
	arg_30_0.anyPageOpen = true

	return
end

function var_0_1.OnUnTracking(arg_31_0, arg_31_1)
	return
end

return var_0_1
