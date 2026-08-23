local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6ml7x1spem7s"

function var_0_0:__ctor()
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_phaseComp = self:getChild("phaseComp")
	self.m_surplusTimeComp = self:getChild("surplusTimeComp")
	self.m_errorDecTimeComp = self:getChild("errorDecTimeComp")
	self.m_baseTimeComp = self:getChild("baseTimeComp")
	self.m_awardList = self:getChild("awardList")
	self.m_startGameBtn = self:getChild("startGameBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
