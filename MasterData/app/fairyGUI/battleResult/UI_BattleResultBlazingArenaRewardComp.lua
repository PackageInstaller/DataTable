local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkv3rkmibyy"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_hideRankController = self:getController("hideRank")
	self.m_rewardList = self:getChild("rewardList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
