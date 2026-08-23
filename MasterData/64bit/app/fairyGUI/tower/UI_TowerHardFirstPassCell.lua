local var_0_0 = {}

var_0_0.URL = "ui://foyq921skzay9c"

function var_0_0:__ctor()
	self.m_getRewardController = self:getController("getReward")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_rewardList = self:getChild("rewardList")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_passOrder = self:getChild("passOrder")
	self.m_isGot = self:getChild("isGot")
	self.m_userIcon = self:getChild("userIcon")
	self.m_userName = self:getChild("userName")
	self.m_serverName = self:getChild("serverName")
	self.m_power = self:getChild("power")
end

var_0_0.GetRewardCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.IsShowBgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
