local var_0_0 = {}

var_0_0.URL = "ui://671qywx2oefv1q"

function var_0_0:__ctor()
	self.m_fullStarController = self:getController("fullStar")
	self.m_showSkillController = self:getController("showSkill")
	self.m_curStarTxt = self:getChild("curStarTxt")
	self.m_nextStarTxt = self:getChild("nextStarTxt")
	self.m_starUpGroup = self:getChild("starUpGroup")
	self.m_fullStarTxt = self:getChild("fullStarTxt")
	self.m_starMaxGroup = self:getChild("starMaxGroup")
	self.m_attrTitleComp = self:getChild("attrTitleComp")
	self.m_bg1 = self:getChild("bg1")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_bg2 = self:getChild("bg2")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_bg3 = self:getChild("bg3")
	self.m_attrComp3 = self:getChild("attrComp3")
	self.m_bg4 = self:getChild("bg4")
	self.m_attrComp4 = self:getChild("attrComp4")
	self.m_skillTitleComp = self:getChild("skillTitleComp")
	self.m_skillTipsText = self:getChild("skillTipsText")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillNameText = self:getChild("skillNameText")
	self.m_skillDescText = self:getChild("skillDescText")
	self.m_skillClickLoader = self:getChild("skillClickLoader")
	self.m_skillGroup = self:getChild("skillGroup")
	self.m_talentTitleComp = self:getChild("talentTitleComp")
	self.m_talentDescList = self:getChild("talentDescList")
	self.m_talentGroup = self:getChild("talentGroup")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
