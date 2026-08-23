local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7frwp37"

function var_0_0:__ctor()
	self.m_hasPassiveSkillController = self:getController("hasPassiveSkill")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_equipIcon1 = self:getChild("equipIcon1")
	self.m_equipIcon2 = self:getChild("equipIcon2")
	self.m_equipIcon3 = self:getChild("equipIcon3")
	self.m_equipIcon4 = self:getChild("equipIcon4")
	self.m_suitDetailPanel = self:getChild("suitDetailPanel")
	self.m_content = self:getChild("content")
end

var_0_0.HasPassiveSkillCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
