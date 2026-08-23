local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99a1hm0"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isExploreController = self:getController("isExplore")
	self.m_bottomImageStateController = self:getController("bottomImageState")
	self.m_isAddController = self:getController("isAdd")
	self.m_isShowLevelAndRankController = self:getController("isShowLevelAndRank")
	self.m_isWeddingController = self:getController("isWedding")
	self.m_imgPosTouch = self:getChild("imgPosTouch")
	self.m_knightPic = self:getChild("knightPic")
	self.m_groupLoader = self:getChild("groupLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_weddingLoader = self:getChild("weddingLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_levelComp1 = self:getChild("levelComp1")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_leaderLoader = self:getChild("leaderLoader")
	self.m_hpBarComp = self:getChild("hpBarComp")
	self.m_levelComp = self:getChild("levelComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsExploreCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.BottomImageStateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsAddCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowLevelAndRankCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsWeddingCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
