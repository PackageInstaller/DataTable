class = var_0_10000

local var_0_0 = "CheaterTavernController"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.controller.IslandController"))

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	return
end

function var_0_1.SystemCtor(arg_2_0)
	IslandStrollAllocator = var_1_10001
	arg_2_0.strollAllocator = var_1_10001.New(arg_2_0)
	IslandVisibilityAllocator = var_1
	arg_2_0.visibilityAllocator = var_1.New(arg_2_0)
	IslandGiftAllocator = var_1
	arg_2_0.giftAllocator = var_1.New(arg_2_0)
	IslandActivityNpcAllocator = var_1
	arg_2_0.activityNpcAllocator = var_1.New(arg_2_0)
	IslandDelayCreationSystem = var_1
	arg_2_0.timeDelayCreate = var_1.New(arg_2_0)

	return
end

function var_0_1.OnCoreInitFinish(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.NotifiyCore

	ISLAND_EVT = var_1_10004

	var_3_1(var_3_0, var_1_10004.INIT_FINISH, arg_3_0.sceneData.camreaZoomData)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.NotifiyIsland

	ISLAND_EX_EVT = var_4

	var_3_3(var_3_2, var_4.INIT_FINISH)

	return
end

function var_0_1.Update(arg_4_0)
	return
end

function var_0_1.AddListeners(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.AddIslandListener

	IslandCheaterTavernMonitor = var_1_10004

	var_5_1(var_5_0, var_1_10004.ADD_CHEATERTAVERN_PLAYER, arg_5_0.OnAddCheaterPlayer)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.AddIslandListener

	IslandCheaterTavernMonitor = var_4

	var_5_3(var_5_2, var_4.INIT_PLAYER_DATA_DONE, arg_5_0.OnInitPlayerDone)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.AddIslandListener

	PlayRoomExitRoomCommand = var_4

	var_5_5(var_5_4, var_4.PLAY_ROOM_EXIT_ROOM_DONE, arg_5_0.OnRoomExitRoom)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.AddIslandListener

	IslandProxy = var_4

	var_5_7(var_5_6, var_4.LINK_CORE, arg_5_0.OnLinkCore)

	return
end

function var_0_1.RemoveListeners(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.RemoveIslandListener

	IslandCheaterTavernMonitor = var_1_10004

	var_6_1(var_6_0, var_1_10004.ADD_CHEATERTAVERN_PLAYER, arg_6_0.OnAddCheaterPlayer)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.RemoveIslandListener

	IslandCheaterTavernMonitor = var_4

	var_6_3(var_6_2, var_4.INIT_PLAYER_DATA_DONE, arg_6_0.OnInitPlayerDone)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.RemoveIslandListener

	PlayRoomExitRoomCommand = var_4

	var_6_5(var_6_4, var_4.PLAY_ROOM_EXIT_ROOM_DONE, arg_6_0.OnRoomExitRoom)

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.RemoveIslandListener

	IslandProxy = var_4

	var_6_7(var_6_6, var_4.LINK_CORE, arg_6_0.OnLinkCore)

	return
end

function var_0_1.OnAddCheaterPlayer(arg_7_0, arg_7_1)
	IslandDataConvertor = var_1_10002

	local var_7_0 = var_1_10002.IslandCheaterTavernPlayerDataToUnit(arg_7_1)
	local var_7_1 = arg_7_1.id

	getProxy = var_4
	PlayerProxy = var_1_10006

	local var_7_2 = var_4(var_1_10006)

	if var_7_1 == var_4.getRawData(var_7_2).id then
		local var_7_3 = arg_7_0
		local var_7_4 = arg_7_0.NotifiyCore

		ISLAND_EVT = var_7_2

		var_7_4(var_7_3, var_7_2.INIT_CHEATERTAVERN_CAMERA, arg_7_1.seat)
	end

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0.NotifiyCore

	ISLAND_EVT = var_7_2

	var_7_6(var_7_5, var_7_2.GEN_UNIT, var_7_0)

	return
end

function var_0_1.OnInitPlayerDone(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.NotifiyCore

	CheaterTavernEvent = var_1_10004

	var_8_1(var_8_0, var_1_10004.INITPLAYER_DATA_DONE)

	return
end

function var_0_1.OnRoomExitRoom(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.NotifiyCore

	CheaterTavernEvent = var_1_10004

	var_9_1(var_9_0, var_1_10004.PLAY_ROOM_EXIT_ROOM_DONE)

	return
end

function var_0_1.OnLinkCore(arg_10_0, arg_10_1, ...)
	arg_10_0:NotifiyCore(arg_10_1, ...)

	return
end

return var_0_1
