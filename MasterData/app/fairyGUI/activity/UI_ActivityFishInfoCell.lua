local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wm4g0bk"

function var_0_0:__ctor()
	self.m_fishTypeController = self:getController("fishType")
	self.m_fishNameTxt = self:getChild("fishNameTxt")
	self.m_fishIcon = self:getChild("fishIcon")
	self.m_rewardList = self:getChild("rewardList")
end

var_0_0.FishTypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
