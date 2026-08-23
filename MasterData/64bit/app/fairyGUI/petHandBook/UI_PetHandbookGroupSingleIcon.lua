local var_0_0 = {}

var_0_0.URL = "ui://05rqz4hsmrvn43"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_isPutController = self:getController("isPut")
	self.m_petIcon = self:getChild("petIcon")
	self.m_singleQualityLoader = self:getChild("singleQualityLoader")
	self.m_name = self:getChild("name")
	self.m_star = self:getChild("star")
end

return var_0_0
