local RechargeVoucherItem = class("RechargeVoucherItem", (import("game.views.shop.base.ShopItemBase")))

function RechargeVoucherItem:InitUI()
	self:BindCfgUI()
end

function RechargeVoucherItem:AddUIListener()
	self:AddBtnListener(self.buyBtn_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_ticket = self.goodID
		})
		JumpTools.OpenPopUp("rechargeDiamondExchange", {
			defaultNum = 0,
			getBaseNum = 1,
			useBaseNum = self.shopCfg.cost,
			useId = self.shopCfg.cost_id,
			getId = self.itemCfg.id,
			exchangeId = self.goodID,
			buy_source = PayConst.BUY_SOURCE_DRAW_SHOP
		}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)
	end)
end

function RechargeVoucherItem:UpdateView()
	self.nameLabel_.text = ItemTools.getItemName(self.itemCfg.id)
	self.image_.sprite = ItemTools.getItemSprite(self.itemCfg.id)
	self.costIcon_.sprite = ItemTools.getItemLittleSprite(self.shopCfg.cost_id)
	self.costLabel_.text = self.shopCfg.cost
end

return RechargeVoucherItem
