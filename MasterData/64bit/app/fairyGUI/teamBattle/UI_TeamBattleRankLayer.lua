local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd0do"

function var_0_0:__ctor()
	self.m_rankTypeController = self:getController("rankType")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_scoreNumTxt = self:getChild("scoreNumTxt")
	self.m_rankList = self:getChild("rankList")
	self.m_rewardList = self:getChild("rewardList")
end

var_0_0.RankTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	empty = 1,
	normal = 0
}

return var_0_0
