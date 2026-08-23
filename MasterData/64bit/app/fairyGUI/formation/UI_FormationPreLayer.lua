local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99o3ikkk2ox"

function var_0_0:__ctor()
	self.m_mainStateController = self:getController("mainState")
	self.m_showPreStateController = self:getController("showPreState")
	self.m_mainComp = self:getChild("mainComp")
	self.m_preComp = self:getChild("preComp")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_shareComp = self:getChild("shareComp")
	self.m_recommendBtn = self:getChild("recommendBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.MainStateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowPreStateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
