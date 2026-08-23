local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2be3mt"

function var_0_0:__ctor()
	self.m_same_countryController = self:getController("same_country")
	self.m_is_finalController = self:getController("is_final")
	self.m_popPanel = self:getChild("popPanel")
	self.m_Comp_pet = self:getChild("Comp_pet")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Btn_chat = self:getChild("Btn_chat")
	self.m_Txt_soulLv = self:getChild("Txt_soulLv")
	self.m_Txt_num = self:getChild("Txt_num")
	self.m_Txt_fight = self:getChild("Txt_fight")
	self.m_Txt_bool = self:getChild("Txt_bool")
	self.m_Txt_limit = self:getChild("Txt_limit")
	self.m_Txt_rank = self:getChild("Txt_rank")
	self.m_List_team = self:getChild("List_team")
	self.m_Txt_point = self:getChild("Txt_point")
	self.m_Btn_join = self:getChild("Btn_join")
	self.m_Btn_cancel = self:getChild("Btn_cancel")
	self.m_content = self:getChild("content")
end

var_0_0.Same_countryCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_finalCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
