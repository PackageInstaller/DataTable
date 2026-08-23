local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9muncv20"

function var_0_0:__ctor()
	self.m_challengeEmptyController = self:getController("challengeEmpty")
	self.m_robEmptyController = self:getController("robEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_challengeList = self:getChild("challengeList")
	self.m_robList = self:getChild("robList")
	self.m_content = self:getChild("content")
end

var_0_0.ChallengeEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.RobEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
