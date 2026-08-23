local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkq285mibxb"

function var_0_0:__ctor()
	self.m_pageController = self:getController("page")
	self.m_rewardList = self:getChild("rewardList")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_noRewardTxt = self:getChild("noRewardTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
