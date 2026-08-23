local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9mlm82y"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_Comp_build1 = self:getChild("Comp_build1")
	self.m_Comp_build2 = self:getChild("Comp_build2")
	self.m_List_level = self:getChild("List_level")
	self.m_List_cost = self:getChild("List_cost")
	self.m_Btn_up = self:getChild("Btn_up")
	self.m_Txt_unlock = self:getChild("Txt_unlock")
end

return var_0_0
