local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25btydh"

function var_0_0:__ctor()
	self.m_hasPlayerController = self:getController("hasPlayer")
	self.m_hasBgController = self:getController("hasBg")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_guildHeadComp = self:getChild("guildHeadComp")
	self.m_guildTxt = self:getChild("guildTxt")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_serverTxt = self:getChild("serverTxt")
	self.m_damageTxt = self:getChild("damageTxt")
end

var_0_0.HasPlayerCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HasBgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
