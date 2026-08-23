local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8ltoz97q"

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

var_0_0.InviteStateCtrl = {
	邀请冷却中 = 1,
	可邀请 = 0
}
var_0_0.IsCrossServerCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
