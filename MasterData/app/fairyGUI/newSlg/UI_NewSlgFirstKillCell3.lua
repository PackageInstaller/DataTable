local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9iebw68nn"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_isselfController = self:getController("isself")
	self.m_Txt_monsterName = self:getChild("Txt_monsterName")
	self.m_redGraph = self:getChild("redGraph")
	self.m_Txt_fist_reward = self:getChild("Txt_fist_reward")
	self.m_List_icons = self:getChild("List_icons")
	self.m_Txt_empty = self:getChild("Txt_empty")
	self.m_Comp_user = self:getChild("Comp_user")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_Txt_troops = self:getChild("Txt_troops")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsselfCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
