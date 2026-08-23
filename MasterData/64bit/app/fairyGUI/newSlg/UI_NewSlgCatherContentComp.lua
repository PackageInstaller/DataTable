local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jtc0968wi"

function var_0_0:__ctor()
	self.m_boss_team_emptyController = self:getController("boss_team_empty")
	self.m_Comp_cityAttack = self:getChild("Comp_cityAttack")
	self.m_List_team = self:getChild("List_team")
end

var_0_0.Boss_team_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
