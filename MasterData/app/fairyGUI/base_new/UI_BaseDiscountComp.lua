local var_0_0 = {}

var_0_0.URL = "ui://kvb3zneprlifwkk333"

function var_0_0:__ctor()
	self.m_bgScaleController = self:getController("bgScale")
	self.m_discountTypeController = self:getController("discountType")
end

var_0_0.BgScaleCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.DiscountTypeCtrl = {
	chiper = 1,
	normal = 0
}

return var_0_0
