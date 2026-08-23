local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7nyyld5"

function var_0_0:__ctor()
	self.m_suitStage1 = self:getChild("suitStage1")
	self.m_suitStage2 = self:getChild("suitStage2")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillDesc = self:getChild("skillDesc")
	self.m_skillGroup = self:getChild("skillGroup")
	self.m_showTransition = self:getTransition("show")
	self.m_hideTransition = self:getTransition("hide")
end

return var_0_0
