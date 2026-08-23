local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2pmty1e"

function var_0_0:__ctor()
	self.m_invate_stateController = self:getController("invate_state")
	self.m_has_rankController = self:getController("has_rank")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Btn_invite = self:getChild("Btn_invite")
	self.m_Txt_rank = self:getChild("Txt_rank")
	self.m_Txt_fight_value = self:getChild("Txt_fight_value")
	self.m_Txt_score = self:getChild("Txt_score")
end

var_0_0.Invate_stateCtrl = {
	队伍中 = 2,
	已邀请 = 1,
	未邀请 = 0
}
var_0_0.Has_rankCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
