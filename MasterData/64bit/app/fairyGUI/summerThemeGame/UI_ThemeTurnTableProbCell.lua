local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6epngkk3ax"

function var_0_0:__ctor()
	self.m_isAllGetController = self:getController("isAllGet")
	self.m_probIcon = self:getChild("probIcon")
	self.m_lastNumText = self:getChild("lastNumText")
end

var_0_0.IsAllGetCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
