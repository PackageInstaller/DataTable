local var_0_0 = {}

var_0_0.URL = "ui://05rqz4hsk27h4d"

function var_0_0:__ctor()
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_petIcon = self:getChild("petIcon")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enter2Transition = self:getTransition("enter2")
end

return var_0_0
