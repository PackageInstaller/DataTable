local var_0_0 = {}

var_0_0.URL = "ui://671qywx2piih24"

function var_0_0:__ctor()
	self.m_showSkillController = self:getController("showSkill")
	self.m_attrTitleComp = self:getChild("attrTitleComp")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_attrComp3 = self:getChild("attrComp3")
	self.m_attrComp4 = self:getChild("attrComp4")
	self.m_skillTitleComp = self:getChild("skillTitleComp")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillNameText = self:getChild("skillNameText")
	self.m_skillDescText = self:getChild("skillDescText")
	self.m_skillClickLoader = self:getChild("skillClickLoader")
	self.m_skillGroup = self:getChild("skillGroup")
	self.m_talentTitleComp = self:getChild("talentTitleComp")
	self.m_talentDescList = self:getChild("talentDescList")
	self.m_talentGroup = self:getChild("talentGroup")
end

return var_0_0
