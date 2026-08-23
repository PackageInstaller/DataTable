local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wk3gjdn"

function var_0_0:__ctor()
	self.m_directController = self:getController("direct")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_loopTransition = self:getTransition("loop")
end

var_0_0.DirectCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
