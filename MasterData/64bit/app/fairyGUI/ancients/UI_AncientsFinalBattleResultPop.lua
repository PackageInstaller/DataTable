local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2efrz66"

function var_0_0:__ctor()
	self.m_is_winController = self:getController("is_win")
	self.m_Comp_click = self:getChild("Comp_click")
	self.m_Comp_effect_atk_result = self:getChild("Comp_effect_atk_result")
	self.m_List_atk_user = self:getChild("List_atk_user")
	self.m_Comp_effect_def_result = self:getChild("Comp_effect_def_result")
	self.m_List_def_user = self:getChild("List_def_user")
	self.m_Txt_def_score = self:getChild("Txt_def_score")
	self.m_Txt_atk_score = self:getChild("Txt_atk_score")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.Is_winCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
