local var_0_0 = {}

var_0_0.URL = "ui://foyq921sz0z91"

function var_0_0:__ctor()
	self.m_showListController = self:getController("showList")
	self.m_isNullListController = self:getController("isNullList")
	self.m_isShowOneKeyBtnController = self:getController("isShowOneKeyBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_rankAwardBtn = self:getChild("rankAwardBtn")
	self.m_firstAwardBtn = self:getChild("firstAwardBtn")
	self.m_rankList = self:getChild("rankList")
	self.m_rewardList = self:getChild("rewardList")
	self.m_firstPassList = self:getChild("firstPassList")
	self.m_tabList = self:getChild("tabList")
	self.m_topBar = self:getChild("topBar")
	self.m_downBg = self:getChild("downBg")
	self.m_rewardTip = self:getChild("rewardTip")
	self.m_rankTitle = self:getChild("rankTitle")
	self.m_rankValue = self:getChild("rankValue")
	self.m_passTitle = self:getChild("passTitle")
	self.m_passValue = self:getChild("passValue")
	self.m_topBg = self:getChild("topBg")
	self.m_oneKeyGetFirstRewardBtn = self:getChild("oneKeyGetFirstRewardBtn")
end

var_0_0.ShowListCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsNullListCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowOneKeyBtnCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
