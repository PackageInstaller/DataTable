local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wavfslx"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_rewardIcon = self:getChild("rewardIcon")
	self.m_dayTxt = self:getChild("dayTxt")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_eff = self:getChild("eff")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
