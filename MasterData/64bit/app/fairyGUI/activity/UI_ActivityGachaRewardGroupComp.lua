local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wr5pq7m"

function var_0_0:__ctor()
	self.m_getBigAwardController = self:getController("getBigAward")
	self.m_bg = self:getChild("bg")
	self.m_rewardABList = self:getChild("rewardABList")
	self.m_lastNumTxt = self:getChild("lastNumTxt")
end

var_0_0.GetBigAwardCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
