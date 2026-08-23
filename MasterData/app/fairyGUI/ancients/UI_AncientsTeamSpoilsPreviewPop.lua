local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2ofz129"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_popPanel = self:getChild("popPanel")
	self.m_Comp_tab1 = self:getChild("Comp_tab1")
	self.m_Comp_tab2 = self:getChild("Comp_tab2")
	self.m_Comp_tab3 = self:getChild("Comp_tab3")
	self.m_Comp_tab4 = self:getChild("Comp_tab4")
	self.m_List_award = self:getChild("List_award")
	self.m_content = self:getChild("content")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
