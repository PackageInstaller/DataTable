local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5sp297bx"

function var_0_0:__ctor()
	self.m_cityInfoComp = self:getChild("cityInfoComp")
	self.m_infoComp = self:getChild("infoComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
