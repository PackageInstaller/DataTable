local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivqoiyfrf3"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_eff = self:getChild("eff")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
