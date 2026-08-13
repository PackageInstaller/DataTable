import = var_0_10000

local var_0_0 = var_0_10000("view.activity.AuctionGame.game.settlement.store.AuctionGameMainSettlementStoreView")

class = var_0_10001

local var_0_1 = var_0_10001("AuctionGamePreorderBoxSettlementStoreView", var_0_0)

function var_0_1.Init(arg_1_0)
	arg_1_0.cellItemViewList = {}
	arg_1_0.itemViewList = {}
	getProxy = var_1
	AuctionGameBaseProxy = var_1_10003

	local var_1_0 = var_1(var_1_10003)
	local var_1_1 = var_1.GetMaxLineCnt(var_1_0)

	AuctionGameConst = var_1_10003

	local var_1_2 = var_1_1 * var_1_10003.CELL_COL_CNT

	for iter_1_0 = 1, var_1_2 do
		local var_1_3 = arg_1_0.cellItemViewList

		AuctionGameCellItem = var_1_10008
		var_1_10008 = var_1_10008.New
		tf = var_1_10010
		Instantiate = var_1_10012
		var_1_3[iter_1_0] = var_1_10008(var_1_10010(var_1_10012(arg_1_0.uiCellItemTf, arg_1_0.uiCellParentTf)), arg_1_0._parentClass)

		local var_1_4 = arg_1_0.cellItemViewList[iter_1_0]

		var_7.Show(var_1_4, true)
	end

	return
end

function var_0_1.didEnter(arg_2_0)
	getProxy = var_1_10001
	AuctionGameBaseProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)

	arg_2_0.itemDataList = var_1.GetItemList(var_2_0)
	arg_2_0.showIndex = 1
	onNextTick = var_1

	var_1(function()
		local var_3_0 = arg_2_0

		var_0.ShowAllContour(var_3_0)

		local var_3_1 = arg_2_0

		var_0.RefreshNextItem(var_3_1)

		return
	end)

	arg_2_0.eventList = {}

	return
end

return var_0_1
