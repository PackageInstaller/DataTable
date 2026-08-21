local var_0_0 = class("IslandCheaterTavernGameView", import("Mod.Island.Core.View.IslandView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	return
end

function var_0_0.OnSceneInited(arg_2_0)
	return
end

function var_0_0.CreateViews(arg_3_0)
	arg_3_0.views = {}

	return
end

function var_0_0.AfterCoreInit(arg_4_0)
	if arg_4_0.weatherSystem then
		arg_4_0.weatherSystem:Dispose()
	end

	arg_4_0.weatherSystem = IslandWeatherSystem.New(arg_4_0)

	arg_4_0:InitSceneGameObject()

	arg_4_0.isSceneLoaded = true

	arg_4_0:PlayBGM()

	return
end

function var_0_0.IsLoaded(arg_5_0)
	return _.all(arg_5_0.views, function(arg_6_0)
		return arg_6_0:IsLoaded()
	end) and _.all(arg_5_0:GetAllUnits(), function(arg_7_0)
		return arg_7_0:IsLoaded()
	end)
end

function var_0_0.IsInit(arg_8_0)
	return arg_8_0.isInit
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddListener(ISLAND_EVT.GEN_UNIT, arg_9_0.OnGenUnit)
	arg_9_0:AddListener(ISLAND_EVT.RMOVE_UNIT, arg_9_0.OnRemoveUnit)
	arg_9_0:AddListener(ISLAND_EVT.INIT_CHEATERTAVERN_CAMERA, arg_9_0.OnInitCamera)
	arg_9_0:AddListener(CheaterTavernEvent.PLAYER_QUESTION_ANIMATION, arg_9_0.OnPlayerQuestion)
	arg_9_0:AddListener(CheaterTavernEvent.SHOOT_AND_TURN_TABLE, arg_9_0.OnPlayerShoot)
	arg_9_0:AddListener(CheaterTavernEvent.PLAYER_OUT_ANIMATION, arg_9_0.OnPlayerOut)
	arg_9_0:AddListener(CheaterTavernEvent.FIRST_TAKE_SHOOT_TIPS, arg_9_0.OnFirstTakeShootTip)
	arg_9_0:AddListener(CheaterTavernEvent.CLOSE_PREPARE_MAIN_PAGE, arg_9_0.OnCloseCheaterMainPage)
	arg_9_0:AddListener(CheaterTavernEvent.PLAY_ROOM_EXIT_ROOM_DONE, arg_9_0.OnExitRoomDone)
	arg_9_0:AddListener(CheaterTavernEvent.INITPLAYER_DATA_DONE, arg_9_0.OnInitPlayerDone)
	arg_9_0:AddListener(CheaterTavernEvent.PLAY_WIN_ANIMATION, arg_9_0.OnPlayWinAnimation)

	return
end

function var_0_0.RemoveListeners(arg_10_0)
	arg_10_0:RemoveListener(ISLAND_EVT.GEN_UNIT, arg_10_0.OnGenUnit)
	arg_10_0:RemoveListener(ISLAND_EVT.RMOVE_UNIT, arg_10_0.OnRemoveUnit)
	arg_10_0:RemoveListener(ISLAND_EVT.INIT_CHEATERTAVERN_CAMERA, arg_10_0.OnInitCamera)
	arg_10_0:RemoveListener(CheaterTavernEvent.PLAYER_QUESTION_ANIMATION, arg_10_0.OnPlayerQuestion)
	arg_10_0:RemoveListener(CheaterTavernEvent.SHOOT_AND_TURN_TABLE, arg_10_0.OnPlayerShoot)
	arg_10_0:RemoveListener(CheaterTavernEvent.PLAYER_OUT_ANIMATION, arg_10_0.OnPlayerOut)
	arg_10_0:RemoveListener(CheaterTavernEvent.FIRST_TAKE_SHOOT_TIPS, arg_10_0.OnFirstTakeShootTip)
	arg_10_0:RemoveListener(CheaterTavernEvent.CLOSE_PREPARE_MAIN_PAGE, arg_10_0.OnCloseCheaterMainPage)
	arg_10_0:RemoveListener(CheaterTavernEvent.PLAY_ROOM_EXIT_ROOM_DONE, arg_10_0.OnExitRoomDone)
	arg_10_0:RemoveListener(CheaterTavernEvent.INITPLAYER_DATA_DONE, arg_10_0.OnInitPlayerDone)
	arg_10_0:RemoveListener(CheaterTavernEvent.PLAY_WIN_ANIMATION, arg_10_0.OnPlayWinAnimation)

	return
end

function var_0_0.OnInitCamera(arg_11_0, arg_11_1)
	print("todo:lookSeet0" .. Time.frameCount)
	CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. arg_11_1)

	CheatTavernCameraMgr.instance._mainCamera.enabled = true

	return
end

function var_0_0.PlayBGM(arg_12_0)
	if not arg_12_0.isSceneLoaded then
		return
	end

	var_0_0.super.PlayBGM(arg_12_0)

	return
end

function var_0_0.OnCloseCheaterMainPage(arg_13_0)
	arg_13_0:NotifiyMeditor(IslandBaseMediator.SWITCH_MAP, arg_13_0:GetSelfIsland():GetLastExitPosition().mapId)

	return
end

function var_0_0.OnFirstTakeShootTip(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskTableId)

	if var_14_0 then
		var_14_0:OnFirstTakeShootTip(arg_14_1)
	end

	return
end

function var_0_0.OnPlayerQuestion(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_PLAYER, arg_15_1)

	if var_15_0 then
		var_15_0:OnPlayerQuestion(arg_15_2)
	end

	if arg_15_3 then
		local var_15_1 = arg_15_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskCharIdList[arg_15_3])

		if var_15_1 then
			var_15_1:OnPlayerQuestion()
		end
	end

	return
end

function var_0_0.OnPlayWinAnimation(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_PLAYER, arg_16_1)

	if var_16_0 then
		var_16_0:OnPlayWinAnimation(arg_16_2, arg_16_3)
	end

	if arg_16_2 then
		local var_16_1 = arg_16_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskCharIdList[arg_16_3])

		if var_16_1 then
			var_16_1:OnPlayWinAnimation()
		end
	end

	return
end

function var_0_0.OnPlayerShoot(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = arg_17_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskTableId)

	if var_17_0 then
		var_17_0:OnShoot(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	end

	return
end

function var_0_0.OnPlayerOut(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_PLAYER, arg_18_1)

	if var_18_0 then
		var_18_0:OnPlayerOut(arg_18_1, arg_18_2)
	end

	local var_18_1 = arg_18_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskCharIdList[arg_18_2])

	if var_18_1 then
		var_18_1:OnPlayerOut(arg_18_3)
	end

	return
end

function var_0_0.OnExitRoomDone(arg_19_0)
	arg_19_0:ClearSceneObject()
	arg_19_0:InitSceneGameObject()

	return
end

function var_0_0.OnInitPlayerDone(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(IslandCheaterTavernConst.deskCharIdList) do
		local var_20_0 = arg_20_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, iter_20_1)

		if var_20_0 then
			var_20_0:InitDisplayState()
		end
	end

	return
end

function var_0_0.ClearSceneObject(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs((arg_21_0:GetUnitListByKey(IslandConst.UNIT_LIST_PLAYER))) do
		table.insert({}, iter_21_1.id)
	end

	for iter_21_2, iter_21_3 in ipairs({}) do
		arg_21_0:OnRemoveUnit(IslandConst.UNIT_LIST_PLAYER, iter_21_3)
	end

	for iter_21_4, iter_21_5 in ipairs((arg_21_0:GetUnitListByKey(IslandConst.UNIT_LIST_CHEATER_ITEM))) do
		table.insert({}, iter_21_5.id)
	end

	for iter_21_6, iter_21_7 in ipairs({}) do
		arg_21_0:OnRemoveUnit(IslandConst.UNIT_LIST_CHEATER_ITEM, iter_21_7)
	end

	return
end

function var_0_0.InitSceneGameObject(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(IslandCheaterTavernConst.deskCharIdList) do
		if pg.island_world_objects[iter_22_1].unitId > 0 then
			table.insert({}, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[iter_22_1], {
				typ = IslandConst.UNIT_TYPE_CHEATERTAVERN_CHAIR,
				index = iter_22_0
			})))
		end
	end

	table.insert({}, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[IslandCheaterTavernConst.deskTableId], {
		typ = IslandConst.UNIT_TYPE_CHEATERTAVERN_TABLE
	})))

	for iter_22_2, iter_22_3 in ipairs({}) do
		arg_22_0:OnGenUnit(iter_22_3)
	end

	return
end

function var_0_0.RestartGame(arg_23_0)
	return
end

function var_0_0.OnEndPerformance(arg_24_0)
	return
end

function var_0_0.DisableOp(arg_25_0)
	return
end

function var_0_0.EnableOp(arg_26_0)
	return
end

function var_0_0.OnDispose(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.views) do
		iter_27_1:Dispose()
	end

	arg_27_0.weatherSystem:Dispose()

	return
end

function var_0_0.OnRemoveUnit(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:GetUnitListByKey(arg_28_1)
	local var_28_1 = 0

	for iter_28_0, iter_28_1 in ipairs(var_28_0 or {}) do
		if iter_28_1.id == arg_28_2 then
			var_28_1 = iter_28_0

			break
		end
	end

	if var_28_1 > 0 then
		arg_28_0:RemoveUnit(var_28_0[var_28_1])
		var_28_0[var_28_1]:Dispose()
	end

	return
end

function var_0_0.OnAllPageClose(arg_29_0)
	arg_29_0.anyPageOpen = false

	return
end

function var_0_0.OnAnyPageOpen(arg_30_0, arg_30_1)
	arg_30_0.anyPageOpen = true

	return
end

function var_0_0.OnUnTracking(arg_31_0, arg_31_1)
	return
end

return var_0_0
