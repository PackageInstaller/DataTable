local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivpepup"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_stateController = self:getController("state")
	self.m_hasExSkillController = self:getController("hasExSkill")
	self.m_groupLoader = self:getChild("groupLoader")
	self.m_subLevel = self:getChild("subLevel")
	self.m_level = self:getChild("level")
	self.m_maxLevel = self:getChild("maxLevel")
	self.m_expProgBar = self:getChild("expProgBar")
	self.m_attrComp = self:getChild("attrComp")
	self.m_addBtn = self:getChild("addBtn")
	self.m_professionTxt = self:getChild("professionTxt")
	self.m_professionIcon = self:getChild("professionIcon")
	self.m_talentSkill1 = self:getChild("talentSkill1")
	self.m_talentSkill2 = self:getChild("talentSkill2")
	self.m_talentSkill3 = self:getChild("talentSkill3")
	self.m_skillsComp = self:getChild("skillsComp")
	self.m_assctTitle = self:getChild("assctTitle")
	self.m_assctComp = self:getChild("assctComp")
	self.m_levelUpComp = self:getChild("levelUpComp")
	self.m_leaderSkillIcon = self:getChild("leaderSkillIcon")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsMaxCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasExSkillCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
