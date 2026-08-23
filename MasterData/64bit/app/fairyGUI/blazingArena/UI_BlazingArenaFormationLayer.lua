local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9v3rk2c"

function var_0_0:__ctor()
	self.m_formationIdxController = self:getController("formationIdx")
	self.m_teamComp = self:getChild("teamComp")
	self.m_tabList = self:getChild("tabList")
	self.m_nextBtn = self:getChild("nextBtn")
	self.m_saveBtn = self:getChild("saveBtn")
	self.m_groupIcon = self:getChild("groupIcon")
	self.m_buffTxt = self:getChild("buffTxt")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
