local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wj0dsbq"

function var_0_0:__ctor()
	self.m_isDiamondController = self:getController("isDiamond")
	self.m_discountPrice = self:getChild("discountPrice")
	self.m_originPrice = self:getChild("originPrice")
	self.m_iconTxt = self:getChild("iconTxt")
end

var_0_0.IsDiamondCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
