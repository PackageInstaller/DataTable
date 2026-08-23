local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepsm78ibph"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_iconScaleController = self:getController("iconScale")
	self.m_loader = self:getChild("loader")
	self.m_icon1 = self:getChild("icon1")
end

var_0_0.IsLockCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IconScaleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
