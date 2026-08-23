local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wdb4rn6"

function var_0_0:__ctor()
	self.m_roleBgLoader = self:getChild("roleBgLoader")
	self.m_award1 = self:getChild("award1")
	self.m_award2 = self:getChild("award2")
	self.m_award3 = self:getChild("award3")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_openTransition = self:getTransition("open")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
