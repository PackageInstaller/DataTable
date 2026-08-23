local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2ov6g3s"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_Comp_spine = self:getChild("Comp_spine")
	self.m_Comp_skill1 = self:getChild("Comp_skill1")
	self.m_Comp_skill2 = self:getChild("Comp_skill2")
	self.m_Comp_skill3 = self:getChild("Comp_skill3")
	self.m_Txt_pet_level = self:getChild("Txt_pet_level")
	self.m_Txt_pet_fight_value = self:getChild("Txt_pet_fight_value")
end

var_0_0.StateCtrl = {
	淘汰赛 = 1,
	积分赛 = 0
}

return var_0_0
