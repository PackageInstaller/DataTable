local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczd1v"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_title = self:getChild("title")
	self.m_conditionTipText = self:getChild("conditionTipText")
	self.m_conditionValueText = self:getChild("conditionValueText")
	self.m_conditionBtn = self:getChild("conditionBtn")
	self.m_rewardTipText = self:getChild("rewardTipText")
	self.m_rewardValueText = self:getChild("rewardValueText")
	self.m_rewardBtn = self:getChild("rewardBtn")
end

var_0_0.StateCtrl = {
	recived = 3,
	match = 4,
	completed = 2,
	onlyReward = 5,
	lock = 0,
	unlock = 1
}

return var_0_0
