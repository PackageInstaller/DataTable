local AuctionGameMainLeftView = class("AuctionGameMainLeftView", import("view.base.BasePanel"))

function AuctionGameMainLeftView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainLeftView.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainLeftView:Init()
	self.storeView = AuctionGameStoreView.New(self.uiStorePanel, self._parentClass)

	return
end

function AuctionGameMainLeftView:didEnter()
	self.storeView:didEnter()

	if getProxy(AuctionGameProxy):GetAuctionID() == 1 then
		setActive(self.uiEstimateGo, true)
	else
		setActive(self.uiEstimateGo, false)
	end

	self.eventList = {
		self:bind(AuctionGameMainRightView.EVENT_SELECTED, handler(self, self.RefreshEstimate))
	}

	return
end

function AuctionGameMainLeftView:RefreshRound()
	self:RefreshEstimate()

	return
end

function AuctionGameMainLeftView:RefreshEstimate()
	local var_5_0 = 0
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(getProxy(AuctionGameProxy):GetStoreItemDataList()) do
		local var_5_2, var_5_3 = iter_5_1:GetEstimateValue()

		var_5_0 = var_5_0 + var_5_2
		var_5_1 = var_5_1 + var_5_3
	end

	setText(self.uiEstimateText, i18n("auction_store_estimate", StringHelper.ForamtNumber(var_5_0), StringHelper.ForamtNumber(var_5_1)))

	return
end

function AuctionGameMainLeftView:willExit()
	for iter_6_0, iter_6_1 in ipairs(self.eventList) do
		self:disconnect(iter_6_1)
	end

	self.eventList = nil

	self.storeView:willExit()

	self.storeView = nil

	self:detach()

	return
end

return AuctionGameMainLeftView
