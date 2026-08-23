local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yiva4d3g8"

function var_0_0:__ctor()
	self.m_skillPosController = self:getController("skillPos")
	self.m_stateController = self:getController("state")
	self.m_bgComp = self:getChild("bgComp")
	self.m_starComp = self:getChild("starComp")
	self.m_effStarLine = self:getChild("effStarLine")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_skill1 = self:getChild("skill1")
	self.m_skill1Level = self:getChild("skill1Level")
	self.m_skillGroup1 = self:getChild("skillGroup1")
	self.m_skill2 = self:getChild("skill2")
	self.m_skill2Level = self:getChild("skill2Level")
	self.m_skillGroup2 = self:getChild("skillGroup2")
	self.m_talentTitle = self:getChild("talentTitle")
	self.m_talentDesc = self:getChild("talentDesc")
	self.m_talentGroup = self:getChild("talentGroup")
	self.m_bloodTitle = self:getChild("bloodTitle")
	self.m_bloodDesc = self:getChild("bloodDesc")
	self.m_bloodGroup = self:getChild("bloodGroup")
	self.m_skill3 = self:getChild("skill3")
	self.m_skill3Level = self:getChild("skill3Level")
	self.m_skillGroup3 = self:getChild("skillGroup3")
	self.m_skillExIcon = self:getChild("skillExIcon")
	self.m_talentSkillName = self:getChild("talentSkillName")
	self.m_talentSkillDesc = self:getChild("talentSkillDesc")
	self.m_effPlaceHolder = self:getChild("effPlaceHolder")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enter_state1Transition = self:getTransition("enter_state1")
end

var_0_0.SkillPosCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}
var_0_0.StateCtrl = {
	额外 = 1,
	正常 = 0
}

return var_0_0
