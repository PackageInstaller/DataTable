local var_0_0 = {}

var_0_0.URL = "ui://44qiyyomft7s9bnoiz"

function var_0_0:__ctor()
	self.m_mainTabController = self:getController("mainTab")
	self.m_subTabController = self:getController("subTab")
	self.m_emptyController = self:getController("empty")
	self.m_totalTab = self:getChild("totalTab")
	self.m_oneTab = self:getChild("oneTab")
	self.m_rankList = self:getChild("rankList")
	self.m_numTxt = self:getChild("numTxt")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.MainTabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SubTabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
