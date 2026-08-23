local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2uvdva"

function var_0_0:__ctor()
	self.m_has_userController = self:getController("has_user")
	self.m_is_leaderController = self:getController("is_leader")
	self.m_ban_fightController = self:getController("ban_fight")
	self.m_stateController = self:getController("state")
	self.m_Comp_click = self:getChild("Comp_click")
	self.m_Btn_invite = self:getChild("Btn_invite")
	self.m_Comp_spine = self:getChild("Comp_spine")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Txt_contribute = self:getChild("Txt_contribute")
	self.m_Txt_fightValue = self:getChild("Txt_fightValue")
end

var_0_0.Has_userCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_leaderCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Ban_fightCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
