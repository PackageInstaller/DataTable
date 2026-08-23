local var_0_0 = {}

var_0_0.URL = "ui://h35b870beba22"

function var_0_0:__ctor()
	self.m_isLowActiveController = self:getController("isLowActive")
	self.m_landComp = self:getChild("landComp")
	self.m_topBar = self:getChild("topBar")
	self.m_guildIcon = self:getChild("guildIcon")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_guildLevelTxt = self:getChild("guildLevelTxt")
	self.m_redPacketBtn = self:getChild("redPacketBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
