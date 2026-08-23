local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagqtk927"

function var_0_0:__ctor()
	self.m_arenaBtn = self:getChild("arenaBtn")
	self.m_chiefArenaBtn = self:getChild("chiefArenaBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
