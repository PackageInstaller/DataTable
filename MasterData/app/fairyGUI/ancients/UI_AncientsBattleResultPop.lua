local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2t1ji34"

function var_0_0:__ctor()
	self.m_is_winController = self:getController("is_win")
	self.m_Comp_effect_resultBg = self:getChild("Comp_effect_resultBg")
	self.m_Comp_effect_resultLoop = self:getChild("Comp_effect_resultLoop")
	self.m_Comp_effect_resultPlay = self:getChild("Comp_effect_resultPlay")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Loader_award_icon = self:getChild("Loader_award_icon")
	self.m_Comp_effect_up = self:getChild("Comp_effect_up")
	self.m_Txt_award = self:getChild("Txt_award")
	self.m_Txt_score_prog = self:getChild("Txt_score_prog")
	self.m_Txt_score_add = self:getChild("Txt_score_add")
	self.m_Prog_score = self:getChild("Prog_score")
	self.m_List_user = self:getChild("List_user")
	self.m_Comp_click = self:getChild("Comp_click")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.Is_winCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
