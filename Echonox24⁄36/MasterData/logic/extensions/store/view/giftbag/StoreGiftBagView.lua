-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/giftbag/StoreGiftBagView.lua

module("logic.extensions.store.view.giftbag.StoreGiftBagView", package.seeall)

local M = class("StoreGiftBagView", StoreFragmentViewBase)
local PermanentGiftBagId = 130001

function M:buildUI()
	M.super.buildUI(self)

	self._goodsScroll = self._registry:getGo("store_gift_bag_panel_-715301967")
	self._scrollView = LoopListHelper.New(self._goodsScroll)

	self._scrollView:InitListView(0, self._updateCell, self)

	self._items = {}
end

function M:destroyUI()
	self._scrollView:ClearCells()
	self._scrollView:Dispose()

	self._scrollView = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_MONTH_CARD_DATA, self._updateScrollView, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._initTopTog, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_MONTH_CARD_DATA, self._updateScrollView, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._initTopTog, self)
	end
end

function M:onEnter()
	self._hasInitTopTog = false

	M.super.onEnter(self)
	self:_setEvent(true)

	local storeList = StoreModel.instance:getStoresByStoreType(StoreEnum.MallType.MonthyCard)

	self._monthCardStoreMo = storeList and storeList[1]
end

function M:onExit()
	M.super.onExit(self)
	self:_setEvent(false)

	for k, v in pairs(self._items) do
		v:clear()
		v:setEvent(false)
	end

	self._items = {}

	StoreModel.instance:setIsNeedShowNew(self._curShowList)
end

function M:callBackFunc(tabCfg)
	self._tabId = tabCfg.code
	self._storeList = StoreModel.instance:getStoreListByTabIndex(self._tabId)

	if not self._storeList or #self._storeList < 1 then
		goutil.setActive(self.mainGO, false)

		return
	end

	goutil.setActive(self.mainGO, true)

	local jumpInfo = StoreModel.instance:getJumpInfo()

	self._targetStoreId = jumpInfo and jumpInfo.targetStoreId
	self._targetGoodsId = jumpInfo and jumpInfo.targetGoodsId or nil

	StoreModel.instance:setJumpInfo(false)

	if not self._targetStoreId and not self._hasInitTopTog then
		local storeIds = {}

		for i = 1, #self._storeList do
			table.insert(storeIds, self._storeList[i]:getId())
		end

		StoreAgent.instance:sendGetGoodsListRequest(storeIds)
	else
		self:initTopTog()
	end
end

function M:_clickStoreCallBack(index, storeMo, isClick)
	M.super._clickStoreCallBack(self, index, storeMo, isClick)

	if self._selectIndex == index and isClick then
		return
	end

	StoreModel.instance:setIsNeedShowNew(self._curShowList)
	self._scrollView:ClearCells()

	self._selectIndex = index

	self:_initGoodsView(storeMo)
	self:_updateMoneyView(storeMo:getId())

	local storeIds = {}

	table.insert(storeIds, storeMo:getId())

	if self._monthCardStoreMo and PermanentGiftBagId == self._selectStoreId then
		table.insert(storeIds, self._monthCardStoreMo:getId())
	end

	StoreAgent.instance:sendGetGoodsListRequest(storeIds)
end

function M:_initGoodsView(storeMo)
	self._storeMo = storeMo
	self._selectStoreId = storeMo:getId()
	self._tabId = storeMo:getTabId()
end

function M:_addMonthCardGoods()
	if not self._curShowList then
		return
	end

	if PermanentGiftBagId == self._selectStoreId then
		local list = StoreModel.instance:getGoodsList(self._monthCardStoreMo:getTabId(), self._monthCardStoreMo:getId())
		local goodsMo = list and list[1]

		if goodsMo then
			local index = 0

			for i = 1, #self._curShowList do
				if self._curShowList[i]:getGoodsId() == goodsMo:getGoodsId() then
					index = i

					break
				end
			end

			if index <= 0 then
				table.insert(self._curShowList, 1, goodsMo)
			else
				self._curShowList[index] = goodsMo
			end
		end
	end
end

function M:_initTopTog(e)
	if self._hasInitTopTog then
		return
	end

	for i = #self._storeList, 1, -1 do
		local storeId = self._storeList[i]:getId()
		local list = StoreModel.instance:getGoodsList(self._tabId, storeId)

		if #list < 1 then
			self._storeList[i]:setIsHasGoods(false)
			table.remove(self._storeList, i)
		elseif not self._targetGoodsId then
			for j = 1, #list do
				local goodsMo = list[j]

				if goodsMo:getPrice() <= 0 and not goodsMo:getSellOut() then
					self._targetGoodsId = goodsMo:getGoodsId()
					self._targetStoreId = storeId

					break
				end
			end
		end
	end

	if not self._targetStoreId then
		self._targetStoreId = self._storeList[1] and self._storeList[1]:getId()
	end

	self:initTopTog()
end

function M:_updateScrollView(e, refresh)
	if not self._hasInitTopTog then
		return
	end

	self._curShowList = StoreModel.instance:getGoodsList(self._tabId, self._selectStoreId)

	if not self._curShowList then
		return
	end

	self:_addMonthCardGoods()

	local count = self._curShowList and #self._curShowList or 0

	if count <= 0 then
		self:_updateTopTog()

		return
	end

	self._scrollView:SetListItemCount(count, refresh)
	self._scrollView:RefreshAllShownItem()

	if not self._targetGoodsId then
		self:_playAnimation()

		return
	end

	local moveToIndex = 0

	for i = 1, #self._curShowList do
		if self._curShowList[i]:getGoodsId() == self._targetGoodsId then
			moveToIndex = i - 1

			break
		end
	end

	self._scrollView:MoveToItemIndex(moveToIndex)
	self:_playAnimation()
end

function M:_updateTopTog()
	for i = 1, #self._storeList do
		if self._storeList[i]:getId() == self._selectStoreId then
			self._storeList[i]:setIsHasGoods(false)

			break
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.CLICK_STORE_RIGHT_TAB, self.callBackFunc, self)
end

function M:_updateCell(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollView:NewListViewItem("store_gift_bag_item")

	if self._curShowList then
		local itemData = self._curShowList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreGiftBagViewItem)

		shower.view = self

		shower:SetItemData(itemData, curIndex)

		if not self._items[shower.id] then
			self._items[shower.id] = shower

			self._items[shower.id]:setEvent(true)
		end
	end

	return item
end

function M:_playAnimation()
	GlobalDispatcher:dispatchEvent(EventType.STORE_PLAY_ITEM_ANIMATION, true)
end

return M
