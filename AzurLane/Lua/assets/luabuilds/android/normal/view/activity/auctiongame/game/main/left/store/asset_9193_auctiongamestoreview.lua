class = var_0_10000

local var_0_0 = "AuctionGameStoreView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

var_0_1.UPDATE_ITEM_LIST = "AuctionGameStoreView::UPDATE_ITEM_LIST"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0.cellItemViewList = {}
	arg_2_0.itemViewList = {}

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0.maxLine = 0

	arg_3_0:RefreshStore()

	local var_3_0 = {}
	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.bind
	local var_3_3 = var_0_1.UPDATE_ITEM_LIST

	handler = var_1_10005
	var_3_0[1] = var_3_2(var_3_1, var_3_3, var_1_10005(arg_3_0, arg_3_0.RefreshStore))
	arg_3_0.eventList = var_3_0

	return
end

function var_0_1.RefreshStore(arg_4_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1 = var_1.GetCurStoreLine(var_4_0) - arg_4_0.maxLine

	AuctionGameConst = var_1_10004

	local var_4_2 = var_4_1 * var_1_10004.CELL_COL_CNT

	arg_4_0.maxLine = var_2

	for iter_4_0 = 1, var_4_2 do
		local var_4_3 = arg_4_0.cellItemViewList
		local var_4_4 = #arg_4_0.cellItemViewList + 1

		AuctionGameCellItem = var_1_10010
		var_1_10010 = var_1_10010.New
		tf = var_1_10011
		Instantiate = var_1_10012
		var_4_3[var_4_4] = var_1_10010(var_1_10011(var_1_10012(arg_4_0.uiCellItemTf, arg_4_0.uiCellParentTf)), arg_4_0._parentClass)

		local var_4_5 = arg_4_0.cellItemViewList[iter_4_0]

		var_8.Show(var_4_5, true)
	end

	onNextTick = var_4

	var_4(function()
		local var_5_0 = arg_4_0

		var_0.RefreshItemList(var_5_0)

		return
	end)

	return
end

function var_0_1.RefreshItemList(arg_6_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.GetStoreItemDataList(var_6_0)

	pairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_6_1) do
		local var_6_2

		if not arg_6_0.itemViewList[iter_6_0] then
			AuctionGameStoreItem = var_6_2
			var_6_2 = var_6_2.New
			tf = var_1_10008
			Instantiate = var_1_10009
			var_6_2 = var_6_2(var_1_10008(var_1_10009(arg_6_0.uiItemTf, arg_6_0.uiCellParentTf)), arg_6_0._parentClass)
		end

		AuctionGameConst = var_1_10008
		var_1_10008 = var_1_10008.CELL_COL_CNT * (iter_6_1.position.y - 1) + iter_6_1.position.x

		local var_6_3 = arg_6_0.cellItemViewList[var_1_10008]

		var_1_10009 = var_1_10009.GetPosition(var_6_3)

		var_6_2:SetPosition(var_1_10009)
		var_6_2:didEnter(iter_6_1)

		arg_6_0.itemViewList[iter_6_0] = var_6_2
	end

	return
end

function var_0_1.RefreshEventEffect(arg_7_0, arg_7_1)
	pairs = var_1_10002
	itemDataList = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10002(var_1_10003) do
		local var_7_0

		if arg_7_0.itemViewList[iter_7_0] == nil then
			AuctionGameStoreItem = var_1_10008
			var_1_10008 = var_1_10008.New
			tf = var_1_10009
			Instantiate = var_1_10010
			var_7_0 = var_1_10008(var_1_10009(var_1_10010(arg_7_0.uiItemTf, arg_7_0.uiCellParentTf)), arg_7_0._parentClass)
			AuctionGameConst = var_1_10008
			var_1_10008 = var_1_10008.CELL_COL_CNT * (iter_7_1.position.y - 1) + iter_7_1.position.x
			var_1_10010 = arg_7_0.cellItemViewList[var_1_10008]
			var_1_10009 = var_1_10009.GetPosition(var_1_10010)

			var_7_0:SetPosition(var_1_10009)

			var_1_10010 = arg_7_0.itemViewList
			var_1_10010[iter_7_0] = var_7_0
		end

		var_1_10009 = var_7_0

		var_7_0.didEnter(var_1_10009, iter_7_0, iter_7_1)
	end

	return
end

function var_0_1.willExit(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.eventList) do
		arg_8_0:disconnect(iter_8_1)
	end

	arg_8_0.eventList = nil
	ipairs = var_1

	for iter_8_2, iter_8_3 in var_1(arg_8_0.cellItemViewList) do
		iter_8_3:willExit()
	end

	arg_8_0.cellItemViewList = nil
	pairs = var_1

	for iter_8_4, iter_8_5 in var_1(arg_8_0.itemViewList) do
		iter_8_5:willExit()
	end

	arg_8_0.itemViewList = nil

	arg_8_0:detach()

	return
end

return var_0_1
