local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074z7w4n"

function var_0_0:__ctor()
	self.m_touchArea = self:getChild("touchArea")
	self.m_boss1 = self:getChild("boss1")
	self.m_boss2 = self:getChild("boss2")
	self.m_boss3 = self:getChild("boss3")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
