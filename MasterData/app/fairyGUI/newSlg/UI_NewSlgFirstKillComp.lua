local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9rvr168ms"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_Comp_tab1 = self:getChild("Comp_tab1")
	self.m_Comp_tab2 = self:getChild("Comp_tab2")
	self.m_Comp_tab3 = self:getChild("Comp_tab3")
	self.m_List_teams1 = self:getChild("List_teams1")
	self.m_List_teams2 = self:getChild("List_teams2")
	self.m_List_teams3 = self:getChild("List_teams3")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
