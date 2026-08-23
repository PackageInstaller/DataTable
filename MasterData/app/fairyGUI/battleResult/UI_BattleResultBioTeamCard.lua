local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkl8r4ibss"

function var_0_0:__ctor()
	self.m_bg = self:getChild("bg")
	self.m_effectComp = self:getChild("effectComp")
	self.m_rewardComp = self:getChild("rewardComp")
	self.m_play0Transition = self:getTransition("play0")
	self.m_cardBgTransition = self:getTransition("cardBg")
	self.m_play1Transition = self:getTransition("play1")
	self.m_play2Transition = self:getTransition("play2")
	self.m_play3Transition = self:getTransition("play3")
	self.m_play4Transition = self:getTransition("play4")
end

return var_0_0
