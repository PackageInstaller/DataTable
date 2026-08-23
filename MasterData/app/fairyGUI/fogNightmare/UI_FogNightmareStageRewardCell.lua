local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnu"

function var_0_0:__ctor()
	self.m_rewardStateController = self:getController("rewardState")
	self.m_rewardTitle = self:getChild("rewardTitle")
	self.m_descTxt = self:getChild("descTxt")
	self.m_rewardList = self:getChild("rewardList")
	self.m_getBtn = self:getChild("getBtn")
	self.m_scoreNum = self:getChild("scoreNum")
	self.m_lockStr = self:getChild("lockStr")
end

var_0_0.RewardStateCtrl = {
	已领取 = 2,
	不可领取 = 0,
	未解锁 = 3,
	可领取 = 1
}

return var_0_0
