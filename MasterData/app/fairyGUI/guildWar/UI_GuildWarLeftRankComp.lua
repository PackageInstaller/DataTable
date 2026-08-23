local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mp2ymm5j"

function var_0_0:__ctor()
	self.m_groupStateController = self:getController("groupState")
	self.m_showGroupController = self:getController("showGroup")
	self.m_isShareController = self:getController("isShare")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isShowDrillResultController = self:getController("isShowDrillResult")
	self.m_shareShowComp = self:getChild("shareShowComp")
	self.m_guildRankList = self:getChild("guildRankList")
	self.m_matchResultBtn = self:getChild("matchResultBtn")
	self.m_guildIcon = self:getChild("guildIcon")
	self.m_guildNameText = self:getChild("guildNameText")
	self.m_guildScoreText = self:getChild("guildScoreText")
	self.m_guildRankText = self:getChild("guildRankText")
	self.m_drillResultBtn = self:getChild("drillResultBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.GroupStateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.ShowGroupCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsShareCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowDrillResultCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
