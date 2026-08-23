local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llx1i"

function var_0_0:__ctor()
	self.m_isTopThreeController = self:getController("isTopThree")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_lvText = self:getChild("lvText")
	self.m_nameText = self:getChild("nameText")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_rankText = self:getChild("rankText")
	self.m_powerText = self:getChild("powerText")
	self.m_scoreTxt = self:getChild("scoreTxt")
end

return var_0_0
