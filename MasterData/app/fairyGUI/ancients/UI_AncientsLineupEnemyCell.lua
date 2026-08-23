local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2qsqqi"

function var_0_0:__ctor()
	self.m_is_leaderController = self:getController("is_leader")
	self.m_positionController = self:getController("position")
	self.m_has_userController = self:getController("has_user")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_server = self:getChild("Txt_server")
	self.m_Txt_fight_value = self:getChild("Txt_fight_value")
end

var_0_0.Is_leaderCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.PositionCtrl = {
	上 = 0,
	下 = 2,
	中 = 1
}
var_0_0.Has_userCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
