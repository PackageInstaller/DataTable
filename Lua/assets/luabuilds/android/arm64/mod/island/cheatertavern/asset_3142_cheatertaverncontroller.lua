local CheaterTavernController = class("CheaterTavernController", import("Mod.Island.Core.controller.IslandController"))

function CheaterTavernController:Init()
	CheaterTavernController.super.Init(self)

	return
end

function CheaterTavernController:SystemCtor()
	self.strollAllocator = IslandStrollAllocator.New(self)
	self.visibilityAllocator = IslandVisibilityAllocator.New(self)
	self.giftAllocator = IslandGiftAllocator.New(self)
	self.activityNpcAllocator = IslandActivityNpcAllocator.New(self)
	self.timeDelayCreate = IslandDelayCreationSystem.New(self)

	return
end

function CheaterTavernController:OnCoreInitFinish()
	self:NotifiyCore(ISLAND_EVT.INIT_FINISH, self.sceneData.camreaZoomData)
	self:NotifiyIsland(ISLAND_EX_EVT.INIT_FINISH)

	return
end

function CheaterTavernController:Update()
	return
end

function CheaterTavernController:AddListeners()
	self:AddIslandListener(IslandCheaterTavernMonitor.ADD_CHEATERTAVERN_PLAYER, self.OnAddCheaterPlayer)
	self:AddIslandListener(IslandCheaterTavernMonitor.INIT_PLAYER_DATA_DONE, self.OnInitPlayerDone)
	self:AddIslandListener(PlayRoomExitRoomCommand.PLAY_ROOM_EXIT_ROOM_DONE, self.OnRoomExitRoom)
	self:AddIslandListener(IslandProxy.LINK_CORE, self.OnLinkCore)

	return
end

function CheaterTavernController:RemoveListeners()
	self:RemoveIslandListener(IslandCheaterTavernMonitor.ADD_CHEATERTAVERN_PLAYER, self.OnAddCheaterPlayer)
	self:RemoveIslandListener(IslandCheaterTavernMonitor.INIT_PLAYER_DATA_DONE, self.OnInitPlayerDone)
	self:RemoveIslandListener(PlayRoomExitRoomCommand.PLAY_ROOM_EXIT_ROOM_DONE, self.OnRoomExitRoom)
	self:RemoveIslandListener(IslandProxy.LINK_CORE, self.OnLinkCore)

	return
end

function CheaterTavernController:OnAddCheaterPlayer(arg_7_1)
	if arg_7_1.id == getProxy(PlayerProxy):getRawData().id then
		self:NotifiyCore(ISLAND_EVT.INIT_CHEATERTAVERN_CAMERA, arg_7_1.seat)
	end

	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (IslandDataConvertor.IslandCheaterTavernPlayerDataToUnit(arg_7_1)))

	return
end

function CheaterTavernController:OnInitPlayerDone()
	self:NotifiyCore(CheaterTavernEvent.INITPLAYER_DATA_DONE)

	return
end

function CheaterTavernController:OnRoomExitRoom()
	self:NotifiyCore(CheaterTavernEvent.PLAY_ROOM_EXIT_ROOM_DONE)

	return
end

function CheaterTavernController:OnLinkCore(arg_10_1, ...)
	self:NotifiyCore(arg_10_1, ...)

	return
end

return CheaterTavernController
