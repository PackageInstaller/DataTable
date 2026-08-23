local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepb1a0ibmp"

function var_0_0:__ctor()
	self.m_isCrossServerController = self:getController("isCrossServer")
	self.m_userIocn = self:getChild("userIocn")
	self.m_level = self:getChild("level")
	self.m_playerName = self:getChild("playerName")
	self.m_chapternName = self:getChild("chapternName")
	self.m_agreeBtn = self:getChild("agreeBtn")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_fightText = self:getChild("fightText")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
end

var_0_0.IsCrossServerCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
