local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd09t"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_playerNameTxt = self:getChild("playerNameTxt")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.RankCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
