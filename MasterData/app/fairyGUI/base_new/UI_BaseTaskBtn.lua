local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepqtv41w"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_getTransition = self:getTransition("get")
	self.m_goTransition = self:getTransition("go")
end

var_0_0.StateCtrl = {
	前往 = 1,
	已领取 = 3,
	未开启 = 2,
	可领取 = 0
}

return var_0_0
