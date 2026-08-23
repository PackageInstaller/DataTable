local var_0_0 = {}

var_0_0.URL = "ui://44qiyyomft7s9bnomh"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_scoreText1 = self:getChild("scoreText1")
	self.m_scoreText2 = self:getChild("scoreText2")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page3 = 3,
	page2 = 2,
	page1 = 1
}

return var_0_0
