local var_0_0 = {}

var_0_0.URL = "ui://p5a8ifc3aop2as"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_getTransition = self:getTransition("get")
	self.m_goTransition = self:getTransition("go")
end

var_0_0.StateCtrl = {
	前往 = 2,
	可领取 = 1,
	已领取 = 5
}

return var_0_0
