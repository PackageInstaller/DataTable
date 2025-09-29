-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/personal/AirWorkShopPersonalView.lua

module("logic.extensions.airworkshop.view.personal.AirWorkShopPersonalView", package.seeall)

local M = class("AirWorkShopPersonalView", ViewComponent)

function M:buildUI()
	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("0&left_tab_content_-399612422"), LeftTabComp)
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)

	for i = 1, 5 do
		self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(i))
	end

	self:_buildSubView()
end

function M:_buildSubView()
	self._subView = {
		[AirWorkShopEnum.PersonalPageType.Main] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, AirWorkShopPersonalSubViewMain),
		[AirWorkShopEnum.PersonalPageType.Trophy] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, AirWorkShopPersonalSubViewTrophy),
		[AirWorkShopEnum.PersonalPageType.LevelPublish] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, AirWorkShopPersonalSubViewLevel)
	}

	for _, _view in ipairs(self._subView) do
		_view:setHandler(self)
	end
end

function M:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter(reasonType)
	local isNormalOpen = not self._viewPresentor:getIsBackOpen() and reasonType ~= WindowType.WindowOpenReasonType.QuickOpenType

	self:setEvent(true)

	local info = self:getFirstParam() or {}

	self._userId = info.userId and info.userId or PlayerModel.instance:getId()

	local tabIndex = info.tabIndex and info.tabIndex or AirWorkShopEnum.PersonalPageType.Main
	local mainPageMsg = info.mainPageMsg

	if Astral.OSDef.isEditor then
		printWarn(string.format("个人页,isBack[%s] user[%s] isSelf:%s", not isNormalOpen, self._userId, self:getIsInMyPage()))
	end

	if not isNormalOpen then
		if self._activeIndex then
			tabIndex = self._activeIndex
		end

		for _, view in pairs(self._subView or {}) do
			if view:isPageTypeMatch(tabIndex) then
				view:setActive(true, tabIndex)
			end
		end
	end

	self._toggleTabControl:selectTab(tabIndex)
	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_PERSONAL_PAGE_ENTER, self._userId)
	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, isNormalOpen, tabIndex)
end

function M:onExit(reasonType)
	local isNormalClose = reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:setEvent(false)

	if isNormalClose then
		self._activeIndex = nil
	end

	for _, view in pairs(self._subView or {}) do
		if view.onExit then
			view:onExit(reasonType)
		end
	end

	self._tabComp:onExit()
	self._tabComp:setCanvasInteractable(false)
	self._tabComp:playGuiAniTab(false, isNormalClose)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_AIR_PAGE_REPLY, self._handleOnAirPageReply, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_AIR_PAGE_USER_CHANGE, self._handleOnAirPageUserChange, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_AIR_PAGE_REPLY, self._handleOnAirPageReply, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_AIR_PAGE_USER_CHANGE, self._handleOnAirPageUserChange, self)
	end
end

function M:_handleOnAirPageReply(e, pageType, msg)
	for _, view in pairs(self._subView or {}) do
		if view:getActive() and view:isPageTypeMatch(pageType) then
			view:refreshView(msg, self:getPageIndex())
		end
	end
end

function M:_handleOnAirPageUserChange(e, info)
	local openParam = self._viewPresentor:getOpenParam()

	openParam[1] = info

	local userId = info.userId
	local pageType = info.tabIndex
	local mainPageMsg = info.mainPageMsg

	self._userId = userId

	self._toggleTabControl:selectTab(pageType)
	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_PERSONAL_PAGE_ENTER, self._userId)
	self._tabComp:MoveSelectMark(pageType, 0)
end

function M:getUserId()
	return self._userId
end

function M:getIsInMyPage()
	return self:getUserId() == PlayerModel.instance:getId()
end

function M:getPageIndex()
	return self._activeIndex
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		for _pageType, _view in ipairs(self._subView) do
			_view:setActive(_view:isPageTypeMatch(tabIndex), self:getPageIndex())
		end
	end

	local duration = needReflash and 0.3 or 0

	self._tabComp:MoveSelectMark(tabIndex, duration)
end

return M
