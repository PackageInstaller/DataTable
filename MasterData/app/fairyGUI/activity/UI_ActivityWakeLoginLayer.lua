local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wavfsl4"

function var_0_0:__ctor()
	self.m_effBg = self:getChild("effBg")
	self.m_banner = self:getChild("banner")
	self.m_dailyList = self:getChild("dailyList")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_timeBgLoader = self:getChild("timeBgLoader")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_sloganLoader = self:getChild("sloganLoader")
	self.m_previewBtn = self:getChild("previewBtn")
	self.m_star1 = self:getChild("star1")
	self.m_star2 = self:getChild("star2")
	self.m_cumulateList = self:getChild("cumulateList")
	self.m_dayBgLoader = self:getChild("dayBgLoader")
	self.m_dayTxt = self:getChild("dayTxt")
	self.m_progIcon = self:getChild("progIcon")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
