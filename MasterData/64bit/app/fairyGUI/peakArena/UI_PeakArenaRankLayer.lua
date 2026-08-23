local var_0_0 = {}

var_0_0.URL = "ui://puryq37kr0fe23"

function var_0_0:__ctor()
	self.m_pageTypeController = self:getController("pageType")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_haveHonorTitleController = self:getController("haveHonorTitle")
	self.m_haveRankingController = self:getController("haveRanking")
	self.m_belong = self:getChild("belong")
	self.m_rankingTitleGroup = self:getChild("rankingTitleGroup")
	self.m_danGradingAwardTitleGroup = self:getChild("danGradingAwardTitleGroup")
	self.m_rankingAwardTitleGroup = self:getChild("rankingAwardTitleGroup")
	self.m_rankingTab = self:getChild("rankingTab")
	self.m_danGradingAwardTab = self:getChild("danGradingAwardTab")
	self.m_rankingAwardTab = self:getChild("rankingAwardTab")
	self.m_rankingList = self:getChild("rankingList")
	self.m_danGradingAwardList = self:getChild("danGradingAwardList")
	self.m_rankingAwardList = self:getChild("rankingAwardList")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_21 = self:getChild("21")
	self.m_rankIcon = self:getChild("rankIcon")
	self.m_myDanGradingTxt = self:getChild("myDanGradingTxt")
	self.m_IconComp = self:getChild("IconComp")
	self.m_userName = self:getChild("userName")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_userInfoGroup = self:getChild("userInfoGroup")
	self.m_guildName = self:getChild("guildName")
	self.m_serverName = self:getChild("serverName")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_rankingAliasComp = self:getChild("rankingAliasComp")
	self.m_myAwardList = self:getChild("myAwardList")
	self.m_emptyGroup = self:getChild("emptyGroup")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
