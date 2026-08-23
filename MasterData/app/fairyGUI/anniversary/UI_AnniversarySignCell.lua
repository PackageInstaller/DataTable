local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiq9hnm27"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_effGet = self:getChild("effGet")
	self.m_dayTxt = self:getChild("dayTxt")
	self.m_progressBar = self:getChild("progressBar")
	self.m_getTodayTransition = self:getTransition("getToday")
end

return var_0_0
