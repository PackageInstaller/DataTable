local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2be3m12"

function var_0_0:__ctor()
	self.m_is_emptyController = self:getController("is_empty")
	self.m_is_leaderController = self:getController("is_leader")
	self.m_is_finalController = self:getController("is_final")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_point = self:getChild("Txt_point")
	self.m_Txt_teamPoint = self:getChild("Txt_teamPoint")
	self.m_Txt_fight = self:getChild("Txt_fight")
end

var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_leaderCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_finalCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
