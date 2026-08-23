local var_0_0 = {}

var_0_0.URL = "ui://akds0szasmfh1e"

function var_0_0:__ctor()
	self.m_inviteStateController = self:getController("inviteState")
	self.m_isCrossServerController = self:getController("isCrossServer")
	self.m_userIcon = self:getChild("userIcon")
	self.m_name = self:getChild("name")
	self.m_guildName = self:getChild("guildName")
	self.m_fightValue = self:getChild("fightValue")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_inviteBtn = self:getChild("inviteBtn")
	self.m_leftTime = self:getChild("leftTime")
end

return var_0_0
