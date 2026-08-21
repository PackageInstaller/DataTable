local var_0_0 = class("CheaterTavernController", import("Mod.Island.Core.controller.IslandController"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	return
end

function var_0_0.SystemCtor(arg_2_0)
	arg_2_0.strollAllocator = IslandStrollAllocator.New(arg_2_0)
	arg_2_0.visibilityAllocator = IslandVisibilityAllocator.New(arg_2_0)
	arg_2_0.giftAllocator = IslandGiftAllocator.New(arg_2_0)
	arg_2_0.activityNpcAllocator = IslandActivityNpcAllocator.New(arg_2_0)
	arg_2_0.timeDelayCreate = IslandDelayCreationSystem.New(arg_2_0)

	return
end

function var_0_0.OnCoreInitFinish(arg_3_0)
	arg_3_0:NotifiyCore(ISLAND_EVT.INIT_FINISH, arg_3_0.sceneData.camreaZoomData)
	arg_3_0:NotifiyIsland(ISLAND_EX_EVT.INIT_FINISH)

	return
end

function var_0_0.Update(arg_4_0)
	return
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddIslandListener(IslandCheaterTavernMonitor.ADD_CHEATERTAVERN_PLAYER, arg_5_0.OnAddCheaterPlayer)
	arg_5_0:AddIslandListener(IslandCheaterTavernMonitor.INIT_PLAYER_DATA_DONE, arg_5_0.OnInitPlayerDone)
	arg_5_0:AddIslandListener(PlayRoomExitRoomCommand.PLAY_ROOM_EXIT_ROOM_DONE, arg_5_0.OnRoomExitRoom)
	arg_5_0:AddIslandListener(IslandProxy.LINK_CORE, arg_5_0.OnLinkCore)

	return
end

function var_0_0.RemoveListeners(arg_6_0)
	arg_6_0:RemoveIslandListener(IslandCheaterTavernMonitor.ADD_CHEATERTAVERN_PLAYER, arg_6_0.OnAddCheaterPlayer)
	arg_6_0:RemoveIslandListener(IslandCheaterTavernMonitor.INIT_PLAYER_DATA_DONE, arg_6_0.OnInitPlayerDone)
	arg_6_0:RemoveIslandListener(PlayRoomExitRoomCommand.PLAY_ROOM_EXIT_ROOM_DONE, arg_6_0.OnRoomExitRoom)
	arg_6_0:RemoveIslandListener(IslandProxy.LINK_CORE, arg_6_0.OnLinkCore)

	return
end

function var_0_0.OnAddCheaterPlayer(arg_7_0, arg_7_1)
	if arg_7_1.id == getProxy(PlayerProxy):getRawData().id then
		arg_7_0:NotifiyCore(ISLAND_EVT.INIT_CHEATERTAVERN_CAMERA, arg_7_1.seat)
	end

	arg_7_0:NotifiyCore(ISLAND_EVT.GEN_UNIT, (IslandDataConvertor.IslandCheaterTavernPlayerDataToUnit(arg_7_1)))

	return
end

function var_0_0.OnInitPlayerDone(arg_8_0)
	arg_8_0:NotifiyCore(CheaterTavernEvent.INITPLAYER_DATA_DONE)

	return
end

function var_0_0.OnRoomExitRoom(arg_9_0)
	arg_9_0:NotifiyCore(CheaterTavernEvent.PLAY_ROOM_EXIT_ROOM_DONE)

	return
end

function var_0_0.OnLinkCore(arg_10_0, arg_10_1, ...)
	arg_10_0:NotifiyCore(arg_10_1, ...)

	return
end

return var_0_0
