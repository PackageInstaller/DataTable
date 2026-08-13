class = var_0_10000

local var_0_0 = "AuctionGameMainSettlementStoreView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

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
	getProxy = var_1
	AuctionGameProxy = var_1_10002

	local var_2_0 = var_1(var_1_10002)
	local var_2_1 = var_1.GetMaxLineCnt(var_2_0)

	AuctionGameConst = var_2_0

	local var_2_2 = var_2_1 * var_2_0.CELL_COL_CNT

	for iter_2_0 = 1, var_2_2 do
		local var_2_3 = arg_2_0.cellItemViewList

		AuctionGameCellItem = var_1_10008
		var_1_10008 = var_1_10008.New
		tf = var_1_10009
		Instantiate = var_1_10010
		var_2_3[iter_2_0] = var_1_10008(var_1_10009(var_1_10010(arg_2_0.uiCellItemTf, arg_2_0.uiCellParentTf)), arg_2_0._parentClass)
		var_1_10008 = arg_2_0.cellItemViewList[iter_2_0]

		var_7.Show(var_1_10008, true)
	end

	return
end

function var_0_1.didEnter(arg_3_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.GetSettlementData(var_3_0)

	arg_3_0.itemDataList = var_1.GetSortItemList(var_3_1)
	arg_3_0.showIndex = 1
	onNextTick = var_1

	var_1(function()
		local var_4_0 = arg_3_0

		var_0.ShowAllContour(var_4_0)

		local var_4_1 = arg_3_0

		var_0.RefreshNextItem(var_4_1)

		return
	end)

	arg_3_0.eventList = {}

	return
end

function var_0_1.ShowAllContour(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.itemDataList) do
		local var_5_0 = arg_5_0.itemViewList

		uid = var_1_10007

		local var_5_1

		if not var_5_0[var_1_10007] then
			AuctionGameStoreItem = var_5_1
			var_5_1 = var_5_1.New
			tf = var_1_10007
			Instantiate = var_1_10008
			var_5_1 = var_5_1(var_1_10007(var_1_10008(arg_5_0.uiItemTf, arg_5_0.uiCellParentTf)), arg_5_0._parentClass)
		end

		AuctionGameConst = var_1_10007
		var_1_10007 = var_1_10007.CELL_COL_CNT * (iter_5_1.position.y - 1) + iter_5_1.position.x

		local var_5_2 = arg_5_0.cellItemViewList[var_1_10007]

		var_1_10008 = var_1_10008.GetPosition(var_5_2)

		var_5_1:SetPosition(var_1_10008)
		var_5_1:ShowSize(iter_5_1)
		var_5_1:ShowContour({
			contour = iter_5_1.contour
		})

		arg_5_0.itemViewList[iter_5_1.uid] = var_5_1
	end

	return
end

function var_0_1.RevealItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.itemDataList[arg_6_1].id
	local var_6_1 = var_2.uid
	local var_6_2

	if not arg_6_0.itemViewList[var_6_1] then
		AuctionGameStoreItem = var_6_2
		var_6_2 = var_6_2.New
		tf = var_1_10006
		Instantiate = var_1_10007
		var_6_2 = var_6_2(var_1_10006(var_1_10007(arg_6_0.uiItemTf, arg_6_0.uiCellParentTf)), arg_6_0._parentClass)
	end

	var_6_2:didEnter(var_2)

	arg_6_0.itemViewList[var_6_1] = var_6_2
	arg_6_0.showIndex = arg_6_0.showIndex + 1

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.emit

	AuctionGameMainSettlementScene = var_8

	var_6_4(var_6_3, var_8.REVEAL_ITEM, var_2)

	return
end

function var_0_1.RefreshNextItem(arg_7_0)
	arg_7_0:RevealItem(arg_7_0.showIndex)

	pg = var_1

	local var_7_0 = var_1.CriMgr.GetInstance()
	local var_7_1 = var_1.PlaySoundEffect_V3

	AuctionGameConst = var_3

	var_7_1(var_7_0, var_3.SOUND_EFFECT.REVEAL)

	Timer = var_7_1

	local var_7_2 = var_7_1.New

	local function var_7_3()
		local var_8_0 = arg_7_0

		var_0.StopTimer(var_8_0)

		if arg_7_0.showIndex > #arg_7_0.itemDataList then
			local var_8_1 = arg_7_0
			local var_8_2 = var_0.emit

			AuctionGameMainSettlementScene = var_2_10002

			var_8_2(var_8_1, var_2_10002.REVEAL_OVER)
		else
			local var_8_3 = arg_7_0

			var_0.RefreshNextItem(var_8_3)
		end

		return
	end

	AuctionGameConst = var_3
	arg_7_0.timer = var_7_2(var_7_3, var_3.REVEAL_ITEM_TIME, 1)

	local var_7_4 = arg_7_0.timer

	var_1.Start(var_7_4)

	return
end

function var_0_1.RevealAllItem(arg_9_0)
	if arg_9_0.showIndex > #arg_9_0.itemDataList then
		return
	end

	arg_9_0:StopTimer()

	for iter_9_0 = arg_9_0.showIndex, #arg_9_0.itemDataList do
		arg_9_0:RevealItem(iter_9_0)
	end

	arg_9_0.showIndex = #arg_9_0.itemDataList + 1

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.emit

	AuctionGameMainSettlementScene = var_3

	var_9_1(var_9_0, var_3.REVEAL_OVER)

	return
end

function var_0_1.StopTimer(arg_10_0)
	if arg_10_0.timer then
		local var_10_0 = arg_10_0.timer

		var_1.Stop(var_10_0)

		arg_10_0.timer = nil
	end

	return
end

function var_0_1.willExit(arg_11_0)
	arg_11_0:StopTimer()

	ipairs = var_1

	for iter_11_0, iter_11_1 in var_1(arg_11_0.eventList) do
		arg_11_0:disconnect(iter_11_1)
	end

	arg_11_0.eventList = nil
	ipairs = var_1

	for iter_11_2, iter_11_3 in var_1(arg_11_0.cellItemViewList) do
		iter_11_3:willExit()
	end

	arg_11_0.cellItemViewList = nil
	pairs = var_1

	for iter_11_4, iter_11_5 in var_1(arg_11_0.itemViewList) do
		iter_11_5:willExit()
	end

	arg_11_0.itemViewList = nil

	arg_11_0:detach()

	return
end

return var_0_1
