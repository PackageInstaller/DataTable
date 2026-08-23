local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9lh7n8c5"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isWinController = self:getController("isWin")
	self.m_hasRewardController = self:getController("hasReward")
	self.m_detailComp = self:getChild("detailComp")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_rewardList = self:getChild("rewardList")
	self.m_newComp = self:getChild("newComp")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsWinCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasRewardCtrl = {
	page0 = 1,
	page1 = 0
}

return var_0_0
