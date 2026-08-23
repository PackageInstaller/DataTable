local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2doeo6c"

function var_0_0:__ctor()
	self.m_is_winController = self:getController("is_win")
	self.m_isSelfController = self:getController("isSelf")
	self.m_popPanel = self:getChild("popPanel")
	self.m_Txt_win = self:getChild("Txt_win")
	self.m_Txt_def_lose = self:getChild("Txt_def_lose")
	self.m_Txt_def_score = self:getChild("Txt_def_score")
	self.m_Txt_atk_score = self:getChild("Txt_atk_score")
	self.m_Comp_atk_icon = self:getChild("Comp_atk_icon")
	self.m_Txt_atk_name = self:getChild("Txt_atk_name")
	self.m_Txt_atk_fight_value = self:getChild("Txt_atk_fight_value")
	self.m_Comp_def_icon = self:getChild("Comp_def_icon")
	self.m_Txt_def_name = self:getChild("Txt_def_name")
	self.m_Txt_def_fight_value = self:getChild("Txt_def_fight_value")
	self.m_List_path = self:getChild("List_path")
	self.m_content = self:getChild("content")
end

var_0_0.Is_winCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsSelfCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
