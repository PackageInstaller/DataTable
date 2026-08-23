local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9iqj728"

function var_0_0:__ctor()
	self.m_isTopThreeController = self:getController("isTopThree")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_nameText = self:getChild("nameText")
	self.m_lvText = self:getChild("lvText")
	self.m_rankText = self:getChild("rankText")
	self.m_guildText = self:getChild("guildText")
	self.m_powerText = self:getChild("powerText")
end

return var_0_0
