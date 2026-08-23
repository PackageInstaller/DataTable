local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvgmffgic3x"

function var_0_0:__ctor()
	self.m_isStageMaxController = self:getController("isStageMax")
	self.m_isMaxLevelController = self:getController("isMaxLevel")
	self.m_allFullController = self:getController("allFull")
	self.m_hasSkillChangeController = self:getController("hasSkillChange")
	self.m_title1 = self:getChild("title1")
	self.m_curSkillComp = self:getChild("curSkillComp")
	self.m_nextSkillComp = self:getChild("nextSkillComp")
	self.m_activeSkillComp = self:getChild("activeSkillComp")
	self.m_attrBg = self:getChild("attrBg")
	self.m_lvMaxDesc = self:getChild("lvMaxDesc")
	self.m_tipsAttrBtn = self:getChild("tipsAttrBtn")
	self.m_attrBg1 = self:getChild("attrBg1")
	self.m_tipsTalentBtn = self:getChild("tipsTalentBtn")
	self.m_talentDescTxt = self:getChild("talentDescTxt")
	self.m_attrBg2 = self:getChild("attrBg2")
	self.m_tipsBaseAttrBtn = self:getChild("tipsBaseAttrBtn")
	self.m_title2 = self:getChild("title2")
	self.m_lvUpBtn = self:getChild("lvUpBtn")
	self.m_stageUpgradeBtn = self:getChild("stageUpgradeBtn")
	self.m_costStageUpComp = self:getChild("costStageUpComp")
	self.m_stageUpCost = self:getChild("stageUpCost")
	self.m_maxTxt = self:getChild("maxTxt")
	self.m_costLevelUpComp = self:getChild("costLevelUpComp")
	self.m_levelUpCost = self:getChild("levelUpCost")
	self.m_progComp = self:getChild("progComp")
	self.m_fastBtn = self:getChild("fastBtn")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
