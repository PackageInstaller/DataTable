local var_0_0 = {}

var_0_0.URL = "ui://z48x0zjhofaj1q"

function var_0_0:__ctor()
	self.m_teamFormationComp = self:getChild("teamFormationComp")
	self.m_saveBtn = self:getChild("saveBtn")
	self.m_tabBtn = self:getChild("tabBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_descTxt = self:getChild("descTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
