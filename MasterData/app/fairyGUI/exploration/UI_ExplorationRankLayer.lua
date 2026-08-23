local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25btydi"

function var_0_0:__ctor()
	self.m_rankTypeController = self:getController("rankType")
	self.m_showTypeController = self:getController("showType")
	self.m_stageController = self:getController("stage")
	self.m_clearRankList = self:getChild("clearRankList")
	self.m_damageRankList = self:getChild("damageRankList")
	self.m_guildRankList = self:getChild("guildRankList")
	self.m_rewardList = self:getChild("rewardList")
	self.m_passGroup = self:getChild("passGroup")
	self.m_damageGroup = self:getChild("damageGroup")
	self.m_guildGroup = self:getChild("guildGroup")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.RankTypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.ShowTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StageCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
