local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepqa8zkk2xo"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_nextTimeTxt = self:getChild("nextTimeTxt")
	self.m_allTimeTxt = self:getChild("allTimeTxt")
	self.m_canRecover = self:getChild("canRecover")
	self.m_nextRefreshTimeTxt = self:getChild("nextRefreshTimeTxt")
	self.m_toTimeRefresh = self:getChild("toTimeRefresh")
end

var_0_0.StateCtrl = {
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
