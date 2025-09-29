-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/hotgoods/StoreHotListView.lua

module("logic.extensions.store.view.hotgoods.StoreHotListView", package.seeall)

local M = class("StoreHotListView", StoreFragmentViewBase)

function M:buildUI()
	M.super.buildUI(self)

	self._goodsScroll = self._registry:getGo("store_hot_list_panel_1110305673")
	self._goodsScrollCF = self._registry:getGo("store_hot_list_panel_305638030")
	self._goExchangeTips = self._registry:getGo("store_hot_list_panel_-1494924260")
	self._btnRecharge = self._registry:getBtn("store_hot_list_panel_-47919785")
	self._scrollView = LoopListHelper.New(self._goodsScroll)

	self._scrollView:InitListView(0, self._updateCell, self)

	self._scrollViewCF = LoopListHelper.New(self._goodsScrollCF)

	self._scrollViewCF:InitListView(0, self._updateCell2, self)

	self._items = {}
	self._itemsCF = {}
	self._goRechargeImg = self._registry:getGo("store_hot_list_panel_-1448232167")

	RedDotModel.instance:createDotView({
		dotNode = self._registry:getGo("2&red_point_-1414002736"),
		keyList = {
			GameEnum.RedPointEnum.RechargeAccumulate
		}
	})
end

function M:destroyUI()
	self._scrollView:ClearCells()
	self._scrollView:Dispose()

	self._scrollView = nil

	self._scrollViewCF:ClearCells()
	self._scrollViewCF:Dispose()

	self._scrollViewCF = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
		GlobalDispatcher:addEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._refreshRecharge, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
		GlobalDispatcher:removeEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._refreshRecharge, self)
	end
end

function M:bindEvents()
	self._btnRecharge:AddClickListener(self._onClickRecharge, self)
end

function M:unbindEvents()
	self._btnRecharge:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)
	self:_setEvent(true)
	StoreRechargeAgent.instance:sendGetRechargeInfoRequest()
end

function M:onExit()
	M.super.onExit(self)
	self:_setEvent(false)

	for k, v in pairs(self._items) do
		v:setEvent(false)
	end

	self._items = {}

	for k, v in pairs(self._itemsCF) do
		v:setEvent(false)
	end

	self._itemsCF = {}

	StoreModel.instance:setIsNeedShowNew(self._curShowList)
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

	self._targetStoreId = jumpInfo and jumpInfo.targetStoreId or StoreEnum.StoreId.SecondExchange
	self._targetGoodsId = jumpInfo and jumpInfo.targetGoodsId or nil

	StoreModel.instance:setJumpInfo(false)
	self:initTopTog()
end

function M:_clickStoreCallBack(index, storeMo, isClick)
	M.super._clickStoreCallBack(self, index, storeMo, isClick)

	if self._selectIndex == index and isClick then
		return
	end

	StoreModel.instance:setIsNeedShowNew(self._curShowList)

	self._isDirectPurchase = storeMo:getStoreType() == StoreEnum.MallType.DirectPurchase

	goutil.setActive(self._goodsScroll, not self._isDirectPurchase)
	goutil.setActive(self._goodsScrollCF, self._isDirectPurchase)

	if self._isDirectPurchase then
		self._scrollViewCF:ClearCells()
	else
		self._scrollView:ClearCells()
	end

	self._selectIndex = index

	self:_initGoodsView(storeMo)
	self:_updateMoneyView(storeMo:getId())
	StoreAgent.instance:sendGetGoodsListRequest({
		storeMo:getId()
	})

	self._hasPlayAnimation = false

	goutil.setActive(self._goExchangeTips, storeMo:getStoreType() == StoreEnum.MallType.SecondExchange)

	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.AccumulateRecharge)

	goutil.setActive(self._btnRecharge.gameObject, storeMo:getStoreType() == StoreEnum.MallType.DirectPurchase and isOpen)
end

function M:_initGoodsView(storeMo)
	self._storeMo = storeMo
	self._selectStoreId = storeMo:getId()
	self._tabId = storeMo:getTabId()
end

function M:_updateScrollView(e, refresh)
	StoreRechargeAgent.instance:sendGetRechargeInfoRequest()

	self._curShowList = StoreModel.instance:getGoodsList(self._tabId, self._selectStoreId)

	if not self._curShowList then
		return
	end

	local count = self._curShowList and #self._curShowList or 0

	count = math.ceil(count / 2)

	if StoreUtil.isOddNumber(count) then
		self.specialIndex = count
	else
		self.specialIndex = -1
	end

	local scrollView = self._isDirectPurchase and self._scrollViewCF or self._scrollView

	scrollView:SetListItemCount(count, refresh)
	scrollView:RefreshAllShownItem()
	self:_playAnimation()
end

function M:_updateCell(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	if curIndex == self.specialIndex then
		local item = self._scrollView:NewListViewItem("store_hot_list_item2")

		if self._curShowList then
			local itemData = self._curShowList[curIndex * 2 - 1]
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreHotListViewItem2)

			shower.view = self

			shower:SetItemData(itemData, curIndex * 2 - 1)

			if not self._items[shower.id] then
				self._items[shower.id] = shower

				self._items[shower.id]:setEvent(true)
			end
		end

		return item
	else
		local item = self._scrollView:NewListViewItem("store_hot_list_item1")
		local index2 = curIndex * 2
		local index1 = index2 - 1

		if self._curShowList then
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreHotListViewItem1)

			shower.view = self

			shower:SetItemData(self._curShowList[index1], self._curShowList[index2], index1, index2)

			if not self._items[shower.id] then
				self._items[shower.id] = shower

				self._items[shower.id]:setEvent(true)
			end
		end

		return item
	end
end

function M:_updateCell2(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollViewCF:NewListViewItem("store_hot_list_item3")
	local index2 = curIndex * 2
	local index1 = index2 - 1

	if self._curShowList then
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreHotListViewCFItem)

		shower.view = self

		shower:SetItemData(self._curShowList[index1], self._curShowList[index2], index1, index2)

		if not self._itemsCF[shower.id] then
			self._itemsCF[shower.id] = shower

			self._itemsCF[shower.id]:setEvent(true)
		end
	end

	return item
end

function M:setPlayAnimIndex(index)
	self.animStartIndex = index < self.animStartIndex and index or self.animStartIndex
	self.animEndIndex = index > self.animEndIndex and index or self.animEndIndex
end

function M:_playAnimation()
	GlobalDispatcher:dispatchEvent(EventType.STORE_PLAY_ITEM_ANIMATION, true)
end

function M:_onClickRecharge()
	ViewMgr.instance:open(ViewName.StoreRechargeView)
end

function M:_refreshRecharge()
	local isActive = StoreRechargeModel.instance:getCurCredit() > 0

	goutil.setActive(self._goRechargeImg, isActive)
end

return M
