local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8eivux34"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_bossList = self:getChild("bossList")
	self.m_bossInfoComp = self:getChild("bossInfoComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_switchUpTransition = self:getTransition("switchUp")
end

return var_0_0
