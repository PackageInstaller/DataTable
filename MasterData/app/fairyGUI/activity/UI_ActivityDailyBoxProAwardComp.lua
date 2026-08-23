local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wpgycce"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_progressBar = self:getChild("progressBar")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_getAwardArea = self:getChild("getAwardArea")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
