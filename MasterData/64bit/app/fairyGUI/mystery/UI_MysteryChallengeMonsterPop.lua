local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8efhgqi"

function var_0_0:__ctor()
	self.m_enterEff1 = self:getChild("enterEff1")
	self.m_enterEff2 = self:getChild("enterEff2")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_challengeComp = self:getChild("challengeComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
