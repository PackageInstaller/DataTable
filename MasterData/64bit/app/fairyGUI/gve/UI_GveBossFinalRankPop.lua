local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbh4hzmicac"

function var_0_0:__ctor()
	self.m_mainTabController = self:getController("mainTab")
	self.m_subTabController = self:getController("subTab")
	self.m_emptyController = self:getController("empty")
	self.m_hasRankController = self:getController("hasRank")
	self.m_guildTab = self:getChild("guildTab")
	self.m_personTab = self:getChild("personTab")
	self.m_rankList = self:getChild("rankList")
	self.m_guildRankList = self:getChild("guildRankList")
	self.m_awardList = self:getChild("awardList")
	self.m_numTxt = self:getChild("numTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
