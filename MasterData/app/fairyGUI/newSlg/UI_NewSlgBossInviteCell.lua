local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ouc78e"

function var_0_0:__ctor()
	self.m_isInvitedController = self:getController("isInvited")
	self.m_Comp_userIcon = self:getChild("Comp_userIcon")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_legionDesc = self:getChild("Txt_legionDesc")
	self.m_fight_value = self:getChild("fight_value")
	self.m_legion_name = self:getChild("legion_name")
	self.m_Btn_invite = self:getChild("Btn_invite")
end

var_0_0.IsInvitedCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
