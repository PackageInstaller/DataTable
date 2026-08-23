local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wtbcp6r"

function var_0_0:__ctor()
	self.m_rewardStateController = self:getController("rewardState")
	self.m_rewardTitle = self:getChild("rewardTitle")
	self.m_starTxt = self:getChild("starTxt")
	self.m_rewardList = self:getChild("rewardList")
	self.m_getBtn = self:getChild("getBtn")
	self.m_starNum = self:getChild("starNum")
end

var_0_0.RewardStateCtrl = {
	空状态 = 0,
	已领取 = 3,
	可领取 = 2,
	不可领取 = 1
}

return var_0_0
