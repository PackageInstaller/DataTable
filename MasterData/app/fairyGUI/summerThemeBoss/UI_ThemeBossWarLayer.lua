local var_0_0 = {}

var_0_0.URL = "ui://44qiyyomft7s9bnolj"

function var_0_0:__ctor()
	self.m_hasTipsCompController = self:getController("hasTipsComp")
	self.m_knightComp = self:getChild("knightComp")
	self.m_leftBg = self:getChild("leftBg")
	self.m_skillTitleText = self:getChild("skillTitleText")
	self.m_skill1 = self:getChild("skill1")
	self.m_skill2 = self:getChild("skill2")
	self.m_skill3 = self:getChild("skill3")
	self.m_tipTitleBg = self:getChild("tipTitleBg")
	self.m_phaseText = self:getChild("phaseText")
	self.m_remainTimeTxt = self:getChild("remainTimeTxt")
	self.m_bossNameTxt = self:getChild("bossNameTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_rankText = self:getChild("rankText")
	self.m_noneText = self:getChild("noneText")
	self.m_rightBg = self:getChild("rightBg")
	self.m_progressList = self:getChild("progressList")
	self.m_previewBtn = self:getChild("previewBtn")
	self.m_progressComp = self:getChild("progressComp")
	self.m_curScoreText = self:getChild("curScoreText")
	self.m_needScoreText = self:getChild("needScoreText")
	self.m_awardList = self:getChild("awardList")
	self.m_getAllAwardLoader = self:getChild("getAllAwardLoader")
	self.m_effAward = self:getChild("effAward")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_challengeCountTxt = self:getChild("challengeCountTxt")
	self.m_tipsComp = self:getChild("tipsComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_refreshTransition = self:getTransition("refresh")
end

var_0_0.HasTipsCompCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
