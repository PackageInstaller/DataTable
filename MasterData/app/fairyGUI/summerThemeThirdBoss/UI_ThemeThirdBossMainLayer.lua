local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obldv70"

function var_0_0:__ctor()
	self.m_showGroupController = self:getController("showGroup")
	self.m_rewardTypeController = self:getController("rewardType")
	self.m_knightComp = self:getChild("knightComp")
	self.m_totalScoreText = self:getChild("totalScoreText")
	self.m_scoreComp = self:getChild("scoreComp")
	self.m_skillTitleText = self:getChild("skillTitleText")
	self.m_skill1 = self:getChild("skill1")
	self.m_skill2 = self:getChild("skill2")
	self.m_skill5 = self:getChild("skill5")
	self.m_skill3 = self:getChild("skill3")
	self.m_skill4 = self:getChild("skill4")
	self.m_tipTitleBg = self:getChild("tipTitleBg")
	self.m_phaseText = self:getChild("phaseText")
	self.m_remainTimeTxt = self:getChild("remainTimeTxt")
	self.m_bossNameTxt = self:getChild("bossNameTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_talentDesc = self:getChild("talentDesc")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_challengeCountTxt = self:getChild("challengeCountTxt")
	self.m_talentBtn = self:getChild("talentBtn")
	self.m_rankText = self:getChild("rankText")
	self.m_noneText = self:getChild("noneText")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowGroupCtrl = {
	page0 = 1,
	page2 = 0,
	page1 = 2,
	page3 = 3
}
var_0_0.RewardTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
