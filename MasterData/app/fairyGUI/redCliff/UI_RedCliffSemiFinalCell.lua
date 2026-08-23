local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2snviq5z"

function var_0_0:__ctor()
	self.m_isSelfController = self:getController("isSelf")
	self.m_bgTypeController = self:getController("bgType")
	self.m_headIcon = self:getChild("headIcon")
	self.m_name = self:getChild("name")
	self.m_fightValue = self:getChild("fightValue")
	self.m_server = self:getChild("server")
	self.m_index = self:getChild("index")
end

return var_0_0
