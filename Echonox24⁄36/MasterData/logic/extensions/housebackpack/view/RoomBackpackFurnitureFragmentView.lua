-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackFurnitureFragmentView.lua

module("logic.extensions.housebackpack.view.RoomBackpackFurnitureFragmentView", package.seeall)

local M = class("RoomBackpackFurnitureFragmentView", RoomBackpackBaseFragmentView)

function M:ctor()
	M.super.ctor(self)

	self._showType = CommEnum.RoomBackpackShowType.FurnitureShowType
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self._registry:getMainGO()

	self._canvasGroup = goutil.addComponentOnce(mainGO, ComponentType.CanvasGroup)
	self._detailView = Astral.LuaComponentContainer.Add(mainGO, RoomBackpackFurnitureDetailView)
	self._guiAnimation = goutil.addComponentOnce(mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self:setEvent(false)
	self._detailView:_destroyUI()
	M.super.destroyUI(self)
end

function M:bindEvents()
	M.super.bindEvents(self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
end

function M:onEnter()
	M.super.onEnter(self)
	self._detailView:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
	self:setInteractable(true)
	self:setEvent(true)
end

function M:onExit()
	self:setEvent(false)
	self._detailView:onExit()
	M.super.onExit(self)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self.handleRoomBackPackPageDataChanged, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self.handleRoomBackPackPageDataChanged, self)
	end
end

function M:handleRoomBackPackPageDataChanged(e)
	self:setInteractable(not RoomBackpackModel.instance:isInRecycling())
end

function M:setInteractable(interactable)
	self._canvasGroup.interactable = interactable
	self._canvasGroup.blocksRaycasts = interactable
end

return M
