local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2o7548"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_getTransition = self:getTransition("get")
	self.m_goTransition = self:getTransition("go")
end

return var_0_0
