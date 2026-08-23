local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yiv9jwhmk"

function var_0_0:__ctor()
	self.m_isGrayController = self:getController("isGray")
	self.m_isDiscountController = self:getController("isDiscount")
	self.m_isTimeLimitController = self:getController("isTimeLimit")
	self.m_nameText = self:getChild("nameText")
	self.m_picComp = self:getChild("picComp")
	self.m_discountLable = self:getChild("discountLable")
	self.m_timeLimit = self:getChild("timeLimit")
	self.m_limitGroup = self:getChild("limitGroup")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsGrayCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsDiscountCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsTimeLimitCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
