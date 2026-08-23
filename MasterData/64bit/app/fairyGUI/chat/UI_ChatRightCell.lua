local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn87dhwcby2x3"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isCrossServerController = self:getController("isCrossServer")
	self.m_heightBg = self:getChild("heightBg")
	self.m_nameText = self:getChild("nameText")
	self.m_userIcon = self:getChild("userIcon")
	self.m_clickBg = self:getChild("clickBg")
	self.m_text2 = self:getChild("text2")
	self.m_chatText = self:getChild("chatText")
	self.m_imgLoader = self:getChild("imgLoader")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_inviteText = self:getChild("inviteText")
	self.m_applyBtn = self:getChild("applyBtn")
	self.m_inviteTitle = self:getChild("inviteTitle")
	self.m_levelText = self:getChild("levelText")
	self.m_serverName = self:getChild("serverName")
end

var_0_0.StateCtrl = {
	page4 = 6,
	page3 = 5,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsCrossServerCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
