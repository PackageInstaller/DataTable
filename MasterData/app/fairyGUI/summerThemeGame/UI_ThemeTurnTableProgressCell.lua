local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6p7pmkk38l"

function var_0_0:__ctor()
	self.m_rewardStateController = self:getController("rewardState")
	self.m_progressTitle = self:getChild("progressTitle")
	self.m_progNumText = self:getChild("progNumText")
	self.m_rewardList = self:getChild("rewardList")
	self.m_getBtn = self:getChild("getBtn")
	self.m_gotText = self:getChild("gotText")
	self.m_turnNum = self:getChild("turnNum")
end

var_0_0.RewardStateCtrl = {
	已领取 = 3,
	不可领取 = 1,
	空状态 = 0,
	可领取 = 2
}

return var_0_0
