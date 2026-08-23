local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99o3ikkk2pa"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TabCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 4
}

return var_0_0
