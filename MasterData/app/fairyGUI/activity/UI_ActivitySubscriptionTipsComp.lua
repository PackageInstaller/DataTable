local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9whs8u2p"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_descTxt = self:getChild("descTxt")
	self.m_gotoRechargeBtn = self:getChild("gotoRechargeBtn")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
