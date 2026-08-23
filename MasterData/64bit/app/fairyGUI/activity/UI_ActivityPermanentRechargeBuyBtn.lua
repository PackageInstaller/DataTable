local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wk3gjdj"

function var_0_0:__ctor()
	self.m_hasBuyController = self:getController("hasBuy")
	self.m_discountTxt = self:getChild("discountTxt")
	self.m_originTxt = self:getChild("originTxt")
end

var_0_0.HasBuyCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
