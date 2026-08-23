local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9now7f"

function var_0_0:__ctor()
	self.m_challengeList = self:getChild("challengeList")
	self.m_effRoll = self:getChild("effRoll")
	self.m_effArrowLeft = self:getChild("effArrowLeft")
	self.m_effArrowright = self:getChild("effArrowright")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
