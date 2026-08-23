local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9m10t0m2d"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_hpProgress = self:getChild("hpProgress")
	self.m_hpTxt = self:getChild("hpTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_challengeBtn = self:getChild("challengeBtn")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
