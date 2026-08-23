local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lueup5t"

function var_0_0:__ctor()
	self.m_lightController = self:getController("light")
	self.m_isBigRewardController = self:getController("isBigReward")
	self.m_rewardIcon = self:getChild("rewardIcon")
	self.m_rewardNumTxt = self:getChild("rewardNumTxt")
	self.m_eff = self:getChild("eff")
end

return var_0_0
