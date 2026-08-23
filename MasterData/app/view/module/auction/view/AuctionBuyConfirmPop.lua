local var_0_0 = g.core.common.Path
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.AuctionData
local AuctionBuyConfirmPop = class("AuctionBuyConfirmPop", require("app.fairyGUI.auction.UI_AuctionBuyConfirmPop"), function()
	return fgui.GComponent:create({
		resName = "AuctionBuyConfirmPop",
		pkgPath = "ui/auction/auction",
		pkgName = "auction"
	}, ...)
end)

function AuctionBuyConfirmPop:ctor(arg_2_1)
	self:showAtCenter()

	self._isSelf = arg_2_1 and arg_2_1.isSelf

	if arg_2_1 then
		self._costType = arg_2_1.costType or 0
	end

	self._c2sParams = {
		act_id = arg_2_1.act_id,
		goods_id = arg_2_1.goods_id,
		is_bid_price = arg_2_1.is_bid_price,
		prepare_cost_amount = arg_2_1.prepare_cost_amount
	}
	self._auctionItemId = arg_2_1.auctionItemId
	self._itemInfo = var_0_2:getItemInfoById(self._auctionItemId)
	self._goods = var_0_1:convert({
		type = self._itemInfo.type,
		value = self._itemInfo.value,
		size = self._itemInfo.size
	})
	self._count = self._itemInfo.size

	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmButtonClick))
	self:_updatePopView()
end

function AuctionBuyConfirmPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_AUCTION_BIDPRICE, self._onRcvBidPrice, self)
end

function AuctionBuyConfirmPop:_updatePopView()
	if self._goods then
		self.m_baseItem:setURL(self._goods.icon)
		self.m_itemBg:setURL(var_0_0:getBaseBuyPopItemBg(self._goods.quality))
		self.m_nameTxt:setText(self._goods.name)
		self.m_nameBg:setURL(var_0_0:getBaseBuyPopNameBg(self._goods.quality or 0))
	end

	self.m_haveNumTxt:setText(self._count)
	self.m_costLoader:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_GOLD, 0, true)))
	self.m_isSelfController:setSelectedIndex(self._isSelf and 1 or 0)
	self.m_costTypeController:setSelectedIndex(self._costType)
	self.m_costText:setText(self._c2sParams.prepare_cost_amount)
end

function AuctionBuyConfirmPop:_onConfirmButtonClick()
	if not self._c2sParams then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Auction_BidPrice(self._c2sParams)
end

function AuctionBuyConfirmPop:_onRcvBidPrice()
	g.core.module.ModuleManager:popModule()
end

return AuctionBuyConfirmPop
