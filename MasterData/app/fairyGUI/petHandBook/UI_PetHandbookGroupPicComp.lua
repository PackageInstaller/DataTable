local var_0_0 = {}

var_0_0.URL = "ui://05rqz4hsmrvn42"

function var_0_0:__ctor()
	self.m_petNumController = self:getController("petNum")
	self.m_isActiveController = self:getController("isActive")
	self.m_rightIcon = self:getChild("rightIcon")
	self.m_leftIcon = self:getChild("leftIcon")
	self.m_singleIcon = self:getChild("singleIcon")
	self.m_qualityLoader = self:getChild("qualityLoader")
end

return var_0_0
