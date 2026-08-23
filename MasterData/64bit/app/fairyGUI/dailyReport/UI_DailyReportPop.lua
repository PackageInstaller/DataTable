local var_0_0 = {}

var_0_0.URL = "ui://8l7hr9r1oj7c0"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_touchPanel = self:getChild("touchPanel")
	self.m_report1 = self:getChild("report1")
	self.m_report2 = self:getChild("report2")
	self.m_report3 = self:getChild("report3")
	self.m_report4 = self:getChild("report4")
	self.m_report5 = self:getChild("report5")
	self.m_dayTxt = self:getChild("dayTxt")
	self.m_curMonthTxt = self:getChild("curMonthTxt")
	self.m_curDayTxt = self:getChild("curDayTxt")
	self.m_daily = self:getChild("daily")
	self.m_report10 = self:getChild("report10")
	self.m_report11 = self:getChild("report11")
	self.m_report12 = self:getChild("report12")
	self.m_report13 = self:getChild("report13")
	self.m_curMonthTxt1 = self:getChild("curMonthTxt1")
	self.m_curDayTxt1 = self:getChild("curDayTxt1")
	self.m_curMonthTxt2 = self:getChild("curMonthTxt2")
	self.m_curDayTxt2 = self:getChild("curDayTxt2")
	self.m_week = self:getChild("week")
	self.m_shareBtn = self:getChild("shareBtn")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_ignoreBtn = self:getChild("ignoreBtn")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_enter_2Transition = self:getTransition("enter_2")
end

return var_0_0
