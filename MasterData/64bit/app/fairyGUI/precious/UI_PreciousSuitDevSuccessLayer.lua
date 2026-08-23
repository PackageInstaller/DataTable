local var_0_0 = {}

var_0_0.URL = "ui://671qywx2sxre1u"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_showSkillController = self:getController("showSkill")
	self.m_qualityzsBg = self:getChild("qualityzsBg")
	self.m_suitComp = self:getChild("suitComp")
	self.m_qualityxxzsBg = self:getChild("qualityxxzsBg")
	self.m_successText = self:getChild("successText")
	self.m_effTitle = self:getChild("effTitle")
	self.m_talentNameText = self:getChild("talentNameText")
	self.m_talentDescText = self:getChild("talentDescText")
	self.m_talentGroup = self:getChild("talentGroup")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillGroup = self:getChild("skillGroup")
	self.m_starComp = self:getChild("starComp")
	self.m_suitNameText = self:getChild("suitNameText")
	self.m_continueComp = self:getChild("continueComp")
	self.m_nameGroup = self:getChild("nameGroup")
	self.m_suitInfoGroup = self:getChild("suitInfoGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
