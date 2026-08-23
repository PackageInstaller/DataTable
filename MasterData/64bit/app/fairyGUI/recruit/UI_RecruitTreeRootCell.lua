local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46nplogic1c"

function var_0_0:__ctor()
	self.m_subList = self:getChild("subList")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_icon1 = self:getChild("icon1")
	self.m_icon2 = self:getChild("icon2")
	self.m_tipText = self:getChild("tipText")
	self.m_redPoint = self:getChild("redPoint")
	self.m_size_minTransition = self:getTransition("size_min")
	self.m_size_maxTransition = self:getTransition("size_max")
end

return var_0_0
