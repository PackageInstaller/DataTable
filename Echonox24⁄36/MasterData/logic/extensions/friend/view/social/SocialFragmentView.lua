-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/social/SocialFragmentView.lua

module("logic.extensions.friend.view.social.SocialFragmentView", package.seeall)

local M = class("SocialFragmentView", StaticFragmentView)

function M:ctor(...)
	M.super.ctor(self, ...)

	self._relationType = GameEnum.RelationTypeEnum.Friend
end

function M:buildUI()
	self._tipsPosGo = self:getGo("friend_main_view_2094539140")
	self._normalGo = self:getGo("friend_main_view_-1638546734")
	self._emptyGo = self:getGo("friend_main_view_102874406")

	local scrollGo = self:getGo("friend_main_view_2025408552")

	self._loopList = LoopListHelper.New(scrollGo)

	self._loopList:InitListView(0, self._updateCell, self)
end

function M:destroyUI()
	return
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.UPDATE_FRIEND_LIST, self._refreshView, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_AGREE_APPLY_SUCCESS, self._refreshView, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_REMOVE_SUCCESS, self._refreshView, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_BLOCK_SUCCESS, self._refreshView, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_SET_ALIAS_SUCCESS, self._refreshView, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.UPDATE_FRIEND_LIST, self._refreshView, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_AGREE_APPLY_SUCCESS, self._refreshView, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_REMOVE_SUCCESS, self._refreshView, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_BLOCK_SUCCESS, self._refreshView, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_SET_ALIAS_SUCCESS, self._refreshView, self)
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
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, SocialItemCell)

	itemView:setTipsPosGo(self._tipsPosGo)

	local mo = self._moList[curIndex]

	itemView:updateData(mo)

	return item
end

return M
