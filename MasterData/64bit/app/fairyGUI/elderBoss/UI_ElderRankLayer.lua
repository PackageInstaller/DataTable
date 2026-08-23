local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074btdpe"

function var_0_0:__ctor()
	self.m_leftTabController = self:getController("leftTab")
	self.m_topTabController = self:getController("topTab")
	self.m_userRank = self:getChild("userRank")
	self.m_guildRank = self:getChild("guildRank")
	self.m_topBar = self:getChild("topBar")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_scoreNumTxt = self:getChild("scoreNumTxt")
	self.m_timeTipTxt = self:getChild("timeTipTxt")
	self.m_rewardShowBtn = self:getChild("rewardShowBtn")
end

var_0_0.LeftTabCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.TopTabCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page4 = 4,
	page3 = 3
}

return var_0_0
