local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52woq5i74"

function var_0_0:__ctor()
	self.m_hasSubController = self:getController("hasSub")
	self.m_isHotSaleController = self:getController("isHotSale")
	self.m_bg = self:getChild("bg")
	self.m_title1 = self:getChild("title1")
	self.m_subBg = self:getChild("subBg")
	self.m_subList = self:getChild("subList")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_t0Transition = self:getTransition("t0")
end

var_0_0.HasSubCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsHotSaleCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 3
}

return var_0_0
