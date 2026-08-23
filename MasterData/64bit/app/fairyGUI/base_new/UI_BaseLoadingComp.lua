local var_0_0 = {}

var_0_0.URL = "ui://kvb3znephiackk2pa"

function var_0_0:__ctor()
	self.m_loadingController = self:getController("loading")
	self.m_appTypeController = self:getController("appType")
	self.m_loadingGroup = self:getChild("loadingGroup")
	self.m_loadTransition = self:getTransition("load")
end

var_0_0.LoadingCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.AppTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
