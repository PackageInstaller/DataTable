local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2scjyt6s"

function var_0_0:__ctor()
	self.m_isSelfController = self:getController("isSelf")
	self.m_hasBgController = self:getController("hasBg")
	self.m_index = self:getChild("index")
	self.m_headComp = self:getChild("headComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_fightValue = self:getChild("fightValue")
	self.m_server = self:getChild("server")
end

return var_0_0
