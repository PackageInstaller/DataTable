local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagtlog3q"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_awardList = self:getChild("awardList")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_taskNameText = self:getChild("taskNameText")
	self.m_taskNumText = self:getChild("taskNumText")
end

var_0_0.IsGetCtrl = {
	page2 = 5,
	page1 = 0,
	page0 = 1
}

return var_0_0
