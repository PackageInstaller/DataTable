local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83e4001x"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_activeLoader = self:getChild("activeLoader")
	self.m_unactiveLoader = self:getChild("unactiveLoader")
	self.m_lockLoader = self:getChild("lockLoader")
end

return var_0_0
