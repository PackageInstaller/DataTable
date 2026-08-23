local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivt77hf1"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_lastLevelText = self:getChild("lastLevelText")
	self.m_levelText = self:getChild("levelText")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_talentComp = self:getChild("talentComp")
	self.m_skillType = self:getChild("skillType")
	self.m_skillComp = self:getChild("skillComp")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_enter_2Transition = self:getTransition("enter_2")
end

var_0_0.StyleCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}

return var_0_0
