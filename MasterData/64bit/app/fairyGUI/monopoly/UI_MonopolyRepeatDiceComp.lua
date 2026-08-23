local var_0_0 = {}

var_0_0.URL = "ui://6b52cxc1e0hfa8"

function var_0_0:__ctor()
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
