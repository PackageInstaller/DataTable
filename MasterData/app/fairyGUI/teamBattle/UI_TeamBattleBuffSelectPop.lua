local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lulde45"

function var_0_0:__ctor()
	self.m_cardComp1 = self:getChild("cardComp1")
	self.m_cardComp2 = self:getChild("cardComp2")
	self.m_cardComp3 = self:getChild("cardComp3")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
