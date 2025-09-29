-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendMainView.lua

module("logic.extensions.friend.view.FriendMainView", package.seeall)

local M = class("FriendMainView", ViewComponent)

M.SubViewType = {
	Search = 2,
	Social = 1,
	Blacklist = 3
}

function M:buildUI()
	local registry = self._viewPresentor._viewElementsRegistry
	local panelGo = self:getGo("friend_main_view_971672345")

	self._viewPager = ViewPager.New(panelGo)

	self._viewPager:setAdapter(StaticPagerAdapter.New(registry))
	self._viewPager:setViewPresentor(self._viewPresentor)

	local pagerAdapter = self._viewPager:getAdapter()

	pagerAdapter:addFragmentView(SocialFragmentView.New(self:getGo("friend_main_view_-1742962649")))
	pagerAdapter:addFragmentView(SearchFragmentView.New(self:getGo("friend_main_view_-449300103")))
	pagerAdapter:addFragmentView(BlacklistFragmentView.New(self:getGo("friend_main_view_-1670900704")))

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:addToggleTab(self:getUIComponent("0&right_tab_content_-242000516", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("0&right_tab_content_-1578871314", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("0&right_tab_content_1651451756", UIComponentType.SpaceXToggle))

	self._txtFriendTag = self:getText("friend_main_view_86766250")
	self._txtLimitNum = self:getText("friend_main_view_125316788")
	self._imgLimit1 = self:getGo("friend_main_view_-1665091004")
	self._imgLimit2 = self:getGo("friend_main_view_1695778428")
end

function M:bindEvents()
	self._viewPager:setPageChangeCallBack(self._onChangePage, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_FRIEND_LIST, self._refreshStatistics, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_BLACKLIST_LIST, self._refreshStatistics, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_REMOVE_SUCCESS, self._refreshStatistics, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_AGREE_APPLY_SUCCESS, self._refreshStatistics, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_BLOCK_SUCCESS, self._refreshStatistics, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_UNBLOCK_SUCCESS, self._refreshStatistics, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_SEARCH_RESULT, self._onSearchResult, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_SEARCH_CLEAR, self._onSearchClear, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.UPDATE_FRIEND_LIST, self._refreshStatistics, self)
	GlobalDispatcher:removeEventListener(EventType.UPDATE_BLACKLIST_LIST, self._refreshStatistics, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_REMOVE_SUCCESS, self._refreshStatistics, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_AGREE_APPLY_SUCCESS, self._refreshStatistics, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_BLOCK_SUCCESS, self._refreshStatistics, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_UNBLOCK_SUCCESS, self._refreshStatistics, self)
	GlobalDispatcher:removeEventListener(EventType.UPDATE_SEARCH_RESULT, self._onSearchResult, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_SEARCH_CLEAR, self._onSearchClear, self)
end

function M:onEnter()
	local params = self:getFirstParam() or {}
	local index = params.index or self._curShowType or M.SubViewType.Social

	self._toggleTabControl:selectTab(index)
end

function M:onExit()
	self._viewPager:clear()
end

function M:destroyUI()
	self._viewPager:destroy()
end

function M:_onChangePage(index)
	self._curShowType = index

	local params = self:getFirstParam()

	if params then
		params.index = index
	end

	self:_refreshStatistics()

	self._txtFriendTag.text = lang("tip_friend_apply")
end

function M:_refreshStatistics()
	local cur = 0
	local max = 0

	goutil.setActive(self._imgLimit1, self._curShowType ~= M.SubViewType.Blacklist)
	goutil.setActive(self._imgLimit2, self._curShowType == M.SubViewType.Blacklist)

	if self._curShowType == M.SubViewType.Blacklist then
		cur = FriendModel.instance:getUserCountByType(GameEnum.RelationTypeEnum.Block)
		max = ConstConfig.instance:getNumValueByKey("MaxBlockNum")

		goutil.setActive(self._txtLimitNum.gameObject, cur ~= 0)
	else
		cur = FriendModel.instance:getUserCountByType(GameEnum.RelationTypeEnum.Friend)
		max = ConstConfig.instance:getNumValueByKey("MaxFriendNum")

		goutil.setActive(self._txtLimitNum.gameObject, true)
	end

	if max <= cur then
		self._txtLimitNum.text = string.format("<color=%s>%d</color>/%d", "#ff7373", cur, max)
	else
		self._txtLimitNum.text = string.format("%d/%d", cur, max)
	end
end

function M:_onSearchResult()
	local searchResult = FriendModel.instance:getSearchResult()
	local applyMoList = FriendModel.instance:getMoList(GameEnum.RelationTypeEnum.BeApply)

	if #searchResult ~= 0 or applyMoList == 0 then
		self._txtFriendTag.text = lang("tip_search_result")
	else
		self._txtFriendTag.text = lang("tip_friend_apply")
	end
end

function M:_onSearchClear()
	self._txtFriendTag.text = lang("tip_friend_apply")
end

return M
