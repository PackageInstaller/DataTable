local var_0_0 = {}

var_0_0.URL = "ui://ko1uzjo7if4x2f"

function var_0_0:__ctor()
	self.m_fullStarController = self:getController("fullStar")
	self.m_curStarTxt = self:getChild("curStarTxt")
	self.m_nextStarTxt = self:getChild("nextStarTxt")
	self.m_fullStarTxt = self:getChild("fullStarTxt")
	self.m_curSkillIcon = self:getChild("curSkillIcon")
	self.m_nextSkillIcon = self:getChild("nextSkillIcon")
	self.m_fullStarSkillIcon = self:getChild("fullStarSkillIcon")
	self.m_baseAttrUpLbl = self:getChild("baseAttrUpLbl")
	self.m_lvUpAttrGrowUpLbl = self:getChild("lvUpAttrGrowUpLbl")
	self.m_hpAttrGrowUpLbl = self:getChild("hpAttrGrowUpLbl")
	self.m_petStarUpFragComp = self:getChild("petStarUpFragComp")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
