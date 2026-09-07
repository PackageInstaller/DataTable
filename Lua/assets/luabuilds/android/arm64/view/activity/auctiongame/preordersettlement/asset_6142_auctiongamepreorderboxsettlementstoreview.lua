local AuctionGamePreorderBoxSettlementStoreView = class("AuctionGamePreorderBoxSettlementStoreView", (import("view.activity.AuctionGame.game.settlement.store.AuctionGameMainSettlementStoreView")))

function AuctionGamePreorderBoxSettlementStoreView:Init()
	self.cellItemViewList = {}
	self.itemViewList = {}

	for iter_1_0 = 1, getProxy(AuctionGameBaseProxy):GetMaxLineCnt() * AuctionGameConst.CELL_COL_CNT do
		self.cellItemViewList[iter_1_0] = AuctionGameCellItem.New(tf(Instantiate(self.uiCellItemTf, self.uiCellParentTf)), self._parentClass)

		self.cellItemViewList[iter_1_0]:Show(true)
	end

	return
end

function AuctionGamePreorderBoxSettlementStoreView:didEnter()
	self.itemDataList = getProxy(AuctionGameBaseProxy):GetItemList()
	self.showIndex = 1

	onNextTick(function()
		self:ShowAllContour()
		self:RefreshNextItem()

		return
	end)

	self.eventList = {}

	return
end

return AuctionGamePreorderBoxSettlementStoreView
