local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvdq86h"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_activeController = self:getController("active")
	self.m_hasTalentController = self:getController("hasTalent")
	self.m_curStarTxt = self:getChild("curStarTxt")
	self.m_nextStarTxt = self:getChild("nextStarTxt")
	self.m_curMaxStarTxt = self:getChild("curMaxStarTxt")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_sellBtn = self:getChild("sellBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_jumpBtn = self:getChild("jumpBtn")
	self.m_attrBg = self:getChild("attrBg")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_attrBg2 = self:getChild("attrBg2")
	self.m_tipsBtn2 = self:getChild("tipsBtn2")
	self.m_talentDescTxt = self:getChild("talentDescTxt")
	self.m_breakTalent = self:getChild("breakTalent")
	self.m_title2 = self:getChild("title2")
	self.m_upgradeBtn = self:getChild("upgradeBtn")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_itemNameTxt = self:getChild("itemNameTxt")
	self.m_itemNumTxt = self:getChild("itemNumTxt")
	self.m_processBar = self:getChild("processBar")
	self.m_exRewardTxt = self:getChild("exRewardTxt")
	self.m_title1 = self:getChild("title1")
	self.m_curSkillComp = self:getChild("curSkillComp")
	self.m_nextSkillComp = self:getChild("nextSkillComp")
	self.m_maxSkillComp = self:getChild("maxSkillComp")
	self.m_universalBtn = self:getChild("universalBtn")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
