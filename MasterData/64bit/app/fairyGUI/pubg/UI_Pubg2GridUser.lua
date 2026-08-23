local var_0_0 = {}

var_0_0.URL = "ui://pbd24silza3s78"

function var_0_0:__ctor()
	self.m_showKnight = self:getChild("showKnight")
	self.m_pos = self:getChild("pos")
	self.m_addExpTransition = self:getTransition("addExp")
	self.m_reliveTransition = self:getTransition("relive")
	self.m_levelTransition = self:getTransition("level")
end

return var_0_0
