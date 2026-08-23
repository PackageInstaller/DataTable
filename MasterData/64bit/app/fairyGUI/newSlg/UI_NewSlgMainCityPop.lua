local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ewxk4e"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_Comp_panel = self:getChild("Comp_panel")
	self.m_Comp_build1 = self:getChild("Comp_build1")
	self.m_Comp_build2 = self:getChild("Comp_build2")
	self.m_List_limit = self:getChild("List_limit")
	self.m_List_arm = self:getChild("List_arm")
	self.m_Btn_up = self:getChild("Btn_up")
	self.m_Txt_unlock = self:getChild("Txt_unlock")
	self.m_Img_line = self:getChild("Img_line")
	self.m_List_cost = self:getChild("List_cost")
end

return var_0_0
