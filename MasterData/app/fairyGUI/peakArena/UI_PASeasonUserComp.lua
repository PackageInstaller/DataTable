local var_0_0 = {}

var_0_0.URL = "ui://puryq37khjxr77"

function var_0_0:__ctor()
	self.m_championController = self:getController("champion")
	self.m_userIcon = self:getChild("userIcon")
	self.m_level = self:getChild("level")
	self.m_name = self:getChild("name")
	self.m_serverName = self:getChild("serverName")
end

return var_0_0
