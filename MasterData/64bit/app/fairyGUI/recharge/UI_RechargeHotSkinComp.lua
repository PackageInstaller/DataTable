local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52woq5i8g"

function var_0_0:__ctor()
	self.m_scaleValueController = self:getController("scaleValue")
	self.m_isDiscountController = self:getController("isDiscount")
	self.m_picLoader = self:getChild("picLoader")
	self.m_videoComp = self:getChild("videoComp")
	self.m_costIcon = self:getChild("costIcon")
	self.m_symbolTxt = self:getChild("symbolTxt")
	self.m_priceTxt = self:getChild("priceTxt")
	self.m_oldPriceTitle = self:getChild("oldPriceTitle")
	self.m_discountTxt = self:getChild("discountTxt")
	self.m_gotoBtn = self:getChild("gotoBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.ScaleValueCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsDiscountCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
