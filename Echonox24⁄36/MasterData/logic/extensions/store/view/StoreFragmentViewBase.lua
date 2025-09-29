-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreFragmentViewBase.lua

module("logic.extensions.store.view.StoreFragmentViewBase", package.seeall)

local M = class("StoreFragmentViewBase", DynamicFragmentView)

function M:buildUI()
	self._togGo = self._registry:getGo("store_top_tab_-729274987")
	self._tabGroup = self._registry:getUIComponent("store_horizontal_tab_content_1990114608", UIComponentType.SpaceXToggleGroup)

	goutil.setActive(self._togGo, false)

	self._togList = {}
end

function M:destroyUI()
	return
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.REENTER_SAME_TAB, self._reEnter, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_STORE_LIST, self._refreshGoods, self)
	GlobalDispatcher:dispatchEvent(EventType.CLICK_STORE_RIGHT_TAB, self.callBackFunc, self)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.REENTER_SAME_TAB, self._reEnter, self)
	GlobalDispatcher:removeEventListener(EventType.REFRESH_STORE_LIST, self._refreshGoods, self)

	self._selectStoreId = nil
end

function M:_reEnter(e, tabCfg)
	self:callBackFunc(tabCfg)
end

function M:_refreshGoods()
	local selectStoreId = self:getCurSelectStoreId()

	if selectStoreId then
		if not StoreModel.instance:isStoreOnline(selectStoreId) then
			GlobalDispatcher:dispatchEvent(EventType.CLICK_STORE_RIGHT_TAB, self.callBackFunc, self)
		else
			StoreAgent.instance:sendGetGoodsListRequest({
				selectStoreId
			})
		end
	end
end

function M:callBackFunc(tabCfg)
	self._hasInitTopTog = false
	self._tabId = tabCfg.code
	self._storeList = StoreModel.instance:getStoreListByTabIndex(self._tabId)

	if not self._storeList or #self._storeList < 1 then
		goutil.setActive(self.mainGO, false)

		return
	end

	goutil.setActive(self.mainGO, true)

	local jumpInfo = StoreModel.instance:getJumpInfo()

	self._targetStoreId = jumpInfo and jumpInfo.targetStoreId or self._storeList[1]:getId()
	self._targetGoodsId = jumpInfo and jumpInfo.targetGoodsId or nil

	StoreModel.instance:setJumpInfo(false)
	self:initTopTog()
end

function M:_updateMoneyView(storeId)
	local viewPage = self:getViewPage()
	local viewPresentor = viewPage:getViewPresentor()
	local storeCO = StoreConfig.instance:getStoreCO(storeId)

	if storeCO then
		viewPresentor:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, nil, storeCO.showCoin)
	end
end

function M:initTopTog()
	local targetIndex = 1
	local isFindTargetStoreId = false
	local isOnlyOne = #self._storeList <= 1

	for i = 1, #self._storeList do
		local togItem = self._togList[i]

		if not togItem then
			local go = goutil.cloneAndSetParent(self._togGo, self._togGo.transform.parent)

			togItem = Astral.LuaComponentContainer.Add(go, StoreTopNavItem)

			togItem:setClickCallBack(self._clickStoreCallBack, self)

			self._togList[i] = togItem
		end

		local storeMo = self._storeList[i]

		if storeMo:getId() == self._targetStoreId then
			targetIndex = i
			isFindTargetStoreId = true
		end

		local selectIndex = isOnlyOne and -1 or targetIndex

		togItem:setSelectIndex(selectIndex)
		togItem:setCellData(storeMo:getName(), storeMo, i, self._tabGroup)

		if self._tabId == StoreEnum.TabId.GiftBag then
			local keyList = {
				string.format("%s_%s", GameEnum.RedPointEnum.MallFreeGiftBag, storeMo:getId())
			}

			togItem:setRedPointData(keyList)
		else
			togItem:setRedPointData(StoreEnum.StoreMapRedId[storeMo:getId()])
		end

		goutil.setActive(togItem.go, true)
	end

	if not isFindTargetStoreId then
		self._targetStoreId = self._storeList[1]:getId()
	end

	for i = #self._storeList + 1, #self._togList do
		goutil.setActive(self._togList[i].go, false)
	end

	self._hasInitTopTog = true

	self:_clickStoreCallBack(targetIndex, self._storeList[targetIndex])
end

function M:_clickStoreCallBack(index, storeMo, isClick)
	self._selectStoreId = storeMo:getId()

	if self._selectIndex == index and isClick then
		return
	end

	if storeMo then
		UserUtil.uploadStoreTaPoint(storeMo:getName())
	end
end

function M:getCurSelectStoreId()
	return self._selectStoreId
end

return M
