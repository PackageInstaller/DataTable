local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2qsqqm"

function var_0_0:__ctor()
	self.m_is_leaderController = self:getController("is_leader")
	self.m_is_selfController = self:getController("is_self")
	self.m_Comp_rect = self:getChild("Comp_rect")
	self.m_Comp_spine = self:getChild("Comp_spine")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Comp_fight_value = self:getChild("Comp_fight_value")
	self.m_Prog_hp = self:getChild("Prog_hp")
end

var_0_0.Is_leaderCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Is_selfCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
