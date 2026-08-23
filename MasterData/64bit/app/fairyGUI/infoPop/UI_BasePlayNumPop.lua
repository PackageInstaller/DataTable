local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnlohxibr2"

function var_0_0:__ctor()
	self.m_timesController = self:getController("times")
	self.m_popPanel = self:getChild("popPanel")
	self.m_baseIcon = self:getChild("baseIcon")
	self.m_useBtn = self:getChild("useBtn")
	self.m_buyBtn = self:getChild("buyBtn")
	self.m_desc = self:getChild("desc")
	self.m_numTxt = self:getChild("numTxt")
	self.m_timesTxt = self:getChild("timesTxt")
	self.m_overTxt = self:getChild("overTxt")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TimesCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
