local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wf3yyh4"

function var_0_0:__ctor()
	self.m_isRecvController = self:getController("isRecv")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_rewardIcon = self:getChild("rewardIcon")
	self.m_dayTxt = self:getChild("dayTxt")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_numTxt = self:getChild("numTxt")
end

var_0_0.IsRecvCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
