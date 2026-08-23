local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0q8"

function var_0_0:__ctor()
	self.m_isInviteController = self:getController("isInvite")
	self.m_guildPic = self:getChild("guildPic")
	self.m_guildName = self:getChild("guildName")
	self.m_serverName = self:getChild("serverName")
	self.m_memberNum = self:getChild("memberNum")
	self.m_powerTxt = self:getChild("powerTxt")
	self.m_inviteBtn = self:getChild("inviteBtn")
	self.m_level = self:getChild("level")
end

var_0_0.IsInviteCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
