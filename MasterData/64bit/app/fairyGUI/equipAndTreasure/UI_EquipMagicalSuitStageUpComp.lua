local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7nyyldh"

function var_0_0:__ctor()
	self.m_hasSkillController = self:getController("hasSkill")
	self.m_activeStage = self:getChild("activeStage")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_skillTitle = self:getChild("skillTitle")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillDesc = self:getChild("skillDesc")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasSkillCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
