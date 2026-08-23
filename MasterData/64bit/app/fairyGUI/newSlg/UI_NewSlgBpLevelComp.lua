local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qdqe7t"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_Comp_effect = self:getChild("Comp_effect")
	self.m_Comp_prog1 = self:getChild("Comp_prog1")
	self.m_Comp_prog2 = self:getChild("Comp_prog2")
	self.m_Txt_exp = self:getChild("Txt_exp")
	self.m_Btn_buyLevel = self:getChild("Btn_buyLevel")
	self.m_Txt_level = self:getChild("Txt_level")
end

return var_0_0
