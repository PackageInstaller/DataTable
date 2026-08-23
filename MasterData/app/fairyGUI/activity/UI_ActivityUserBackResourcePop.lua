local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wqlxuk2"

function var_0_0:__ctor()
	self.m_selectDayController = self:getController("selectDay")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_openGraph = self:getChild("openGraph")
	self.m_effStar = self:getChild("effStar")
	self.m_effTitle = self:getChild("effTitle")
	self.m_tipsText = self:getChild("tipsText")
	self.m_timeText = self:getChild("timeText")
	self.m_daySelBtn1 = self:getChild("daySelBtn1")
	self.m_daySelBtn2 = self:getChild("daySelBtn2")
	self.m_daySelBtn3 = self:getChild("daySelBtn3")
	self.m_resourceList = self:getChild("resourceList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.SelectDayCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
