local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9uep09697j"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_tab0 = self:getChild("tab0")
	self.m_tab1 = self:getChild("tab1")
	self.m_achieveList = self:getChild("achieveList")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
