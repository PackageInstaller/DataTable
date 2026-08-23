local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9m10t0m2e"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_buildLoader = self:getChild("buildLoader")
	self.m_progressComp = self:getChild("progressComp")
	self.m_hpTxt = self:getChild("hpTxt")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_effHolder = self:getChild("effHolder")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
