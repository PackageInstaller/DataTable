local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2qsqqj"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_Txt_pet_level = self:getChild("Txt_pet_level")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Comp_pet_equip = self:getChild("Comp_pet_equip")
	self.m_Txt_match_desc = self:getChild("Txt_match_desc")
	self.m_Txt_score_desc = self:getChild("Txt_score_desc")
	self.m_Txt_cd = self:getChild("Txt_cd")
	self.m_Txt_cd2 = self:getChild("Txt_cd2")
	self.m_Btn_fight = self:getChild("Btn_fight")
	self.m_Txt_round_cd = self:getChild("Txt_round_cd")
	self.m_Txt_round_name = self:getChild("Txt_round_name")
	self.m_daoshuTransition = self:getTransition("daoshu")
end

var_0_0.StateCtrl = {
	淘汰赛 = 1,
	积分赛 = 0
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
