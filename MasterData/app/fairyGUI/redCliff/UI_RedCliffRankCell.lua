local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2snviq5m"

function var_0_0:__ctor()
	self.m_hasPlayerController = self:getController("hasPlayer")
	self.m_hasBgController = self:getController("hasBg")
	self.m_rankComp = self:getChild("rankComp")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_stage = self:getChild("stage")
	self.m_fightValue = self:getChild("fightValue")
	self.m_score = self:getChild("score")
	self.m_server = self:getChild("server")
end

return var_0_0
