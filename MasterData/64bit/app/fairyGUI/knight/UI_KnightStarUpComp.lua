local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivf4oz1"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_qualityRangeController = self:getController("qualityRange")
	self.m_levelText = self:getChild("levelText")
	self.m_urSkillComp = self:getChild("urSkillComp")
	self.m_talentSkillIcon = self:getChild("talentSkillIcon")
	self.m_talentSkillName = self:getChild("talentSkillName")
	self.m_talentSkillDesc = self:getChild("talentSkillDesc")
	self.m_talentSkillSkill = self:getChild("talentSkillSkill")
	self.m_skill1 = self:getChild("skill1")
	self.m_skill2 = self:getChild("skill2")
	self.m_baseSkillName = self:getChild("baseSkillName")
	self.m_baseSkillDesc = self:getChild("baseSkillDesc")
	self.m_baseSkill = self:getChild("baseSkill")
	self.m_valueDescText = self:getChild("valueDescText")
	self.m_skillDescText = self:getChild("skillDescText")
	self.m_knightFragComp = self:getChild("knightFragComp")
	self.m_mrTips = self:getChild("mrTips")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsMaxCtrl = {
	未满级没有talentSkill = 2,
	满级 = 1,
	未满级 = 0
}
var_0_0.QualityRangeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
