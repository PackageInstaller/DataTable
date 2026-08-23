local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2pmty1d"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_tab1 = self:getChild("tab1")
	self.m_tab2 = self:getChild("tab2")
	self.m_tab3 = self:getChild("tab3")
	self.m_List_user = self:getChild("List_user")
	self.m_Comp_empty = self:getChild("Comp_empty")
	self.m_oneKeyCallBtn = self:getChild("oneKeyCallBtn")
	self.m_content = self:getChild("content")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
