local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2r02u2e"

function var_0_0:__ctor()
	self.m_is_emptyController = self:getController("is_empty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_Btn_message = self:getChild("Btn_message")
	self.m_List_message = self:getChild("List_message")
	self.m_Comp_empty = self:getChild("Comp_empty")
	self.m_content = self:getChild("content")
end

var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
