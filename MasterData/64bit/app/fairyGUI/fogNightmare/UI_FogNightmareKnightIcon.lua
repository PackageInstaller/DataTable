local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnt"

function var_0_0:__ctor()
	self.m_knightComp = self:getChild("knightComp")
	self.m_sealLoader = self:getChild("sealLoader")
	self.m_sealIcon = self:getChild("sealIcon")
	self.m_effIcon = self:getChild("effIcon")
	self.m_keepsakeEnterTransition = self:getTransition("keepsakeEnter")
end

return var_0_0
