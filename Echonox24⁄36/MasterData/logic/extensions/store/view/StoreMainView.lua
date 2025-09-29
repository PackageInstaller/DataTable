-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreMainView.lua

module("logic.extensions.store.view.StoreMainView", package.seeall)

local M = class("StoreMainView", ViewComponent)

function M:buildUI()
	self._rectViewRoot = self:getRectTransform("store_main_view_-872396409")
	self._viewPager = ViewPager.New(self._rectViewRoot.gameObject)

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setPageChangeCallBack(self._onPageChanged, self)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setTabCheckFunc(function(tabIndex)
		return self:_tabCheckFunc(tabIndex)
	end)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("3&left_tab_content_-399612422"), StoreLeftTabComp)
	self._goMask = self:getGo("store_main_view_-1295114737")
end

function M:destroyUI()
	self._rectTabRoot = nil
	self._rectViewRoot = nil
	self._goTabItem = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._viewPager:destroy()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CLICK_STORE_RIGHT_TAB, self._handleGetTabActId, self)
		GlobalDispatcher:addEventListener(EventType.STORE_SHOW_MASK, self._handleShowMask, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CLICK_STORE_RIGHT_TAB, self._handleGetTabActId, self)
		GlobalDispatcher:removeEventListener(EventType.STORE_SHOW_MASK, self._handleShowMask, self)
	end
end

function M:onEnter()
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BGMAMBCHANGE, CriwareAudioEnum.music_main_shop)
	StoreMainFacade.instance:registerView(self)
	self:_setEvent(true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Store)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)

	self._tabList = StoreModel.instance:getStoreTabList()

	local tabIndex = 1
	local openParam = self:getOpenParam()
	local jumpInfo = StoreModel.instance:getJumpInfo()

	if jumpInfo then
		tabIndex = jumpInfo.index
	elseif openParam and openParam[1] then
		tabIndex = openParam[1].tabIndex
	elseif self._tabIndex then
		tabIndex = self._tabIndex
	end

	self:jumpTab(tabIndex, true)
	self._tabComp:onEnter()
	GlobalDispatcher:dispatchEvent(EventType.CHANGE_VIEW_TO, true)
	goutil.setActive(self._goMask, false)
end

function M:onExit(reasonTyp)
	GlobalDispatcher:dispatchEvent(EventType.ON_CUR_BGMAMBCLOSE)

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	StoreMainFacade.instance:unregisterView(self)
	self:_setEvent(false)
	self._tabComp:onExit()
	self._viewPager:clear()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Store)
	GlobalDispatcher:dispatchEvent(EventType.CHANGE_VIEW_TO, false, isNormalClose)
	self._tabComp:playGuiAniTab(false, isNormalClose)

	self._tabList = nil
	self._curTabIndex = nil
end

function M:_handleGetTabActId(e, callBackFunc, callBackHandler)
	local tabIndex = self._viewPager:getPage()
	local tabCfg = self._tabList[tabIndex]

	if callBackFunc then
		if callBackHandler then
			callBackFunc(callBackHandler, tabCfg)
		else
			callBackFunc()
		end
	end
end

function M:jumpTab(tabIndex, forceRefresh)
	local tabIndex = tabIndex and tabIndex or 1

	if not self._adapter or forceRefresh then
		self:_initToggle()
	end

	if self._curTabIndex == tabIndex then
		GlobalDispatcher:dispatchEvent(EventType.REENTER_SAME_TAB, self._tabList[tabIndex])

		return
	end

	if #self._tabList > 0 then
		self._toggleTabControl:selectTab(tabIndex)
		self._tabComp:playGuiAniTab(true, not self._viewPresentor:getIsBackOpen(), tabIndex)
	end
end

function M:_initToggle()
	self._viewPager:clear()

	self._adapter = DynamicPagerAdapter.New()

	self._viewPager:setAdapter(self._adapter)
	self._toggleTabControl:clear()
	self._toggleTabControl:setViewPager(self._viewPager)
	self._tabComp:clearActiveTabIndex()

	local tabCount = #self._tabList

	self._tabIdMapIndex = {}

	for i = 1, tabCount do
		local cfg = self._tabList[i]

		self._tabIdMapIndex[cfg.code] = i

		local tabComp = self._tabComp:getTabComps(i)

		if not tabComp then
			self._tabComp:createTab()

			tabComp = self._tabComp:getTabComps(i)
		end

		self._tabComp:setActiveTabIndex(i)
		self._tabComp:setTabName(i, cfg.name)
		self._toggleTabControl:addToggleTab(tabComp.toggleTab)

		local className = cfg and cfg.className or ""

		self._adapter:registerView(cfg.prefab, _G[className])
	end

	if tabCount < self._tabComp:getTabsCount() then
		for i = 1, self._tabComp:getTabsCount() do
			local tabShow = i <= tabCount

			self._tabComp:setTabShow(i, tabShow)
		end
	end

	self:_initTabRedPoint()
end

function M:_onPageChanged(index)
	local samePage = self._curTabIndex and self._curTabIndex == index

	self._curTabIndex = index

	local cfg = self._tabList[self._curTabIndex]

	if not samePage and cfg then
		UserUtil.uploadStoreTaPoint(cfg.name)
	end

	self._tabComp:MoveSelectMark(index, samePage and 0 or 0.3)
end

function M:_tabCheckFunc(tabIndex)
	local mo = self._tabList[tabIndex]

	if not mo then
		return false
	end

	return true
end

function M:_handleShowMask(e, isShow)
	goutil.setActive(self._goMask, isShow)
end

function M:_initTabRedPoint()
	local list = {
		[StoreEnum.TabId.SuperValue] = {
			GameEnum.RedPointEnum.RechargeFirst
		},
		[StoreEnum.TabId.HotList] = {
			GameEnum.RedPointEnum.RechargeAccumulate
		},
		[StoreEnum.TabId.GiftBag] = {
			GameEnum.RedPointEnum.MallFreeGiftBag
		}
	}
	local redDotLst = {}

	for key, value in pairs(list) do
		local index = self._tabIdMapIndex[key]

		if index then
			redDotLst[index] = {
				keyList = value
			}
		end
	end

	self._tabComp:setRedDotLst(redDotLst)
end

return M
