local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693d"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_List_award = self:getChild("List_award")
	self.m_Txt_percent = self:getChild("Txt_percent")
	self.m_Txt_taskDesc = self:getChild("Txt_taskDesc")
	self.m_Btn_get = self:getChild("Btn_get")
	self.m_Btn_route = self:getChild("Btn_route")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
