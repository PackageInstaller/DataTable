local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gt62o12"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_eff = self:getChild("eff")
	self.m_upTransition = self:getTransition("up")
end

return var_0_0
