local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ouc78f"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_tab1 = self:getChild("tab1")
	self.m_List_player = self:getChild("List_player")
	self.m_Btn_call = self:getChild("Btn_call")
	self.m_Com_empty = self:getChild("Com_empty")
	self.m_content = self:getChild("content")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
