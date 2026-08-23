local var_0_0 = {}

var_0_0.URL = "ui://ko1uzjo7if4x19"

function var_0_0:__ctor()
	self.m_fullStageController = self:getController("fullStage")
	self.m_passiveChangeController = self:getController("passiveChange")
	self.m_progComp = self:getChild("progComp")
	self.m_skillIcon_1 = self:getChild("skillIcon_1")
	self.m_skillIcon_2 = self:getChild("skillIcon_2")
	self.m_talentTitleLbl = self:getChild("talentTitleLbl")
	self.m_talentTitleLbl2 = self:getChild("talentTitleLbl2")
	self.m_matList = self:getChild("matList")
	self.m_advBtn = self:getChild("advBtn")
	self.m_fullSkillIcon = self:getChild("fullSkillIcon")
	self.m_fullSkillDescLbl = self:getChild("fullSkillDescLbl")
	self.m_talentTitleLbl3 = self:getChild("talentTitleLbl3")
	self.m_viewTalentTitleLbl = self:getChild("viewTalentTitleLbl")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
