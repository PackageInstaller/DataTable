local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6ppb7kk39k"

function var_0_0:__ctor()
	self.m_curWaveTxt = self:getChild("curWaveTxt")
	self.m_maxWaveTxt = self:getChild("maxWaveTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_curScoreTxt = self:getChild("curScoreTxt")
	self.m_awardTimeComp = self:getChild("awardTimeComp")
	self.m_pauseBtn = self:getChild("pauseBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_countDownTransition = self:getTransition("countDown")
	self.m_refreshTransition = self:getTransition("refresh")
end

return var_0_0
