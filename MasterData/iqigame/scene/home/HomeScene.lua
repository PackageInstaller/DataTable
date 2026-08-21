-- chunkname: @IQIGame\\Scene\\Home\\HomeScene.lua

local HomeRoom = require("IQIGame/Scene/Home/HomeRoom")
local PlayerActor = require("IQIGame/Scene/Home/Actor/PlayerActor")
local PlayerController = require("IQIGame/Scene/Home/Controller/PlayerController")
local HomeScene = {
	sceneCid = 0
}

function HomeScene.New(sceneCid)
	local obj = Clone(HomeScene)

	obj:__Init(sceneCid)

	return obj
end

function HomeScene:__Init(sceneCid)
	self:__LoadRoom(sceneCid, function()
		self:__OnSceneReady()
	end)
	self:__InitEventDelegate()
	self:__AddListeners()
end

function HomeScene:__InitEventDelegate()
	function self.__delegateOnHomePlayerActorCollisionPartEnterEvent(_actorCom)
		self:__OnHomePlayerActorCollisionPartEnterEvent(_actorCom)
	end

	function self.__delegateOnHomePlayerActorCollisionPartExitEvent(_actorCom)
		self:__OnHomePlayerActorCollisionPartExitEvent(_actorCom)
	end

	function self.__delegateOnHomeDataChange()
		self:__OnHomeDataChange()
	end

	function self.refreshAllComponentsEvent()
		self.room:RefreshAllComponent()
	end
end

function HomeScene:__AddListeners()
	EventDispatcher.AddEventListener(EventID.HomePlayerActorCollisionPartEnterEvent, self.__delegateOnHomePlayerActorCollisionPartEnterEvent)
	EventDispatcher.AddEventListener(EventID.HomePlayerActorCollisionPartExitEvent, self.__delegateOnHomePlayerActorCollisionPartExitEvent)
	EventDispatcher.AddEventListener(EventID.HomeDataChange, self.__delegateOnHomeDataChange)
	EventDispatcher.AddEventListener(EventID.WorldMapRoom_RefreshAllComponentsEvent, self.refreshAllComponentsEvent)
end

function HomeScene:__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.HomePlayerActorCollisionPartEnterEvent, self.__delegateOnHomePlayerActorCollisionPartEnterEvent)
	EventDispatcher.RemoveEventListener(EventID.HomePlayerActorCollisionPartExitEvent, self.__delegateOnHomePlayerActorCollisionPartExitEvent)
	EventDispatcher.RemoveEventListener(EventID.HomeDataChange, self.__delegateOnHomeDataChange)
	EventDispatcher.RemoveEventListener(EventID.HomeDataChange, self.__delegateOnHomeDataChange)
	EventDispatcher.RemoveEventListener(EventID.WorldMapRoom_RefreshAllComponentsEvent, self.refreshAllComponentsEvent)
end

function HomeScene:OnFrameUpdate()
	if self.playerActor ~= nil then
		self.playerActor:OnFrameUpdate()
	end

	if self.room ~= nil then
		self.room:OnFrameUpdate()
	end
end

function HomeScene:Dispose()
	self:__RemoveListeners()
	self.playerActor:Dispose()

	self.playerActor = nil

	self.room:Dispose()

	self.room = nil
end

function HomeScene:__CreatePlayer()
	local playerEntityId = 8001

	if PlayerModule.PlayerInfo.baseInfo.sex == 1 then
		playerEntityId = 8003
	end

	self.playerActor = PlayerActor.New(playerEntityId, PlayerActor, PlayerController, function()
		self:__OnMountPlayer()
		EventDispatcher.Dispatch(EventID.JoystickDirectTransform)
	end)
end

function HomeScene:__OnHomePlayerActorCollisionPartEnterEvent(_actorCom)
	return
end

function HomeScene:__OnPlayerCollisionTranslateDoorPart(part)
	return
end

function HomeScene:__OnHomePlayerActorCollisionPartExitEvent(_actorCom)
	if _actorCom.ActorType == Constant.HomeSceneActorType.TranslateDoorActor then
		EventDispatcher.Dispatch(EventID.HideHomeChangeRoomSelectListView)
	end
end

function HomeScene:__LoadRoom(sceneCid, callback)
	self.sceneCid = sceneCid
	self.room = HomeRoom.New(sceneCid, callback)
end

function HomeScene:ChangeRoom(sceneCid, playerBornPos)
	EventDispatcher.Dispatch(EventID.SetMainUIScreenMaskActive, true)
	self.room:Dispose()
	self:__LoadRoom(sceneCid, function()
		self:__OnMountPlayer(playerBornPos)
	end)
end

function HomeScene:__OnSceneReady()
	self:__CreatePlayer()
end

function HomeScene:__OnMountPlayer(playerBornPos)
	local trans = self.playerActor.skinEntityGo.transform

	self.room:__BindPlayer(trans, playerBornPos)
	EventDispatcher.Dispatch(EventID.HomeSceneReadyToShow)
end

function HomeScene:__OnHomeDataChange()
	if self.room == nil then
		return
	end

	self.room:RefreshWorkHero()
end

function HomeScene:EnterOrnamentEditorMode()
	self.room:EnterOrnamentEditorMode()
	self.playerActor.skinEntityGo:SetActive(false)
end

function HomeScene:ExitOrnamentEditorMode()
	self.room:ExitOrnamentEditorMode()
	self.playerActor.skinEntityGo:SetActive(true)
end

return HomeScene
