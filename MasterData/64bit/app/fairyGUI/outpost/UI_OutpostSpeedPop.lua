local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5ssf3x7ic"

function var_0_0:__ctor()
	self.m_touchComp = self:getChild("touchComp")
	self.m_speedBtn = self:getChild("speedBtn")
	self.m_battleSpeed = self:getChild("battleSpeed")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
