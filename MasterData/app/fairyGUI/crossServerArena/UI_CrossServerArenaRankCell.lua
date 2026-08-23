local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagjgxu4"

function var_0_0:__ctor()
	self.m_isTopThreeController = self:getController("isTopThree")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_lvText = self:getChild("lvText")
	self.m_nameText = self:getChild("nameText")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_rankText = self:getChild("rankText")
	self.m_guildText = self:getChild("guildText")
	self.m_powerText = self:getChild("powerText")
	self.m_scoreTxt = self:getChild("scoreTxt")
end

var_0_0.IsTopThreeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowBgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
