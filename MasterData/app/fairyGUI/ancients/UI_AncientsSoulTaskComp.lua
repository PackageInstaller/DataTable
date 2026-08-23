local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2unko3f"

function var_0_0:__ctor()
	self.m_task_groupController = self:getController("task_group")
	self.m_is_openController = self:getController("is_open")
	self.m_Comp_tab1 = self:getChild("Comp_tab1")
	self.m_Comp_tab2 = self:getChild("Comp_tab2")
	self.m_List_task = self:getChild("List_task")
end

var_0_0.Task_groupCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_openCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
