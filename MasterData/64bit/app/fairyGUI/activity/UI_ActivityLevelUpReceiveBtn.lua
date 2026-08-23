local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wk9cin"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_getTransition = self:getTransition("get")
	self.m_goTransition = self:getTransition("go")
end

var_0_0.StateCtrl = {
	前往 = 0,
	已领取 = 2,
	可领取 = 1
}

return var_0_0
