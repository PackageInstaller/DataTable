local var_0_0 = {}

var_0_0.URL = "ui://99hn3059jycc2q"

function var_0_0:__ctor()
	self.m_rewardStateController = self:getController("rewardState")
	self.m_rewardTitle = self:getChild("rewardTitle")
	self.m_starTxt = self:getChild("starTxt")
	self.m_rewardList = self:getChild("rewardList")
	self.m_getBtn = self:getChild("getBtn")
	self.m_starNum = self:getChild("starNum")
end

var_0_0.RewardStateCtrl = {
	page1 = 1,
	page0 = 0,
	page3 = 3,
	page2 = 2
}

return var_0_0
