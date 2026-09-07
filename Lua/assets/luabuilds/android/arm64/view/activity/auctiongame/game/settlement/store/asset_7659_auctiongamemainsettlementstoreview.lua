local AuctionGameMainSettlementStoreView = class("AuctionGameMainSettlementStoreView", import("view.base.BasePanel"))

function AuctionGameMainSettlementStoreView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainSettlementStoreView.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainSettlementStoreView:Init()
	self.cellItemViewList = {}
	self.itemViewList = {}

	for iter_2_0 = 1, getProxy(AuctionGameProxy):GetMaxLineCnt() * AuctionGameConst.CELL_COL_CNT do
		self.cellItemViewList[iter_2_0] = AuctionGameCellItem.New(tf(Instantiate(self.uiCellItemTf, self.uiCellParentTf)), self._parentClass)

		self.cellItemViewList[iter_2_0]:Show(true)
	end

	return
end

function AuctionGameMainSettlementStoreView:didEnter()
	self.itemDataList = getProxy(AuctionGameProxy):GetSettlementData():GetSortItemList()
	self.showIndex = 1

	onNextTick(function()
		self:ShowAllContour()
		self:RefreshNextItem()

		return
	end)

	self.eventList = {}

	return
end

function AuctionGameMainSettlementStoreView:ShowAllContour()
	for iter_5_0, iter_5_1 in ipairs(self.itemDataList) do
		local var_5_0 = self.itemViewList[uid] or AuctionGameStoreItem.New(tf(Instantiate(self.uiItemTf, self.uiCellParentTf)), self._parentClass)

		var_5_0:SetPosition((self.cellItemViewList[AuctionGameConst.CELL_COL_CNT * (iter_5_1.position.y - 1) + iter_5_1.position.x]:GetPosition()))
		var_5_0:ShowSize(iter_5_1)
		var_5_0:ShowContour({
			contour = iter_5_1.contour
		})

		self.itemViewList[iter_5_1.uid] = var_5_0
	end

	return
end

function AuctionGameMainSettlementStoreView:RevealItem(arg_6_1)
	local var_6_1 = self.itemViewList[self.itemDataList[arg_6_1].uid] or AuctionGameStoreItem.New(tf(Instantiate(self.uiItemTf, self.uiCellParentTf)), self._parentClass)

	var_6_1:didEnter(self.itemDataList[arg_6_1])

	self.itemViewList[self.itemDataList[arg_6_1].uid] = var_6_1
	self.showIndex = self.showIndex + 1

	self:emit(AuctionGameMainSettlementScene.REVEAL_ITEM, self.itemDataList[arg_6_1])

	return
end

function AuctionGameMainSettlementStoreView:RefreshNextItem()
	self:RevealItem(self.showIndex)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.REVEAL)

	self.timer = Timer.New(function()
		self:StopTimer()

		if self.showIndex > #self.itemDataList then
			self:emit(AuctionGameMainSettlementScene.REVEAL_OVER)
		else
			self:RefreshNextItem()
		end

		return
	end, AuctionGameConst.REVEAL_ITEM_TIME, 1)

	self.timer:Start()

	return
end

function AuctionGameMainSettlementStoreView:RevealAllItem()
	if self.showIndex > #self.itemDataList then
		return
	end

	self:StopTimer()

	for iter_9_0 = self.showIndex, #self.itemDataList do
		self:RevealItem(iter_9_0)
	end

	self.showIndex = #self.itemDataList + 1

	self:emit(AuctionGameMainSettlementScene.REVEAL_OVER)

	return
end

function AuctionGameMainSettlementStoreView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function AuctionGameMainSettlementStoreView:willExit()
	self:StopTimer()

	for iter_11_0, iter_11_1 in ipairs(self.eventList) do
		self:disconnect(iter_11_1)
	end

	self.eventList = nil

	for iter_11_2, iter_11_3 in ipairs(self.cellItemViewList) do
		iter_11_3:willExit()
	end

	self.cellItemViewList = nil

	for iter_11_4, iter_11_5 in pairs(self.itemViewList) do
		iter_11_5:willExit()
	end

	self.itemViewList = nil

	self:detach()

	return
end

return AuctionGameMainSettlementStoreView
