local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lzqgm2i"

function var_0_0:__ctor()
	self.m_eff = self:getChild("eff")
	self.m_enterEff1 = self:getChild("enterEff1")
	self.m_enterEff2 = self:getChild("enterEff2")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_challengeComp = self:getChild("challengeComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_resetTransition = self:getTransition("reset")
end

return var_0_0
