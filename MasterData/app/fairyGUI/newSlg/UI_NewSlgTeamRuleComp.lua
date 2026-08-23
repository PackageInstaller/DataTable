local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jt0v67"

function var_0_0:__ctor()
	self.m_hasExtTeamController = self:getController("hasExtTeam")
	self.m_redLine1 = self:getChild("redLine1")
	self.m_title1 = self:getChild("title1")
	self.m_Txt_rule = self:getChild("Txt_rule")
	self.m_Comp_1 = self:getChild("Comp_1")
	self.m_Comp_2 = self:getChild("Comp_2")
	self.m_Comp_3 = self:getChild("Comp_3")
	self.m_Comp_4 = self:getChild("Comp_4")
	self.m_Comp_5 = self:getChild("Comp_5")
end

var_0_0.HasExtTeamCtrl = {
	has = 1,
	normal = 0
}

return var_0_0
