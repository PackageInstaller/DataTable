local var_0_0 = {}

var_0_0.URL = "ui://671qywx2ezpn11"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_stateController = self:getController("state")
	self.m_mr = self:getChild("mr")
	self.m_ur = self:getChild("ur")
	self.m_ssr = self:getChild("ssr")
	self.m_sr = self:getChild("sr")
	self.m_r = self:getChild("r")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_saveBtn = self:getChild("saveBtn")
end

return var_0_0
