local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7wnqfbf"

function var_0_0:__ctor()
	self.m_hasPassiveSkillController = self:getController("hasPassiveSkill")
	self.m_skillList = self:getChild("skillList")
	self.m_activeComp1 = self:getChild("activeComp1")
	self.m_activeComp2 = self:getChild("activeComp2")
	self.m_activeComp3 = self:getChild("activeComp3")
end

var_0_0.HasPassiveSkillCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
