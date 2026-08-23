local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivo0vsbpv"

function var_0_0:__ctor()
	self.m_skillNumController = self:getController("skillNum")
	self.m_skillTypesController = self:getController("skillTypes")
	self.m_isMaxController = self:getController("isMax")
	self.m_talentSkillIcon = self:getChild("talentSkillIcon")
	self.m_talentSkillName = self:getChild("talentSkillName")
	self.m_talentSkillDesc = self:getChild("talentSkillDesc")
	self.m_talentSkillSkill = self:getChild("talentSkillSkill")
	self.m_skillComp1 = self:getChild("skillComp1")
	self.m_skillComp2 = self:getChild("skillComp2")
	self.m_skillGroup = self:getChild("skillGroup")
	self.m_skillIcon1 = self:getChild("skillIcon1")
	self.m_skillIcon2 = self:getChild("skillIcon2")
	self.m_skillIcon3 = self:getChild("skillIcon3")
	self.m_skillIcon4 = self:getChild("skillIcon4")
	self.m_maxTalentSkillIcon = self:getChild("maxTalentSkillIcon")
	self.m_valueDescText = self:getChild("valueDescText")
	self.m_skillDescText = self:getChild("skillDescText")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.SkillNumCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.SkillTypesCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsMaxCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
