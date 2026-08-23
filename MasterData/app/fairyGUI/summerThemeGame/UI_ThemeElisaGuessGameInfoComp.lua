local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6ml7x1spem7y"

function var_0_0:__ctor()
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_curScoreTxt = self:getChild("curScoreTxt")
	self.m_errorDecTimeComp = self:getChild("errorDecTimeComp")
	self.m_pauseBtn = self:getChild("pauseBtn")
	self.m_decTxt = self:getChild("decTxt")
	self.m_decAnimTransition = self:getTransition("decAnim")
end

return var_0_0
