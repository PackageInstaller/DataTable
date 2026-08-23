local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ohksqfm"

function var_0_0:__ctor()
	self.m_showListController = self:getController("showList")
	self.m_isMyRankController = self:getController("isMyRank")
	self.m_hasRankListController = self:getController("hasRankList")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_rankAwardBtn = self:getChild("rankAwardBtn")
	self.m_rankList = self:getChild("rankList")
	self.m_rewardList = self:getChild("rewardList")
	self.m_downBg = self:getChild("downBg")
	self.m_rankValueText = self:getChild("rankValueText")
	self.m_topBg1 = self:getChild("topBg1")
	self.m_topBg2 = self:getChild("topBg2")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.ShowListCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsMyRankCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasRankListCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
