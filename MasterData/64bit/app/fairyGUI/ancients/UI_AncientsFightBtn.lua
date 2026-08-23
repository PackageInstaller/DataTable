local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2uvdvd"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_show_timeController = self:getController("show_time")
	self.m_ban_fightController = self:getController("ban_fight")
	self.m_show_resController = self:getController("show_res")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_Btn_icon = self:getChild("Btn_icon")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_battleBtnEffect = self:getChild("battleBtnEffect")
end

var_0_0.StateCtrl = {
	匹配 = 0,
	布阵 = 2,
	出战 = 1
}
var_0_0.Show_timeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Ban_fightCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Show_resCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
