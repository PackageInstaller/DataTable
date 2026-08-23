local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfqr6v32"

function var_0_0:__ctor()
	self.m_rankList = self:getChild("rankList")
	self.m_ourTeamRankTxt = self:getChild("ourTeamRankTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
