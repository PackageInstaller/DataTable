local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2be3m9"

function var_0_0:__ctor()
	self.m_is_emptyController = self:getController("is_empty")
	self.m_is_finalController = self:getController("is_final")
	self.m_bgEffect = self:getChild("bgEffect")
	self.m_Btn_check = self:getChild("Btn_check")
	self.m_Btn_left = self:getChild("Btn_left")
	self.m_Btn_right = self:getChild("Btn_right")
	self.m_Btn_invite = self:getChild("Btn_invite")
	self.m_Btn_rank = self:getChild("Btn_rank")
	self.m_Btn_quickIn = self:getChild("Btn_quickIn")
	self.m_Btn_create = self:getChild("Btn_create")
	self.m_List_team = self:getChild("List_team")
	self.m_Comp_stage = self:getChild("Comp_stage")
	self.m_Txt_finalTeamCd = self:getChild("Txt_finalTeamCd")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_finalCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
