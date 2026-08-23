local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwi6ei2c"

function var_0_0:__ctor()
	self.m_monsterIcon = self:getChild("monsterIcon")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
