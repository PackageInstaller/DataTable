local var_0_0 = {}

var_0_0.URL = "ui://454a48jpc8pw14bnnmf"

function var_0_0:__ctor()
	self.m_lackController = self:getController("lack")
	self.m_isOnSaleController = self:getController("isOnSale")
	self.m_discountPriceTxt = self:getChild("discountPriceTxt")
end

var_0_0.LackCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOnSaleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
