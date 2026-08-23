local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83ijb632"

function var_0_0:__ctor()
	self.m_showCDController = self:getController("showCD")
	self.m_titleTextIcon = self:getChild("titleTextIcon")
	self.m_taskList = self:getChild("taskList")
	self.m_tabList = self:getChild("tabList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_lineLoader = self:getChild("lineLoader")
	self.m_dailyRefreshTxt = self:getChild("dailyRefreshTxt")
	self.m_dailyGroup = self:getChild("dailyGroup")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
