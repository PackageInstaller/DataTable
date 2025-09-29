-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/blacklist/BlacklistFragmentView.lua

module("logic.extensions.friend.view.blacklist.BlacklistFragmentView", package.seeall)

local M = class("BlacklistFragmentView", StaticFragmentView)

function M:ctor(...)
	M.super.ctor(self, ...)

	self._relationType = GameEnum.RelationTypeEnum.Block
end

function M:buildUI()
	self._normalGo = self:getGo("friend_main_view_-2079366796")
	self._emptyGo = self:getGo("friend_main_view_246381952")

	local scrollGo = self:getGo("friend_main_view_-1654482018")

	self._loopList = LoopListHelper.New(scrollGo)

	self._loopList:InitListView(0, self._updateCell, self)
end

function M:destroyUI()
	return
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.UPDATE_BLACKLIST_LIST, self._refreshView, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_BLOCK_SUCCESS, self._refreshView, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_UNBLOCK_SUCCESS, self._refreshView, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.UPDATE_BLACKLIST_LIST, self._refreshView, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_BLOCK_SUCCESS, self._refreshView, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_UNBLOCK_SUCCESS, self._refreshView, self)
end

function M:onEnter()
	self:_bindEvents()
	self:_refreshView()
	FriendAgent.instance:sendGetUserListRequest(self._relationType)
end

function M:onExit()
	self:_unbindEvents()
end

function M:_refreshView()
	self._moList = FriendModel.instance:getMoList(self._relationType)

	local itemCount = #self._moList

	self._loopList:SetListItemCount(itemCount)
	self._loopList:RefreshAllShownItem()
	self._emptyGo:SetActive(itemCount == 0)
	self._normalGo:SetActive(itemCount > 0)
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("friend_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, BlacklistItemCell)
	local mo = self._moList[curIndex]

	itemView:updateData(mo)

	return item
end

return M
