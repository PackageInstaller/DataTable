local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ypdnfl5ibm2"

function var_0_0:__ctor()
	self.m_identityController = self:getController("identity")
	self.m_logTypeController = self:getController("logType")
	self.m_indexText = self:getChild("indexText")
	self.m_identityText = self:getChild("identityText")
	self.m_desc = self:getChild("desc")
	self.m_descType = self:getChild("descType")
end

return var_0_0
