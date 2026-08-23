local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gt62o11"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_effDot = self:getChild("effDot")
	self.m_upTransition = self:getTransition("up")
end

return var_0_0
