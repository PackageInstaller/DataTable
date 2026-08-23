local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2kr031j"

function var_0_0:__ctor()
	self.m_is_emptyController = self:getController("is_empty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_List_user = self:getChild("List_user")
	self.m_Comp_empty = self:getChild("Comp_empty")
	self.m_content = self:getChild("content")
end

var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
