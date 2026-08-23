local var_0_0 = {}

var_0_0.URL = "ui://44qiyyomft7s9bnojy"

function var_0_0:__ctor()
	self.m_phaseLevelController = self:getController("phaseLevel")
	self.m_recommendController = self:getController("recommend")
	self.m_knightComp = self:getChild("knightComp")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_totalRankTxt = self:getChild("totalRankTxt")
	self.m_bossNameTxt = self:getChild("bossNameTxt")
	self.m_remainTimeTxt = self:getChild("remainTimeTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_descTxt = self:getChild("descTxt")
	self.m_showIcon1 = self:getChild("showIcon1")
	self.m_showIcon2 = self:getChild("showIcon2")
	self.m_showIcon3 = self:getChild("showIcon3")
	self.m_skill1 = self:getChild("skill1")
	self.m_skill2 = self:getChild("skill2")
	self.m_skill3 = self:getChild("skill3")
	self.m_challengeCountTxt = self:getChild("challengeCountTxt")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_2Transition = self:getTransition("enter_2")
	self.m_enter_3Transition = self:getTransition("enter_3")
end

var_0_0.PhaseLevelCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.RecommendCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
