local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9rvr168mp"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_Comp_task = self:getChild("Comp_task")
	self.m_Comp_firstKill = self:getChild("Comp_firstKill")
	self.m_Comp_tab1 = self:getChild("Comp_tab1")
	self.m_Comp_tab3 = self:getChild("Comp_tab3")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TabCtrl = {
	荣誉 = 2,
	悬赏任务 = 0
}

return var_0_0
