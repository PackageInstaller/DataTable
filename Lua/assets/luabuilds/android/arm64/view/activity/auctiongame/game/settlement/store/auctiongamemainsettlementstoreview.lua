local var_0_0 = class("AuctionGameMainSettlementStoreView", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.cellItemViewList = {}
	arg_2_0.itemViewList = {}

	for iter_2_0 = 1, getProxy(AuctionGameProxy):GetMaxLineCnt() * AuctionGameConst.CELL_COL_CNT do
		arg_2_0.cellItemViewList[iter_2_0] = AuctionGameCellItem.New(tf(Instantiate(arg_2_0.uiCellItemTf, arg_2_0.uiCellParentTf)), arg_2_0._parentClass)

		arg_2_0.cellItemViewList[iter_2_0]:Show(true)
	end

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.itemDataList = getProxy(AuctionGameProxy):GetSettlementData():GetSortItemList()
	arg_3_0.showIndex = 1

	onNextTick(function()
		arg_3_0:ShowAllContour()
		arg_3_0:RefreshNextItem()

		return
	end)

	arg_3_0.eventList = {}

	return
end

function var_0_0.ShowAllContour(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemDataList) do
		local var_5_0 = arg_5_0.itemViewList[uid]
		local var_5_1

		if not arg_5_0.itemViewList[uid] then
			var_5_0 = AuctionGameStoreItem.New(tf(Instantiate(arg_5_0.uiItemTf, arg_5_0.uiCellParentTf)), arg_5_0._parentClass)
			var_5_1 = var_5_0
		end

		var_5_0:SetPosition((arg_5_0.cellItemViewList[AuctionGameConst.CELL_COL_CNT * (iter_5_1.position.y - 1) + iter_5_1.position.x]:GetPosition()))
		var_5_0:ShowSize(iter_5_1)
		var_5_0:ShowContour({
			contour = iter_5_1.contour
		})

		arg_5_0.itemViewList[iter_5_1.uid] = var_5_0
	end

	return
end

function var_0_0.RevealItem(arg_6_0, arg_6_1)
	local var_6_1 = arg_6_0.itemViewList[arg_6_0.itemDataList[arg_6_1].uid] or AuctionGameStoreItem.New(tf(Instantiate(arg_6_0.uiItemTf, arg_6_0.uiCellParentTf)), arg_6_0._parentClass)

	var_6_1:didEnter(arg_6_0.itemDataList[arg_6_1])

	arg_6_0.itemViewList[arg_6_0.itemDataList[arg_6_1].uid] = var_6_1
	arg_6_0.showIndex = arg_6_0.showIndex + 1

	arg_6_0:emit(AuctionGameMainSettlementScene.REVEAL_ITEM, arg_6_0.itemDataList[arg_6_1])

	return
end

function var_0_0.RefreshNextItem(arg_7_0)
	arg_7_0:RevealItem(arg_7_0.showIndex)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.REVEAL)

	arg_7_0.timer = Timer.New(function()
		arg_7_0:StopTimer()

		if arg_7_0.showIndex > #arg_7_0.itemDataList then
			arg_7_0:emit(AuctionGameMainSettlementScene.REVEAL_OVER)
		else
			arg_7_0:RefreshNextItem()
		end

		return
	end, AuctionGameConst.REVEAL_ITEM_TIME, 1)

	arg_7_0.timer:Start()

	return
end

function var_0_0.RevealAllItem(arg_9_0)
	if arg_9_0.showIndex > #arg_9_0.itemDataList then
		return
	end

	arg_9_0:StopTimer()

	for iter_9_0 = arg_9_0.showIndex, #arg_9_0.itemDataList do
		arg_9_0:RevealItem(iter_9_0)
	end

	arg_9_0.showIndex = #arg_9_0.itemDataList + 1

	arg_9_0:emit(AuctionGameMainSettlementScene.REVEAL_OVER)

	return
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end

	return
end

function var_0_0.willExit(arg_11_0)
	arg_11_0:StopTimer()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.eventList) do
		arg_11_0:disconnect(iter_11_1)
	end

	arg_11_0.eventList = nil

	for iter_11_2, iter_11_3 in ipairs(arg_11_0.cellItemViewList) do
		iter_11_3:willExit()
	end

	arg_11_0.cellItemViewList = nil

	for iter_11_4, iter_11_5 in pairs(arg_11_0.itemViewList) do
		iter_11_5:willExit()
	end

	arg_11_0.itemViewList = nil

	arg_11_0:detach()

	return
end

return var_0_0
