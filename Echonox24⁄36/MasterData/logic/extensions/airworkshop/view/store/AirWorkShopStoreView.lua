-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/store/AirWorkShopStoreView.lua

module("logic.extensions.airworkshop.view.store.AirWorkShopStoreView", package.seeall)

local M = class("AirWorkShopStoreView", ViewComponent)

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Store)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("0&left_tab_content_-399612422"), LeftTabComp)
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setTabCheckFunc(function(tabIndex)
		return self:_tabCheckFunc(tabIndex)
	end)

	self._scrollItem = self:getUIComponent("air_workshop_store_view_-2106840794", UIComponentType.ScrollRect)
	self._loopGridView = LoopGridViewHelper.New(self._scrollItem.gameObject)

	self._loopGridView:InitGridView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Store)
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._loopGridView:Dispose()

	self._loopGridView = nil

	for _, value in pairs(self._itemData or {}) do
		value.destroyUI()
	end

	self._itemData = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:setEvent(true)

	self._tabId = AirWorkShopStoreModel.instance:getStoreTabId()
	self._storeList = AirWorkShopStoreModel.instance:getStoreList()

	self:_refreshTab()

	local defualtTabIndex = 1

	if #self._storeList > 0 then
		TableUtil.dump(self._storeList)
		self._toggleTabControl:selectTab(defualtTabIndex)
	end

	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, not self._viewPresentor:getIsBackOpen(), defualtTabIndex)
end

function M:onExit(reasonTyp)
	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:setEvent(false)
	self:_playItemOpenAni(false)

	self._activeIndex = nil

	self._loopGridView:ClearCells()
	self._tabComp:onExit()
	self._tabComp:playGuiAniTab(false, isNormalClose)

	self._selectStoreId = false
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.STORE_STATE_CODE_ERROR, self._onRefreshGoods, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._handleRefreshGoodsItemData, self)
	else
		GlobalDispatcher:removeEventListener(EventType.STORE_STATE_CODE_ERROR, self._onRefreshGoods, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._handleRefreshGoodsItemData, self)
	end
end

function M:_onRefreshGoods()
	if self._selectStoreId then
		StoreAgent.instance:sendGetGoodsListRequest({
			self._selectStoreId
		})
	end
end

function M:_handleRefreshGoodsItemData()
	self:refreshItemScroll(false, false)
end

function M:_tabCheckFunc(tabIndex)
	return true
end

function M:_refreshTab()
	local len = self._storeList and #self._storeList or 0

	self._toggleTabControl:clear()
	self._toggleTabControl:setViewPager(self)
	self._tabComp:clearActiveTabIndex()

	for i = 1, len do
		local mo = self._storeList[i]
		local tabComps = self._tabComp:getTabComps(i)

		if not tabComps then
			self._tabComp:createTab()

			tabComps = self._tabComp:getTabComps(i)
		end

		self._tabComp:setActiveTabIndex(i)
		self._tabComp:setTabName(i, mo:getName())
		self._toggleTabControl:addToggleTab(tabComps.toggleTab)
	end

	if len < self._tabComp:getTabsCount() then
		for i = 1, self._tabComp:getTabsCount() do
			local tabShow = i <= len

			self._tabComp:setTabShow(i, tabShow)
		end
	end
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	local selectedStoreMo = self._storeList[tabIndex]

	self._selectStoreId = selectedStoreMo:getId()

	if needReflash then
		self:refreshItemScroll(true, true)
		self:_updateMoneyView(self._selectStoreId)
		StoreAgent.instance:sendGetGoodsListRequest({
			self._selectStoreId
		})
	end

	self._tabComp:MoveSelectMark(tabIndex, needReflash and 0.3 or 0)
end

function M:refreshItemScroll(resetPos, playOpenAni)
	self._scrollItem.enabled = false
	self._itemMoLst = StoreModel.instance:getGoodsList(self._tabId, self._selectStoreId)

	local len = self._itemMoLst and #self._itemMoLst or 0

	self._needPlayItemCellOpenAni = playOpenAni and len > 0

	if len > 0 then
		if resetPos then
			self._loopGridView:ClearCells()
		end

		if self._loopGridView:GetLoopGridView().ItemTotalCount ~= len then
			self._loopGridView:SetListItemCount(len, resetPos)
		else
			self._loopGridView:RefreshAllShownItem()
		end

		if resetPos then
			self._loopGridView:MoveToItemIndex(0)
		end
	else
		self._loopGridView:ClearCells()
	end

	self:_playItemOpenAni(self._needPlayItemCellOpenAni)
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._loopGridView:NewListViewItem("air_workshop_store_item")
	local data = self._itemMoLst[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkShopStoreItemCell)

	shower.view = self

	shower:SetItemData(data, curIndex)
	self:_updateCell(item.gameObject, data)

	return item
end

function M:_updateCell(go, data)
	if not self._itemData then
		self._itemData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemData[key]

	if not theItem then
		theItem = {
			go = go,
			canvasGroup = goutil.addComponentOnce(go, ComponentType.CanvasGroup)
		}

		function theItem.playOpenAni(play, duration, delay)
			theItem.canvasGroup:DOKill(false)

			if play then
				duration = duration or 0.26
				delay = delay or 0
				theItem.canvasGroup.alpha = 0

				return theItem.canvasGroup:DOFade(1, duration):SetEase(DG.Tweening.Ease.Linear):SetDelay(delay):SetAutoKill(true):OnComplete(function()
					return
				end, self)
			else
				theItem.canvasGroup.alpha = 1

				return nil
			end
		end

		function theItem.destroyUI()
			return
		end

		self._itemData[key] = theItem
	end

	theItem.canvasGroup.alpha = self._needPlayItemCellOpenAni and 0 or 1
end

function M:_playItemOpenAni(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	if play then
		self._scrollItem.enabled = false

		local duration = 0.26
		local maxDelay = 0.1
		local index = 1

		for _, cell in pairs(self._itemData or {}) do
			local delay = index * 0.05

			delay = delay > 1 and 1 or delay
			maxDelay = maxDelay < delay and delay or maxDelay

			cell.playOpenAni(play, duration, delay)

			index = index + 1
		end

		self._needPlayItemCellOpenAni = false

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay, function()
			self._scrollItem.enabled = true
		end))
	else
		for _, cell in pairs(self._itemData or {}) do
			cell.playOpenAni(false)
		end

		self._cacheTweenLst = nil
		self._needPlayItemCellOpenAni = false
		self._scrollItem.enabled = true
	end
end

function M:_updateMoneyView(storeId)
	local viewPresentor = self._viewPresentor
	local moneyShowType = AirWorkShopStoreViewPresentor.MONEY_SHOW_TYPE[storeId] or CommEnum.MoneyShowType.DefaultHideType

	viewPresentor:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, moneyShowType)
end

return M
