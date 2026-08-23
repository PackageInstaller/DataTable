local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2w3g31x"

function var_0_0:__ctor()
	self.m_is_winController = self:getController("is_win")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_kill = self:getChild("Txt_kill")
	self.m_Txt_damage = self:getChild("Txt_damage")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Txt_score_win = self:getChild("Txt_score_win")
	self.m_Txt_level = self:getChild("Txt_level")
end

var_0_0.Is_winCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
