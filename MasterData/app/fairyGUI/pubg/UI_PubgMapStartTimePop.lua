local var_0_0 = {}

var_0_0.URL = "ui://pbd24silr0zj65"

function var_0_0:__ctor()
	self.m_timeText = self:getChild("timeText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
