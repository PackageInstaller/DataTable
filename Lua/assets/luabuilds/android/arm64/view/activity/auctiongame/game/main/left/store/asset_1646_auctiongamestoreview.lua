local AuctionGameStoreView = class("AuctionGameStoreView", import("view.base.BasePanel"))

AuctionGameStoreView.UPDATE_ITEM_LIST = "AuctionGameStoreView::UPDATE_ITEM_LIST"

function AuctionGameStoreView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameStoreView.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameStoreView:Init()
	self.cellItemViewList = {}
	self.itemViewList = {}

	return
end

function AuctionGameStoreView:didEnter()
	self.maxLine = 0

	self:RefreshStore()

	self.eventList = {
		self:bind(AuctionGameStoreView.UPDATE_ITEM_LIST, handler(self, self.RefreshStore))
	}

	return
end

function AuctionGameStoreView:RefreshStore()
	local var_4_0 = getProxy(AuctionGameProxy):GetCurStoreLine()

	self.maxLine = var_4_0

	for iter_4_0 = 1, (var_4_0 - self.maxLine) * AuctionGameConst.CELL_COL_CNT do
		self.cellItemViewList[#self.cellItemViewList + 1] = AuctionGameCellItem.New(tf(Instantiate(self.uiCellItemTf, self.uiCellParentTf)), self._parentClass)

		self.cellItemViewList[iter_4_0]:Show(true)
	end

	onNextTick(function()
		self:RefreshItemList()

		return
	end)

	return
end

function AuctionGameStoreView:RefreshItemList()
	for iter_6_0, iter_6_1 in pairs((getProxy(AuctionGameProxy):GetStoreItemDataList())) do
		local var_6_0 = self.itemViewList[iter_6_0] or AuctionGameStoreItem.New(tf(Instantiate(self.uiItemTf, self.uiCellParentTf)), self._parentClass)

		var_6_0:SetPosition((self.cellItemViewList[AuctionGameConst.CELL_COL_CNT * (iter_6_1.position.y - 1) + iter_6_1.position.x]:GetPosition()))
		var_6_0:didEnter(iter_6_1)

		self.itemViewList[iter_6_0] = var_6_0
	end

	return
end

function AuctionGameStoreView:RefreshEventEffect(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(itemDataList) do
		local var_7_0 = self.itemViewList[iter_7_0]

		if self.itemViewList[iter_7_0] == nil then
			var_7_0 = AuctionGameStoreItem.New(tf(Instantiate(self.uiItemTf, self.uiCellParentTf)), self._parentClass)

			var_7_0:SetPosition((self.cellItemViewList[AuctionGameConst.CELL_COL_CNT * (iter_7_1.position.y - 1) + iter_7_1.position.x]:GetPosition()))

			self.itemViewList[iter_7_0] = var_7_0
		end

		var_7_0:didEnter(iter_7_0, iter_7_1)
	end

	return
end

function AuctionGameStoreView:willExit()
	for iter_8_0, iter_8_1 in ipairs(self.eventList) do
		self:disconnect(iter_8_1)
	end

	self.eventList = nil

	for iter_8_2, iter_8_3 in ipairs(self.cellItemViewList) do
		iter_8_3:willExit()
	end

	self.cellItemViewList = nil

	for iter_8_4, iter_8_5 in pairs(self.itemViewList) do
		iter_8_5:willExit()
	end

	self.itemViewList = nil

	self:detach()

	return
end

return AuctionGameStoreView
