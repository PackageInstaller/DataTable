local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepqdr0kk2vp"

function var_0_0:__ctor()
	self.m_isMaxVitController = self:getController("isMaxVit")
	self.m_nextCountText = self:getChild("nextCountText")
	self.m_allCountText = self:getChild("allCountText")
	self.m_outpostAttr = self:getChild("outpostAttr")
end

var_0_0.IsMaxVitCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
