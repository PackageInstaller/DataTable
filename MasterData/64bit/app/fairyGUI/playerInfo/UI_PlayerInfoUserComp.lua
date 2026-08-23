local var_0_0 = {}

var_0_0.URL = "ui://1hwemy6untql29"

function var_0_0:__ctor()
	self.m_isSelfController = self:getController("isSelf")
	self.m_isCrossServerController = self:getController("isCrossServer")
	self.m_isSmallController = self:getController("isSmall")
	self.m_userIcon = self:getChild("userIcon")
	self.m_levelText = self:getChild("levelText")
	self.m_userName = self:getChild("userName")
	self.m_lookRoomBtn = self:getChild("lookRoomBtn")
	self.m_friendBtn = self:getChild("friendBtn")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_blackBtn = self:getChild("blackBtn")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_serverName = self:getChild("serverName")
	self.m_powerText = self:getChild("powerText")
	self.m_guildName = self:getChild("guildName")
end

var_0_0.IsSelfCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsCrossServerCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsSmallCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
