local var_0_0 = {}

var_0_0.URL = "ui://fqn2vo16mt0bh"

function var_0_0:__ctor()
	self.m_isLimitBuyController = self:getController("isLimitBuy")
	self.m_isLimitTimeController = self:getController("isLimitTime")
	self.m_isDiscountController = self:getController("isDiscount")
	self.m_isFreeController = self:getController("isFree")
	self.m_showRechargeTypeController = self:getController("showRechargeType")
	self.m_discountComp = self:getChild("discountComp")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_priceComp = self:getChild("priceComp")
	self.m_priceCompMoney = self:getChild("priceCompMoney")
	self.m_freeTxt = self:getChild("freeTxt")
	self.m_buyTitleTxt = self:getChild("buyTitleTxt")
	self.m_buyTimesTxt = self:getChild("buyTimesTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
