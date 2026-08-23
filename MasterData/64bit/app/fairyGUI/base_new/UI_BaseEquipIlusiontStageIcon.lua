local var_0_0 = {}

var_0_0.URL = "ui://kvb3zneppnxg1emigik"

function var_0_0:__ctor()
	self.m_equipTypeController = self:getController("equipType")
	self.m_isActiveController = self:getController("isActive")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_iconLoader = self:getChild("iconLoader")
end

return var_0_0
