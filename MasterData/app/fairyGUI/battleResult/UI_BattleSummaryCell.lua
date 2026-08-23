local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkxubz2f"

function var_0_0:__ctor()
	self.m_winController = self:getController("win")
	self.m_diffController = self:getController("diff")
	self.m_showStateController = self:getController("showState")
	self.m_iconComp1 = self:getChild("iconComp1")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_name1 = self:getChild("name1")
	self.m_dam1Pb = self:getChild("dam1Pb")
	self.m_takeDam1Pb = self:getChild("takeDam1Pb")
	self.m_recover1Pb = self:getChild("recover1Pb")
	self.m_group1 = self:getChild("group1")
end

return var_0_0
