local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9ma4qx17"

function var_0_0:__ctor()
	self.m_groupStateController = self:getController("groupState")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_hasRankController = self:getController("hasRank")
	self.m_guildRankList = self:getChild("guildRankList")
	self.m_guildIcon = self:getChild("guildIcon")
	self.m_guildNameText = self:getChild("guildNameText")
	self.m_guildScoreText = self:getChild("guildScoreText")
	self.m_guildRankText = self:getChild("guildRankText")
	self.m_matchingPopBtn = self:getChild("matchingPopBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.GroupStateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HasRankCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
