local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2pmty15"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_ban_fightController = self:getController("ban_fight")
	self.m_Btn_view_info = self:getChild("Btn_view_info")
	self.m_Btn_kick_out = self:getChild("Btn_kick_out")
	self.m_Btn_quit = self:getChild("Btn_quit")
	self.m_Btn_ban_fight = self:getChild("Btn_ban_fight")
end

var_0_0.TypeCtrl = {
	淘汰赛组队期队长点别人 = 3,
	非队长点别人 = 1,
	淘汰赛队长点别人 = 4,
	点自己 = 0,
	积分赛队长点别人 = 2
}
var_0_0.Ban_fightCtrl = {
	允许开战 = 0,
	禁止开战 = 1
}

return var_0_0
