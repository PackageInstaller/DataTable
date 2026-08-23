local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lpwm79k"

function var_0_0:__ctor()
	self.m_rightComp = self:getChild("rightComp")
	self.m_leftCell1 = self:getChild("leftCell1")
	self.m_leftCell2 = self:getChild("leftCell2")
	self.m_leftCell3 = self:getChild("leftCell3")
	self.m_handHolder = self:getChild("handHolder")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
