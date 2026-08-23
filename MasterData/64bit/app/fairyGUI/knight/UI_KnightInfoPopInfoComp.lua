local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivdef9cr"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_skillNumController = self:getController("skillNum")
	self.m_showETController = self:getController("showET")
	self.m_featureText = self:getChild("featureText")
	self.m_professionIcon = self:getChild("professionIcon")
	self.m_professionTxt = self:getChild("professionTxt")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_skill1 = self:getChild("skill1")
	self.m_skill2 = self:getChild("skill2")
	self.m_skill3 = self:getChild("skill3")
	self.m_skill4 = self:getChild("skill4")
	self.m_descText = self:getChild("descText")
	self.m_groupLoader = self:getChild("groupLoader")
	self.m_talentSkill1 = self:getChild("talentSkill1")
	self.m_talentSkill2 = self:getChild("talentSkill2")
	self.m_talentSkill3 = self:getChild("talentSkill3")
	self.m_leaderSkillIcon = self:getChild("leaderSkillIcon")
	self.m_equipTreasureComp = self:getChild("equipTreasureComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SkillNumCtrl = {
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.ShowETCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
