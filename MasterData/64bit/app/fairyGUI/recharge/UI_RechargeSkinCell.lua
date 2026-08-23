local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wt3hc6w"

function var_0_0:__ctor()
	self.m_isTimeLimitController = self:getController("isTimeLimit")
	self.m_isLimitController = self:getController("isLimit")
	self.m_canBuyController = self:getController("canBuy")
	self.m_scaleValueController = self:getController("scaleValue")
	self.m_isDiscountController = self:getController("isDiscount")
	self.m_picComp = self:getChild("picComp")
	self.m_timeLimit = self:getChild("timeLimit")
	self.m_hasOwnGroup = self:getChild("hasOwnGroup")
	self.m_timeLimitBg = self:getChild("timeLimitBg")
	self.m_limitTimeEfft = self:getChild("limitTimeEfft")
	self.m_limitGroup = self:getChild("limitGroup")
	self.m_timeLeftComp = self:getChild("timeLeftComp")
	self.m_skinEfft = self:getChild("skinEfft")
	self.m_discountComp = self:getChild("discountComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_ticketPriceTxt = self:getChild("ticketPriceTxt")
	self.m_buyTouchBg2 = self:getChild("buyTouchBg2")
	self.m_ticketPriceGroup = self:getChild("ticketPriceGroup")
	self.m_priceTxt = self:getChild("priceTxt")
	self.m_buyTouchBg = self:getChild("buyTouchBg")
	self.m_directPriceGroup = self:getChild("directPriceGroup")
	self.m_resPriceComp = self:getChild("resPriceComp")
	self.m_discountLabel = self:getChild("discountLabel")
	self.m_buyTouchBg3 = self:getChild("buyTouchBg3")
	self.m_priceGroup = self:getChild("priceGroup")
	self.m_limitComp = self:getChild("limitComp")
	self.m_upTransition = self:getTransition("up")
	self.m_downTransition = self:getTransition("down")
	self.m_normalTransition = self:getTransition("normal")
end

var_0_0.IsTimeLimitCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 4
}
var_0_0.IsLimitCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.CanBuyCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.ScaleValueCtrl = {
	page1 = 1,
	page0 = 0,
	page3 = 3,
	page2 = 2
}
var_0_0.IsDiscountCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 4
}

return var_0_0
