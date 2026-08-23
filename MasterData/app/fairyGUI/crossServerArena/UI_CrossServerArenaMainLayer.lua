local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuisk"

function var_0_0:__ctor()
	self.m_tabSelController = self:getController("tabSel")
	self.m_guildRankStatusController = self:getController("guildRankStatus")
	self.m_buffGroupController = self:getController("buffGroup")
	self.m_isTop3Controller = self:getController("isTop3")
	self.m_skipFormationController = self:getController("skipFormation")
	self.m_buffGroupIcon = self:getChild("buffGroupIcon")
	self.m_buffLineLoader = self:getChild("buffLineLoader")
	self.m_challengeListComp = self:getChild("challengeListComp")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_groupIcon = self:getChild("groupIcon")
	self.m_buffTxt = self:getChild("buffTxt")
	self.m_additionComp = self:getChild("additionComp")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_guildRankBtn = self:getChild("guildRankBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_aidBtn = self:getChild("aidBtn")
	self.m_recordBtn = self:getChild("recordBtn")
	self.m_lineupList = self:getChild("lineupList")
	self.m_lineUpBgLoader = self:getChild("lineUpBgLoader")
	self.m_arenaWordImg = self:getChild("arenaWordImg")
	self.m_deployWordLoader = self:getChild("deployWordLoader")
	self.m_lineupBtn = self:getChild("lineupBtn")
	self.m_selectBtn1 = self:getChild("selectBtn1")
	self.m_selectBtn2 = self:getChild("selectBtn2")
	self.m_selectBtn3 = self:getChild("selectBtn3")
	self.m_skipFormationBtn = self:getChild("skipFormationBtn")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_challengesNumComp = self:getChild("challengesNumComp")
	self.m_lineupHolder = self:getChild("lineupHolder")
	self.m_myRankText = self:getChild("myRankText")
	self.m_noRankTxt = self:getChild("noRankTxt")
	self.m_guildRankText = self:getChild("guildRankText")
	self.m_noGuildRankTxt = self:getChild("noGuildRankTxt")
	self.m_topGuildRank = self:getChild("topGuildRank")
	self.m_fightValuePreText = self:getChild("fightValuePreText")
	self.m_powerNumText = self:getChild("powerNumText")
	self.m_seasonGroupLoader = self:getChild("seasonGroupLoader")
	self.m_seasonTxt = self:getChild("seasonTxt")
	self.m_seasonTimeTxt = self:getChild("seasonTimeTxt")
	self.m_serverTipBtn = self:getChild("serverTipBtn")
	self.m_matchServerGroup = self:getChild("matchServerGroup")
	self.m_seasonGroup = self:getChild("seasonGroup")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_robotHolder = self:getChild("robotHolder")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TabSelCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.GuildRankStatusCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.BuffGroupCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.IsTop3Ctrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SkipFormationCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
