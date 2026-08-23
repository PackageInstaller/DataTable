local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2xhbl4k"

function var_0_0:__ctor()
	self.m_my_emptyController = self:getController("my_empty")
	self.m_List_allocated = self:getChild("List_allocated")
	self.m_List_myAllocated = self:getChild("List_myAllocated")
end

var_0_0.My_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
