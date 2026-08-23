local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nknbcfibtx"

function var_0_0:__ctor()
	self.m_hasRewardController = self:getController("hasReward")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_levelComp = self:getChild("levelComp")
	self.m_rewardList = self:getChild("rewardList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
