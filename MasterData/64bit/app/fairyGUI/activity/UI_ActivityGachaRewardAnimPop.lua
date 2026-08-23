local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wjy7c8i"

function var_0_0:__ctor()
	self.m_openStateController = self:getController("openState")
	self.m_rewardQualityController = self:getController("rewardQuality")
	self.m_effHolder = self:getChild("effHolder")
end

var_0_0.OpenStateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.RewardQualityCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
