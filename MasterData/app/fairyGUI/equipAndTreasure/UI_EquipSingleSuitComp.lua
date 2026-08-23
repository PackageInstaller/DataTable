local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7dsi27k"

function var_0_0:__ctor()
	self.m_hasPassiveSkillController = self:getController("hasPassiveSkill")
	self.m_suitTitleComp = self:getChild("suitTitleComp")
	self.m_suit1 = self:getChild("suit1")
	self.m_suit2 = self:getChild("suit2")
	self.m_suit3 = self:getChild("suit3")
	self.m_suit4 = self:getChild("suit4")
	self.m_suitGroup = self:getChild("suitGroup")
	self.m_skillList = self:getChild("skillList")
	self.m_suitAttrList = self:getChild("suitAttrList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasPassiveSkillCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
