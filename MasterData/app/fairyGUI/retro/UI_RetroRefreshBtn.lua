local var_0_0 = {}

var_0_0.URL = "ui://e2ymx4wafr981o"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_freeTxt = self:getChild("freeTxt")
	self.m_costComp = self:getChild("costComp")
end

return var_0_0
