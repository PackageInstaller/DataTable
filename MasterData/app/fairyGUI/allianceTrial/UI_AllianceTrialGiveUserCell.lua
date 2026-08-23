local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llx11"

function var_0_0:__ctor()
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_isGiveController = self:getController("isGive")
	self.m_userComp = self:getChild("userComp")
	self.m_userName = self:getChild("userName")
	self.m_level = self:getChild("level")
	self.m_serverName = self:getChild("serverName")
	self.m_fightValue = self:getChild("fightValue")
	self.m_giveCount = self:getChild("giveCount")
	self.m_giveBtn = self:getChild("giveBtn")
end

return var_0_0
