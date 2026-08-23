local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm37"

function var_0_0:__ctor()
	self.m_proComp = self:getChild("proComp")
	self.m_tipComp = self:getChild("tipComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
