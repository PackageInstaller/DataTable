local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wf3yy0"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_banner = self:getChild("banner")
	self.m_cumulateList = self:getChild("cumulateList")
	self.m_dailyList = self:getChild("dailyList")
	self.m_dayBgLoader = self:getChild("dayBgLoader")
	self.m_dayTxt = self:getChild("dayTxt")
	self.m_sloganLoader = self:getChild("sloganLoader")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_previewBtn = self:getChild("previewBtn")
	self.m_timeBgLoader = self:getChild("timeBgLoader")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
