local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2jk2ist15vw"

function var_0_0:__ctor()
	self.m_teamFormationComp = self:getChild("teamFormationComp")
	self.m_saveBtn = self:getChild("saveBtn")
	self.m_tabBtn = self:getChild("tabBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
