local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a1l"

function var_0_0:__ctor()
	self.m_is_baseController = self:getController("is_base")
	self.m_redLine2 = self:getChild("redLine2")
	self.m_Txt_formula = self:getChild("Txt_formula")
	self.m_Txt_rule = self:getChild("Txt_rule")
	self.m_List_army = self:getChild("List_army")
	self.m_Txt_unlock = self:getChild("Txt_unlock")
	self.m_Txt_rule1 = self:getChild("Txt_rule1")
end

var_0_0.Is_baseCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
