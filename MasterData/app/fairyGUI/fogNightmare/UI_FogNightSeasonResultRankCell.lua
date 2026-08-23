local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88onsbkrrn6"

function var_0_0:__ctor()
	self.m_isMeController = self:getController("isMe")
	self.m_hasGuildController = self:getController("hasGuild")
	self.m_rankText = self:getChild("rankText")
	self.m_userIcon = self:getChild("userIcon")
	self.m_userNameText = self:getChild("userNameText")
	self.m_guildNameText = self:getChild("guildNameText")
	self.m_stageText = self:getChild("stageText")
end

var_0_0.IsMeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasGuildCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
