local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgft555ibj3"

function var_0_0:__ctor()
	self.m_subList = self:getChild("subList")
	self.m_sizeMinTransition = self:getTransition("sizeMin")
	self.m_sizeMaxTransition = self:getTransition("sizeMax")
end

return var_0_0
