local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9e1al68t2"

function var_0_0:__ctor()
	self.m_seasonViewController = self:getController("seasonView")
	self.m_userIconComp = self:getChild("userIconComp")
	self.m_userNameTxt = self:getChild("userNameTxt")
	self.m_allianceNameTxt = self:getChild("allianceNameTxt")
	self.m_conLoader = self:getChild("conLoader")
	self.m_contributionTxt = self:getChild("contributionTxt")
	self.m_noRankTxt = self:getChild("noRankTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_kingConLoader = self:getChild("kingConLoader")
	self.m_kingContributionTxt = self:getChild("kingContributionTxt")
	self.m_noRankTxt1 = self:getChild("noRankTxt1")
	self.m_kingAwardList = self:getChild("kingAwardList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.SeasonViewCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
