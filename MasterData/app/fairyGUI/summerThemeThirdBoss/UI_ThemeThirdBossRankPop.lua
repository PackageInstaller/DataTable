local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obldv73"

function var_0_0:__ctor()
	self.m_mainTabController = self:getController("mainTab")
	self.m_emptyController = self:getController("empty")
	self.m_oneTab = self:getChild("oneTab")
	self.m_lineBg = self:getChild("lineBg")
	self.m_topBg = self:getChild("topBg")
	self.m_rankList = self:getChild("rankList")
	self.m_downBg = self:getChild("downBg")
	self.m_numTxt = self:getChild("numTxt")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.MainTabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
