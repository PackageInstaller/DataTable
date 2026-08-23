local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693e"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_Comp_tab2 = self:getChild("Comp_tab2")
	self.m_Comp_tab1 = self:getChild("Comp_tab1")
	self.m_List_achievement = self:getChild("List_achievement")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
