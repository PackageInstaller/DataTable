local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wpautiv"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_backIcon = self:getChild("backIcon")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_rechargeBtn = self:getChild("rechargeBtn")
	self.m_costTxt = self:getChild("costTxt")
	self.m_backTxt = self:getChild("backTxt")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
