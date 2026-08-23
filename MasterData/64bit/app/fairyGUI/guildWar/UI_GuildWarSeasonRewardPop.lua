local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9myiivm9y"

function var_0_0:__ctor()
	self.m_showGroupTabController = self:getController("showGroupTab")
	self.m_hasRankController = self:getController("hasRank")
	self.m_rankAwardBtn = self:getChild("rankAwardBtn")
	self.m_rewardList = self:getChild("rewardList")
	self.m_downBg = self:getChild("downBg")
	self.m_rewardTip = self:getChild("rewardTip")
	self.m_noneText = self:getChild("noneText")
	self.m_rankTitle = self:getChild("rankTitle")
	self.m_rankValue = self:getChild("rankValue")
	self.m_topBg1 = self:getChild("topBg1")
	self.m_topBar = self:getChild("topBar")
end

var_0_0.ShowGroupTabCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.HasRankCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
