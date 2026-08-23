local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jt0v6b"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_leftTabController = self:getController("leftTab")
	self.m_rightTabController = self:getController("rightTab")
	self.m_seasonController = self:getController("season")
	self.m_userRank = self:getChild("userRank")
	self.m_unionRank = self:getChild("unionRank")
	self.m_finalRank = self:getChild("finalRank")
	self.m_topBar = self:getChild("topBar")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_scoreNumTxt = self:getChild("scoreNumTxt")
	self.m_timeTipTxt = self:getChild("timeTipTxt")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1
}
var_0_0.LeftTabCtrl = {
	page2 = 3,
	page1 = 2,
	page4 = 5,
	page0 = 1,
	page3 = 4
}
var_0_0.RightTabCtrl = {
	page0 = 0,
	page2 = 6,
	page1 = 1
}
var_0_0.SeasonCtrl = {
	S2 = 1,
	S1 = 0,
	["S2-个人榜隐藏"] = 2
}

return var_0_0
