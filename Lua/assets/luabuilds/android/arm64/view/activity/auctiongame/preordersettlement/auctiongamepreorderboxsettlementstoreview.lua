local var_0_0 = class("AuctionGamePreorderBoxSettlementStoreView", (import("view.activity.AuctionGame.game.settlement.store.AuctionGameMainSettlementStoreView")))

function var_0_0.Init(arg_1_0)
	arg_1_0.cellItemViewList = {}
	arg_1_0.itemViewList = {}

	for iter_1_0 = 1, getProxy(AuctionGameBaseProxy):GetMaxLineCnt() * AuctionGameConst.CELL_COL_CNT do
		arg_1_0.cellItemViewList[iter_1_0] = AuctionGameCellItem.New(tf(Instantiate(arg_1_0.uiCellItemTf, arg_1_0.uiCellParentTf)), arg_1_0._parentClass)

		arg_1_0.cellItemViewList[iter_1_0]:Show(true)
	end

	return
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0.itemDataList = getProxy(AuctionGameBaseProxy):GetItemList()
	arg_2_0.showIndex = 1

	onNextTick(function()
		arg_2_0:ShowAllContour()
		arg_2_0:RefreshNextItem()

		return
	end)

	arg_2_0.eventList = {}

	return
end

return var_0_0
