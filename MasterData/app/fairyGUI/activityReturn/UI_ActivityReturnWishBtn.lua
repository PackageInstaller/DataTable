local var_0_0 = {}

var_0_0.URL = "ui://0xhekt5ief2w1a"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_eff = self:getChild("eff")
	self.m_knightIcon = self:getChild("knightIcon")
end

return var_0_0
