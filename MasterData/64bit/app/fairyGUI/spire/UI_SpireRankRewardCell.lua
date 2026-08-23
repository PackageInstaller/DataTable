local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm1w"

function var_0_0:__ctor()
	self.m_hasBgController = self:getController("hasBg")
	self.m_rankComp = self:getChild("rankComp")
	self.m_rewardList = self:getChild("rewardList")
end

var_0_0.HasBgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
