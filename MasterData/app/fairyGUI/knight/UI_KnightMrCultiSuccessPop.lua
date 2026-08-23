local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivh27bfrg4"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bgComp = self:getChild("bgComp")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_talentSkillName = self:getChild("talentSkillName")
	self.m_talentSkillDesc = self:getChild("talentSkillDesc")
	self.m_skillComp = self:getChild("skillComp")
	self.m_effPlaceHolder = self:getChild("effPlaceHolder")
	self.m_level = self:getChild("level")
	self.m_levelAfter = self:getChild("levelAfter")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enter_state1Transition = self:getTransition("enter_state1")
end

var_0_0.StateCtrl = {
	额外 = 1,
	正常 = 0
}

return var_0_0
