local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mgzbqm74"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
