local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2uvdvg"

function var_0_0:__ctor()
	self.m_lineup_stateController = self:getController("lineup_state")
	self.m_effDi = self:getChild("effDi")
	self.m_effPetDown = self:getChild("effPetDown")
	self.m_effPetUp = self:getChild("effPetUp")
	self.m_Comp_drag = self:getChild("Comp_drag")
	self.m_Comp_pet = self:getChild("Comp_pet")
	self.m_Comp_match = self:getChild("Comp_match")
	self.m_Comp_fight = self:getChild("Comp_fight")
	self.m_Btn_lineup = self:getChild("Btn_lineup")
	self.m_Comp_top_bar = self:getChild("Comp_top_bar")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.Lineup_stateCtrl = {
	战斗 = 1,
	匹配 = 0
}

return var_0_0
