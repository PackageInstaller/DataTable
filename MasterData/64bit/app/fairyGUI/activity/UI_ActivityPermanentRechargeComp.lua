local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wo2388s"

function var_0_0:__ctor()
	self.m_canBuyController = self:getController("canBuy")
	self.m_knightComp = self:getChild("knightComp")
	self.m_buyComp = self:getChild("buyComp")
	self.m_lookBtn = self:getChild("lookBtn")
	self.m_attrTxt = self:getChild("attrTxt")
	self.m_skinAttrGroup = self:getChild("skinAttrGroup")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.CanBuyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
