local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obl1fx1q"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_eff = self:getChild("eff")
	self.m_scoreText = self:getChild("scoreText")
	self.m_awardList = self:getChild("awardList")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_getAwardComp = self:getChild("getAwardComp")
end

var_0_0.StateCtrl = {
	page2 = 4,
	page1 = 1,
	page0 = 0,
	page3 = 5
}

return var_0_0
