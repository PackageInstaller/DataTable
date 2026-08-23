local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepq7aaibnb"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_bg = self:getChild("bg")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_enter_2Transition = self:getTransition("enter_2")
end

var_0_0.IsLockCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
