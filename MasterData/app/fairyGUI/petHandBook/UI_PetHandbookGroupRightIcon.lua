local var_0_0 = {}

var_0_0.URL = "ui://05rqz4hsmrvn41"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_isPutController = self:getController("isPut")
	self.m_petIcon = self:getChild("petIcon")
	self.m_rightQualityLoader = self:getChild("rightQualityLoader")
	self.m_name = self:getChild("name")
	self.m_star = self:getChild("star")
	self.m_mask = self:getChild("mask")
end

return var_0_0
