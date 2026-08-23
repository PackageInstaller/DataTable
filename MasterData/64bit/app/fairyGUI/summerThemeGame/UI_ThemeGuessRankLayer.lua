local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6xll81kk40t"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_phaseTab1 = self:getChild("phaseTab1")
	self.m_phaseTab2 = self:getChild("phaseTab2")
	self.m_phaseTab3 = self:getChild("phaseTab3")
	self.m_rankList = self:getChild("rankList")
	self.m_myRankTxt = self:getChild("myRankTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.TabCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
