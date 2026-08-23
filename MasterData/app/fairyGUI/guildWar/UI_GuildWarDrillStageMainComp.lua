local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mtk7x1"

function var_0_0:__ctor()
	self.m_hasChallengeCountController = self:getController("hasChallengeCount")
	self.m_bgComp = self:getChild("bgComp")
	self.m_titleComp = self:getChild("titleComp")
	self.m_rankComp = self:getChild("rankComp")
	self.m_myScoreText = self:getChild("myScoreText")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_challengeEffect = self:getChild("challengeEffect")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_drillRankBtn = self:getChild("drillRankBtn")
	self.m_seasonRankBtn = self:getChild("seasonRankBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasChallengeCountCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
