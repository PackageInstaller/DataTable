local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepke2z1b"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_loader = self:getChild("loader")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsLockCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
