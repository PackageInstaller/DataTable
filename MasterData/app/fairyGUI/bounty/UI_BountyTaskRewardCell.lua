local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfib932b"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_taskTypeController = self:getController("taskType")
	self.m_awardList = self:getChild("awardList")
	self.m_desTxt = self:getChild("desTxt")
	self.m_proTxt = self:getChild("proTxt")
	self.m_getBtn = self:getChild("getBtn")
end

return var_0_0
