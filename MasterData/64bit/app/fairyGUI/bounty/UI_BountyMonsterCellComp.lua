local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfqr6v3m"

function var_0_0:__ctor()
	self.m_isNewController = self:getController("isNew")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_leftTimeTxt = self:getChild("leftTimeTxt")
end

return var_0_0
