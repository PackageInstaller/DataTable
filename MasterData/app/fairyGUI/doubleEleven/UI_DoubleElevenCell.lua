local var_0_0 = {}

var_0_0.URL = "ui://vtqfjjaif2do5"

function var_0_0:__ctor()
	self.m_isLimitController = self:getController("isLimit")
	self.m_isAdditionalController = self:getController("isAdditional")
	self.m_isGiftController = self:getController("isGift")
	self.m_canBuyController = self:getController("canBuy")
	self.m_item = self:getChild("item")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_resComp = self:getChild("resComp")
	self.m_limitTimes = self:getChild("limitTimes")
	self.m_resIcon4 = self:getChild("resIcon4")
	self.m_resNum4 = self:getChild("resNum4")
	self.m_resIcon3 = self:getChild("resIcon3")
	self.m_resNum3 = self:getChild("resNum3")
	self.m_resIcon2 = self:getChild("resIcon2")
	self.m_resNum2 = self:getChild("resNum2")
	self.m_priceComp = self:getChild("priceComp")
end

var_0_0.IsLimitCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsAdditionalCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsGiftCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1
}
var_0_0.CanBuyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
