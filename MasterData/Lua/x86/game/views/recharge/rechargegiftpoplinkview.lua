local RechargeGiftPopLinkView = class("RechargeGiftPopLinkView", (import("game.views.recharge.RechargeGiftPopView")))

function RechargeGiftPopLinkView:OnEnter()
	local var_1_0 = getShopCfg(self.params_.goodId, self.params_.shopId)

	self.params_.itemCfg = ItemCfg[var_1_0.give_id]
	self.params_.shopCfg = var_1_0
	self.params_.itemDesCfg_ = RechargeShopDescriptionCfg[var_1_0.description]
	self.params_.buyTime = ShopData.GetShop(self.params_.shopId)[self.params_.goodId] ~= nil and ShopData.GetShop(self.params_.shopId)[self.params_.goodId].buy_times or 0

	RechargeGiftPopLinkView.super.OnEnter(self)
end

return RechargeGiftPopLinkView
