local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nknviqmibxz"

function var_0_0:__ctor()
	self.m_playerName = self:getChild("playerName")
	self.m_editorName = self:getChild("editorName")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
