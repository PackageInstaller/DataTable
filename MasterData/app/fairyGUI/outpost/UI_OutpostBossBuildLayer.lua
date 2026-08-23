local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5sp297d3"

function var_0_0:__ctor()
	self.m_buiodComp = self:getChild("buiodComp")
	self.m_bossInfoComp = self:getChild("bossInfoComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
