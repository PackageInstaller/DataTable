local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ni5y68su"

function var_0_0:__ctor()
	self.m_isSmallController = self:getController("isSmall")
	self.m_userIcon = self:getChild("userIcon")
	self.m_levelText = self:getChild("levelText")
	self.m_userName = self:getChild("userName")
	self.m_friendBtn = self:getChild("friendBtn")
	self.m_blackBtn = self:getChild("blackBtn")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_serverName = self:getChild("serverName")
	self.m_powerText = self:getChild("powerText")
	self.m_allianceName = self:getChild("allianceName")
end

var_0_0.IsSmallCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
