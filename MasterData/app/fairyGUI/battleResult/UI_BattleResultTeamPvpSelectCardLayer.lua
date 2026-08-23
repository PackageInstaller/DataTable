local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkq285mibxc"

function var_0_0:__ctor()
	self.m_haveRewardController = self:getController("haveReward")
	self.m_card1 = self:getChild("card1")
	self.m_card2 = self:getChild("card2")
	self.m_card3 = self:getChild("card3")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_timeGroup = self:getChild("timeGroup")
	self.m_rewardDescTxt = self:getChild("rewardDescTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
