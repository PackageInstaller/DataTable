local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2uvdv5"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_effDi = self:getChild("effDi")
	self.m_effPetDown = self:getChild("effPetDown")
	self.m_Comp_prog = self:getChild("Comp_prog")
	self.m_Comp_pet = self:getChild("Comp_pet")
	self.m_Comp_user1 = self:getChild("Comp_user1")
	self.m_Comp_user2 = self:getChild("Comp_user2")
	self.m_Comp_user3 = self:getChild("Comp_user3")
	self.m_Comp_user4 = self:getChild("Comp_user4")
	self.m_Comp_stage = self:getChild("Comp_stage")
	self.m_Comp_score = self:getChild("Comp_score")
	self.m_Btn_rank = self:getChild("Btn_rank")
	self.m_Btn_shop = self:getChild("Btn_shop")
	self.m_Btn_chain = self:getChild("Btn_chain")
	self.m_Btn_report = self:getChild("Btn_report")
	self.m_Btn_message = self:getChild("Btn_message")
	self.m_Btn_pet = self:getChild("Btn_pet")
	self.m_Btn_apply = self:getChild("Btn_apply")
	self.m_Comp_award = self:getChild("Comp_award")
	self.m_Btn_fight = self:getChild("Btn_fight")
	self.m_Btn_lineup = self:getChild("Btn_lineup")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_effPetUp = self:getChild("effPetUp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	积分赛 = 0,
	淘汰赛 = 1
}

return var_0_0
