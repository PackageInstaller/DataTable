local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2be3m14"

function var_0_0:__ctor()
	self.m_tabTypeController = self:getController("tabType")
	self.m_Comp_pet = self:getChild("Comp_pet")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_num = self:getChild("Txt_num")
	self.m_Txt_fight = self:getChild("Txt_fight")
	self.m_Btn_reject = self:getChild("Btn_reject")
	self.m_Btn_confirm = self:getChild("Btn_confirm")
	self.m_Btn_cancel = self:getChild("Btn_cancel")
	self.m_Btn_apply = self:getChild("Btn_apply")
end

var_0_0.TabTypeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
