local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9epir9699n"

function var_0_0:__ctor()
	self.m_isGetRewardController = self:getController("isGetReward")
	self.m_iconComp = self:getChild("iconComp")
	self.m_grayGraph = self:getChild("grayGraph")
end

var_0_0.IsGetRewardCtrl = {
	已领奖 = 1,
	未领奖 = 0
}

return var_0_0
