local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wd1uyd7"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_lineBgImg = self:getChild("lineBgImg")
	self.m_rechargeTest = self:getChild("rechargeTest")
	self.m_itemComp = self:getChild("itemComp")
	self.m_rechargeBtn = self:getChild("rechargeBtn")
	self.m_getBtn = self:getChild("getBtn")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
