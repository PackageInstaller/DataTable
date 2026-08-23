local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wgmjec1"

function var_0_0:__ctor()
	self.m_canDrawController = self:getController("canDraw")
	self.m_priceDesc = self:getChild("priceDesc")
	self.m_leftTimeTxt = self:getChild("leftTimeTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.CanDrawCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
