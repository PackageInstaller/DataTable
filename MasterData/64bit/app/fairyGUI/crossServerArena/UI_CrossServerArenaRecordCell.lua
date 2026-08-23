local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuis1a"

function var_0_0:__ctor()
	self.m_challengeController = self:getController("challenge")
	self.m_resultLoader = self:getChild("resultLoader")
	self.m_resultText = self:getChild("resultText")
	self.m_rankText = self:getChild("rankText")
	self.m_recordBtn = self:getChild("recordBtn")
	self.m_leftUserComp = self:getChild("leftUserComp")
	self.m_rightUserComp = self:getChild("rightUserComp")
end

var_0_0.ChallengeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}

return var_0_0
