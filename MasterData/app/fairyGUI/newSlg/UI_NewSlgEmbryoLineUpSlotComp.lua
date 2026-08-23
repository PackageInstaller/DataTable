local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ewxk3o"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_star_typeController = self:getController("star_type")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_Comp_red = self:getChild("Comp_red")
	self.m_Btn_unLineUp = self:getChild("Btn_unLineUp")
	self.m_Comp_star = self:getChild("Comp_star")
	self.m_Txt_grade = self:getChild("Txt_grade")
	self.m_Comp_effect = self:getChild("Comp_effect")
end

return var_0_0
