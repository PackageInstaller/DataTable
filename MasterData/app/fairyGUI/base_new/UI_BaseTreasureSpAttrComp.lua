local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepqwj3wkk33k"

function var_0_0:__ctor()
	self.m_eff = self:getChild("eff")
	self.m_iconComp = self:getChild("iconComp")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_scoreText = self:getChild("scoreText")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
