local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2zcce28"

function var_0_0:__ctor()
	self.m_is_leaderController = self:getController("is_leader")
	self.m_show_battleController = self:getController("show_battle")
	self.m_Comp_spine = self:getChild("Comp_spine")
	self.m_Comp_effect = self:getChild("Comp_effect")
	self.m_Prog_hp = self:getChild("Prog_hp")
	self.m_name = self:getChild("name")
	self.m_fightValue = self:getChild("fightValue")
end

var_0_0.Is_leaderCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Show_battleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
